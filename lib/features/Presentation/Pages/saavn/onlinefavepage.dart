import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/pages/MainHomePage/MainHomePage.dart';
import '../../../Domain/Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../Blocs/Musicbloc/Library/album/libraryalbum/libraryalbum_bloc.dart';
import '../../Blocs/Musicbloc/Library/playlist/libraryplaylist/libraryplaylist_bloc.dart';
import '../../Blocs/Musicbloc/Library/song/library_bloc/library_bloc.dart';
import '../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../CustomWidgets/backgroundGradient.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';

class Onlinefavscreen extends StatefulWidget {
  static const String onlinefavscreen = './onlinefavscreen';
  const Onlinefavscreen({super.key});

  @override
  State<Onlinefavscreen> createState() => _OnlinefavscreenState();
}

class _OnlinefavscreenState extends State<Onlinefavscreen> {

  int currentpage = 0;

  List<String> pages = [
    'Songs',
    'Albums',
    'Playlists',
    'Recently Played'
  ];

  List<Widget> screen = [
    const OnlineSongs(),
    const OnlineAlbum(),
    const OnlinePlaylist(),
    const Placeholder()
  ];

  @override
  void initState() {
    BlocProvider.of<LibraryBloc>(context)
        .add(const LibraryEvent.getlibrarysong());
    BlocProvider.of<LibraryalbumBloc>(context)
        .add(const LibraryalbumEvent.getalbumsongs());
    BlocProvider.of<LibraryplaylistBloc>(context)
        .add(const LibraryplaylistEvent.getlibraryplaylist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                const backgroundgradient(),
                Container(
                  color: Colors.black.withOpacity(0.8),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 37,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: pages.length,
                          itemBuilder:(context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentpage = index;
                                  });
                                },
                                child: Container(
                                  height: 36,
                                
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: currentpage == index? const Color.fromARGB(255, 63, 63, 63): Colors.white
                                  ),
                                  child: Center(
                                    widthFactor: 1.1,
                                  
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Textutil(text: pages[index], fontsize: 12, color:currentpage == index? Colors.white: Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },)
                      ),
                      Spaces.Kheight20,
                       Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            screen[currentpage],
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
}

class OnlinePlaylist extends StatelessWidget {
  const OnlinePlaylist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryplaylistBloc, LibraryplaylistState>(
      builder: (context, state) {
        return state.maybeWhen(
            playlists: (playlist) {
              return playlist.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            itemCount: playlist.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SongDetailsPage.SongDetials,
                                      arguments: SongDetailsPage(
                                          type: 'playlist',
                                          imageurl: playlist[index]['image'],
                                          albumurl: playlist[index]['url'],
                                          name: playlist[index]['name'],
                                          id: playlist[index]['id']));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Material(
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          shadowColor:
                                              Colors.white.withOpacity(0.4),
                                          elevation: 5,
                                          child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Image.network(
                                                playlist[index]['image'],
                                                fit: BoxFit.cover,
                                              ))),
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spaceadjust()
                      ],
                    )
                  : const Nullstate();
            },
            orElse: () => const Nullstate());
      },
    );
  }
}

class OnlineAlbum extends StatelessWidget {
  const OnlineAlbum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryalbumBloc, LibraryalbumState>(
      builder: (context, state) {
        return state.maybeWhen(
          libraryalbums: (albums) {
            return albums.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: albums.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SongDetailsPage.SongDetials,
                                      arguments: SongDetailsPage(
                                          type: 'album',
                                          imageurl: albums[index]['image'],
                                          albumurl: albums[index]['url'],
                                          name: albums[index]['name'],
                                          id: albums[index]['id']));
                                },
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Image.network(
                                              albums[index]['image']),
                                        ),
                                      ),
                                      Spaces.Kheight10,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          albums[index]['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: Spaces.Getstyle(15,
                                              Colors.white, FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                      const Spaceadjust()
                    ],
                  )
                : const Nullstate();
          },
          orElse: () {
            return const Nullstate();
          },
        );
      },
    );
  }
}

class Nullstate extends StatelessWidget {
  const Nullstate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/folder.png',
            scale: 3,
          ),
          Text(
            'Nothing Liked Yet',
            style: GoogleFonts.aldrich(
                color: Colors.white.withOpacity(0.4), fontSize: 15),
          ),
          Text(
            'Start liking to build your list',
            style: GoogleFonts.aldrich(
                color: Colors.white.withOpacity(0.4), fontSize: 15),
          )
        ],
      ),
    );
  }
}

class OnlineSongs extends StatelessWidget {
  const OnlineSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          return state.maybeWhen(
              librarysong: (librarysong) {
                return librarysong.isEmpty
                    ? const Nullstate()
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: librarysong.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {

                                return GestureDetector(
                                  onTap: () {
                                    List<AlbumSongEntity> songs = [];

                                    for (var song in librarysong) {
                                      AlbumSongEntity songEntity =
                                          AlbumSongEntity(
                                              id: song['id'],
                                              name: song['name'],
                                              year: 'null',
                                              primaryArtists: song['artist'],
                                              image: song['image'],
                                              songs: song['uri'],
                                              albumurl: song['uri']);
                                      songs.add(songEntity);
                                    }
                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.onlineaudio(
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
                                    title: Text(
                                      librarysong[index]['name'],
                                      style: Spaces.Getstyle(
                                          15, Colors.white, FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      librarysong[index]['artist'],
                                      style: Spaces.Getstyle(
                                          10, Colors.white, FontWeight.normal),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: PopupMenuButton(
                                      itemBuilder: (BuildContext contex) {
                                        return [
                                          PopupMenuItem(
                                              onTap: () {
                                                List<AlbumSongEntity> songs =
                                                    [];
                                                songs.clear();
                                                for (var song in librarysong) {
                                                  AlbumSongEntity songEntity =
                                                      AlbumSongEntity(
                                                          id: song['id'],
                                                          name: song['name'],
                                                          year: 'null',
                                                          primaryArtists:
                                                              song['artist'],
                                                          image: song['image'],
                                                          songs: song['uri'],
                                                          albumurl:
                                                              song['uri']);
                                                  songs.add(songEntity);
                                                }

                                                BlocProvider.of<AudioBloc>(
                                                        context)
                                                    .add(AudioEvent.onlineaudio(
                                                        songs[index].id,
                                                        index,
                                                        songs[index].songs,
                                                        songs[index].image,
                                                        songs[index].name,
                                                        songs[index]
                                                            .primaryArtists,
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: CachedNetworkImage(
                                          imageUrl: librarysong[index]['image'],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spaceadjust()
                        ],
                      );
              },
              orElse: () => const Nullstate());
        },
      ),
    );
  }
}
