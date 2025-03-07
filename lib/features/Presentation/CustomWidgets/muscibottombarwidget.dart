// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:norse/features/Presentation/CustomWidgets/CustomSliderWidget.dart';

import '../../../configs/constants/Spaces.dart';
import '../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';

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
