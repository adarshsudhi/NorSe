// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import 'package:norse/features/Presentation/pages/saavn/subscreens/Mymusic/artist.dart';
import 'package:norse/features/Presentation/pages/saavn/subscreens/Mymusic/genre.dart';
import 'subscreens/Mymusic/album.dart';
import 'subscreens/Mymusic/playlist.dart';
import 'subscreens/Mymusic/songs.dart';

class MySongPage extends StatefulWidget {
  const MySongPage({
    super.key,
  });

  @override
  State<MySongPage> createState() => _MySongPageState();
}

class _MySongPageState extends State<MySongPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Spaces.backgroundColor,
          extendBodyBehindAppBar: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                child: SafeArea(
                  child: Column(
                    children: [
                      TabBar(
                          indicatorPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.white,
                          labelStyle: Spaces.Getstyle(
                              12,
                              const Color.fromARGB(255, 0, 0, 0),
                              FontWeight.bold),
                          labelColor: const Color.fromARGB(255, 255, 255, 255),
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor:
                              const Color.fromARGB(255, 69, 69, 69),
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [Colors.yellow, Colors.red])),
                          tabs: const [
                            LocalAudioTitleContainer(
                              title: 'SONG',
                            ),
                            LocalAudioTitleContainer(
                              title: 'ALBUMS',
                            ),
                            LocalAudioTitleContainer(
                              title: 'ARTISTS',
                            ),
                            LocalAudioTitleContainer(
                              title: 'GENRE',
                            ),
                            LocalAudioTitleContainer(
                              title: 'PLAYLIST',
                            ),
                          ]),
                      Spaces.kheight10,
                      
                      Expanded(
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              BlocBuilder<LocalsongBloc, LocalsongState>(
                                builder: (context, state) {
                                  return state.maybeWhen(songs: (songlist,
                                      albums,
                                      artist,
                                      genre,
                                      isloading,
                                      failed) {
                                    return Songwidget(
                                      count: songlist.length,
                                    );
                                  }, orElse: () {
                                    return const SizedBox(
                                      child: Center(
                                        child: Textutil(
                                            text: 'No Songs Found',
                                            fontsize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  });
                                },
                              ),
                              BlocBuilder<LocalsongBloc, LocalsongState>(
                                builder: (context, state) {
                                  return state.maybeWhen(songs: (songlist,
                                      albums,
                                      artist,
                                      genre,
                                      isloading,
                                      failed) {
                                    return AlbumWidget(count: albums.length);
                                  }, orElse: () {
                                    return const SizedBox(
                                      child: Center(
                                        child: Textutil(
                                            text: 'No Songs Found',
                                            fontsize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  });
                                },
                              ),
                              BlocBuilder<LocalsongBloc, LocalsongState>(
                                builder: (context, state) {
                                  return state.maybeWhen(songs: (songlist,
                                      albums,
                                      artist,
                                      genre,
                                      isloading,
                                      failed) {
                                    return ArtistWiseSongWidget(
                                        artistmodel: artist);
                                  }, orElse: () {
                                    return const SizedBox(
                                      child: Center(
                                        child: Textutil(
                                            text: 'No Artist Found',
                                            fontsize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  });
                                },
                              ),
                              const GenrePage(),
                              PlaylistWidget(
                                  size: size, controller: _controller),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class LocalAudioTitleContainer extends StatelessWidget {
  const LocalAudioTitleContainer({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 70,
      child: Center(
        child: Textutil(
            text: title,
            fontsize: 8,
            color: Colors.white,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
