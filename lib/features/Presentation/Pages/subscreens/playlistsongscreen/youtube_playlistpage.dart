import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../../configs/constants/Spaces.dart';
import '../../../Bloc/audio_bloc/audio_bloc.dart';
import '../../HomePage.dart';
import '../../MainHomePage/MainHomePage.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Youtubeplaylistpage extends StatelessWidget {
  static const youtubeplaylistpage = './youtubeplaylistpage';
  const Youtubeplaylistpage({super.key, required this.songs});
  final List<Video> songs;

  @override
  Widget build(BuildContext context) {
       final size = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.black,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
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
                           height: size.width/1.0,
                          child: CachedNetworkImage(imageUrl: songs[0].thumbnails.maxResUrl,fit: BoxFit.cover,)
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
                                width: double.infinity,
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
                                        scrollDirection: Axis.vertical,
                                        controller: sc,
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        itemCount: songs.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 18),
                                            child: InkWell(
                                              onTap: () {
                                                  BlocProvider.of<AudioBloc>(context).add(AudioEvent.ytaudio(songs,index,songs[index].author,songs[index].title));
                                              },
                                              child: Row(
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            width: 80,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(14)
                                                            ),
                                                            child: CachedNetworkImage(
                                                              errorWidget: (context, url, error) {
                                                                return Image.asset('assets/musical-note.png',color: Colors.white.withOpacity(0.5),);
                                                              },
                                                              imageUrl: songs[index].thumbnails.mediumResUrl,fit: BoxFit.cover,),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Textutil(text: songs[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                                                Textutil(text: songs[index].author, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
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
                        ),
      )
    );
  }
  }

class loadinglist extends StatelessWidget {
  const loadinglist({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
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
  }
}