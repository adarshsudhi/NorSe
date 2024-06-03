import 'package:flutter/cupertino.dart';
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

class _SongwidgetState extends State<Songwidget>
    with SingleTickerProviderStateMixin {
  late List<Animation<Offset>> animations;

  late Animation<double> fadetransitionsanimations;

  late AnimationController slidercontroller;

  @override
  void initState() {
    super.initState();

    slidercontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    animations = List.generate(
        widget.count,
        (index) => Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: slidercontroller,
                curve: Interval(index * (1 / widget.count), 1,
                    curve: Curves.easeIn))));

    fadetransitionsanimations =
        Tween<double>(begin: 0, end: 1).animate(slidercontroller);

    slidercontroller.forward();
  }

  @override
  void dispose() {
    slidercontroller.dispose();
    super.dispose();
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
                songs: (songlist, albums, isloading, failed) {
                  if (isloading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else {
                    return SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: BlocBuilder<FavoriteplaylistBloc,
                                FavoriteplaylistState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                    favsongs: (songs) {
                                      return songs.isNotEmpty
                                          ? SizedBox(
                                              height: 290,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textutil(
                                                      text:
                                                          'Favorite(${songs.length})',
                                                      fontsize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  Spaces.kheight10,
                                                  Expanded(
                                                      child: PageView.builder(
                                                    controller: PageController(
                                                      viewportFraction: 1,
                                                    ),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        (songs.length / 3)
                                                            .ceil(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SizedBox(
                                                        width: size.width,
                                                        child: Column(
                                                          children:
                                                              List.generate(
                                                            3,
                                                            (innerIndex) {
                                                              final itemIndex =
                                                                  index * 3 +
                                                                      innerIndex;
                                                              if (itemIndex <
                                                                  songs
                                                                      .length) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          3),
                                                                  child: Card(
                                                                    elevation:
                                                                        10,
                                                                    shadowColor: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.3),
                                                                    color: Colors
                                                                        .transparent,
                                                                    surfaceTintColor:
                                                                        Colors
                                                                            .transparent,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          70,
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              40),
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.2)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],
                                                                                songs,
                                                                                itemIndex));
                                                                          },
                                                                          child:
                                                                              ListTile(
                                                                            leading:
                                                                                SizedBox(
                                                                              height: 60,
                                                                              width: 60,
                                                                              child: Stack(
                                                                                alignment: Alignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    height: 46,
                                                                                    width: 46,
                                                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: QueryArtworkWidget(
                                                                                      id: int.parse(songs[itemIndex]['id']),
                                                                                      type: ArtworkType.AUDIO,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            title: Textutil(
                                                                                text: songs[itemIndex]['title'],
                                                                                fontsize: 13,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                            subtitle: Textutil(
                                                                                text: songs[itemIndex]['artist'],
                                                                                fontsize: 10,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                            trailing:
                                                                                Container(
                                                                              height: 40,
                                                                              width: 40,
                                                                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(60)),
                                                                              child: const Center(
                                                                                child: Icon(
                                                                                  CupertinoIcons.play_arrow,
                                                                                  color: Colors.white,
                                                                                  size: 15,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Container();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )),
                                                ],
                                              ),
                                            )
                                          : const SizedBox();
                                    },
                                    orElse: () => const SizedBox());
                              },
                            ),
                          ), */
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Textutil(
                                    text: 'songs(${songlist.length})',
                                    fontsize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                          Spaces.kheight10,
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: songlist.length,
                            itemBuilder: (context, index) {
                              return SlideTransition(
                                position: animations[index],
                                child: FadeTransition(
                                  opacity: fadetransitionsanimations,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<AudioBloc>(context).add(
                                            AudioEvent.localaudio(
                                                songlist, [], index));
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
                                                  nullArtworkWidget: SizedBox(
                                                    height: 55,
                                                    width: 60,
                                                    child: Image.asset(
                                                      'assets/musical-note.png',
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  artworkBorder:
                                                      BorderRadius.circular(10),
                                                  id: songlist[index].id,
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
                                                        text: songlist[index]
                                                            .displayNameWOExt,
                                                        fontsize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    Textutil(
                                                        text: songlist[index]
                                                                    .artist !=
                                                                null
                                                            ? songlist[index]
                                                                .artist!
                                                            : "unknown",
                                                        fontsize: 10,
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.bold)
                                                  ],
                                                ),
                                              ),
                                              PopupMenuButton(
                                                iconColor: Colors.white,
                                                itemBuilder:
                                                    (BuildContext contex) {
                                                  return [
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          Songmodel songmodel = Songmodel(
                                                              id: songlist[
                                                                      index]
                                                                  .id,
                                                              title: songlist[
                                                                      index]
                                                                  .displayNameWOExt,
                                                              subtitle: songlist[
                                                                          index]
                                                                      .artist ??
                                                                  "unkown",
                                                              uri: songlist[
                                                                      index]
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
