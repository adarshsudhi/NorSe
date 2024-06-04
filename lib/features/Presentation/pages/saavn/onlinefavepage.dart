import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Blocs/Musicbloc/recents_bloc/recents_bloc.dart';
import '../../../Domain/Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../Blocs/Musicbloc/Library/album/libraryalbum/libraryalbum_bloc.dart';
import '../../Blocs/Musicbloc/Library/playlist/libraryplaylist/libraryplaylist_bloc.dart';
import '../../Blocs/Musicbloc/Library/song/library_bloc/library_bloc.dart';
import '../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../CustomWidgets/backgroundGradient.dart';
import '../MainHomePage/MainHomePage.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';

class Onlinefavscreen extends StatefulWidget {
  static const String onlinefavscreen = './onlinefavscreen';
  const Onlinefavscreen({super.key});

  @override
  State<Onlinefavscreen> createState() => _OnlinefavscreenState();
}

class _OnlinefavscreenState extends State<Onlinefavscreen> {
  int currentpage = 0;

  List<String> pages = ['songs', 'albums', 'playlists', 'recently played'];

  PageController controller = PageController();

  List<Widget> screen = [
    const OnlineSongs(),
    const OnlineAlbum(),
    const OnlinePlaylist(),
    const RecentlyPlayed()
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
  void dispose() {
    super.dispose();
    controller.dispose();
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
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    controller.jumpToPage(index);
                                  },
                                  child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: currentpage == index
                                            ? const LinearGradient(colors: [
                                                Colors.yellow,
                                                Colors.red
                                              ])
                                            : null,
                                        color: Colors.white),
                                    child: Center(
                                      widthFactor: 1.1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Textutil(
                                            text: pages[index],
                                            fontsize: 11,
                                            color: currentpage == index
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                      Spaces.kheight20,
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            PageView(
                              controller: controller,
                              onPageChanged: (value) {
                                setState(() {
                                  currentpage = value;
                                });
                              },
                              children: screen,
                            ),
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
                          child: ListView.builder(
                            itemCount: playlist.length,
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
                                  child: OnlineFevSongTiles(
                                      title: playlist[index]['name'],
                                      uri: 'null',
                                      image: playlist[index]['image'],
                                      artist: 'null',
                                      ontap: () {
                                        Navigator.pushNamed(context,
                                            SongDetailsPage.SongDetials,
                                            arguments: SongDetailsPage(
                                                type: 'playlist',
                                                imageurl: playlist[index]
                                                    ['image'],
                                                albumurl: playlist[index]
                                                    ['url'],
                                                name: playlist[index]['name'],
                                                id: playlist[index]['id']));
                                      },
                                      show: false));
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
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: albums.length,
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
                                child: OnlineFevSongTiles(
                                    title: albums[index]['name'],
                                    uri: 'null',
                                    image: albums[index]['image'],
                                    artist: 'null',
                                    ontap: () {
                                      Navigator.pushNamed(
                                          context, SongDetailsPage.SongDetials,
                                          arguments: SongDetailsPage(
                                              type: 'album',
                                              imageurl: albums[index]['image'],
                                              albumurl: albums[index]['url'],
                                              name: albums[index]['name'],
                                              id: albums[index]['id']));
                                    },
                                    show: false));
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
                                final data = librarysong[index];
                                return InkWell(
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
                                    child: OnlineFevSongTiles(
                                        show: true,
                                        title: data['name'],
                                        uri: data['uri'],
                                        image: data['image'],
                                        artist: data['artist'],
                                        ontap: () {
                                          List<AlbumSongEntity> songs = [];

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
                                                    albumurl: song['uri']);
                                            songs.add(songEntity);
                                          }
                                          BlocProvider.of<AudioBloc>(context)
                                              .add(AudioEvent.onlineaudio(
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
                                        }));
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

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecentsBloc>(context)
        .add(const RecentsEvent.getallrecent());
    return BlocBuilder<RecentsBloc, RecentsState>(
      builder: (context, state) {
        return state.maybeWhen(
            recents: (recents) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: recents.length,
                      itemBuilder: (context, index) {
                        final data = recents[index];
                        return InkWell(
                          onTap: () {
                            List<AlbumSongEntity> songs = [];
                            songs.clear();
                            for (var song in recents) {
                              AlbumSongEntity songEntity = AlbumSongEntity(
                                  id: song['id'],
                                  name: song['title'],
                                  year: 'null',
                                  primaryArtists: song['artist'],
                                  image: song['imageurl'],
                                  songs: song['downloadurl'],
                                  albumurl: song['downloadurl']);
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
                          child: OnlineFevSongTiles(
                            show: true,
                            title: data['title'],
                            image: data['imageurl'],
                            artist: data['artist'],
                            uri: data['downloadurl'],
                            ontap: () {
                              List<AlbumSongEntity> songs = [];
                              songs.clear();
                              for (var song in recents) {
                                AlbumSongEntity songEntity = AlbumSongEntity(
                                    id: song['id'],
                                    name: song['title'],
                                    year: 'null',
                                    primaryArtists: song['artist'],
                                    image: song['imageurl'],
                                    songs: song['downloadurl'],
                                    albumurl: song['downloadurl']);
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
    );
  }
}

class OnlineFevSongTiles extends StatelessWidget {
  const OnlineFevSongTiles({
    super.key,
    required this.title,
    required this.uri,
    required this.image,
    required this.artist,
    required this.ontap,
    required this.show,
  });

  final String title;
  final String uri;
  final String image;
  final String artist;
  final VoidCallback ontap;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Spaces.Getstyle(15, Colors.white, FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: show
          ? Text(
              artist,
              style: Spaces.Getstyle(10, Colors.white, FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            )
          : const Textutil(
              text: '',
              fontsize: 5,
              color: Colors.white,
              fontWeight: FontWeight.normal),
      trailing: show
          ? PopupMenuButton(
              itemBuilder: (BuildContext contex) {
                return [
                  PopupMenuItem(onTap: ontap, child: const Text('Play')),
                ];
              },
            )
          : null,
      leading: Container(
          padding: EdgeInsets.zero,
          height: 70,
          width: 60,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          )),
    );
  }
}


/**
 * List<AlbumSongEntity> songs = [];
                                  songs.clear();
                                  for (var song in recents) {
                                    AlbumSongEntity songEntity =
                                        AlbumSongEntity(
                                            id: song['id'],
                                            name: song['title'],
                                            year: 'null',
                                            primaryArtists: song['artist'],
                                            image: song['imageurl'],
                                            songs: song['downloadurl'],
                                            albumurl: song['downloadurl']);
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
 */