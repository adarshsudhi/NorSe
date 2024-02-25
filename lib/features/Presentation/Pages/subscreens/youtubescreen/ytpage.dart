import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/youtubeBloc/yt_bloc/yt_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/ytsearch_bloc/ytsearch_bloc.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/youtubescreen/ytdetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Youtubepage extends StatefulWidget {
  const Youtubepage({super.key});

  @override
  State<Youtubepage> createState() => _YoutubepageState();
}

class _YoutubepageState extends State<Youtubepage> {

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
                                fres: (videos,vidoes1, isloading, isfailed) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CarouselSlider(
                                        options: CarouselOptions
                                        (height: 200.0,
                                        viewportFraction: 1,
                                        autoPlayInterval: const Duration(seconds: 3),
                                        autoPlay: true,
                                        ),
                                        items: videos.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<YtBloc>(context).add(YtEvent.getvideoinfoevent(i.url.split('=')[1]));
                                                  Navigator.pushNamed(context,Ytdetailss.ytdetails,arguments: Ytdetailss(video: i));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width/1.1,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30)
                                                  ),
                                                  child: Image.network(i.thumbnails.highResUrl,fit: BoxFit.cover,)
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      Spaces.Kheight10,
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 17),
                                        child: Textutil(text: 'Trending Songs', fontsize: 20, color:Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      Spaces.Kheight10,
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:vidoes1.length,
                                          itemBuilder:(context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 17),
                                            child: GestureDetector(
                                              onTap: () {
                                            BlocProvider.of<YtBloc>(context).add(YtEvent.getvideoinfoevent(vidoes1[index].url.split('=')[1]));
                                            Navigator.pushNamed(context,Ytdetailss.ytdetails,arguments: Ytdetailss(video: vidoes1[index]));

                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(14)
                                                    ),
                                                    child: Image.network(vidoes1[index].thumbnails.standardResUrl,fit: BoxFit.cover,),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Textutil(text: vidoes1[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                        Textutil(text: vidoes1[index].title, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ); 
                                        },) 
                                        )
                                    ],
                                  );
                                },
                                searchedvideo: (videos, isloading, isfailed) {
                                  return isloading != true?Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: videos.length,
                                      itemBuilder:(context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                          BlocProvider.of<YtBloc>(context).add(YtEvent.getvideoinfoevent(videos[index].url.split('=')[1]));
                                          Navigator.pushNamed(context,Ytdetailss.ytdetails,arguments: Ytdetailss(video: videos[index]));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 17),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14)
                                                  ),
                                                  child: Image.network(videos[index].thumbnails.standardResUrl,fit: BoxFit.cover,),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Textutil(text: videos[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                      Textutil(text: videos[index].title, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        );
                                      },),
                                  ):const Column(
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
                                  
                                orElse: ()=> SizedBox(
                                  width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/yt.png',scale: 4,filterQuality: FilterQuality.low,color: Colors.white,),
                                            Spaces.Kheight10,
                                            const Textutil(text: 'YouTube Music Downloader', fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal,)
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

