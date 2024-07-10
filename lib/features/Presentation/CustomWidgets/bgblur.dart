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
                  final songindex = snapshot.data!.maybeMap(
                    orElse: () => 0,
                    onlinestreams: (value) => value.index,
                  );

                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: CachedNetworkImage(
                      imageUrl: audios[songindex].imageurl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
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
                  final songindex = snapshot.data!.mapOrNull(
                    LocalStreams: (value) => value.index,
                  );
                  return QueryArtworkWidget(
                      keepOldArtwork: true,
                      size: 5,
                      id: audios[songindex!].id,
                      type: ArtworkType.AUDIO);
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
