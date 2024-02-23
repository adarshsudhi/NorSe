import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/youtubeBloc/yt_bloc/yt_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/ytsearch_bloc/ytsearch_bloc.dart';
import '../../../Bloc/youtubeBloc/ytdownload_bloc/ytdownload_bloc.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Youtubepage extends StatelessWidget {
  const Youtubepage({super.key});

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
                                            showModalBottomSheet(
                                            barrierColor: Colors.black.withOpacity(0.9),
                                            context: context, 
                                            builder:(context) {
                                              return Container(
                                                width: double.infinity,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                                ),
                                                child: const Ytdetails(),
                                              );
                                            },
                                           );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: Row( 
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 70,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Image.network(videos[index].thumbnails.mediumResUrl,fit: BoxFit.cover,),
                                                ),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                   Textutil(text: videos[index].title, fontsize: 20, color:Colors.white, fontWeight: FontWeight.normal),
                                             
                                                  Textutil(text: videos[index].author, fontsize: 13, color:Colors.white.withOpacity(0.4), fontWeight: FontWeight.normal),
                                                                                                
                                                  ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
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

class Ytdetails extends StatelessWidget {
  const Ytdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: SizedBox(
                   child: BlocBuilder<YtBloc,YtState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loader: () {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height/2,
                            width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        ),
                                        Spaces.Kheight20,
                                        Text('Decoding Audio Stream...',style: Spaces.Getstyle(15,Colors.white,FontWeight.normal),textAlign: TextAlign.center,),
                                        Spaces.Kheight10,
                                        Text('Please wait ...',style: Spaces.Getstyle(15,Colors.white,FontWeight.normal),textAlign: TextAlign.center,),
                                      ],
                                    ),
                                  );
                        },
                        vidoeinfo: (videoinfo) {
                           return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(videoinfo.thumbnails.highResUrl,fit: BoxFit.cover,),
                              Spaces.Kheight20,
                               BlocBuilder<YtdownloadBloc,YtdownloadState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loading: () {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                                  height: 60,
                                                  width: MediaQuery.sizeOf(context).width/2,
                                                  decoration: BoxDecoration(
                                                 color: Colors.blue,
                                                 borderRadius: BorderRadius.circular(30)
                                                        ),
                                                   child: const Center(
                                                    child: CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                   )
                                              ),
                                          ],
                                         );
                                       },
                                          downloading: (progress) {
                                             return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Container(
                                                 height: 60,
                                                 width: MediaQuery.sizeOf(context).width/2,
                                                 decoration: BoxDecoration(
                                                 color: Colors.blue,
                                                 borderRadius: BorderRadius.circular(30)
                                                     ),
                                                     child: StreamBuilder( 
                                                 stream: progress,
                                                    builder: (context, snapshot) {
                                                 if (snapshot.hasData) {
                                                   return Center(child:
                                                  Stack(
                                               alignment: Alignment.center,
                                               children: [
                                            CircularProgressIndicator(value: snapshot.data!/100,color: Colors.white,),
                                            Text('% ${snapshot.data!.toStringAsFixed(0)}',style: Spaces.Getstyle(7,Colors.white,FontWeight.normal),)    
                                               ],
                                             ));
                                                 }
                                                 return const SizedBox();
                                                      },)
                                                    ),
                                               ],
                                             );
                                           },
                                  orElse: ()=>Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                             onTap: (){
                                               BlocProvider.of<YtdownloadBloc>(context).add(YtdownloadEvent.downloadsong(videoinfo,videoinfo.id.toString()));
                                             },
                                             child:  Container(
                                               height: 60,
                                                width: MediaQuery.sizeOf(context).width/2,
                                               decoration: BoxDecoration(
                                                 color: Colors.blue,
                                                 borderRadius: BorderRadius.circular(30)
                                               ),
                                               child: const Center(child: Textutil(text: 'Download', fontsize: 12, color: Colors.white, fontWeight: FontWeight.normal))
                                             ),
                                           ),
                                  ],
                                ),);
                                },
                               ),
                               Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                               Spaces.Kheight20,
                               Textutil(text: 'Duration : ${videoinfo.duration.toString().split('.')[0]}', fontsize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                               Spaces.Kheight10,
                               Textutil(text: 'title : ${videoinfo.title}', fontsize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                               Spaces.Kheight10,
                               Textutil(text: 'Auther: ${videoinfo.author}', fontsize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                               Spaces.Kheight10,
                               Text('discription: ${videoinfo.description}',style: Spaces.Getstyle(15,Colors.white,FontWeight.bold),),
                               Spaces.Kheight10,
                                ],
                              ),
                               const Spaceadjust()
                               ],
                             );
                            },
                            orElse: ()=>SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.sizeOf(context).height/4,
                                          ),
                                          Image.asset('assets/yt.png',scale: 5,filterQuality: FilterQuality.low,color: Colors.white,), 
                                        ],
                                      ),
                                    ),
                                  ),
                      );
                    },
                   )
                 ),
    );
  }
}