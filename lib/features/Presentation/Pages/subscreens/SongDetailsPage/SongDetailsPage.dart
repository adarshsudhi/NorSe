import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Data/Models/onlinesongmodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/Albumsongs/albums_songs_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Library/album/libraryalbum/libraryalbum_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Library/playlist/libraryplaylist/libraryplaylist_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Library/playlist/libraryplaylistlike/libraryplaylistlike_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Pages/MainHomePage/MainHomePage.dart';
import 'package:nebula/injection_container.dart' as di;

import '../../../../Domain/Entity/SongsDetailsEntity/SongsEntity.dart';
import '../../../../Domain/UseCases/Sql_UseCase/addtodownloads_Usecase.dart';
import '../../../Bloc/Library/album/libraryalbumlike/libraryalbumlike_bloc.dart';
import '../../HomePage.dart';
import '../../Testingplayerscreen/testonlineplayerscreen.dart';

class SongDetailsPage extends StatefulWidget {
  static const String SongDetials = '/SongDetailPage';
  const SongDetailsPage({
    Key? key,
    required this.imageurl,
    required this.albumurl,
    required this.name,
    required this.id,
    required this.type,
  }) : super(key: key);
  final String imageurl;
  final String albumurl;
  final String name;
  final String id;
  final String type;
  @override
  State<SongDetailsPage> createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {

  PanelController controller = PanelController();

  Color? colors;
  @override
  void initState() {
    super.initState();
    if (widget.type == 'album') {
      BlocProvider.of<AlbumsSongsBloc>(context)
          .add(GetAlbumSongsEvent(albumurl: widget.albumurl));
      BlocProvider.of<LibraryalbumlikeBloc>(context).add(LibraryalbumlikeEvent.checkforalbum(widget.id));
    } else if (widget.type == 'playlist') {
      BlocProvider.of<AlbumsSongsBloc>(context)
          .add(GetPlaylistsSongsEvent(id: widget.id));
      BlocProvider.of<LibraryplaylistlikeBloc>(context).add(LibraryplaylistlikeEvent.chechifplaylistavai(widget.id));
    }
  }

  _calllibrary(){
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      BlocProvider.of<LibraryalbumBloc>(context).add(const LibraryalbumEvent.getalbumsongs());
    });
  }

  _callplaylist(){
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      BlocProvider.of<LibraryplaylistBloc>(context).add(const LibraryplaylistEvent.getlibraryplaylist());
    });
  }

   _addetails(String name,String image,String id,String url,String type){
          AlbumElements albumElements = AlbumElements(
               id: id,
                name: name,
                    year: 'NULL',
             type: 'null',
          language: 'null',
                Artist: 'null',
                 url: url,
                   image: image.replaceAll('150x150', '500x500'));

                type=="album" ?
                 BlocProvider.of<LibraryalbumlikeBloc>(context).add(LibraryalbumlikeEvent.addtolibrary('album',albumElements)):
                 BlocProvider.of<LibraryplaylistlikeBloc>(context).add(LibraryplaylistlikeEvent.addtolibrary('playlist', albumElements));
              }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              BlocBuilder<AlbumsSongsBloc, AlbumsSongsState>(
                builder: (context, state) {
                  if (state is AlbumsSongsloading) {
                    return SizedBox.expand(
                        child: Stack(
                      children: [
                        SizedBox(
                          height: size.height / 2,
                          child: Shimmer.fromColors(
                              period: const Duration(seconds: 2),
                              baseColor: const Color.fromARGB(255, 8, 8, 8),
                              highlightColor:
                                  const Color.fromARGB(255, 67, 67, 67)
                                      .withOpacity(0.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 67, 67, 67),
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
                                              baseColor: Color.fromARGB(255, 0, 0, 0),
                                              highlightColor:
                                                  Color.fromARGB(255, 22, 22, 22)
                                                      .withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 3, 33, 57),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              )),
                                        ),
                                        title: SizedBox(
                                          height: 10,
                                          width: size.width / 3.4,
                                          child: Shimmer.fromColors(
                                              period:
                                                  const Duration(seconds: 2),
                                              baseColor: Color.fromARGB(255, 0, 0, 0),
                                              highlightColor:
                                                  Color.fromARGB(255, 40, 40, 40)
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
                                              baseColor: const Color.fromARGB(255, 1, 1, 1),
                                              highlightColor:
                                                  const Color.fromARGB(255, 36, 36, 36)
                                                      .withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(255, 1, 1, 1),
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
                  } else if (state is AlbumsSongsloaded) {
                    return Stack(
                      children: [
                        SlidingUpPanel(
                          color: Colors.transparent,
                          backdropColor: Colors.black,
                          backdropEnabled: true,
                          maxHeight: size.height,
                          minHeight: size.height/1.5,
                          panelBuilder: (sc) {
                             return Container(
                              color: Colors.transparent,
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
                                          BlocBuilder<LibraryalbumlikeBloc,LibraryalbumlikeState>(
                                            builder: (context, state) {
                                              return state.maybeWhen(
                                                ispresent: (ispresent) {
                                                  return ispresent? IconButton(onPressed: (){
                                            _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'album');
                                            _calllibrary();
                                           }, icon: const Icon(Icons.favorite,color: Colors.red,size: 27,)):
                                           IconButton(onPressed: (){
                                              _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'album');
                                              _calllibrary();
                                           }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,));
                                                },
                                                removed: () {
                                                     return IconButton(onPressed: (){
                                                _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'album');
                                              _calllibrary();
                                           }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,));
                                                },
                                                added: () {
                                                  return IconButton(onPressed: (){
                                               _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'album');
                                              _calllibrary();
                                           }, icon: const Icon(Icons.favorite,color: Colors.red,size: 27,));
                                                },
                                                orElse: ()=>IconButton(onPressed: (){
                                               _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'album');
                                              _calllibrary();
                                           }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,)),);
                                            },
                                           ),
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
                                  child:ListView.builder(
                                   padding: EdgeInsets.zero,
                                   itemCount: state.songs.length,
                                   itemBuilder: (context, index) {
                                     return InkWell(
                                       onTap: () {
                                        
                                         Recents(state.songs, index, context,widget.name);

                                          BlocProvider.of<AudioBloc>(context)
                                                     .add(AudioEvent.
                                                     onlineaudio(
                                                      state.songs[index].id, 
                                                      index,
                                                      state.songs[index].songs, 
                                                      state.songs[index].image, 
                                                      widget.name, 
                                                      state.songs[index].primaryArtists, 
                                                     const [], 
                                                      state.songs,
                                                     const [], 
                                                     const []));

                                       },
                                       child: Songtiles(
                                         name: state.songs[index].name,
                                         image: state.songs[index].image,
                                         artist:
                                             state.songs[index].primaryArtists,
                                         icons1: Icons.add_to_queue,
                                         icons2: Icons.download_outlined,
                                         visible1: true,
                                         visible2: true,
                                         ontapqueue: () {
                                         OnlineSongModel onlineSongModel = OnlineSongModel(
                                         id: state.songs[index].id, 
                                         title: state.songs[index].name, 
                                         imageurl: state.songs[index].image, 
                                         downloadurl: state.songs[index].songs, 
                                         artist: state.songs[index].primaryArtists);
                                                    
                                          BlocProvider.of<AudioBloc>(context).add(AudioEvent.addtonlinequeue('online',onlineSongModel));
                                         },
                                         ontap: () async {
                                           final data = state.songs[index];
                                           AlbumElements albumElements =
                                               AlbumElements(
                                                   id: data.id,
                                                   name: data.name,
                                                   year: data.year,
                                                   type: widget.name,
                                                   language: 'null',
                                                   Artist: data.primaryArtists,
                                                   url: data.songs,
                                                   image: data.image);
                                           await di
                                               .di<addtodownloadsUsecase>()
                                               .call(albumElements);
                                         },
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
                          body: Stack(
                            children: [
                             SizedBox(
                            height: size.height / 2,
                            child: CachedNetworkImage(
                              imageUrl: widget.imageurl
                                  .replaceAll('150x150', '500x500'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: size.height,
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
                        ),
                        
                      ],
                    );
                  } else if (state is playlistsongs) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Stack(
                        children: [
                          SlidingUpPanel(
                            backdropColor: Colors.black,
                            backdropEnabled: true,
                            color: Colors.transparent,
                            maxHeight: size.height,
                            minHeight: size.height/1.5,
                            body: Stack(
                              children: [
                                SizedBox(
                            height: size.height / 2,
                            child: CachedNetworkImage(
                              imageUrl: widget.imageurl
                                  .replaceAll('150x150', '500x500'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: size.height,
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
                              return Container(
                                decoration: const BoxDecoration(color: Colors.transparent),
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
                                            BlocBuilder<LibraryplaylistlikeBloc,LibraryplaylistlikeState>(
                                              builder: (context, state) {
                                                return state.maybeWhen(
                                                  ifpresent: (ispresent) {
                                                     if (ispresent) {
                                                      return IconButton(onPressed: (){
                                               _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'playlist');
                                               _callplaylist();
                                            }, icon: const Icon(Icons.favorite,color: Colors.red,size: 27,));
                                                     }else{
                                                    return IconButton(onPressed: (){
                                               _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'playlist');
                                              _callplaylist();
                                             }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,));}
                                                  },
                                                  removed: () {
                                                   return IconButton(onPressed: (){
                                              _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'playlist');
                                              _callplaylist();
                                            }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,));
                                                  },
                                                  added: () {
                                                    return IconButton(onPressed: (){
                                              _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'playlist');
                                              _callplaylist();
                                            }, icon: const Icon(Icons.favorite,color: Colors.red,size: 27,));
                                                  },
                                                  orElse: (){
                                                  return IconButton(onPressed: (){
                                              _addetails(widget.name,widget.imageurl,widget.id, widget.albumurl, 'playlist');
                                              _callplaylist();
                                            }, icon: const Icon(Icons.favorite,color: Colors.white,size: 27,));
                                                });
                                              },
                                            ),
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
                                                      List<Map> moreinfo = [];
                                                      for (var itemss  in state.songs) {
                                                         moreinfo.add(itemss.more_info);
                                                      }
                                                     
                                                      
                                                    
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
                                      child: state.songs.isNotEmpty
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: state.songs.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    List<Map> moreinfo = [];
                                                    moreinfo.isNotEmpty?moreinfo.clear():null;
                                                      for (var itemss  in state.songs) {
                                                         moreinfo.add(itemss.more_info);
                                                      }
                                                    Recents(state.songs, index,
                                                        context,widget.name);

                                                       BlocProvider.of<AudioBloc>(context)
                                                     .add(AudioEvent.
                                                     onlineaudio(
                                                      state.songs[index].id, 
                                                      index,
                                                      state.songs[index].downloadUrl, 
                                                      state.songs[index].images, 
                                                      widget.name, 
                                                      state.songs[index].primaryArtists, 
                                                     moreinfo, 
                                                     const [],
                                                     const [], 
                                                     state.songs));
     
                                                  },
                                                  child: Songtiles(
                                                    name:
                                                        state.songs[index].name,
                                                    image: state
                                                        .songs[index].images,
                                                    artist: state.songs[index]
                                                        .primaryArtists,
                                                    icons1: Icons.more_vert,
                                                    icons2:
                                                        Icons.download_outlined,
                                                    visible1: true,
                                                    visible2: true,
                                                    ontapqueue: () {
                                                      OnlineSongModel onlineSongModel = OnlineSongModel(
                                                        id: state.songs[index].id, 
                                                        title: state.songs[index].name, 
                                                        imageurl: state.songs[index].images, 
                                                        downloadurl: state.songs[index].downloadUrl, 
                                                        artist: state.songs[index].primaryArtists);
                                                    
                                                     BlocProvider.of<AudioBloc>(context).add(AudioEvent.addtonlinequeue('online',onlineSongModel));
                                                    },
                                                    ontap: () async {
                                                      final data =
                                                          state.songs[index];
                                                      AlbumElements
                                                          albumElements =
                                                          AlbumElements(
                                                              id: data.id,
                                                              name: data.name,
                                                              year: '',
                                                              type: data.more_info['album'],
                                                              language: 'null',
                                                              Artist: data
                                                                  .primaryArtists,
                                                              url: data
                                                                  .downloadUrl,
                                                              image:
                                                                  data.images);
                                                      await di
                                                          .di<addtodownloadsUsecase>()
                                                          .call(albumElements);
                                                    },
                                                  ),
                                                );
                                              },
                                            )
                                          : const SizedBox(
                                              child: Center(
                                                  child: Text(
                                                'Error Fetching',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            )),
                                      const Spaceadjust() 
                                             
                                ],
                              ),
                                                        );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: BottomMusicBar(),
              )
            ],
          ),
        ));
  }
}

