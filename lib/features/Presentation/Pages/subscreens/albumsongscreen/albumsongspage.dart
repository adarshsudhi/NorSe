import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Albumsongs/albums_songs_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Data/Models/songmodel.dart';
import '../../HomePage.dart';
import '../../MainHomePage/MainHomePage.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Albumsongspage extends StatefulWidget {
  static const String albumsongspage = './albumsongscreen';
  final int id;
  const Albumsongspage({super.key,required this.id});

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
                        child: Stack(
                      children: [
                        SizedBox(
                          height: size.height / 2,
                          child: Shimmer.fromColors(
                              period: const Duration(seconds: 2),
                              baseColor: const Color.fromARGB(255, 18, 41, 61),
                              highlightColor:
                                  const Color.fromARGB(255, 2, 38, 68)
                                      .withOpacity(0.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 3, 33, 57),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: size.height,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5),
                                  Colors.black,
                                  Colors.black,
                                  Colors.black
                                ],
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: size.height / 1.5,
                            child: Column(
                              children: [
                                Spaces.Kheight20,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TitleText(
                                          titleTextt: 'Related Songs'),
                                      Row(
                                        children: [
                                          IconButton(onPressed: (){
                                          
                                          }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,)),
                                          const SizedBox(width: 30,),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Center(
                                              child: Icon(Icons.play_arrow),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Shimmer.fromColors(
                                              period:
                                                  const Duration(seconds: 2),
                                              baseColor: const Color.fromARGB(
                                                  255, 18, 41, 61),
                                              highlightColor:
                                                  const Color.fromARGB(
                                                          255, 2, 38, 68)
                                                      .withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 3, 33, 57),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              )),
                                        ),
                                        title: SizedBox(
                                          height: 10,
                                          width: size.width / 3.4,
                                          child: Shimmer.fromColors(
                                              period:
                                                  const Duration(seconds: 2),
                                              baseColor: const Color.fromARGB(
                                                  255, 18, 41, 61),
                                              highlightColor:
                                                  const Color.fromARGB(
                                                          255, 2, 38, 68)
                                                      .withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 3, 33, 57),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              )),
                                        ),
                                      
                                        subtitle: SizedBox(
                                          height: 8,
                                          width: size.width / 3.4,
                                          child: Shimmer.fromColors(
                                              period:
                                                  const Duration(seconds: 2),
                                              baseColor: const Color.fromARGB(
                                                  255, 18, 41, 61),
                                              highlightColor:
                                                  const Color.fromARGB(
                                                          255, 2, 38, 68)
                                                      .withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 3, 33, 57),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Spaceadjust()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
          }else if(state is Songsfromalbum){
            return Stack(
               children: [
                SlidingUpPanel(
                  color: Colors.transparent,
                          backdropColor: Colors.black,
                          backdropEnabled: true,
                          maxHeight: size.height,
                          minHeight: size.height/1.5,
                          body:Stack(
                            children: [
                              SizedBox(
                       height: size.height / 1.5,
                        child: QueryArtworkWidget(
                              id: state.albumsongs[0].id,
                               type: ArtworkType.AUDIO,
                               keepOldArtwork: true,
                               artworkBorder: BorderRadius.zero,
                               artworkWidth: double.infinity,
                               size: 2000,
                               artworkHeight: size.height,
                               )
                              ),
                              Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: size.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.8),
                                    Colors.black,
                                    Colors.black,
                                    Colors.black
                                  ],
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter)),
                            ),
                          ),
                            ],
                          ),
                          panelBuilder: (sc) {
                            return SizedBox(
                              height: size.height / 2,
                              child: Column(
                                children: [
                                  Spaces.Kheight10,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleText(
                                            titleTextt: 'Related Songs'),
                                        Row(
                                          children: [
                                            
                                            const SizedBox(width: 30,),
                                            Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(50)),
                                                child: IconButton(
                                                    onPressed: () {
                                                       BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(state.albumsongs,[],0));
                                                    },
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
                                  Expanded(
                                    child: ListView.builder(
                                      controller: sc,
                                      padding: EdgeInsets.zero,
                                      itemCount: state.albumsongs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                             BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(state.albumsongs,[],index ));
                                          },
                                          child: ListTile(
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
                                             color: Colors.white, 
                                             fontWeight: FontWeight.normal),
                                            title: Textutil(
                                             text: state.albumsongs[index].displayNameWOExt,
                                             fontsize: 20, 
                                             color: Colors.white, 
                                             fontWeight: FontWeight.bold),
                                            leading: QueryArtworkWidget(
                                              keepOldArtwork: true,
                                            id: state.albumsongs[index].id,
                                            artworkBorder: BorderRadius.circular(10),
                                            type: ArtworkType.AUDIO),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const Spaceadjust()
                                ],
                              ),
                            );
                          },
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