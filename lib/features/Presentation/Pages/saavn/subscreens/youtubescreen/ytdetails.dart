import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';

import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../../Blocs/youtubeBloc/yt_bloc/yt_bloc.dart';
import '../../../../Blocs/youtubeBloc/ytdownload_bloc/ytdownload_bloc.dart';
import 'ytpage.dart';


class Ytdetails extends StatefulWidget {
  final String id;
  const Ytdetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<Ytdetails> createState() => _YtdetailsState();
}

class _YtdetailsState extends State<Ytdetails> {

 int selectedindex = 0;



  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioBloc>(context).add(const AudioEvent.dispose());
    BlocProvider.of<YtBloc>(context).add(YtEvent.getvideoinfoevent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height/2,
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
                           vidoeinfo: (videoinfo,videos,audionly) {
                             return SingleChildScrollView(
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                  Spaces.Kheight20,
                                  Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: MediaQuery.sizeOf(context).height/4,
                                        width: double.infinity,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) {
                                            return Thumbnailfuturebuilder(video: videoinfo.thumbnails);
                                          },
                                          imageUrl: videoinfo.thumbnails.maxResUrl,fit: BoxFit.cover,),
                                      ),
                                  Spaces.Kheight10,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Textutil(text: videoinfo.title, fontsize: 15, color: Colors.white, fontWeight:FontWeight.w600),
                                      Textutil(text: videoinfo.author, fontsize: 10, color: Colors.white, fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                  Spaces.Kheight20,
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.white
                                          ),
                                          child: const Icon(Icons.music_note,color: Colors.black,size: 15,),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Textutil(text: "Audio • ${audionly.bitrate.toString().replaceAll('it','')} •  ${audionly.audioCodec.split('.')[0]}",
                                         fontsize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                                      ],
                                    ),
                                    Spaces.Kheight20,
                                    Row(
                                      children: [
                                        Container(
                                              height: 50,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white
                                              ),
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(7),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Textutil(text: "${audionly.audioCodec} • ${audionly.size}",
                                                           fontsize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          Textutil(text: "${audionly.bitrate} ",
                                                           fontsize: 8, color: Colors.black, fontWeight: FontWeight.normal),
                                                            ],
                                                          ),)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                          Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: Colors.white
                                          ),
                                          child: Center(
                                            child: BlocBuilder<YtdownloadBloc,YtdownloadState>(
                                              builder: (context, state) {
                                                return state.maybeWhen(
                                                  loading: () {
                                                    return const CircularProgressIndicator(color: Colors.black,);
                                                  },
                                                  downloading: (progress) {
                                                    return StreamBuilder( 
                                                     stream: progress,
                                                        builder: (context, snapshot) {
                                                     if (snapshot.hasData) {
                                                       return Center(
                                                        child:Stack(
                                                         alignment: Alignment.center,
                                                         children: [
                                                         CircularProgressIndicator(value: snapshot.data!/100,color: Colors.black,),
                                                         Text(snapshot.data!.toStringAsFixed(0),style: Spaces.Getstyle(11,Colors.black,FontWeight.normal),)    
                                                       ],
                                                      )
                                                       );
                                                     }else{
                                                      return const SizedBox();
                                                     }
                                                     });
                                                     },
                                                  orElse: (){
                                                  return IconButton(onPressed: (){
                                                     BlocProvider.of<YtdownloadBloc>(context).add(YtdownloadEvent.downloadsong(videoinfo,videoinfo.id.toString()));
                                                  }, icon: const Icon(Icons.download));
                                                });
                                              },
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spaces.Kheight20,
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.white
                                          ),
                                          child: const Icon(CupertinoIcons.videocam,color: Colors.black,size: 15,),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Textutil(text: "Video • ${videos[selectedindex].qualityLabel} • ${videos[0].codec.subtype}",
                                         fontsize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                                      ],
                                    ),
                                    Spaces.Kheight20,
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 6,
                                        crossAxisCount: 3),
                                      itemCount: videos.length,
                                      itemBuilder:(context, index) {
                                        return  GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedindex = index;
                                            });
                                          },
                                          child: Container(
                                                height: 50,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: selectedindex==index?const Color.fromARGB(255, 31, 29, 58):Colors.white
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(7),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                              Textutil(text: "${videos[index].qualityLabel} • ${videos[index].size}",
                                                              fontsize: 9, color:selectedindex==index?Colors.white: Colors.black, fontWeight: FontWeight.bold),
                                                              Textutil(text: "Quality ${videos[index].codec.mimeType} ",
                                                              fontsize: 8, color:selectedindex==index?Colors.white: Colors.black, fontWeight: FontWeight.normal),
                                                              ],
                                                            ),)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        );
                                      },),
                                      Spaces.Kheight20,
                                      Container(
                                        height: 90,
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: const Color.fromARGB(255, 31, 29, 58)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Textutil(text: 'Download video in ${videos[selectedindex].qualityLabel}', fontsize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                                            Textutil(text: "Size ${videos[selectedindex].size} • Quality ${videos[selectedindex].qualityLabel}", fontsize: 10, color: Colors.white, fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                      )
                                           ],
                                       ),
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
      ),
    );
  }
}



