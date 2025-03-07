import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:norse/features/Presentation/pages/saavn/queue/onlinequeue.dart';
import 'package:norse/features/Presentation/pages/saavn/queue/queue.dart';

import '../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../../Data/Models/MusicModels/songmodel.dart';

class CustomQueueManager extends StatefulWidget {
  final List<OnlineSongModel> audios;
  final AudioPlayer audioPlayer;
  final List<Songmodel> local;
  final String page;
  final ScrollController controller;

  const CustomQueueManager(
    this.controller, {
    super.key,
    required this.audios,
    required this.audioPlayer,
    required this.page,
    required this.local,
  });

  @override
  State<CustomQueueManager> createState() => _CustomQueueManagerState();
}

class _CustomQueueManagerState extends State<CustomQueueManager> {
  @override
  Widget build(BuildContext context) {
    return widget.page == "online"
        ? Onlinequeue(
            audios: widget.audios,
            audioPlayer: widget.audioPlayer,
            controller: widget.controller,
          )
        : Reorder(
            audios: widget.local,
            audioPlayer: widget.audioPlayer,
            controller: widget.controller,
          );
  }
}
