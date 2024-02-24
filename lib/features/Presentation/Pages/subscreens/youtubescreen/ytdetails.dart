import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../Bloc/youtubeBloc/yt_bloc/yt_bloc.dart';
import '../../../Bloc/youtubeBloc/ytdownload_bloc/ytdownload_bloc.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Ytdetailss extends StatelessWidget {
  static const String ytdetails = './ytdetails';
  const Ytdetailss({
    Key? key,
    required this.video,
  }) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.sizeOf(context);
     return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Textutil(text: video.title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child:Stack(
          children: [
         Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Colors.indigo,
              Colors.black
            ])
          ),
        ),  
                  Container(
            color: Colors.black.withOpacity(0.8),
          ),
            SafeArea(
              child: ListView(
                children: [
                  Spaces.Kheight10,
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      height: 200,
                      width: double.infinity,
                      child: Image.network(video.thumbnails.highResUrl,fit: BoxFit.cover,),
                    ),
                    Spaces.Kheight20,
                    const Ytdetails()
                ],
              ),
            ),
          ],
        ),
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