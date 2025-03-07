import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/Blocs/Connectivity_bloc/connnectivity_bloc.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/CustomSliderWidget.dart';
import 'package:norse/features/Presentation/pages/MainHomePage/MainHomePage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CustomWidgets/musicbottombarloading.dart';
import '../testonlineplayerscreen.dart';

class LyricsModel extends StatefulWidget {
  const LyricsModel({super.key, required this.size, required this.title});
  final Size size;
  final String title;

  @override
  State<LyricsModel> createState() => _LyricsModelState();
}

class _LyricsModelState extends State<LyricsModel> {
  int progresss = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) {
                  return state.maybeWhen(Localsongs: (isloading, isfailed,
                      audios, valueStream, index, audioPlayer) {
                    return StreamBuilder(
                      stream: valueStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          int songindex = snapshot.data!.maybeWhen(
                              LocalStreams: (pos, dur, playerState, index) =>
                                  index,
                              orElse: () => 0);
                          return Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Textutil(
                                                    text:
                                                        audios[songindex].title,
                                                    fontsize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Textutil(
                                                    text: audios[songindex]
                                                        .subtitle,
                                                    fontsize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spaces.kheight10,
                                    Expanded(
                                      child: BlocBuilder<ConnnectivityBloc,
                                          ConnnectivityState>(
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                              networkstate: (isavailable) {
                                                return isavailable
                                                    ? Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          SizedBox(
                                                            width: widget
                                                                .size.width,
                                                            child: Column(
                                                              children: [
                                                                progresss != 100
                                                                    ? LinearProgressIndicator(
                                                                        minHeight:
                                                                            2,
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                        color: Colors
                                                                            .white,
                                                                        value: progresss /
                                                                            100,
                                                                      )
                                                                    : const SizedBox(),
                                                                Expanded(
                                                                    child:
                                                                        SizedBox()),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : NetworKerrorwidget(
                                                        color:
                                                            Colors.transparent,
                                                        size: widget.size);
                                              },
                                              orElse: () => const SizedBox());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: widget.size.width,
                                child: BlocBuilder<AudioBloc, AudioState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                        Localsongs: (isloading,
                                            isfailed,
                                            audios,
                                            valueStream,
                                            index,
                                            audioPlayer) {
                                          return isloading == true
                                              ? const MusicBottomBarloading()
                                              : StreamBuilder(
                                                  stream: valueStream,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.data != null) {
                                                      double postion =
                                                          snapshot.data!
                                                              .maybeMap(
                                                                orElse: () => 0,
                                                                LocalStreams:
                                                                    (value) => value
                                                                        .pos
                                                                        .inSeconds,
                                                              )
                                                              .toDouble();

                                                      double duration =
                                                          snapshot.data!
                                                              .maybeMap(
                                                                orElse: () => 0,
                                                                LocalStreams:
                                                                    (value) => value
                                                                        .Dur
                                                                        .inSeconds,
                                                              )
                                                              .toDouble();

                                                      PlayerState player =
                                                          PlayerState(
                                                              true,
                                                              ProcessingState
                                                                  .loading);

                                                      PlayerState playerState =
                                                          snapshot.data!
                                                              .maybeMap(
                                                        orElse: () => player,
                                                        LocalStreams: (value) =>
                                                            value.playerState,
                                                      );

                                                      int songindex = snapshot
                                                          .data!
                                                          .maybeMap(
                                                        orElse: () => 0,
                                                        LocalStreams: (value) =>
                                                            value.index,
                                                      );

                                                      return GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                            height: 73,
                                                            decoration: BoxDecoration(
                                                                gradient: Spaces
                                                                    .musicgradient()),
                                                            child: Stack(
                                                              fit: StackFit
                                                                  .expand,
                                                              children: [
                                                                QueryArtworkWidget(
                                                                  id: audios[
                                                                          songindex]
                                                                      .id,
                                                                  artworkQuality:
                                                                      FilterQuality
                                                                          .low,
                                                                  type:
                                                                      ArtworkType
                                                                          .AUDIO,
                                                                  size: 1000,
                                                                  artworkBlendMode:
                                                                      BlendMode
                                                                          .plus,
                                                                  artworkClipBehavior:
                                                                      Clip.antiAlias,
                                                                  keepOldArtwork:
                                                                      true,
                                                                  format:
                                                                      ArtworkFormat
                                                                          .JPEG,
                                                                  artworkBorder:
                                                                      BorderRadius
                                                                          .zero,
                                                                  nullArtworkWidget:
                                                                      Shimmer(
                                                                          gradient:
                                                                              const LinearGradient(colors: [
                                                                            Colors.grey,
                                                                            Colors.white
                                                                          ]),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                          )),
                                                                ),
                                                                Container(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      QueryArtworkWidget(
                                                                        keepOldArtwork:
                                                                            true,
                                                                        id: audios[songindex]
                                                                            .id,
                                                                        type: ArtworkType
                                                                            .AUDIO,
                                                                        artworkHeight:
                                                                            50,
                                                                        artworkWidth:
                                                                            50,
                                                                        artworkBorder:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                      Expanded(
                                                                        child: SizedBox(
                                                                            height: 73,
                                                                            width: MediaQuery.sizeOf(context).width,
                                                                            child: Column(
                                                                              children: [
                                                                                CustomSlider(postion: postion, duration: duration, trackHeight: 2, thumshape: const RoundSliderThumbShape(), audioPlayer: audioPlayer),
                                                                                SizedBox(
                                                                                  width: widget.size.width,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 26),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Textutil(text: snapshot.data!.mapOrNull(LocalStreams: (value) => value.pos.toString())!.toString().split('.')[0], fontsize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                                                                        Textutil(text: snapshot.data!.mapOrNull(LocalStreams: (value) => value.Dur.toString())!.toString().split('.')[0], fontsize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 239, 239, 239),
                                                                              borderRadius: BorderRadius.circular(60)),
                                                                          child: PlayIcons(
                                                                              playicons: playerState.playing ? CupertinoIcons.pause : Icons.play_arrow_rounded,
                                                                              iconscolors: Colors.black,
                                                                              iconsize: 25,
                                                                              ontap: () {
                                                                                if (audioPlayer.playing == true) {
                                                                                  BlocProvider.of<AudioBloc>(context).add(const AudioEvent.pause());
                                                                                } else {
                                                                                  BlocProvider.of<AudioBloc>(context).add(const AudioEvent.resume());
                                                                                }
                                                                              })),
                                                                    ],
                                                                  ),
                                                                ),
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
                                ),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  }, orElse: () {
                    return const SizedBox();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
