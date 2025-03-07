// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.postion,
    required this.duration,
    required this.trackHeight,
    required this.thumshape,
    this.secondaryTrackValue,
    required this.audioPlayer,
  }) : super(key: key);
  final double postion;
  final double duration;
  final double trackHeight;
  final SliderComponentShape thumshape;
  final double? secondaryTrackValue;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
          trackShape: const RectangularSliderTrackShape(),
          trackHeight: trackHeight,
          thumbShape: thumshape),
      child: Slider(
        secondaryTrackValue: secondaryTrackValue ?? 0,
        secondaryActiveColor: Colors.grey.withOpacity(0.6),
        thumbColor: const Color.fromARGB(255, 255, 255, 255),
        activeColor: const Color.fromARGB(255, 255, 255, 255),
        inactiveColor:
            const Color.fromARGB(255, 125, 125, 125).withOpacity(0.6),
        value: postion,
        max: duration,
        min: const Duration(microseconds: 0).inSeconds.toDouble(),
        onChanged: (value) async {
          Duration duration = Duration(seconds: value.toInt());
          await audioPlayer.seek(duration);
        },
      ),
    );
  }
}
