import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';

class BGblur extends StatelessWidget {
  const BGblur({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox(),
          onlinesongs:
              (isloading, isfailed, audios, valueStream, index, audioPlayer) {
            return StreamBuilder(
              stream: valueStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  int songindex = snapshot.data!.maybeMap(
                      orElse: () => 0, onlinestreams: (val) => val.index);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: CachedNetworkImage(
                          imageUrl: audios[songindex].imageurl,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.96),
                              Colors.black.withOpacity(0.79),
                            ])),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          },
          Localsongs:
              (isloading, isfailed, audios, valueStream, index, audioPlayer) {
            return StreamBuilder(
              stream: valueStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final songindex = snapshot.data!.maybeMap(
                    orElse: () => 0,
                    LocalStreams: (value) => value.index,
                  );
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
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.95),
                              Colors.black.withOpacity(0.79),
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
    );
  }
}
