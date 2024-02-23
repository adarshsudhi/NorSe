import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/Library/album/libraryalbum/libraryalbum_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Library/playlist/libraryplaylist/libraryplaylist_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Pages/MainHomePage/MainHomePage.dart';
import '../../Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../Bloc/Library/song/library_bloc/library_bloc.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';

class Onlinefavscreen extends StatefulWidget {
  static const String onlinefavscreen = './onlinefavscreen';
  const Onlinefavscreen({super.key});

  @override
  State<Onlinefavscreen> createState() => _OnlinefavscreenState();
}

class _OnlinefavscreenState extends State<Onlinefavscreen> {

  @override
  void initState() {
    BlocProvider.of<LibraryBloc>(context).add(const LibraryEvent.getlibrarysong());
    BlocProvider.of<LibraryalbumBloc>(context).add(const LibraryalbumEvent.getalbumsongs());
    BlocProvider.of<LibraryplaylistBloc>(context).add(const LibraryplaylistEvent.getlibraryplaylist());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
    child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 20,)),
        title: const Textutil(text: 'My Library', fontsize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child:  Stack(
          children: [
                      Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Colors.indigo,
              Colors.black
            ])
          ),
        ),  
                  Container(
            color: Colors.black.withOpacity(0.8),
          ),
            SafeArea(
              child: Column(
                children: [
                 SizedBox(
                            height: 50,
                            child: TabBar(   
                              dividerColor: Colors.transparent,
                              indicatorColor: const Color.fromARGB(255, 0, 0, 0),
                               labelStyle: Spaces.Getstyle(13,Colors.black, FontWeight.bold),
                          labelColor: const Color.fromARGB(255, 255, 255, 255),
                          unselectedLabelColor: const Color.fromARGB(255, 94, 94, 94),
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent),
                              tabs: const [
                              Text('Songs'),
                              Text('Albums'),
                              Text('Playlists'),
                            ]),                 
                          ),
                           Expanded(
                            child: Stack(
                              children: [
                                TabBarView(children: [
                                  SizedBox(
                                    child: BlocBuilder<LibraryBloc,LibraryState>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          librarysong: (librarysong) {
                                          return librarysong.isEmpty? 
                                          nullstate()
                                           : Column(
                                             children: [
                                              Spaces.Kheight10,
                                               Expanded(
                                                 child: ListView.builder(
                                                  itemCount: librarysong.length,
                                                  itemBuilder:(context, index) {
                                                   // List<AlbumSongEntity> allsongs = [];
                                                  return GestureDetector(
                                                    onTap: () {
              
                                                      List<AlbumSongEntity> songs = [];
              
                                                      for (var song in librarysong) {
                                                       AlbumSongEntity songEntity = AlbumSongEntity(
                                                            id: song['id'],
                                                            name: song['name'], 
                                                            year: 'null', 
                                                            primaryArtists: song['artist'], 
                                                            image: song['image'], 
                                                            songs: song['uri'], 
                                                            albumurl: song['uri']);
                                                        songs.add(songEntity);
                                                      }
                                                    BlocProvider.of<AudioBloc>(context).
                                                               add(AudioEvent.onlineaudio(
                                                                songs[index].id, 
                                                                index, 
                                                                songs[index].songs, 
                                                                songs[index].image, 
                                                                songs[index].name, 
                                                                songs[index].primaryArtists, 
                                                               const [], 
                                                                songs, 
                                                               const [], 
                                                               const []));
              
                                                      
                                                    },
                                                    child: ListTile(
                                                      title: Text(librarysong[index]['name'],style: Spaces.Getstyle(15,Colors.white, FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                                      subtitle:Text(librarysong[index]['artist'],style: Spaces.Getstyle(10,Colors.white, FontWeight.normal),overflow: TextOverflow.ellipsis,),
                                                      trailing: PopupMenuButton(
                                                         itemBuilder: (BuildContext contex) {
                                                         return [
                                                           PopupMenuItem(
                                                           onTap: () {
                                                             List<AlbumSongEntity> songs = [];
                                                             songs.clear();
                                                             for (var song in librarysong) {
                                                                 AlbumSongEntity songEntity = AlbumSongEntity(
                                                                   id: song['id'],
                                                                 name: song['name'], 
                                                                  year: 'null', 
                                                                 primaryArtists: song['artist'], 
                                                                    image: song['image'], 
                                                                  songs: song['uri'], 
                                                                    albumurl: song['uri']);
                                                                  songs.add(songEntity);
                                                              }    
              
                                                               BlocProvider.of<AudioBloc>(context).
                                                               add(AudioEvent.onlineaudio(
                                                                songs[index].id, 
                                                                index, 
                                                                songs[index].songs, 
                                                                songs[index].image, 
                                                                songs[index].name, 
                                                                songs[index].primaryArtists, 
                                                               const [], 
                                                                songs, 
                                                               const [], 
                                                               const []));
                                                               },
                                                                child: const Text('Play')),
                                                             ];
                                                          },
                                                      ),
                                                      leading: Container(
                                                        height: 70,
                                                        width: 60,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: CachedNetworkImage(imageUrl: librarysong[index]['image'],fit: BoxFit.cover,)),
                                                    ),
                                                  );
                                                        },),
                                               ),
                                              const Spaceadjust()
                                             ],
                                           );
                                          },
                                          orElse: ()=> nullstate());
                                      },
                                    ),
                                  ),
                                  BlocBuilder<LibraryalbumBloc,LibraryalbumState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        libraryalbums: (albums) {
                                          return albums.isNotEmpty? Column(
                                            children: [
                                              Expanded(
                                                child: GridView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: albums.length,
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 15
                                                    ),
                                                      itemBuilder:(context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                                                           arguments: SongDetailsPage(
                                                           type: 'album',
                                                           imageurl: albums[index]['image'],
                                                           albumurl: albums[index]['url'],
                                                           name: albums[index]['name'],
                                                           id: albums[index]['id']));
                                                        },
                                                        child: SizedBox(
                                                          width: MediaQuery.sizeOf(context).width/2,
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: Container(
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                                  child: Image.network(albums[index]['image']),
                                                                ),
                                                              ),
                                                              Spaces.Kheight10,
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                child: Text(albums[index]['name'],overflow: TextOverflow.ellipsis,style: Spaces.Getstyle(15,Colors.white,FontWeight.bold),textAlign: TextAlign.center,),
                                                              ),
                                                                   
                                                            ],
                                                          ),
                                                        )
                                                      );
                                                    },),
                                              ),
                                              const Spaceadjust()
                                            ],
                                          ):nullstate();
                                        },
                                        orElse:() {
                                        return nullstate();
                                      },);
                                    },
                                  ),
                                  BlocBuilder<LibraryplaylistBloc,LibraryplaylistState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        playlists: (playlist){
                                        return playlist.isNotEmpty? Column(
                                            children: [
                                              
                                             Expanded(
                                                child: GridView.builder(
                                                  itemCount: playlist.length,
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 5
                                                      ),
                                                      itemBuilder:(context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                                                           arguments: SongDetailsPage(
                                                           type: 'playlist',
                                                           imageurl: playlist[index]['image'],
                                                           albumurl: playlist[index]['url'],
                                                           name: playlist[index]['name'],
                                                           id: playlist[index]['id']));
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                          child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                               Material(
                                                              color: Colors.transparent,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                              shadowColor: Colors.white.withOpacity(0.4),
                                                              elevation:5,
                                                              child: Container(
                                                                clipBehavior: Clip.antiAlias,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20)
                                                                ),
                                                                child: Image.network(playlist[index]['image'],fit: BoxFit.cover,))
                                                            ),
                                                              Container(
                                                                clipBehavior: Clip.antiAlias,
                                                                decoration: const BoxDecoration(
                                                               color: Colors.transparent 
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },),
                                              ),
                                             const Spaceadjust()
                                            ],
                                          ):nullstate();
                                        },
                                        orElse: ()=>nullstate());
                                    },
                                  )
                                ]),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomMusicBar(),
                                )
                              ],
                            ),
                          )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  
                            SizedBox nullstate() {
                                return SizedBox(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/folder.png',scale: 3,),
                                          Text('Nothing Liked Yet',style: GoogleFonts.aldrich(
                                            color: Colors.white.withOpacity(0.4),
                                            fontSize: 15
                                          ),),
                                          Text('Start liking to build your list',style: GoogleFonts.aldrich(
                                            color: Colors.white.withOpacity(0.4),
                                            fontSize: 15
                                          ),)
                                        ],
                                      ),
                                    );
  }
}