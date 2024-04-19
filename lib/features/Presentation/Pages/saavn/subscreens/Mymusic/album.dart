// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../SongDetailsPage/SongDetailsPage.dart';
import '../albumsongscreen/albumsongspage.dart';

class AlbumWidget extends StatefulWidget {
  final int count;
  const AlbumWidget({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget>  with TickerProviderStateMixin{

  late List<Animation<Offset>> animations;

  late Animation<double> fadetransitionsanimations;

  late AnimationController controller;

    @override
    void initState() {
    super.initState();

    controller = AnimationController(vsync: this,duration: const Duration(seconds: 1));

     animations = List.generate(widget.count, (index) => Tween(begin: const Offset(0,1),end: Offset.zero).animate(
      CurvedAnimation(parent: controller, curve: Interval(index*(1/widget.count),1,curve: Curves.bounceOut))
      ));

      fadetransitionsanimations = Tween<double>(begin: 0,end: 1).animate(
        controller
      );

    controller.forward();
  }

  @override
  void dispose() {
     controller.dispose();
     super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<LocalsongBloc,LocalsongState>(
            builder: (context, state) {
              return state.maybeWhen(
                songs: (songlist, albums, isloading, failed) {
                  return Column(
                    children: [
                      Spaces.Kheight20,
                      Expanded(
                        child: ListView.builder(
                              itemCount: albums.length,
                              itemBuilder:(context, index) {
                                return SlideTransition(
                                  position: animations[index],
                                  child: FadeTransition(
                                    opacity: fadetransitionsanimations,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,Albumsongspage.albumsongspage,arguments:Albumsongspage(id: albums[index].id, albumname: albums[index].album));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        child: Row(
                                        children: [
                                          Container(
                                            height: 55,
                                            width: 60,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(0)
                                            ),
                                            child: QueryArtworkWidget(
                                              id: albums[index].id,
                                              type: ArtworkType.ALBUM,
                                              keepOldArtwork: true,
                                              artworkHeight: 54,
                                              artworkWidth: 50,
                                              artworkBorder: BorderRadius.circular(0),
                                              ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Textutil(text: albums[index].album, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                Textutil(text: "songs ${albums[index].numOfSongs}", fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      )
                                    ),
                                  ),
                                );
                              },),
                      ),
                      const Spaceadjust()
                    ],
                  );
                },
                orElse: ()=>const SizedBox());
            },
          )
          )
      ],
    );
  }
}
