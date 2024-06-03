import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../configs/constants/Spaces.dart';
import '../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';

class MusicbottombarWidget extends StatelessWidget {
  const MusicbottombarWidget({
    Key? key,
    required this.songindex,
    required this.ontap,
    required this.audios,
    required this.audioPlayer,
    required this.playerState,
    required this.type,
  }) : super(key: key);

  final int songindex;
  final String type;
  final VoidCallback ontap;
  final List<OnlineSongModel> audios;
  final AudioPlayer audioPlayer;
  final PlayerState playerState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: Spaces.musicgradient()),
        child: Center(
          child: ListTile(
            leading: Container(
                height: 50,
                width: 50,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/musical-note.png',
                      color: Colors.black.withOpacity(0.5),
                    );
                  },
                  audios[songindex].imageurl,
                  fit: BoxFit.cover,
                )),
            title: SizedBox(
              height: 20,
              width: 150,
              child: Textutil(
                  text: audios[songindex].title,
                  fontsize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: SizedBox(
              height: 12,
              width: 100,
              child: Textutil(
                  text: audios[songindex].artist,
                  fontsize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            trailing: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<AudioBloc>(context)
                            .add(const AudioEvent.SeekPreviousAudio());
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
                      height: 45,
                      width: 45,
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
                        BlocProvider.of<AudioBloc>(context)
                            .add(const AudioEvent.seeknextaudio());
                      },
                      icon: Icon(
                        CupertinoIcons.forward_end_fill,
                        color: audioPlayer.hasNext ? Colors.white : Colors.grey,
                        size: 15,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
