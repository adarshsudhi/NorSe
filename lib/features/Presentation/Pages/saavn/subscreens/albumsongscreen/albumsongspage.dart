// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../Data/Models/MusicModels/songmodel.dart';
import '../../../../Blocs/Musicbloc/Albumsongs/albums_songs_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../MainHomePage/MainHomePage.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Albumsongspage extends StatefulWidget {
  static const String albumsongspage = './albumsongscreen';
  final int id;
  final String albumname;
  const Albumsongspage({
    Key? key,
    required this.id,
    required this.albumname,
  }) : super(key: key);

  @override
  State<Albumsongspage> createState() => _AlbumsongspageState();
}

class _AlbumsongspageState extends State<Albumsongspage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AlbumsSongsBloc>(context).add(Getsongsfromalbum(id: widget.id));
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.black,
      child: BlocBuilder<AlbumsSongsBloc,AlbumsSongsState>(
        builder: (context, state) {
          if (state is AlbumsSongsloading) {
            return SizedBox.expand(
                        child: SizedBox.expand(child: Songslistloading(size: size,show: true,)));
          }else if(state is Songsfromalbum){
            return  Stack(
                      children: [
                        QueryArtworkWidget(id: state.albumsongs[0].id,
                        type: ArtworkType.ALBUM,
                        keepOldArtwork: true,
                        artworkHeight: size.height,
                        artworkWidth: size.width,
                        size: 3,
                        ),
                        Container(
                          color: Colors.black,
                          height: size.height,
                          width: size.width,
                        ),
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              pinned: true,
                              stretch: true,
                              expandedHeight: 280,
                              foregroundColor: Colors.transparent,
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: FlexibleSpaceBar(
                                stretchModes: const [StretchMode.zoomBackground],
                                background: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                     QueryArtworkWidget(id: widget.id,
                                                type: ArtworkType.ALBUM,
                                                keepOldArtwork: true,
                                               artworkHeight: size.height,
                                               artworkWidth: size.width,
                                               artworkFit: BoxFit.cover,
                                                     size: 500,
                                        ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ])),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textutil(
                                                text: widget.albumname,
                                                fontsize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                            Row(
                                              children: [
                                                const Textutil(
                                                    text: "Album  •  ",
                                                    fontsize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                Textutil(
                                                    text:
                                                        "songs ${state.albumsongs.length}",
                                                    fontsize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                           Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            SliverPadding(
                              padding: const EdgeInsets.only(bottom: 20),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      childCount: state.albumsongs.length,
                                      (context, index) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(state.albumsongs,[],index));
                                  },
                                  child: LocalAlbumsonglistWidget(state: state, index: index)
                                );
                              })),
                            ),
                            const SliverToBoxAdapter(
                              child: Spaceadjust(),
                            )
                          ],
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                           child: BottomMusicBar(),
                        )
                      ],
                    );
           
          }else{
            return const SizedBox();
          }
        },
      )
    );
  }
}

class LocalAlbumsonglistWidget extends StatelessWidget {
  final Songsfromalbum state;
  final int index;
  const LocalAlbumsonglistWidget({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: PopupMenuButton(
              itemBuilder:
                  (BuildContext contex) {
                return [
                  PopupMenuItem(
                      onTap: () {
                        Songmodel songmodel = Songmodel(
                          id: state.albumsongs[index].id, 
                          title: state.albumsongs[index].displayNameWOExt, 
                          subtitle: state.albumsongs[index].artist ?? "unkown", 
                          uri: state.albumsongs[index].uri!);
                        BlocProvider.of<AudioBloc>(context).add(AudioEvent.addsongtoqueue('local',songmodel));
                      },
                      child: const Text('Add to Queue')),
                ];
              },
            ),
      subtitle:Textutil(
       text: state.albumsongs[index].artist ?? 'null',
       fontsize: 10, 
       color: Colors.white.withOpacity(0.6), 
       fontWeight: FontWeight.normal),
      title: Textutil(
       text: state.albumsongs[index].displayNameWOExt,
       fontsize: 15, 
       color: Colors.white, 
       fontWeight: FontWeight.bold),
      leading: QueryArtworkWidget(
        keepOldArtwork: true,
      id: state.albumsongs[index].id,
      artworkBorder: BorderRadius.circular(10),
      type: ArtworkType.AUDIO),
    );
  }
}
