import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../Data/Models/MusicModels/songmodel.dart';
import '../../../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Songwidget extends StatefulWidget {
  final int count;

  const Songwidget({super.key, required this.count});

  @override
  State<Songwidget> createState() => _SongwidgetState();
}

class _SongwidgetState extends State<Songwidget> {
  getallsongs(BuildContext context) {
    BlocProvider.of<LocalsongBloc>(context)
        .add(const LocalsongEvent.getallsongs());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spaces.kheight20,
        Expanded(
          child: BlocBuilder<LocalsongBloc, LocalsongState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                songs: (localaudios, albums, isloading, failed) {
                  if (isloading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else {
                    return SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Textutil(
                                    text: 'songs(${localaudios.length})',
                                    fontsize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                TextButton.icon(
                                    style: const ButtonStyle(
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () async {
                                      await getallsongs(context);
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    label: const Textutil(
                                        text: 'Refresh',
                                        fontsize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                          ),
                          Spaces.kheight10,
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: localaudios.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.localaudio(
                                            localaudios, [], index));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          QueryArtworkWidget(
                                              artworkHeight: 55,
                                              artworkWidth: 60,
                                              nullArtworkWidget: const Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                              ),
                                              artworkBorder:
                                                  BorderRadius.circular(10),
                                              id: localaudios[index].id,
                                              type: ArtworkType.AUDIO),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Textutil(
                                                    text: localaudios[index]
                                                        .displayNameWOExt,
                                                    fontsize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                Textutil(
                                                    text: localaudios[index]
                                                                .artist !=
                                                            null
                                                        ? localaudios[index]
                                                            .artist!
                                                        : "unknown",
                                                    fontsize: 10,
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    fontWeight: FontWeight.bold)
                                              ],
                                            ),
                                          ),
                                          PopupMenuButton(
                                            iconColor: Colors.white,
                                            itemBuilder: (BuildContext contex) {
                                              return [
                                                PopupMenuItem(
                                                    onTap: () {
                                                      Songmodel songmodel = Songmodel(
                                                          id: localaudios[index]
                                                              .id,
                                                          title: localaudios[
                                                                  index]
                                                              .displayNameWOExt,
                                                          subtitle:
                                                              localaudios[index]
                                                                      .artist ??
                                                                  "unkown",
                                                          uri:
                                                              localaudios[index]
                                                                  .uri!);
                                                      BlocProvider.of<
                                                                  AudioBloc>(
                                                              context)
                                                          .add(AudioEvent
                                                              .addsongtoqueue(
                                                                  'local',
                                                                  songmodel));
                                                    },
                                                    child: const Text(
                                                        'Add to Queue')),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spaceadjust()
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
