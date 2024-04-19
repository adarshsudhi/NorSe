// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/pages/MainHomePage/MainHomePage.dart';

import '../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../subscreens/SongDetailsPage/SongDetailsPage.dart';

class Localfavsongpage extends StatefulWidget {
  static const String localfavpage = "./favsongscreen";
  const Localfavsongpage({super.key});

  @override
  State<Localfavsongpage> createState() => _LocalfavsongpageState();
}

class _LocalfavsongpageState extends State<Localfavsongpage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteplaylistBloc>(context).add(const FavoriteplaylistEvent.getallsongs());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        automaticallyImplyLeading: false,
         backgroundColor: Colors.transparent,),
       backgroundColor: Colors.black.withOpacity(0.8),
      body: SizedBox(
       height: size.height,
        width: size.width,
        child: Stack(
          children: [
                    Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
            const Color.fromARGB(255, 11, 19, 67).withOpacity(0.5),
            Colors.black
          ])
        ),
                ),
            SafeArea(
              child: Column(
                children: [
                     Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(Localfavsongpage.localfavpage),
                                child: BlocBuilder<FavoriteplaylistBloc,FavoriteplaylistState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      favsongs: (allfavsongs) {
                                      return  Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.5)
                                        
                                      ),
                                      child: allfavsongs.isNotEmpty? QueryArtworkWidget(
                                        artworkHeight: 70,
                                        artworkWidth: 70,
                                        artworkBorder: BorderRadius.circular(10),
                                        id: int.parse(allfavsongs[0]['id']), type:ArtworkType.AUDIO) : const Icon(Icons.music_note,color: Colors.white,size: 20,),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('My Favorites',style: Spaces.Getstyle(18, Colors.white,FontWeight.normal),),
                                  ],
                                );
                                      },
                                      orElse: ()=>Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.5)
                                      ),
                                   child: const Center(
                                    child: Icon(Icons.music_note,color: Colors.white,size: 20,),
                                   ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Textutil(text: 'My Favorites', fontsize: 18, color: Colors.white, fontWeight: FontWeight.normal),
                                  ],
                                ));
                                  },
                                )
                              ),
                            ),
                            Spaces.Kheight20,
                            Spaces.Kheight10,
                            BlocBuilder<FavoriteplaylistBloc,FavoriteplaylistState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  favsongs: (allfavsongs) {
                                    return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: TextButton.icon(onPressed: (){
                                         BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],allfavsongs,Random().nextInt(allfavsongs.length),));
                                         BlocProvider.of<AudioBloc>(context).add(const AudioEvent.shuffleon(true));
                                          setState(() {
                                           isSuffled = true;
                                           });
                                    }, icon: const Icon(Icons.shuffle,color: Colors.white,), label: Text('Shuffle',style: Spaces.Getstyle(15, Colors.white,FontWeight.normal),)),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: TextButton.icon(onPressed: (){
                                         BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],allfavsongs,0));
                                         BlocProvider.of<AudioBloc>(context).add(const AudioEvent.shuffleon(false));
                                    }, icon: const Icon(Icons.play_arrow,color: Colors.white,), label: Text('Play',style: Spaces.Getstyle(15, Colors.white,FontWeight.normal),)),
                                  ),
                                )
                              ],
                            );
                                  },
                                  orElse:() {
                                    return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: TextButton.icon(onPressed: (){
                                    }, icon: const Icon(Icons.shuffle,color: Colors.white,), label: Text('Shuffle',style: Spaces.Getstyle(15, Colors.white,FontWeight.normal),)),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: TextButton.icon(onPressed: (){
                                    
                                    }, icon: const Icon(Icons.play_arrow,color: Colors.white,), label: Text('Play',style: Spaces.Getstyle(15, Colors.white,FontWeight.normal),)),
                                  ),
                                )
                              ],
                            );
                                  },);
                              },
                            ),
                            Spaces.Kheight20,
                            Expanded(
                              child: BlocBuilder<FavoriteplaylistBloc,FavoriteplaylistState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    favsongs: (allfavsongs) {
                                      if (allfavsongs.isEmpty) {
                                        return const SizedBox();
                                      } else {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Text('songs(${allfavsongs.length})',style: Spaces.Getstyle(18,Colors.white,FontWeight.normal),),
                                            ),
                                            Spaces.Kheight10,
                                            Expanded(
                                              child: ListView.builder(
                                              itemCount: allfavsongs.length,
                                              itemBuilder:(context, index) {
                                              final songdetails = allfavsongs[index];
                                              return GestureDetector(
                                                onTap: () {
                                               BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],allfavsongs,index));
                                         
                                                },
                                                child: Localfavtiles(songdetails: songdetails,index:index,songs: allfavsongs,));
                                              })
                                              ),
                                              const Spaceadjust()
                                          ],
                                        );
                                      }
                                    },
                                    orElse:()=>const SizedBox());
                                },
                              ),
                            )
                ],
              ),
            ),
            const Align(alignment: Alignment.bottomCenter,
            child: BottomMusicBar(),
            )
          ],
        ),
      ),
    );
  }
}

class Localfavtiles extends StatelessWidget {
  final int index;
  final List<Map<String,dynamic>> songs;
  const Localfavtiles({
    Key? key,
    required this.index,
    required this.songs,
    required this.songdetails,
  }) : super(key: key);

  final Map<String, dynamic> songdetails;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: PopupMenuButton(
          itemBuilder:
              (BuildContext contex) {
            return [
              PopupMenuItem(
                  onTap: () {


                  },
                  child: const Text('Play')),
              PopupMenuItem(
                  onTap: () {
                    BlocProvider.of<FavoriteplaylistBloc>(context).add(FavoriteplaylistEvent.removesongs(songs[index]['id']));
                  },
                  child: const Text('Remove')),
            ];
          },
        ),
        subtitle: Textutil(text: songdetails['artist'], fontsize: 10, color: Colors.white, fontWeight: FontWeight.normal),
        title: Textutil(text: songdetails['title'], fontsize: 17, color: Colors.white, fontWeight: FontWeight.normal),
        leading: QueryArtworkWidget(
            artworkHeight: 60,
            artworkWidth: 60,
            artworkBorder:BorderRadius.circular(10),
            id: int.parse(songdetails['id']),
            type: ArtworkType.AUDIO));
  }
}
