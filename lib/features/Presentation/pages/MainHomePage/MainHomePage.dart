import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:norse/features/Presentation/Blocs/Connectivity_bloc/connnectivity_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/CustomSliderWidget.dart';
import 'package:norse/features/Presentation/CustomWidgets/musicbottombarloading.dart';
import 'package:norse/features/Presentation/pages/Youtube/youtubescreen/ytpage.dart';
import 'package:norse/features/Presentation/pages/spotify/homepage/homepage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:norse/injection_container.dart' as dii;
import '../../../../configs/constants/Spaces.dart';
import '../../../../configs/notifier/notifiers.dart';
import '../../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../../../Domain/UseCases/Platform_UseCase/GetPermissions_UseCase.dart';
import '../../../Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';
import '../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../../Blocs/Musicbloc/Trending_Song_bloc/trending_song_bloc.dart';
import '../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../Blocs/Musicbloc/playlist_Bloc/playlist_bloc.dart';
import '../../Blocs/youtubeBloc/youtubeplayer_bloc/youtubeplayer_bloc.dart';
import '../../Blocs/youtubeBloc/ytsearch_bloc/ytsearch_bloc.dart';
import '../Youtube/youtubeplayer/testytplayerscreen.dart';
import '../saavn/HomePage.dart';
import '../saavn/MySongPage.dart';
import '../saavn/musicplayerpage/testonlineplayerscreen.dart';
import '../saavn/musicplayerpage/testplayerscreen.dart';
import '../saavn/onlinefavepage.dart';

bool isytplayingvisible = false;
bool isSuffled = false;

final _navigatorkey0 = GlobalKey();
final navigatorkey1 = GlobalKey();
final navigatorkey2 = GlobalKey();
final ytnavigator0 = GlobalKey();
final ytchannelnav0 = GlobalKey();

class MainHomePage extends StatefulWidget {
  static const String mainHomePAge = '/mainhomepage';
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final mainpagestate = GlobalKey<_MainHomePageState>();

  int currentindex = 0;

