// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/notifier/notifiers.dart';
import 'package:norse/features/Presentation/pages/saavn/subscreens/SongDetailsPage/SongDetailsPage.dart';
import 'package:norse/features/Presentation/pages/saavn/subscreens/edittrackdetails/edittrackdetailspage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:norse/features/Presentation/CustomWidgets/modelbottamsheet.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../Data/Models/MusicModels/songmodel.dart';
import '../../../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../../CustomWidgets/nullmusicWidget.dart';

class Songwidget extends StatefulWidget {
  final int count;
  const Songwidget({super.key, required this.count});

  @override
  State<Songwidget> createState() => _SongwidgetState();
}

class _SongwidgetState extends State<Songwidget> {
  @override
  void initState() {
    Notifiers.showMenu.value = false;
    super.initState();
  }

  SongModel songModel = SongModel({});
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spaces.kheigth5,
        Expanded(
          child: BlocBuilder<LocalsongBloc, LocalsongState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                songs: (localaudios, albums, artist, genre, isloading, failed) {
                  if (isloading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else {
                    return RepaintBoundary(
                      child: Stack(
                        children: [
                          CustomScrollView(
                            shrinkWrap: true,
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textutil(
                                        text: 'Tracks(${localaudios.length})',
                                        fontsize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    Spaces.kheigth5,
                                  ],
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 9),
                                      child: InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          Notifiers.showplayer.value = true;

                                          BlocProvider.of<AudioBloc>(context)
                                              .add(AudioEvent.localaudio(
                                                  localaudios, [], index));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: Row(
                                            children: [
                                              QueryArtworkWidget(
                                                  artworkFit: BoxFit.fitHeight,
                                                  artworkWidth: 55,
                                                  artworkHeight: 54,
                                                  nullArtworkWidget: const NullMusicAlbumWidget(),
                                                  artworkBorder:
                                                      BorderRadius.circular(9),
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
                                                            .title,
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
                                                        fontWeight:
                                                            FontWeight.bold)
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      currentindex = index;
                                                      songModel =
                                                          localaudios[index];
                                                    });
                                                    Notifiers.showMenu.value =
                                                        !Notifiers
                                                            .showMenu.value;
                                                  },
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: localaudios.length,
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: Spaceadjust(),
                              )
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: Notifiers.showMenu,
                            builder: (context, value, child) {
                              if (!value) return const SizedBox.shrink();

                              return Stack(
                                children: [
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  Container(
                                    color: Colors.black,
                                    height:
                                        MediaQuery.sizeOf(context).height / 1.8,
                                    child: SafeArea(
                                      child: IndividialSongMenu(
                                          song: songModel,
                                          audios: localaudios,
                                          index: currentindex),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
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

class IndividialSongMenu extends StatelessWidget {
  const IndividialSongMenu({
    super.key,
    required this.song,
    required this.audios,
    required this.index,
  });
  final SongModel song;
  final List<SongModel> audios;
  final int index;

  _showmodelsheet(Songmodel songmodel, BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Custombottomsheet(
          songModel: songmodel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                QueryArtworkWidget(
                  keepOldArtwork: true,
                  nullArtworkWidget: const NullMusicAlbumWidget(),
                  artworkBorder: BorderRadius.circular(5),
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: 50,
                  artworkWidth: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textutil(
                            text: song.title,
                            fontsize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        Textutil(
                            text: song.artist ?? 'unkown',
                            fontsize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.share,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IndividualItemwidgets(
                            iconcolor: Colors.white,
                            title: 'Play',
                            iconDatal: CupertinoIcons.play_arrow_solid,
                            voidCallback: () {
                              BlocProvider.of<AudioBloc>(context).add(
                                  AudioEvent.localaudio(audios, [], index));
                            }),
                        IndividualItemwidgets(
                            iconcolor: Colors.white,
                            title: 'Add to queue',
                            iconDatal: Icons.queue,
                            voidCallback: () {
                              Songmodel songmodel = Songmodel(
                                  id: song.id,
                                  title: song.title,
                                  subtitle: song.artist ?? "unkown",
                                  uri: song.uri!);
                              BlocProvider.of<AudioBloc>(context).add(
                                  AudioEvent.addsongtoqueue(
                                      'local', songmodel));
                            }),
                      ],
                    ),
                  )),
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IndividualItemwidgets(
                            iconcolor: Colors.white,
                            title: 'Add to playlist',
                            iconDatal: Icons.playlist_add,
                            voidCallback: () {
                              Songmodel songmodel = Songmodel(
                                  id: song.id,
                                  title: song.title,
                                  subtitle: song.artist ?? 'unkown',
                                  uri: song.uri!);
                              _showmodelsheet(songmodel, context);
                            }),
                        audios[index].displayNameWOExt.contains("yt")
                            ? const SizedBox()
                            : IndividualItemwidgets(
                                iconcolor: Colors.white,
                                title: 'Edit info',
                                iconDatal: Icons.info,
                                voidCallback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              EditAudioTagsPage(audio: song)));
                                }),
                      ],
                    ),
                  )),
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*  IndividualItemwidgets(
                            iconcolor: Colors.red,
                            title: 'Delete from device',
                            iconDatal: Icons.delete,
                            voidCallback: () {
                              Notifiers.showMenu.value = false;
                              showAlert(context, song.title);
                            }), */
                        IndividualItemwidgets(
                            iconcolor: Colors.red,
                            title: 'Close',
                            iconDatal: Icons.close_outlined,
                            voidCallback: () {
                              Notifiers.showMenu.value = false;
                              // Navigator.pop(context);
                            }),
                      ],
                    ),
                  )),
            ],
          ),
        )),
      ],
    );
  }

  Future<dynamic> showAlert(BuildContext context, String title) {
    return showDialog(
        context: context,
        builder: (dialogcontext) {
          return Dialog(
            surfaceTintColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.black,
            child: SizedBox(
              height: 200,
              width: MediaQuery.sizeOf(dialogcontext).width / 1.2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Textutil(
                        text: 'Delete Song?',
                        fontsize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    Text(
                      'Are you sure you want to Delete : $title',
                      style:
                          Spaces.Getstyle(14, Colors.white, FontWeight.normal),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuCoinfirmIcon(
                          textcolor: Colors.black,
                          title: 'Cancel',
                          ontap: () {
                            Navigator.of(dialogcontext).pop();
                          },
                          backgroundColor: Colors.white,
                        ),
                        MenuCoinfirmIcon(
                          textcolor: Colors.white,
                          title: 'Delete',
                          ontap: () {
                            BlocProvider.of<AudioBloc>(dialogcontext).add(
                                AudioEvent.clearspecificaudio(
                                    song.data, song.id));
                            BlocProvider.of<LocalsongBloc>(dialogcontext).add(
                                LocalsongEvent.removesongsfromdevice(
                                    index, song.data));

                            Navigator.of(dialogcontext).pop();
                          },
                          backgroundColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class MenuCoinfirmIcon extends StatelessWidget {
  const MenuCoinfirmIcon({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.ontap,
    required this.textcolor,
  }) : super(key: key);
  final String title;
  final Color backgroundColor;
  final VoidCallback ontap;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: Center(
            child: Textutil(
                text: title,
                fontsize: 13,
                color: textcolor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class IndividualItemwidgets extends StatelessWidget {
  const IndividualItemwidgets(
      {super.key,
      required this.title,
      required this.iconDatal,
      required this.voidCallback,
      required this.iconcolor});
  final String title;
  final IconData iconDatal;
  final VoidCallback voidCallback;
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        onTap: voidCallback,
        child: Row(
          children: [
            Icon(
              iconDatal,
              color: iconcolor,
              size: 22,
            ),
            const SizedBox(
              width: 18,
            ),
            Textutil(
                text: title,
                fontsize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}