class Spaceadjust extends StatelessWidget {
  const Spaceadjust({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc,AudioState>(
      builder: (context, state) {
       return state.maybeWhen(
        youtubesong: (isloading, isfailed, audios, valueStream, index, audioPlayer) {
          return const SizedBox(
            height: 70,
          );
        },
        onlinesongs: (isloading, isfailed, audios, valueStream, index, audioPlayer) {
          return const SizedBox(
            height: 70,
          );
        },
        Localsongs: (isloading, isfailed, audios, valueStream, index, audioPlayer) {
          return const SizedBox(
            height: 70,
          );
        },
        orElse: ()=>const SizedBox());
      },
    );
  }
}

class Songtiles extends StatelessWidget {
   Songtiles({
    Key? key,
    required this.name,
    required this.image,
    required this.artist,
    required this.icons1,
    required this.icons2,
    required this.ontap,
    required this.ontapqueue,
    required this.visible1,
    required this.visible2,
  }) : super(key: key);
  final String name;
  final String image;
  final String artist;
  final IconData icons1;
  final IconData icons2;
  final VoidCallback ontap;
  final VoidCallback ontapqueue;
  final bool visible1;
  final bool visible2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
        ),
        const SizedBox(width: 15,),
         Expanded(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textutil(text: name, fontsize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              Textutil(text: artist, fontsize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.bold)
            ],
           ),
         ),
         Expanded(
           child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
           
                visible2 != true
                    ? const SizedBox()
                    : IconButton(
                        onPressed: ontap,
                        icon: Icon(icons2, size: 20, color: Colors.white)),
                
                  visible1 != true
                    ?  const SizedBox()
                    : PopupMenuButton(
                       iconColor: Colors.white,
                          itemBuilder: (BuildContext contex) {
                             return [
                               PopupMenuItem(
                                    onTap: ontapqueue,
                                   child:const Text('Add to Queue'))
                             ];
                             },
                        ),
              ],
            ),
              ],
            ),
           ),
         )
        ],
      )
    );
  }
}