  List<Widget> pages = [
    Navigator(
      key: _navigatorkey0,
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (_) => const HomePage()),
    ),
    Navigator(
      key: navigatorkey1,
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (_) => const MySongPage()),
    ),
    Navigator(
      key: ytnavigator0,
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (_) => const IntialytHomepage()),
    ),
        Navigator(
      key: navigatorkey2,
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (_) => const SpotifyHomePage()),
    ),
    const Onlinefavscreen()
  ];

  void call() {
    BlocProvider.of<YtsearchBloc>(context).add(const YtsearchEvent.freestate());
    BlocProvider.of<PlaylistBloc>(context)
        .add(const PlaylistEvent.getallplaylist());
    BlocProvider.of<FavoriteplaylistBloc>(context)
        .add(const FavoriteplaylistEvent.getallsongs());
    BlocProvider.of<TrendingSongBloc>(context)
        .add(const TrendingSongs(mode: 'initial'));
  }

  getpermission() async {
    try {
      await dii.di<initializedbusecase>().call();
      bool check =
          await dii.di<GetpermissionUseCase>().call().then((value) async {
        call();
        await _getallsongs();
        return value ? value : false;
      });
      if (check != true) {
        Spaces.showtoast(
            'Some Permissions are not Granted Some App Features May not work'
                .toLowerCase());
      }
    } catch (e) {}
  }

  _getallsongs() {
    BlocProvider.of<LocalsongBloc>(context)
        .add(const LocalsongEvent.getallsongs());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        setState(() => currentindex = 0);
      }
      await getpermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MiniplayerWillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              bottomNavigationBar: ValueListenableBuilder(
                valueListenable: Notifiers.isfullscreen,
                builder: (context, value, child) {
                  return value
                      ? const SizedBox()
                      : SalomonBottomBar(
                          onTap: (p0) {
                            setState(() => currentindex = p0);
                          },
                          currentIndex: currentindex,
                          selectedItemColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: Colors.black,
                          selectedColorOpacity: 0.1,
                          unselectedItemColor: Colors.grey.withOpacity(0.6),
                          itemPadding: const EdgeInsets.all(12),
                          items: [
                              SalomonBottomBarItem(
                                  icon: const Icon(Icons.home),
                                  title: Text(
                                    'Discover',
                                    style: Spaces.Getstyle(
                                        11, Colors.white, FontWeight.normal),
                                  )),
                              SalomonBottomBarItem(
                                  icon: const Icon(Icons.folder_outlined),
                                  title: Text(
                                    'Device',
                                    style: Spaces.Getstyle(
                                        11, Colors.white, FontWeight.normal),
                                  )),

                              SalomonBottomBarItem(
                                  icon: Image.asset(
                                    'assets/yt.png',
                                    scale: 24,
                                    filterQuality: FilterQuality.low,
                                  ),
                                  title: Text(
                                    'YouTube',
                                    style: Spaces.Getstyle(
                                        10, Colors.white, FontWeight.normal),
                                  )),
                                  SalomonBottomBarItem(
                                  icon: Image.asset(
                                    'assets/sp.png',
                                    scale: 25,
                                    filterQuality: FilterQuality.low,
                                  ),
                                  title: Text(
                                    'Spotify',
                                    style: Spaces.Getstyle(
                                        10, Colors.green, FontWeight.bold),
                                  )),
                              SalomonBottomBarItem(
                                  icon: const Icon(Icons.my_library_music),
                                  title: Text(
                                    'Library',
                                    style: Spaces.Getstyle(
                                        10, Colors.white, FontWeight.normal),
                                  )),
                            ]);
                },
              ),
              body: BlocBuilder<ConnnectivityBloc, ConnnectivityState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    networkstate: (isavailable) {
                      return Stack(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: Notifiers.showplayer,
                              builder: (context, value, child) =>
                                  const SizedBox()),
                          pages[currentindex],
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: BottomMusicBar(),
                          ),
                          SafeArea(
                            child: BlocBuilder<YoutubeplayerBloc,
                                YoutubeplayerState>(
                              builder: (context, state) {
                                Size size = MediaQuery.sizeOf(context);
                                return state.maybeWhen(
                                    youtubeplayerstate: (info,
                                            index, video, loading, failed) =>
                                        ValueListenableBuilder(
                                          valueListenable: Notifiers.showplayer,
                                          builder: (context, value, child) {
                                            return Offstage(
                                              offstage: value,
                                              child: Miniplayer(
                                                minHeight: 60,
                                                maxHeight: size.height,
                                                valueNotifier:
                                                    Notifiers.ytexpandnotifer,
                                                builder: (height, percentage) {
                                                  return Testytplayer(
                                                      height: height,
                                                      persentage: percentage,
                                                      video: video,
                                                      index: index,
                                                      context: context,
                                                     );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                    orElse: () => const SizedBox.shrink());
                              },
                            ),
                          )
                        ],
                      );
                    },
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewDraweritems extends StatelessWidget {
  const NewDraweritems({
    super.key,
    required this.callback,
    required this.title,
  });
  final VoidCallback callback;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: ListTile(
        leading: Image.asset(
          'assets/yt.png',
          scale: 24,
          filterQuality: FilterQuality.low,
        ),
        title: Text(title,
            style: GoogleFonts.aldrich(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}

class NetworKerrorwidget extends StatelessWidget {
  const NetworKerrorwidget({
    super.key,
    required this.size,
    required this.color,
  });

  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  height: size.height / 2.5,
                  width: size.width / 1.2,
                  child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade600.withOpacity(0.2)),
                          height: size.height / 2.5,
                          width: size.width / 1.2,
                        )),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                height: size.height / 2.5,
                width: size.width / 1.2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no-wifi.png',
                            scale: 6,
                          ),
                          const Textutil(
                              text: 'Whoops',
                              fontsize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                    Textutil(
                        text: 'No internet connection found',
                        fontsize: 14,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.normal),
                    Textutil(
                        text: 'Check your Connection and try again later',
                        fontsize: 13,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.normal),
                    Spaces.kheight20
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Draweritems extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final IconData iconsdata;
  const Draweritems({
    super.key,
    required this.ontap,
    required this.title,
    required this.iconsdata,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: Icon(
          iconsdata,
          color: Colors.white,
          size: 21,
        ),
        title: Text(title,
            style: GoogleFonts.aldrich(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}

class BottomMusicBar extends StatelessWidget {
  const BottomMusicBar({super.key});

  void changeduration(int sceconds, AudioPlayer player) {
    Duration duration = Duration(seconds: sceconds);
    player.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return state.maybeWhen(
            loading: () => const MusicBottomBarloading(),
            onlinesongs:
                (isloading, isfailed, audios, valueStream, index, audioPlayer) {
              return isloading == true
                  ? const MusicBottomBarloading()
                  : StreamBuilder(
                      stream: valueStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          double postion = snapshot.data!
                              .maybeMap(
                                orElse: () => 0,
                                onlinestreams: (value) => value.pos.inSeconds,
                              )
                              .toDouble();

                          double duration = snapshot.data!
                              .maybeMap(
                                orElse: () => 0,
                                onlinestreams: (value) => value.dur.inSeconds,
                              )
                              .toDouble();
                          int songindex = snapshot.data!.maybeMap(
                              orElse: () => 0,
                              onlinestreams: (val) => val.index);

                          PlayerState dupplayerstate =
                              PlayerState(false, ProcessingState.loading);

                          PlayerState playerState = snapshot.data!.maybeMap(
                            orElse: () => dupplayerstate,
                            onlinestreams: (value) => value.playerState,
                          );

                          return MusicbottombarWidget(
                            onchange: (value) =>
                                changeduration(value.toInt(), audioPlayer),
                            pos: postion,
                            dur: duration,
                            ontap: () => Navigator.pushNamed(
                                context, Onlineplayerscreen.onlineplayerscreen),
                            type: 'online',
                            songindex: songindex,
                            playerState: playerState,
                            audioPlayer: audioPlayer,
                            audios: audios,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
            },
            Localsongs:
                (isloading, isfailed, audios, valueStream, index, audioPlayer) {
              return isloading == true
                  ? const MusicBottomBarloading()
                  : StreamBuilder(
                      stream: valueStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          double postion = snapshot.data!
                              .maybeMap(
                                orElse: () => 0,
                                LocalStreams: (value) => value.pos.inSeconds,
                              )
                              .toDouble();

                          double duration = snapshot.data!
                              .maybeMap(
                                orElse: () => 0,
                                LocalStreams: (value) => value.Dur.inSeconds,
                              )
                              .toDouble();

                          PlayerState player =
                              PlayerState(true, ProcessingState.loading);

                          PlayerState playerState = snapshot.data!.maybeMap(
                            orElse: () => player,
                            LocalStreams: (value) => value.playerState,
                          );

                          int songindex = snapshot.data!.maybeMap(
                            orElse: () => 0,
                            LocalStreams: (value) => value.index,
                          );

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Testplayerscreen.textscreen,
                                  arguments: 'okey ');
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    gradient: Spaces.musicgradient()),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    QueryArtworkWidget(
                                      id: audios[songindex].id,
                                      artworkQuality: FilterQuality.low,
                                      type: ArtworkType.AUDIO,
                                      size: 1000,
                                      artworkBlendMode: BlendMode.plus,
                                      artworkClipBehavior: Clip.antiAlias,
                                      keepOldArtwork: true,
                                      format: ArtworkFormat.JPEG,
                                      artworkBorder: BorderRadius.zero,
                                      nullArtworkWidget: Shimmer(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.grey,
                                                Colors.white
                                              ]),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )),
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          QueryArtworkWidget(
                                            artworkWidth: 40,
                                            artworkHeight: 40,
                                            id: audios[songindex].id,
                                            artworkQuality: FilterQuality.low,
                                            type: ArtworkType.AUDIO,
                                            artworkBlendMode: BlendMode.plus,
                                            artworkClipBehavior: Clip.antiAlias,
                                            keepOldArtwork: true,
                                            format: ArtworkFormat.JPEG,
                                            artworkBorder:
                                                BorderRadius.circular(9),
                                            nullArtworkWidget: Shimmer(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.grey,
                                                      Colors.white
                                                    ]),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 150,
                                                child: Textutil(
                                                    text:
                                                        audios[songindex].title,
                                                    fontsize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spaces.kheigth5,
                                              SizedBox(
                                                height: 12,
                                                width: 100,
                                                child: Textutil(
                                                    text: audios[songindex]
                                                        .subtitle,
                                                    fontsize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  AudioBloc>(
                                                              context)
                                                          .add(const AudioEvent
                                                              .SeekPreviousAudio());
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons
                                                          .backward_end_fill,
                                                      color: audioPlayer
                                                              .hasPrevious
                                                          ? Colors.white
                                                          : Colors.grey,
                                                      size: 15,
                                                    )),
                                                GestureDetector(
                                                  onTap: () {
                                                    playerState.playing == true
                                                        ? BlocProvider.of<
                                                                    AudioBloc>(
                                                                context)
                                                            .add(
                                                                const AudioEvent
                                                                    .pause())
                                                        : BlocProvider.of<
                                                                    AudioBloc>(
                                                                context)
                                                            .add(
                                                                const AudioEvent
                                                                    .resume());
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white),
                                                    child: Icon(
                                                      playerState.playing ==
                                                              true
                                                          ? CupertinoIcons.pause
                                                          : CupertinoIcons
                                                              .play_arrow,
                                                      color: Colors.black,
                                                      size: 19,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  AudioBloc>(
                                                              context)
                                                          .add(const AudioEvent
                                                              .seeknextaudio());
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons
                                                          .forward_end_fill,
                                                      color: audioPlayer.hasNext
                                                          ? Colors.white
                                                          : Colors.grey,
                                                      size: 15,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                          height: 3,
                                          child: CustomSlider(
                                            audioPlayer: audioPlayer,
                                            postion: postion,
                                            duration: duration,
                                            trackHeight: 1,
                                            thumshape:
                                                const RoundSliderOverlayShape(),
                                          )),
                                    )
                                  ],
                                )),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
            },
            orElse: () => const SizedBox());
      },
    );
  }
}

class Loadingcustomgradient extends StatelessWidget {
  const Loadingcustomgradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 150,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 81, 81, 81),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

class MusicbottombarWidget extends StatelessWidget {
  const MusicbottombarWidget({
    Key? key,
    required this.songindex,
    required this.type,
    required this.ontap,
    required this.audios,
    required this.audioPlayer,
    required this.playerState,
    required this.pos,
    required this.dur,
    required this.onchange,
  }) : super(key: key);

  final int songindex;
  final String type;
  final VoidCallback ontap;
  final List<OnlineSongModel> audios;
  final AudioPlayer audioPlayer;
  final PlayerState playerState;
  final double pos;
  final double dur;
  final ValueChanged<double> onchange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: audios[songindex].imageurl,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.network(
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/musical-note.png',
                                    color: Colors.black.withOpacity(0.6),
                                  );
                                },
                                audios[songindex].imageurl,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 150,
                                child: Textutil(
                                    text: audios[songindex].title,
                                    fontsize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spaces.kheigth5,
                              SizedBox(
                                height: 20,
                                width: 100,
                                child: Textutil(
                                    text: audios[songindex].artist,
                                    fontsize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<AudioBloc>(context).add(
                                          const AudioEvent.SeekPreviousAudio());
                                    },
                                    icon: Icon(
                                      CupertinoIcons.backward_end_fill,
                                      color: audioPlayer.hasPrevious
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 15,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    playerState.playing == true
                                        ? BlocProvider.of<AudioBloc>(context)
                                            .add(const AudioEvent.pause())
                                        : BlocProvider.of<AudioBloc>(context)
                                            .add(const AudioEvent.resume());
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      playerState.playing == true
                                          ? CupertinoIcons.pause
                                          : CupertinoIcons.play_arrow,
                                      color: Colors.black,
                                      size: 19,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<AudioBloc>(context).add(
                                          const AudioEvent.seeknextaudio());
                                    },
                                    icon: Icon(
                                      CupertinoIcons.forward_end_fill,
                                      color: audioPlayer.hasNext
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 15,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1,
                child: CustomSlider(
                  audioPlayer: audioPlayer,
                  postion: pos,
                  duration: dur,
                  trackHeight: 1,
                  thumshape: SliderComponentShape.noThumb,
                ),
              )
            ],
          )),
    );
  }
}
