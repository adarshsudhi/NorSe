import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:norse/configs/notifier/notifiers.dart';
import 'package:norse/features/Data/Models/MusicModels/onlinesongmodel.dart';
import 'package:norse/features/Presentation/CustomWidgets/CustomSliderWidget.dart';
import 'package:norse/features/Presentation/CustomWidgets/customqueuemanager.dart';
import 'package:norse/features/Presentation/pages/saavn/musicplayerpage/models/lyricsmodel0.dart';
import 'package:norse/injection_container.dart' as di;
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import '../../../../../Domain/UseCases/Sql_UseCase/addtodownloads_Usecase.dart';
import '../../../../Blocs/Musicbloc/Library/song/library_bloc/library_bloc.dart';
import '../../../../Blocs/Musicbloc/Library/song/songlike_bloc/songlike_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../testonlineplayerscreen.dart';

class Model1 extends StatefulWidget {
  const Model1({
    super.key,
  });

  @override
  State<Model1> createState() => _Model1State();
}

class _Model1State extends State<Model1> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currenttab = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (mounted) {
        setState(() => currenttab = tabController.index);
      }
    });
  }

  void changeduration(int sceconds, AudioPlayer player) {
    Duration duration = Duration(seconds: sceconds);
    player.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    List<OnlineSongModel> audios = [];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.6,
                child: TabBar(
                    controller: tabController,
                    splashFactory: NoSplash.splashFactory,
                    isScrollable: false,
                    physics: const NeverScrollableScrollPhysics(),
                    unselectedLabelColor: Colors.grey,
                    automaticIndicatorColorAdjustment: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    dividerHeight: 0,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    tabs: const [
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text("Now Playing",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text("Lyrics",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 15,
                  )),
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) {
                  return state.maybeMap(
                      onlinesongs: (state) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            BlocBuilder<AudioBloc, AudioState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const SizedBox(),
                                  onlinesongs: (isloading, isfailed, audios,
                                      valueStream, index, audioPlayer) {
                                    return StreamBuilder(
                                      stream: valueStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          int songindex =
                                              snapshot.data!.maybeMap(
                                            orElse: () => 0,
                                            onlinestreams: (val) {
                                              return val.index;
                                            },
                                          );

                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                        .height,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                child: ImageFiltered(
                                                  imageFilter: ImageFilter.blur(
                                                      sigmaX: 90, sigmaY: 90),
                                                  child: CachedNetworkImage(
                                                    imageUrl: audios[songindex]
                                                        .imageurl,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                          .height,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                          colors: [
                                                        Colors.black,
                                                        Colors.black
                                                            .withOpacity(0.8),
                                                        Colors.black
                                                            .withOpacity(0.6),
                                                        Colors.transparent
                                                      ])),
                                                ),
                                              ),
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
                            TabBarView(
                              controller: tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                StreamBuilder(
                                  stream: state.valueStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      double postion = snapshot.data!
                                          .maybeMap(
                                            orElse: () => 0,
                                            onlinestreams: (value) =>
                                                value.pos.inSeconds,
                                          )
                                          .toDouble();

                                      double duration = snapshot.data!
                                          .maybeMap(
                                            orElse: () => 0,
                                            onlinestreams: (value) =>
                                                value.dur.inSeconds,
                                          )
                                          .toDouble();

                                      PlayerState duplayer = PlayerState(
                                          false, ProcessingState.loading);

                                      final songindex = snapshot.data!.maybeMap(
                                        orElse: () => 0,
                                        onlinestreams: (value) => value.index,
                                      );

                                      PlayerState playerState =
                                          snapshot.data!.maybeMap(
                                        orElse: () => duplayer,
                                        onlinestreams: (value) =>
                                            value.playerState,
                                      );

                                      audios = List.from(state.audios);

                                      audios.isNotEmpty
                                          ? BlocProvider.of<SonglikeBloc>(
                                                  context)
                                              .add(SonglikeEvent.checkifpresent(
                                                  audios[songindex].id))
                                          : null;

                                      return SafeArea(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25, right: 25, top: 10),
                                              child: Card(
                                                shadowColor: Colors.black,
                                                color: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                elevation: 5,
                                                child: SizedBox(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height /
                                                        2.7,
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: Material(
                                                      elevation: 6,
                                                      surfaceTintColor:
                                                          Colors.transparent,
                                                      color: Colors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Hero(
                                                        tag: '2',
                                                        child: Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: CachedNetworkImage(
                                                                imageUrl: audios[
                                                                        songindex]
                                                                    .imageurl,
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    )),
                                              ),
                                            ),

                                            Column(
                                              children: [
                                                audios[songindex]
                                                            .title
                                                            .length <=
                                                        20
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 35,
                                                                left: 35),
                                                        child: SizedBox(
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Textutil(
                                                                  text: audios[
                                                                          songindex]
                                                                      .title,
                                                                  fontsize: 30,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ],
                                                          ),
                                                        ))
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 35,
                                                                left: 35),
                                                        child: SizedBox(
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          child: Textutil(
                                                              text: audios[
                                                                      songindex]
                                                                  .title,
                                                              fontsize: 30,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30, left: 30),
                                                  child: Text(
                                                    audios[songindex].artist,
                                                    style: Spaces.Getstyle(
                                                        12,
                                                        Colors.white,
                                                        FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(children: [
                                                    SizedBox(
                                                        height: 30,
                                                        child: CustomSlider(
                                                          audioPlayer:
                                                              state.audioPlayer,
                                                          postion: postion,
                                                          duration: duration,
                                                          trackHeight: 5,
                                                          thumshape: const RoundSliderThumbShape(
                                                              enabledThumbRadius:
                                                                  8,
                                                              disabledThumbRadius:
                                                                  8,
                                                              elevation: 7),
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    onlinestreams:
                                                                        (value) => value
                                                                            .pos
                                                                            .toString())!
                                                                .toString()
                                                                .split(".")[0]
                                                                .replaceRange(
                                                                    0, 2, ""),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            snapshot.data!
                                                                .mapOrNull(
                                                                    onlinestreams:
                                                                        (value) => value
                                                                            .dur
                                                                            .toString())!
                                                                .toString()
                                                                .split(".")[0]
                                                                .replaceRange(
                                                                    0, 2, ""),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      Notifiers.isloopednotifer,
                                                  builder: (context, bool value,
                                                      child) {
                                                    return PlayIcons(
                                                      iconscolors: value
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(
                                                              255, 68, 68, 68),
                                                      iconsize: 25,
                                                      playicons: CupertinoIcons
                                                          .loop_thick,
                                                      ontap: () {
                                                        Notifiers
                                                                .isloopednotifer
                                                                .value =
                                                            !Notifiers
                                                                .isloopednotifer
                                                                .value;

                                                        if (Notifiers
                                                            .isloopednotifer
                                                            .value) {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(
                                                                  const AudioEvent
                                                                      .loopon(
                                                                      true));
                                                        } else {
                                                          BlocProvider.of<
                                                                      AudioBloc>(
                                                                  context)
                                                              .add(
                                                                  const AudioEvent
                                                                      .loopon(
                                                                      false));
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                                PlayIcons(
                                                  iconscolors: state.audioPlayer
                                                          .hasPrevious
                                                      ? const Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : Colors.white
                                                          .withOpacity(0.3),
                                                  iconsize: 30,
                                                  playicons: CupertinoIcons
                                                      .backward_end_fill,
                                                  ontap: () async {
                                                    BlocProvider.of<AudioBloc>(
                                                            context)
                                                        .add(const AudioEvent
                                                            .SeekPreviousAudio());
                                                  },
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    playerState.processingState ==
                                                                ProcessingState
                                                                    .loading ||
                                                            playerState
                                                                    .processingState ==
                                                                ProcessingState
                                                                    .buffering
                                                        ? const SizedBox(
                                                            height: 75,
                                                            width: 75,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                        : const SizedBox(),
                                                    Card(
                                                      elevation: 11,
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60)),
                                                      child: Container(
                                                          height: 65,
                                                          width: 65,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      239,
                                                                      239,
                                                                      239),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60)),
                                                          child: PlayIcons(
                                                              playicons: state
                                                                          .audioPlayer
                                                                          .playing ==
                                                                      true
                                                                  ? CupertinoIcons
                                                                      .pause
                                                                  : CupertinoIcons
                                                                      .play_arrow,
                                                              iconscolors:
                                                                  Colors.black,
                                                              iconsize: 25,
                                                              ontap: () {
                                                                if (state
                                                                        .audioPlayer
                                                                        .playing ==
                                                                    true) {
                                                                  BlocProvider.of<
                                                                              AudioBloc>(
                                                                          context)
                                                                      .add(const AudioEvent
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
                                                  iconscolors: state
                                                          .audioPlayer.hasNext
                                                      ? const Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : Colors.white
                                                          .withOpacity(0.3),
                                                  iconsize: 30,
                                                  playicons: CupertinoIcons
                                                      .forward_end_fill,
                                                  ontap: () async {
                                                    BlocProvider.of<AudioBloc>(
                                                            context)
                                                        .add(const AudioEvent
                                                            .seeknextaudio());
                                                  },
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable: Notifiers
                                                      .isshufflednotifier,
                                                  builder: (context, bool value,
                                                      child) {
                                                    return PlayIcons(
                                                      iconscolors: value
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(
                                                              255, 68, 68, 68),
                                                      iconsize: 25,
                                                      playicons: CupertinoIcons
                                                          .shuffle,
                                                      ontap: () {
                                                        Notifiers
                                                                .isshufflednotifier
                                                                .value =
                                                            !Notifiers
                                                                .isshufflednotifier
                                                                .value;

                                                        if (Notifiers
                                                            .isshufflednotifier
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
                                                ),
                                              ],
                                            ),

                                            //Ends Here
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 17),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  PlayIcons(
                                                      playicons: Icons.download,
                                                      iconscolors:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      iconsize: 26,
                                                      ontap: () async {
                                                        audios.isNotEmpty
                                                            ? _downloadsong(
                                                                audios,
                                                                songindex)
                                                            : null;
                                                      }),
                                                  BlocBuilder<SonglikeBloc,
                                                      SonglikeState>(
                                                    builder: (context, state0) {
                                                      return state0.maybeWhen(
                                                          removed: () {
                                                        return PlayIcons(
                                                            playicons:
                                                                CupertinoIcons
                                                                    .heart,
                                                            iconscolors:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            iconsize: 26,
                                                            ontap: () {
                                                              AlbumElements song = AlbumElements(
                                                                  id: audios[
                                                                          songindex]
                                                                      .id,
                                                                  name: audios[
                                                                          songindex]
                                                                      .title,
                                                                  year: '',
                                                                  type: 'null',
                                                                  language:
                                                                      'null',
                                                                  Artist: audios[
                                                                          songindex]
                                                                      .artist,
                                                                  url: audios[
                                                                          songindex]
                                                                      .downloadurl,
                                                                  image: audios[
                                                                          songindex]
                                                                      .imageurl);
                                                              BlocProvider.of<
                                                                          SonglikeBloc>(
                                                                      context)
                                                                  .add(SonglikeEvent
                                                                      .addtolibray(
                                                                          'song',
                                                                          song));
                                                              _callallsongs(
                                                                  context);
                                                            });
                                                      }, added: () {
                                                        return PlayIcons(
                                                            playicons:
                                                                CupertinoIcons
                                                                    .heart_fill,
                                                            iconscolors:
                                                                Colors.red,
                                                            iconsize: 26,
                                                            ontap: () {
                                                              AlbumElements song = AlbumElements(
                                                                  id: audios[
                                                                          songindex]
                                                                      .id,
                                                                  name: audios[
                                                                          songindex]
                                                                      .title,
                                                                  year: '',
                                                                  type: 'null',
                                                                  language:
                                                                      'null',
                                                                  Artist: audios[
                                                                          songindex]
                                                                      .artist,
                                                                  url: audios[
                                                                          songindex]
                                                                      .downloadurl,
                                                                  image: audios[
                                                                          songindex]
                                                                      .imageurl);
                                                              BlocProvider.of<
                                                                          SonglikeBloc>(
                                                                      context)
                                                                  .add(SonglikeEvent
                                                                      .addtolibray(
                                                                          'song',
                                                                          song));
                                                              _callallsongs(
                                                                  context);
                                                            });
                                                      }, ispresent:
                                                              (ispresent) {
                                                        return PlayIcons(
                                                            playicons: ispresent
                                                                ? CupertinoIcons
                                                                    .heart_fill
                                                                : CupertinoIcons
                                                                    .heart,
                                                            iconscolors: ispresent
                                                                ? Colors.red
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            iconsize: 26,
                                                            ontap: () {
                                                              AlbumElements song = AlbumElements(
                                                                  id: audios[
                                                                          songindex]
                                                                      .id,
                                                                  name: audios[
                                                                          songindex]
                                                                      .title,
                                                                  year: '',
                                                                  type: 'null',
                                                                  language:
                                                                      'null',
                                                                  Artist: audios[
                                                                          songindex]
                                                                      .artist,
                                                                  url: audios[
                                                                          songindex]
                                                                      .downloadurl,
                                                                  image: audios[
                                                                          songindex]
                                                                      .imageurl);
                                                              BlocProvider.of<
                                                                          SonglikeBloc>(
                                                                      context)
                                                                  .add(SonglikeEvent
                                                                      .addtolibray(
                                                                          'song',
                                                                          song));
                                                              _callallsongs(
                                                                  context);
                                                            });
                                                      }, orElse: () {
                                                        return PlayIcons(
                                                            playicons:
                                                                CupertinoIcons
                                                                    .heart,
                                                            iconscolors:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            iconsize: 26,
                                                            ontap: () {
                                                              AlbumElements song = AlbumElements(
                                                                  id: audios[
                                                                          songindex]
                                                                      .id,
                                                                  name: audios[
                                                                          songindex]
                                                                      .title,
                                                                  year: '',
                                                                  type: 'null',
                                                                  language:
                                                                      'null',
                                                                  Artist: audios[
                                                                          songindex]
                                                                      .artist,
                                                                  url: audios[
                                                                          songindex]
                                                                      .downloadurl,
                                                                  image: audios[
                                                                          songindex]
                                                                      .imageurl);
                                                              BlocProvider.of<
                                                                          SonglikeBloc>(
                                                                      context)
                                                                  .add(SonglikeEvent
                                                                      .addtolibray(
                                                                          'song',
                                                                          song));
                                                              _callallsongs(
                                                                  context);
                                                            });
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                                const LyricsModel0()
                              ],
                            ),
                          ],
                        );
                      },
                      orElse: () => const SizedBox());
                },
              ),
            ),
          ),
          currenttab != 0
              ? const SizedBox()
              : BlocBuilder<AudioBloc, AudioState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        onlinesongs: (isloading, isfailed, audios, valueStream,
                            index, audioPlayer) {
                          return SafeArea(
                            top: false,
                            child: DraggableScrollableSheet(
                              minChildSize: 0.07,
                              initialChildSize: 0.07,
                              maxChildSize: 1,
                              builder: (context, scrollController) {
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  child: CustomQueueManager(scrollController,
                                      local: const [],
                                      page: 'online',
                                      audios: audios,
                                      audioPlayer: audioPlayer),
                                );
                              },
                            ),
                          );
                        },
                        orElse: () => const SizedBox());
                  },
                )
        ],
      ),
    );
  }

  _callallsongs(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      BlocProvider.of<LibraryBloc>(context)
          .add(const LibraryEvent.getlibrarysong());
    });
  }

  _downloadsong(List<OnlineSongModel> song, int index) async {
    log(song[index].downloadurl.toString());
    final data = song[index];
    AlbumElements albumElements = AlbumElements(
        id: data.id,
        name: data.title,
        year: 'null',
        type: data.album,
        language: 'null',
        Artist: data.artist,
        url: data.downloadurl,
        image: data.imageurl);
    await di.di<addtodownloadsUsecase>().call(albumElements);
  }
}
