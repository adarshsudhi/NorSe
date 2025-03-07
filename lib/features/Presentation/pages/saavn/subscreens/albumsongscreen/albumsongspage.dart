import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:norse/features/Presentation/CustomWidgets/bgblur.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Blocs/Musicbloc/Albumsongs/albums_songs_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../../CustomWidgets/nullmusicWidget.dart';
import '../Mymusic/songs.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Albumsongspage extends StatefulWidget {
  static const String albumsongspage = './albumsongscreen';
  final int id;
  final String albumname;
  final String type;
  const Albumsongspage({
    Key? key,
    required this.id,
    required this.albumname,
    required this.type,
  }) : super(key: key);

  @override
  State<Albumsongspage> createState() => _AlbumsongspageState();
}

class _AlbumsongspageState extends State<Albumsongspage> {
  @override
  void initState() {
    if (widget.type == 'album') {
      BlocProvider.of<AlbumsSongsBloc>(context)
          .add(Getsongsfromalbum(id: widget.id));
    } else if (widget.type == 'artist') {
      BlocProvider.of<AlbumsSongsBloc>(context)
          .add(GetArtistSongs(id: widget.id));
    } else if (widget.type == 'genre') {
      BlocProvider.of<AlbumsSongsBloc>(context)
          .add(GetSongsFromGenre(id: widget.id));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlocBuilder<AlbumsSongsBloc, AlbumsSongsState>(
              builder: (context, state) {
                if (state is AlbumsSongsloading) {
                  return SizedBox.expand(
                      child: SizedBox.expand(
                          child: Songslistloading(
                    size: size,
                    show: true,
                  )));
                } else if (state is Songsfromalbum) {
                  return Stack(
                    children: [
                      const BGblur(),
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
                                  QueryArtworkWidget(
                                    nullArtworkWidget:
                                        const NullMusicAlbumWidget(),
                                    id: widget.id,
                                    type: ArtworkType.ALBUM,
                                    keepOldArtwork: true,
                                    artworkHeight: size.height,
                                    artworkWidth: size.width,
                                    artworkFit: BoxFit.cover,
                                    size: 700,
                                    artworkBorder: BorderRadius.circular(0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                              Textutil(
                                                  text: "${widget.type}  •  ",
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
                                                    BorderRadius.circular(50)),
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
                              SongModel details = state.albumsongs[index];
                              return InkWell(
                                  onTap: () {
                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.localaudio(
                                            state.albumsongs, [], index));
                                  },
                                  child: LocalAlbumsonglistWidget(
                                    song: state.albumsongs[index],
                                    audios: state.albumsongs,
                                    id: details.id,
                                    title: details.title,
                                    artist: details.artist,
                                    uri: details.uri!,
                                    index: index,
                                  ));
                            })),
                          ),
                          const SliverToBoxAdapter(
                            child: Spaceadjust(),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (state is SongfromArtist) {
                  return Stack(
                    children: [
                      const BGblur(),
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
                                  QueryArtworkWidget(
                                    id: widget.id,
                                    type: ArtworkType.ARTIST,
                                    nullArtworkWidget:
                                        const NullMusicAlbumWidget(),
                                    keepOldArtwork: true,
                                    artworkHeight: size.height,
                                    artworkWidth: size.width,
                                    artworkFit: BoxFit.cover,
                                    size: 500,
                                    artworkBorder: BorderRadius.circular(0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                                  text: "Artist  •  ",
                                                  fontsize: 13,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              Textutil(
                                                  text:
                                                      "songs ${state.artist.length}",
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
                                                    BorderRadius.circular(50)),
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
                                    childCount: state.artist.length,
                                    (context, index) {
                              final details = state.artist[index];
                              return InkWell(
                                  onTap: () {
                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.localaudio(
                                            state.artist, [], index));
                                  },
                                  child: LocalAlbumsonglistWidget(
                                    song: state.artist[index],
                                    audios: state.artist,
                                    id: details.id,
                                    title: details.title,
                                    artist: details.artist,
                                    uri: details.uri!,
                                    index: index,
                                  ));
                            })),
                          ),
                          const SliverToBoxAdapter(
                            child: Spaceadjust(),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (state is SongsFromGenre) {
                  return Stack(
                    children: [
                      const BGblur(),
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
                                  QueryArtworkWidget(
                                    id: widget.id,
                                    type: ArtworkType.GENRE,
                                    nullArtworkWidget:
                                        const NullMusicAlbumWidget(),
                                    keepOldArtwork: true,
                                    artworkHeight: size.height,
                                    artworkWidth: size.width,
                                    artworkFit: BoxFit.cover,
                                    size: 700,
                                    artworkBorder: BorderRadius.circular(0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                                  text: "Artist  •  ",
                                                  fontsize: 13,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              Textutil(
                                                  text:
                                                      "songs ${state.genresongs.length}",
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
                                                    BorderRadius.circular(50)),
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
                                    childCount: state.genresongs.length,
                                    (context, index) {
                              final details = state.genresongs[index];
                              return InkWell(
                                  onTap: () {
                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.localaudio(
                                            state.genresongs, [], index));
                                  },
                                  child: LocalAlbumsonglistWidget(
                                    song: state.genresongs[index],
                                    audios: state.genresongs,
                                    id: details.id,
                                    title: details.title,
                                    artist: details.artist,
                                    uri: details.uri!,
                                    index: index,
                                  ));
                            })),
                          ),
                          const SliverToBoxAdapter(
                            child: Spaceadjust(),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ));
  }
}

class LocalAlbumsonglistWidget extends StatelessWidget {
  final int id;
  final String title;
  final String? artist;
  final String uri;
  final int index;
  final List<SongModel> audios;
  final SongModel song;
  const LocalAlbumsonglistWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.artist,
    required this.uri,
    required this.audios,
    required this.song,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.black,
              context: context,
              builder: (context) {
                return IndividialSongMenu(
                  index: index,
                  audios: audios,
                  song: song,
                );
              },
            );
          },
          icon: const Icon(Icons.more_vert)),
      subtitle: Textutil(
          text: artist ?? 'null',
          fontsize: 10,
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.normal),
      title: Textutil(
          text: title,
          fontsize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      leading: QueryArtworkWidget(
          nullArtworkWidget: const NullMusicAlbumWidget(),
          keepOldArtwork: true,
          id: id,
          artworkBorder: BorderRadius.circular(10),
          type: ArtworkType.AUDIO),
    );
  }
}
