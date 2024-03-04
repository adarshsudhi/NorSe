
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/ytsearch_bloc/ytsearch_bloc.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/playlistsongscreen/youtube_playlistpage.dart';
import '../SongDetailsPage/SongDetailsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Youtubepage extends StatefulWidget {
  const Youtubepage({super.key});

  @override
  State<Youtubepage> createState() => _YoutubepageState();
}

class _YoutubepageState extends State<Youtubepage> {

  _call()async{
    BlocProvider.of<YtsearchBloc>(context).add(const YtsearchEvent.freestate());
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Column(
        children: [
          Spaces.Kheight10,
               Expanded(
                 child: SafeArea(
                   child: BlocBuilder<YtsearchBloc,YtsearchState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                fres: (videos,vidoes1,videos2, isloading, isfailed) {
                                  return ListView(
                                    children: [
                                      CarouselSlider(
                                         options: CarouselOptions
                                         (height: 200.0,
                                         viewportFraction: 1,
                                         autoPlayInterval: const Duration(seconds: 5),
                                         autoPlay: true,
                                         ),
                                         items: List.generate(videos.length,
                                         (index) => GestureDetector(
                                           onTap: () {
                                             BlocProvider.of<AudioBloc>(context).add(AudioEvent.ytaudio(videos,index,videos[index].author, videos[index].title));
                                           },
                                           child: Container(
                                                     width: MediaQuery.of(context).size.width/1.1,
                                                     clipBehavior: Clip.antiAlias,
                                                     decoration:BoxDecoration(
                                                       borderRadius: BorderRadius.circular(10)
                                                     ),
                                                     child: Image.network(
                                                       errorBuilder: (context, error, stackTrace) {
                                                         return const Center(child: Icon(Icons.music_note,color: Colors.white,));
                                                       },
                                                       videos[index].thumbnails.maxResUrl
                                                       ,fit: BoxFit.cover,)
                                                   ),
                                         ),)
                                       ),
                                       Spaces.Kheight10,
                                       SizedBox(
                                         height: 250,
                                         width: MediaQuery.of(context).size.width,
                                         child: ListView(
                                           padding: const EdgeInsets.only(left: 19),
                                           scrollDirection: Axis.horizontal,
                                           children: [
                                                                              
                                                                              
                                                                              
                                             InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,Youtubeplaylistpage.youtubeplaylistpage,arguments: videos2);
                                            },
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 children: [
                                                   Padding(
                                                     padding: const EdgeInsets.only(right: 18),
                                                     child: Container(
                                                       height: 200,
                                                       width: MediaQuery.of(context).size.width/1.1,
                                                       clipBehavior: Clip.antiAlias,
                                                       decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(10)
                                                       ),
                                                       child: Stack(
                                                         children: [
                                                           Image.network(videos2[0].thumbnails.maxResUrl,fit: BoxFit.cover,),
                                                           Align(
                                                             alignment: Alignment.centerRight,
                                                             child: Container(
                                                               width: 150,
                                                               color: Colors.black.withOpacity(0.8),
                                                               child: const Center(
                                                                 child: Column(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                                   children: [
                                                                     Textutil(text: '100', fontsize: 20, color: Colors.white, fontWeight: FontWeight.normal),
                                                                     SizedBox(height: 3,),
                                                                     Icon(Icons.playlist_play,color: Colors.white,size: 40,)
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                   const Textutil(text: 'Top 100 Party songs', fontsize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                                   const Textutil(text: 'YouTube', fontsize: 8, color: Colors.white, fontWeight: FontWeight.normal)
                                                 ],
                                               ),
                                             ),                           
                                             InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context,Youtubeplaylistpage.youtubeplaylistpage,arguments: vidoes1);
                                              },
                                                child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 children: [
                                                   Padding(
                                                     padding: const EdgeInsets.only(right: 18),
                                                     child: Container(
                                                       height: 200,
                                                       width: MediaQuery.of(context).size.width/1.1,
                                                       clipBehavior: Clip.antiAlias,
                                                       decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(10)
                                                       ),
                                                       child: Stack(
                                                         children: [
                                                           Image.network(vidoes1[0].thumbnails.maxResUrl,fit: BoxFit.cover,),
                                                           Align(
                                                             alignment: Alignment.centerRight,
                                                             child: Container(
                                                               width: 150,
                                                               color: Colors.black.withOpacity(0.8),
                                                               child: const Center(
                                                                 child: Column(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                                   children: [
                                                                     Textutil(text: '100', fontsize: 20, color: Colors.white, fontWeight: FontWeight.normal),
                                                                     SizedBox(height: 3,),
                                                                     Icon(Icons.playlist_play,color: Colors.white,size: 40,)
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                   const Textutil(text: 'All time best bollywood songs', fontsize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                                   const Textutil(text: 'YouTube', fontsize: 8, color: Colors.white, fontWeight: FontWeight.normal)
                                                 ],
                                                                                             ),
                                              ),
                                           ],
                                         )
                                       
                                       ),
                                       const Padding(
                                         padding: EdgeInsets.only(left: 16),
                                         child: Textutil(text: 'Latest trending songs', fontsize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                       ),
                                       Spaces.Kheight10,
                                       Column(
                                        children: List.generate(videos.length,(index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: InkWell(
                                                  onTap: () {
                                                BlocProvider.of<AudioBloc>(context).add(AudioEvent.ytaudio(videos, index,videos[index].author, videos[index].title));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 17),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 60,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(14)
                                                          ),
                                                          child: CachedNetworkImage(
                                                            errorWidget: (context, url, error) {
                                                              return Image.asset('assets/musical-note.png',color: Colors.white.withOpacity(0.5),);
                                                            },
                                                            imageUrl: videos[index].thumbnails.mediumResUrl,fit: BoxFit.cover,),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Textutil(text: videos[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                              Textutil(text: videos[index].author, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ),
                                          );
                                        }),
                                       ) 
                                    ],
                                    
                                  );
                                },
                                searchedvideo: (videos, isloading, isfailed) {
                                  return isloading != true?
                                    ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: videos.length,
                                    itemBuilder:(context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: InkWell(
                                          onTap: () {
                                        BlocProvider.of<AudioBloc>(context).add(AudioEvent.ytaudio(videos, index,videos[index].author, videos[index].title));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 50,
                                                    width:60,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Image.network(
                                                    errorBuilder: (context, error, stackTrace) {
                                                     return Image.asset('assets/musical-note.png',color: Colors.white.withOpacity(0.5),);
                                                   },
                                                    videos[index].thumbnails.maxResUrl,fit: BoxFit.cover,),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Textutil(text: videos[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                      Textutil(text: videos[index].author, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ),
                                      );
                                    },):const Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(color: Colors.white,),
                                      )
                                    ],
                                  );
                                  },
                                  loader: () =>const SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                orElse: ()=> const SizedBox(
                                  width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Spaces.Kheight20,
                                            Textutil(text: 'Synchronizing audio stream', fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal,),
                                            Spaces.Kheight10,
                                            Textutil(text: 'please wait ...', fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal,)
                                          
                                            ],
                                            
                                        ),
                                      ),);
                            },
                          ),
                   ),
                 ),
               const Spaceadjust()
        ],
      ),
    );
  }
}

