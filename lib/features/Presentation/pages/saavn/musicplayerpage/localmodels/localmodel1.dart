import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/nullmusicWidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../../configs/notifier/notifiers.dart';
import '../../../../../Data/Models/MusicModels/songmodel.dart';
import '../../../../../Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../../Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../../../Blocs/Musicbloc/favsong_bloc/favsongs_bloc.dart';
import '../../../../CustomWidgets/CustomSliderWidget.dart';
import '../../../../CustomWidgets/customqueuemanager.dart';
import '../../../../CustomWidgets/modelbottamsheet.dart';
import '../testonlineplayerscreen.dart';

class LocalModel1 extends StatefulWidget {
  const LocalModel1({
    super.key,
    required this.currentscreen,
  });

  final String currentscreen;

  @override
  State<LocalModel1> createState() => _LocalModel1State();
}

class _LocalModel1State extends State<LocalModel1>
    with SingleTickerProviderStateMixin {
  _showmodelsheet(Songmodel songModel, BuildContext context) async {
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

  late TabController tabController;
  late List<Songmodel> lateaudios;
  int? lateindex;
  late bool isplaying;

  @override
  void initState() {
    super.initState();
    Notifiers.tabindexNotifer.value = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      Notifiers.tabindexNotifer.value = tabController.index;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    lateaudios.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            BlocBuilder<AudioBloc, AudioState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  Localsongs: (isloading, isfailed, audios, valueStream, index,
                      audioPlayer) {
                    audios.isNotEmpty
                        ? BlocProvider.of<FavoriteplaylistBloc>(context)
                            .add(const FavoriteplaylistEvent.getallsongs())
                        : null;

                    isplaying = audioPlayer.playerState.playing;

                    return StreamBuilder(
                      stream: valueStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final songindex = snapshot.data!.maybeMap(
                            orElse: () => 0,
                            LocalStreams: (value) => value.index,
                          );

                          lateindex = songindex;

                          audios.isNotEmpty
                              ? BlocProvider.of<FavsongsBloc>(context,
                                      listen: true)
                                  .add(FavsongsEvent.checkforfav(
                                      audios[songindex].id.toString()))
                              : null;

                          lateaudios = List.from(audios);

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              QueryArtworkWidget(
                                  keepOldArtwork: true,
                                  size: 1,
                                  id: audios[songindex].id,
                                  type: ArtworkType.AUDIO),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                      Colors.black,
                                      Colors.black.withOpacity(0.9),
                                      Colors.black.withOpacity(0.8),
                                      Colors.black.withOpacity(0.1)
                                    ])),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  },
                );
              },
            ),
            Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 15,
                    )),
                title: const Textutil(text: 'Now Playing', fontsize: 20, color: Colors.white, fontWeight: FontWeight.bold)
                
              ),
              body: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          BlocBuilder<AudioBloc, AudioState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                  Localsongs: (isloading, isfailed, audios,
                                      valueStream, index, audioPlayer) {
                                    lateaudios = List.from(audios);

                                    return SafeArea(
                                      child: SizedBox(
                                        height: size.height,
                                        child: Column(
                                          children: [
                                            Spaces.kheight20,
                                            StreamBuilder(
                                              stream: valueStream,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData &&
                                                    snapshot.data != null) {
                                                  final songindex =
                                                      snapshot.data!.maybeMap(
                                                    orElse: () => 0,
                                                    LocalStreams: (value) =>
                                                        value.index,
                                                  );
                                                  double postion = snapshot
                                                      .data!
                                                      .maybeMap(
                                                        orElse: () => 0,
                                                        LocalStreams: (value) =>
                                                            value.pos.inSeconds,
                                                      )
                                                      .toDouble();

                                                  double duration = snapshot
                                                      .data!
                                                      .maybeMap(
                                                        orElse: () => 0,
                                                        LocalStreams: (value) =>
                                                            value.Dur.inSeconds,
                                                      )
                                                      .toDouble();

                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          SizedBox(
                                                            width: size.width,
                                                            height:
                                                                size.height /
                                                                    2.7,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          26),
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  lateaudios[songindex]
                                                                          .title
                                                                          .contains(
                                                                              'ytMusic')
                                                                      ? SizedBox(
                                                                          height:
                                                                              size.height / 4.4,
                                                                          width:
                                                                              size.width,
                                                                          child: LocalQueryArtWidget(
                                                                              fit: BoxFit.fitWidth,
                                                                              size: size,
                                                                              audios: lateaudios,
                                                                              songindex: songindex),
                                                                        )
                                                                      : SizedBox(
                                                                          height:
                                                                              size.height / 2.7,
                                                                          width:
                                                                              size.width,
                                                                          child: LocalQueryArtWidget(
                                                                              fit: BoxFit.cover,
                                                                              size: size,
                                                                              audios: lateaudios,
                                                                              songindex: songindex),
                                                                        )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Spaces.kheight10,
                                                      Column(
                                                        children: [
                                                          lateaudios[songindex]
                                                                      .title
                                                                      .length <=
                                                                  20
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              35,
                                                                          left:
                                                                              35),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Textutil(
                                                                            text: lateaudios[songindex]
                                                                                .title,
                                                                            fontsize:
                                                                                30,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              : Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          26),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Textutil(
                                                                        text: audios[songindex]
                                                                            .title,
                                                                        fontsize:
                                                                            30,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        26),
                                                            child: Text(
                                                              lateaudios[
                                                                      songindex]
                                                                  .subtitle,
                                                              style: Spaces
                                                                  .Getstyle(
                                                                      12,
                                                                      Colors
                                                                          .white,
                                                                      FontWeight
                                                                          .normal),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spaces.kheight10,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                CustomSlider(
                                                                  audioPlayer:
                                                                      audioPlayer,
                                                                  postion:
                                                                      postion,
                                                                  duration:
                                                                      duration,
                                                                  trackHeight:
                                                                      4,
                                                                  thumshape: const RoundSliderThumbShape(
                                                                      disabledThumbRadius:
                                                                          8,
                                                                      enabledThumbRadius:
                                                                          8,
                                                                      elevation:
                                                                          6),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              22,
                                                                          left:
                                                                              23,
                                                                          top:
                                                                              0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Textutil(
                                                                          text: snapshot.data!.mapOrNull(LocalStreams: (value) => value.pos.toString())!.toString().split('.')[
                                                                              0],
                                                                          fontsize:
                                                                              14,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                      Textutil(
                                                                          text: snapshot.data!.mapOrNull(LocalStreams: (value) => value.Dur.toString())!.toString().split('.')[
                                                                              0],
                                                                          fontsize:
                                                                              14,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }
                                                return const SizedBox();
                                              },
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ValueListenableBuilder(
                                                        valueListenable: Notifiers
                                                            .isLoloopednotifier,
                                                        builder: (context,
                                                            value, child) {
                                                          return PlayIcons(
                                                            iconscolors: value
                                                                ? Colors.red
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    75,
                                                                    75,
                                                                    75),
                                                            iconsize: 25,
                                                            playicons:
                                                                CupertinoIcons
                                                                    .loop,
                                                            ontap: () {
                                                              Notifiers
                                                                      .isLoloopednotifier
                                                                      .value =
                                                                  !Notifiers
                                                                      .isLoloopednotifier
                                                                      .value;

                                                              if (Notifiers
                                                                  .isLoloopednotifier
                                                                  .value) {
                                                                BlocProvider.of<
                                                                            AudioBloc>(
                                                                        context)
                                                                    .add(const AudioEvent
                                                                        .loopon(
                                                                        true));
                                                              } else {
                                                                BlocProvider.of<
                                                                            AudioBloc>(
                                                                        context)
                                                                    .add(const AudioEvent
                                                                        .loopon(
                                                                        false));
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      PlayIcons(
                                                        iconscolors: audioPlayer
                                                                .hasPrevious
                                                            ? const Color
                                                                .fromARGB(255,
                                                                255, 255, 255)
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.3),
                                                        iconsize: 35,
                                                        playicons: CupertinoIcons
                                                            .backward_end_fill,
                                                        ontap: () async {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(const AudioEvent
                                                                  .SeekPreviousAudio());
                                                        },
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Card(
                                                            elevation: 5,
                                                            shadowColor:
                                                                Colors.white,
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60)),
                                                            child: Container(
                                                                height: 65,
                                                                width: 65,
                                                                decoration: BoxDecoration(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        239,
                                                                        239,
                                                                        239),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            60)),
                                                                child:
                                                                    PlayIcons(
                                                                        playicons: isplaying
                                                                            ? CupertinoIcons
                                                                                .pause
                                                                            : Icons
                                                                                .play_arrow_rounded,
                                                                        iconscolors:
                                                                            Colors
                                                                                .black,
                                                                        iconsize:
                                                                            25,
                                                                        ontap:
                                                                            () {
                                                                          if (audioPlayer.playing ==
                                                                              true) {
                                                                            setState(() =>
                                                                                isplaying = true);
                                                                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.pause());
                                                                          } else {
                                                                            setState(() =>
                                                                                isplaying = true);
                                                                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.resume());
                                                                          }
                                                                        })),
                                                          ),
                                                        ],
                                                      ),
                                                      PlayIcons(
                                                        iconscolors: audioPlayer
                                                                .hasNext
                                                            ? const Color
                                                                .fromARGB(255,
                                                                255, 255, 255)
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.3),
                                                        iconsize: 35,
                                                        playicons: CupertinoIcons
                                                            .forward_end_fill,
                                                        ontap: () async {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(const AudioEvent
                                                                  .seeknextaudio());
                                                        },
                                                      ),
                                                      ValueListenableBuilder(
                                                        valueListenable: Notifiers
                                                            .isLoshufflednotifier,
                                                        builder: (context,
                                                            value, child) {
                                                          return PlayIcons(
                                                            iconscolors: value
                                                                ? Colors.red
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    75,
                                                                    75,
                                                                    75),
                                                            iconsize: 25,
                                                            playicons:
                                                                CupertinoIcons
                                                                    .shuffle,
                                                            ontap: () {
                                                              Notifiers
                                                                      .isLoshufflednotifier
                                                                      .value =
                                                                  !Notifiers
                                                                      .isLoshufflednotifier
                                                                      .value;

                                                              if (Notifiers
                                                                  .isLoshufflednotifier
                                                                  .value) {
                                                                BlocProvider.of<
                                                                            AudioBloc>(
                                                                        context)
                                                                    .add(const AudioEvent
                                                                        .shuffleon(
                                                                        true));
                                                              } else {
                                                                BlocProvider.of<
                                                                            AudioBloc>(
                                                                        context)
                                                                    .add(const AudioEvent
                                                                        .shuffleon(
                                                                        false));
                                                              }
                                                            },
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 22),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              _showmodelsheet(
                                                                  lateaudios[
                                                                      lateindex!],
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .playlist_add,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        BlocBuilder<
                                                            FavsongsBloc,
                                                            FavsongsState>(
                                                          builder: (context,
                                                              state2) {
                                                            return state2
                                                                .maybeWhen(
                                                                    notpresent:
                                                                        () {
                                                                      return BlocBuilder<
                                                                          FavsongsBloc,
                                                                          FavsongsState>(
                                                                        builder:
                                                                            (context,
                                                                                state1) {
                                                                          return state1.maybeWhen(
                                                                              added: () {
                                                                                return PlayIcons(
                                                                                    playicons: CupertinoIcons.heart_fill,
                                                                                    iconscolors: Colors.red,
                                                                                    iconsize: 25,
                                                                                    ontap: () {
                                                                                      BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.removefromfav(lateaudios[lateindex!].id.toString()));
                                                                                    });
                                                                              },
                                                                              removed: () {
                                                                                return PlayIcons(
                                                                                    playicons: CupertinoIcons.heart,
                                                                                    iconscolors: Colors.white,
                                                                                    iconsize: 25,
                                                                                    ontap: () {
                                                                                      final details = lateaudios[lateindex!];
                                                                                      final song = AlbumElements(id: details.id.toString(), name: details.title, year: '', type: '', language: '', Artist: details.subtitle, url: details.uri, image: '');
                                                                                      BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.addtofav(song, false));
                                                                                    });
                                                                              },
                                                                              orElse: () => PlayIcons(
                                                                                  playicons: CupertinoIcons.heart,
                                                                                  iconscolors: Colors.white,
                                                                                  iconsize: 25,
                                                                                  ontap: () {
                                                                                    final details = lateaudios[lateindex!];
                                                                                    final song = AlbumElements(id: details.id.toString(), name: details.title, year: '', type: '', language: '', Artist: details.subtitle, url: details.uri, image: '');
                                                                                    BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.addtofav(song, false));
                                                                                  }));
                                                                        },
                                                                      );
                                                                    },
                                                                    ispresent:
                                                                        (ispresent) {
                                                                      return PlayIcons(
                                                                          playicons: CupertinoIcons
                                                                              .heart_fill,
                                                                          iconscolors: Colors
                                                                              .red,
                                                                          iconsize:
                                                                              25,
                                                                          ontap:
                                                                              () {
                                                                            BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.checkforfav(lateaudios[lateindex!].id.toString()));

                                                                            BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.checkforfav(lateaudios[lateindex!].id.toString()));

                                                                            BlocProvider.of<FavsongsBloc>(context).add(FavsongsEvent.removefromfav(lateaudios[lateindex!].id.toString()));
                                                                          });
                                                                    },
                                                                    orElse: () => PlayIcons(
                                                                        playicons:
                                                                            CupertinoIcons
                                                                                .heart_fill,
                                                                        iconscolors:
                                                                            Colors
                                                                                .red,
                                                                        iconsize:
                                                                            25,
                                                                        ontap:
                                                                            () {}));
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spaces.kheight20,
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  orElse: () => const SizedBox());
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            ValueListenableBuilder(
              valueListenable: Notifiers.tabindexNotifer,
              builder: (context, value, child) {
                return value == 0
                    ? BlocBuilder<AudioBloc, AudioState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                              Localsongs: (isloading, isfailed, audios,
                                  valueStream, index, audioPlayer) {
                                return SafeArea(
                                  top: false,
                                  child: DraggableScrollableSheet(
                                    minChildSize: 0.07,
                                    initialChildSize: 0.07,
                                    maxChildSize: 1,
                                    builder: (context, scrollController) {
                                      return CustomQueueManager(
                                          scrollController,
                                          local: audios,
                                          page: 'local',
                                          audios: const [],
                                          audioPlayer: audioPlayer);
                                    },
                                  ),
                                );
                              },
                              orElse: () => const SizedBox());
                        },
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LocalQueryArtWidget extends StatelessWidget {
  const LocalQueryArtWidget({
    super.key,
    required this.size,
    required this.audios,
    required this.songindex,
    required this.fit,
  });

  final Size size;
  final List<Songmodel> audios;
  final int songindex;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      color: Colors.transparent,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: QueryArtworkWidget(
          nullArtworkWidget: const NullMusicAlbumWidget(),
          artworkBorder: BorderRadius.circular(0),
          size: 1000,
          format: ArtworkFormat.JPEG,
          artworkFit: fit,
          artworkQuality: FilterQuality.low,
          keepOldArtwork: true,
          artworkWidth: size.width,
          
          artworkBlendMode: BlendMode.colorBurn,
          id: audios[songindex].id,
          type: ArtworkType.AUDIO),
    );
  }
}
