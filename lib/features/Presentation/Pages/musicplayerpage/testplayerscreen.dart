import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import '../../../../configs/constants/Spaces.dart';
import '../../../Data/Models/songmodel.dart';
import '../../../Domain/Entity/SongsDetailsEntity/SongsEntity.dart';
import '../../Bloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../Bloc/favsong_bloc/favsongs_bloc.dart';
import '../../CustomWidgets/modelbottamsheet.dart';
import '../../queue/queue.dart';
import '../MainHomePage/MainHomePage.dart';
import 'testonlineplayerscreen.dart';

class Testplayerscreen extends StatefulWidget {
  static const String textscreen = './testscreen';
  const Testplayerscreen({
    Key? key,
    required this.currentscreen,
  }) : super(key: key);

  final String currentscreen;

  @override
  State<Testplayerscreen> createState() => _TestplayerscreenState();
}

class _TestplayerscreenState extends State<Testplayerscreen> {
  late PageController _controller;

  void changeduration(int sceconds, AudioPlayer player) {
    Duration duration = Duration(seconds: sceconds);
    player.seek(duration);
  }

  _showmodelsheet(Songmodel songModel) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Custombottomsheet(
          songModel: songModel,
        );
      },
    );
  }

  List<Songmodel> audios = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return state.maybeMap(
              Localsongs: (state) {
                return StreamBuilder(
                  stream: state.valueStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final songindex = snapshot.data!.mapOrNull(
                        LocalStreams: (value) => value.index,
                      );

                      _controller = PageController(
                          initialPage: songindex!, viewportFraction: 1);

                      state.audios.isNotEmpty
                          ? BlocProvider.of<FavsongsBloc>(context, listen: true)
                              .add(FavsongsEvent.checkforfav(
                                  state.audios[songindex].id.toString()))
                          : null;

                      state.audios.isNotEmpty
                          ? BlocProvider.of<FavoriteplaylistBloc>(context)
                              .add(const FavoriteplaylistEvent.getallsongs())
                          : null;

                      audios = List.from(state.audios);

                      return Scaffold(
                          backgroundColor: Colors.transparent,
                          extendBodyBehindAppBar: true,
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    _showmodelsheet(state.audios[songindex]);
                                  },
                                  icon: const Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                  ))
                            ],
                            centerTitle: true,
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 17,
                                )),
                          ),
                          body: Stack(
                            children: [
                              SizedBox(
                                  height: size.height,
                                  width: size.width,
                                  child: Hero(
                                    tag: '0',
                                    child: QueryArtworkWidget(
                                      keepOldArtwork: true,
                                      id: state.audios[songindex].id,
                                      type: ArtworkType.AUDIO,
                                      artworkHeight: size.height,
                                      artworkWidth: size.width,
                                      size: 1,
                                      artworkFit: BoxFit.fitHeight,
                                      artworkQuality: FilterQuality.low,
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: MediaQuery.sizeOf(context).height,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                        Colors.black,
                                        Colors.black.withOpacity(0.9),
                                        Colors.transparent
                                      ])),
                                ),
                              ),
                              SafeArea(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                2.65,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: PageView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: _controller,
                                          itemCount: state.audios.length,
                                          scrollBehavior:
                                              const MaterialScrollBehavior(),
                                          itemBuilder: (context, index) {
                                            _controller.hasClients &&
                                                    songindex != index
                                                ? _controller.animateToPage(
                                                    songindex,
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    curve: Curves.ease)
                                                : null;
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  bottom: 10),
                                              child: Hero(
                                                  tag: '3',
                                                  child: ClipRRect(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: QueryArtworkWidget(
                                                        artworkBorder:
                                                            BorderRadius
                                                                .circular(20),
                                                        size: 550,
                                                        format:
                                                            ArtworkFormat.JPEG,
                                                        artworkFit:
                                                            BoxFit.fitWidth,
                                                        artworkQuality:
                                                            FilterQuality.low,
                                                        keepOldArtwork: true,
                                                        artworkBlendMode:
                                                            BlendMode.colorBurn,
                                                        id: state
                                                            .audios[index].id,
                                                        nullArtworkWidget:
                                                            Image.asset(
                                                          'assets/musical-note.png',
                                                          color: Colors.white,
                                                          scale: 2,
                                                        ),
                                                        type:
                                                            ArtworkType.AUDIO),
                                                  )),
                                            );
                                          },
                                        )),
                                    //

                                    Column(
                                      children: [
                                        audios[songindex].title.length <= 20
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 35, left: 35),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Textutil(
                                                          text:
                                                              audios[songindex]
                                                                  .title,
                                                          fontsize: 30,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ],
                                                  ),
                                                ))
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 26),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: Spaces.songtitle(
                                                      audios[songindex].title,
                                                      30,
                                                      Colors.white,
                                                      FontWeight.bold,
                                                      context),
                                                )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 26),
                                          child: Text(
                                            state.audios[songindex].subtitle,
                                            style: Spaces.Getstyle(
                                                12,
                                                Colors.white,
                                                FontWeight.normal),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Slider(
                                                secondaryActiveColor: Colors
                                                    .grey
                                                    .withOpacity(0.6),
                                                thumbColor:
                                                    const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                activeColor:
                                                    const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                inactiveColor:
                                                    const Color.fromARGB(
                                                            255, 125, 125, 125)
                                                        .withOpacity(0.6),
                                                value: snapshot.data!
                                                    .mapOrNull(
                                                      LocalStreams: (value) =>
                                                          value.pos.inSeconds,
                                                    )!
                                                    .toDouble(),
                                                max: snapshot.data!
                                                    .mapOrNull(
                                                      LocalStreams: (value) =>
                                                          value.Dur.inSeconds,
                                                    )!
                                                    .toDouble(),
                                                min: const Duration(
                                                        microseconds: 0)
                                                    .inSeconds
                                                    .toDouble(),
                                                onChanged: (double value) {
                                                  changeduration(value.toInt(),
                                                      state.audioPlayer);
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 22,
                                                    left: 23,
                                                    top: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data!
                                                          .mapOrNull(
                                                              LocalStreams:
                                                                  (value) => value
                                                                      .pos
                                                                      .toString())!
                                                          .toString()
                                                          .split('.')[0],
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          .mapOrNull(
                                                              LocalStreams:
                                                                  (value) => value
                                                                          .Dur
                                                                      .toString())!
                                                          .toString()
                                                          .split(".")[0],
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        PlayIcons(
                                          iconscolors: islooped == true
                                              ? Colors.red
                                              : const Color.fromARGB(
                                                  255, 75, 75, 75),
                                          iconsize: 25,
                                          playicons: CupertinoIcons.loop,
                                          ontap: () {
                                            setState(() {
                                              islooped = !islooped;
                                            });
                                            if (islooped == true) {
                                              BlocProvider.of<AudioBloc>(
                                                      context)
                                                  .add(AudioEvent.loopon(
                                                      islooped));
                                            } else {
                                              BlocProvider.of<AudioBloc>(
                                                      context)
                                                  .add(AudioEvent.loopon(
                                                      islooped));
                                            }
                                          },
                                        ),
                                        PlayIcons(
                                          iconscolors: state
                                                  .audioPlayer.hasPrevious
                                              ? const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Colors.white.withOpacity(0.3),
                                          iconsize: 35,
                                          playicons:
                                              CupertinoIcons.backward_end_fill,
                                          ontap: () async {
                                            BlocProvider.of<AudioBloc>(context)
                                                .add(const AudioEvent
                                                    .SeekPreviousAudio());
                                            _controller.animateToPage(
                                                state
                                                    .audioPlayer.previousIndex!,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.linear);
                                          },
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Card(
                                              elevation: 5,
                                              shadowColor: Colors.white,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60)),
                                              child: Container(
                                                  height: 65,
                                                  width: 65,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              239,
                                                              239,
                                                              239),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: PlayIcons(
                                                      playicons: state
                                                                  .audioPlayer
                                                                  .playing ==
                                                              true
                                                          ? CupertinoIcons.pause
                                                          : Icons
                                                              .play_arrow_rounded,
                                                      iconscolors: Colors.black,
                                                      iconsize: 25,
                                                      ontap: () {
                                                        if (state.audioPlayer
                                                                .playing ==
                                                            true) {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(
                                                                  const AudioEvent
                                                                      .pause());
                                                        } else {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(const AudioEvent
                                                                  .resume());
                                                        }
                                                      })),
                                            ),
                                          ],
                                        ),
                                        PlayIcons(
                                          iconscolors: state.audioPlayer.hasNext
                                              ? const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Colors.white.withOpacity(0.3),
                                          iconsize: 35,
                                          playicons:
                                              CupertinoIcons.forward_end_fill,
                                          ontap: () async {
                                            BlocProvider.of<AudioBloc>(context)
                                                .add(const AudioEvent
                                                    .seeknextaudio());
                                            _controller.animateToPage(
                                                state.audioPlayer.nextIndex!,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.linear);
                                            setState(() {});
                                          },
                                        ),
                                        PlayIcons(
                                          iconscolors: isSuffled == true
                                              ? Colors.red
                                              : const Color.fromARGB(
                                                  255, 75, 75, 75),
                                          iconsize: 25,
                                          playicons: CupertinoIcons.shuffle,
                                          ontap: () {
                                            setState(() {
                                              isSuffled = !isSuffled;
                                            });
                                            if (isSuffled == true) {
                                              BlocProvider.of<AudioBloc>(
                                                      context)
                                                  .add(AudioEvent.shuffleon(
                                                      isSuffled));
                                            } else {
                                              BlocProvider.of<AudioBloc>(
                                                      context)
                                                  .add(AudioEvent.shuffleon(
                                                      isSuffled));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    widget.currentscreen == 'bad'
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                PlayIcons(
                                                    playicons: Icons
                                                        .queue_music_rounded,
                                                    iconscolors:
                                                        const Color.fromARGB(
                                                            255, 255, 255, 255),
                                                    iconsize: 27,
                                                    ontap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Reorder(
                                                                        audios:
                                                                            audios,
                                                                        audioPlayer:
                                                                            state.audioPlayer,
                                                                        index:
                                                                            songindex,
                                                                      )));
                                                    }),
                                                BlocBuilder<FavsongsBloc,
                                                    FavsongsState>(
                                                  builder: (context, state2) {
                                                    return state2.maybeWhen(
                                                        notpresent: () {
                                                          return BlocBuilder<
                                                              FavsongsBloc,
                                                              FavsongsState>(
                                                            builder: (context,
                                                                state1) {
                                                              return state1.maybeWhen(
                                                                  added: () {
                                                                    return PlayIcons(
                                                                        playicons:
                                                                            Icons
                                                                                .favorite,
                                                                        iconscolors:
                                                                            Colors
                                                                                .red,
                                                                        iconsize:
                                                                            25,
                                                                        ontap:
                                                                            () {
                                                                          BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.removefromfav(state
                                                                              .audios[songindex]
                                                                              .id
                                                                              .toString()));
                                                                        });
                                                                  },
                                                                  removed: () {
                                                                    return PlayIcons(
                                                                        playicons:
                                                                            Icons
                                                                                .favorite,
                                                                        iconscolors:
                                                                            Colors
                                                                                .white,
                                                                        iconsize:
                                                                            25,
                                                                        ontap:
                                                                            () {
                                                                          final details =
                                                                              state.audios[songindex];
                                                                          final song = AlbumElements(
                                                                              id: details.id.toString(),
                                                                              name: details.title,
                                                                              year: '',
                                                                              type: '',
                                                                              language: '',
                                                                              Artist: details.subtitle,
                                                                              url: details.uri,
                                                                              image: '');
                                                                          BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.addtofav(
                                                                              song,
                                                                              false));
                                                                        });
                                                                  },
                                                                  orElse: () => PlayIcons(
                                                                      playicons: Icons.favorite,
                                                                      iconscolors: Colors.white,
                                                                      iconsize: 25,
                                                                      ontap: () {
                                                                        final details =
                                                                            state.audios[songindex];
                                                                        final song = AlbumElements(
                                                                            id: details.id
                                                                                .toString(),
                                                                            name: details
                                                                                .title,
                                                                            year:
                                                                                '',
                                                                            type:
                                                                                '',
                                                                            language:
                                                                                '',
                                                                            Artist:
                                                                                details.subtitle,
                                                                            url: details.uri,
                                                                            image: '');
                                                                        BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.addtofav(
                                                                            song,
                                                                            false));
                                                                      }));
                                                            },
                                                          );
                                                        },
                                                        ispresent: (ispresent) {
                                                          return PlayIcons(
                                                              playicons: Icons
                                                                  .favorite,
                                                              iconscolors:
                                                                  Colors.red,
                                                              iconsize: 25,
                                                              ontap: () {
                                                                BlocProvider.of<
                                                                            FavsongsBloc>(
                                                                        context)
                                                                    .add(FavsongsEvent.checkforfav(state
                                                                        .audios[
                                                                            songindex]
                                                                        .id
                                                                        .toString()));

                                                                setState(() {
                                                                  BlocProvider.of<
                                                                              FavsongsBloc>(
                                                                          context)
                                                                      .add(FavsongsEvent.checkforfav(state
                                                                          .audios[
                                                                              songindex]
                                                                          .id
                                                                          .toString()));
                                                                });

                                                                BlocProvider.of<
                                                                            FavsongsBloc>(
                                                                        context)
                                                                    .add(FavsongsEvent.removefromfav(state
                                                                        .audios[
                                                                            songindex]
                                                                        .id
                                                                        .toString()));
                                                              });
                                                        },
                                                        orElse: () => PlayIcons(
                                                            playicons:
                                                                Icons.favorite,
                                                            iconscolors:
                                                                Colors.red,
                                                            iconsize: 25,
                                                            ontap: () {}));
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
              orElse: () => const SizedBox());
        },
      ),
    );
  }
}
