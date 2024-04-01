import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/LocalSongs_bloc/localsong_bloc.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/Mymusic/songs.dart';
import 'subscreens/Mymusic/album.dart';
import 'subscreens/Mymusic/playlist.dart';



class MySongPage extends StatefulWidget {
  const MySongPage({super.key});

  @override
  State<MySongPage> createState() => _MySongPageState();
}

class _MySongPageState extends State<MySongPage> {
  final TextEditingController _controller = TextEditingController();

       _getallsongs(BuildContext context){
  BlocProvider.of<LocalsongBloc>(context).add(const LocalsongEvent.getallsongs());
       }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.8),
          extendBodyBehindAppBar: true,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Column(
                children: [
                  Spaces.Kheight10,
                  TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      labelStyle:
                          Spaces.Getstyle(12, Colors.black, FontWeight.bold),
                      labelColor: const Color.fromARGB(255, 255, 255, 255),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 69, 69, 69),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      tabs: const [
                       Text("SONGS"),
                       Text('ALBUMS'),
                       Text("PLAYLISTS")
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      RefreshIndicator(
                        onRefresh: () async=> await _getallsongs(context),
                        child: BlocBuilder<LocalsongBloc, LocalsongState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              songs: (songlist, albums, isloading, failed) {
                                return Songwidget(count: songlist.length);
                              },
                              orElse: (){
                              return const SizedBox(
                                child: Center(
                                  child: Textutil(text: 'No Songs Found', fontsize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      BlocBuilder<LocalsongBloc, LocalsongState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              songs: (songlist, albums, isloading, failed) {
                                return AlbumWidget(count: albums.length);
                              },
                              orElse: (){
                              return const SizedBox(
                                child: Center(
                                  child: Textutil(text: 'No Songs Found', fontsize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              );
                            });
                          },
                        ),
                      PlaylistWidget(size: size, controller: _controller)
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}



