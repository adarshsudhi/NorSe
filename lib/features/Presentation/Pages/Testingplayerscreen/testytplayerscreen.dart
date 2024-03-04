import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nebula/features/Presentation/Bloc/youtubeBloc/yt_bloc/yt_bloc.dart';
import 'package:nebula/features/Presentation/Pages/Testingplayerscreen/testonlineplayerscreen.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/youtubescreen/ytdetails.dart';
import '../../../../configs/constants/Spaces.dart';
import '../../../Data/Models/onlinesongmodel.dart';
import '../../Bloc/audio_bloc/audio_bloc.dart';
import '../../CustomWidgets/onlinequeue.dart';
import '../MainHomePage/MainHomePage.dart';

class Testytplayer extends StatefulWidget {
  static const String testytplayer = "./testytplayer";
  const Testytplayer({super.key});

  @override
  State<Testytplayer> createState() => _TestytplayerState();
}

class _TestytplayerState extends State<Testytplayer> {
     late PageController _controller;

    void changeduration(int sceconds, AudioPlayer player) {
    Duration duration = Duration(seconds: sceconds);
    player.seek(duration);
    }

  List<OnlineSongModel> audios = [];

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Scaffold(extendBodyBehindAppBar: true,
    backgroundColor: Colors.transparent,
     body: SizedBox(
        height: size.height,
        width:size.width,
        child: BlocBuilder<AudioBloc,AudioState>(
          builder: (context, state) {
            return state.maybeMap(
              youtubesong: (state) {
                return StreamBuilder(
                         stream:state.valueStream,
                         builder: (context, snapshot) {
                           if (snapshot.hasData && snapshot.data != null) {

                      PlayerState duplayer = PlayerState(false,ProcessingState.loading);
      
                      final songindex = snapshot.data!.maybeMap(orElse: () => 0,youtubestreams: (value) => value.index,);
      
                     _controller = PageController(initialPage: songindex,viewportFraction: 1);
      
                      PlayerState playerState = snapshot.data!.maybeMap(orElse: () => duplayer,youtubestreams: (value) => value.playerState,);
                         
                      audios = List.from(state.audios);
                            
                             return Stack(
                              children: [
                                 SizedBox(
                                 height: MediaQuery.sizeOf(context).height,
                                 width: MediaQuery.sizeOf(context).width,
                                 child: ImageFiltered(
                                 imageFilter: ImageFilter.blur(sigmaX:100,sigmaY:100),
                                 child: CachedNetworkImage(imageUrl: audios[songindex].imageurl,fit: BoxFit.cover,filterQuality: FilterQuality.high,),
                                 ),
                                ),
                                 Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: MediaQuery.sizeOf(context).height,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                Colors.black,
                                Colors.black,
                                Colors.black.withOpacity(0.8),
                                Colors.transparent
                                ])
                                ),
                               ),
                             ),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppBar(
                                 surfaceTintColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                 centerTitle: true,
                                 actions: [
                                  IconButton(onPressed: (){
                                    BlocProvider.of<YtBloc>(context).add(YtEvent.getvideoinfoevent(audios[songindex].id));
                                    Navigator.pushNamed(context,Ytdetailss.ytdetails,arguments: audios[songindex]);
                                  }, icon: const Icon(Icons.download,color: Colors.white,)),
                                  const SizedBox(width: 20,),
                                  IconButton(onPressed: (){
                                    Navigator.pushNamed(context,Onlinequeue.onlinequeuescreen,
                                    arguments: Onlinequeue(audios: audios,audioPlayer: state.audioPlayer,));
                                  }, icon: const Icon(Icons.queue_music,size: 28,color: Colors.white,))
                                 ],
                                 leading: IconButton(onPressed: (){
                                 Navigator.pop(context);
                                  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
                                   ),
                                  SizedBox(
                                  height: MediaQuery.sizeOf(context).height/2.50,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: PageView.builder(
                                  physics:const NeverScrollableScrollPhysics(),
                                  controller: _controller,
                                  scrollBehavior: const CupertinoScrollBehavior(),
                                  itemCount: audios.length,
                                  itemBuilder: (context, index) {
                                    String img = audios[index].imageurl;
                                   _controller.hasClients && songindex != index? _controller.animateToPage(songindex, duration: const Duration(milliseconds: 300), curve:Curves.easeInOut):null;
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
                                      child: Material(
                                        elevation: 6,
                                        surfaceTintColor: Colors.transparent,
                                        color: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        child: Hero(
                                          tag: '1',
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: CachedNetworkImage(
                                              errorWidget: (context, url, error) {
                                                return Image.asset('assets/musical-note.png',color: Colors.white.withOpacity(0.5),);
                                              },
                                              imageUrl: img,fit: BoxFit.fitWidth,)),
                                        ),
                                      ),
                                    );
                                  },
                                 ),
                               ),
                                  
                               Column(
                                children: [
                                Padding(
                               padding: const EdgeInsets.only(right: 35,left: 35),
                               child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Spaces.songtitle(audios[songindex].title,30,Colors.white,FontWeight.bold,context),
                               )
                              ),  Padding(
                              padding: const EdgeInsets.only(right: 30,left: 30),
                              child: Text(audios[songindex].artist,style: Spaces.Getstyle(12,Colors.white,FontWeight.bold),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
                               ),
                                ],
                               ), Row(   
                                   mainAxisAlignment: MainAxisAlignment.center, 
                                    children: [
                                     Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Slider(
                                            secondaryActiveColor: Colors.grey.withOpacity(0.6),
                                             secondaryTrackValue: snapshot.data!.mapOrNull(youtubestreams: (value) => value.buffer.inSeconds)!.toDouble(),
                                             thumbColor:const Color.fromARGB(255, 246, 246, 246),
                                             activeColor:  const Color.fromARGB(255, 255, 255, 255),
                                             inactiveColor: const Color.fromARGB(255, 115, 115, 115).withOpacity(0.6),
                                           value: snapshot.data!.mapOrNull(youtubestreams: (value) => value.pos.inSeconds,)!.toDouble(),
                                           max: snapshot.data!.mapOrNull(youtubestreams: (value) => value.dur.inSeconds,)!.toDouble(),
                                           min: const Duration(microseconds: 0).inSeconds
                                            .toDouble(),
                                             onChanged: (double value) {
                                              changeduration(value.toInt(), state.audioPlayer);
                                              },),
                                          ),
                                             Padding(
                              padding: const EdgeInsets.only(right: 22,left: 23,top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                        Text(
                                            snapshot.data!.mapOrNull(youtubestreams: (value) => value.pos.toString())!
                                            .toString()
                                            .split(".")[0],
                                         style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 15),
                                       ),
                                       Text(
                                       snapshot.data!.mapOrNull(youtubestreams: (value) => value.dur.toString())!
                                    .toString()
                                        .split(".")[0],
                                     style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 15),
                                   ),
                                ],
                              ),
                                    ),
                                     ] 
                                  ),
                                  ),
                               ],
                                                          ),
                              
                              Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                        PlayIcons(iconscolors: islooped==true?Colors.white: const Color.fromARGB(255, 68, 68, 68),iconsize: 25,playicons:CupertinoIcons.loop_thick,
                                                        ontap:  () { 
                                                          setState(() {
                                                               islooped = !islooped;
                                                          });
                                                          if (islooped == true) {
                                                               BlocProvider.of<AudioBloc>(context).add(AudioEvent.loopon(islooped));
                                                          } else {
                                                               BlocProvider.of<AudioBloc>(context).add(AudioEvent.loopon(islooped));
                                                          }
                                                        },),
                                                        PlayIcons(iconscolors: state.audioPlayer.hasPrevious? const Color.fromARGB(255, 255, 255, 255):
                                                        Colors.white.withOpacity(0.3)
                                                        ,iconsize: 30,playicons: CupertinoIcons.backward_end_fill,ontap: () async{
                                                        BlocProvider.of<AudioBloc>(context).add(const AudioEvent.SeekPreviousAudio());
                                                        _controller.animateToPage(state.audioPlayer.previousIndex!, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                                                        },),
                                                        Stack(
                                                         alignment: Alignment.center,
                                                          children: [
                                                          playerState.processingState == ProcessingState.loading || 
                                                          playerState.processingState == ProcessingState.buffering
                                                          ?   const SizedBox(
                                                                height: 75,
                                                                width: 75,
                                                                child: CircularProgressIndicator(color: Colors.white,)
                                                           ):const SizedBox(),
                                                               Card(
                                                                elevation: 11,
                                                                color: Colors.white,
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                                          child: Container(
                                                               height: 65,
                                                               width: 65,
                                                               decoration: BoxDecoration(color: const Color.fromARGB(255, 239, 239, 239),borderRadius: BorderRadius.circular(60)),
                                                               child: PlayIcons(playicons: state.audioPlayer.playing == true?CupertinoIcons.pause:CupertinoIcons.play_arrow, iconscolors: Colors.black, iconsize: 25, ontap: (){
                                                                 if (state.audioPlayer.playing == true) {
                                                                 BlocProvider.of<AudioBloc>(context).add(const AudioEvent.pause());
                                                                 } else {
                                                               BlocProvider.of<AudioBloc>(context).add(const AudioEvent.resume());
                                                               
                                                                    }
                                                               })
                                                          ),
                                                               ),
                                                          ],
                                                        ),
                                                        PlayIcons(iconscolors:state.audioPlayer.hasNext? const Color.fromARGB(255, 255, 255, 255)
                                                        :Colors.white.withOpacity(0.3)
                                                        ,iconsize: 30,playicons: CupertinoIcons.forward_end_fill,ontap: () async{
                                                       
                                                       BlocProvider.of<AudioBloc>(context).add(const AudioEvent.seeknextaudio());  
                                                        _controller.animateToPage(state.audioPlayer.nextIndex!, duration: const Duration(seconds: 1), curve: Curves.easeIn);
                                                       setState(() {});
                                                        },),
                                                         PlayIcons(iconscolors:isSuffled==true?Colors.white: const Color.fromARGB(255, 68, 68, 68),iconsize: 25,playicons: CupertinoIcons.shuffle,
                                                        ontap:  () { 
                                                               setState(() {
                                                          isSuffled = !isSuffled;
                                                               });
                                                               if (isSuffled==true) {
                                                          BlocProvider.of<AudioBloc>(context).add(AudioEvent.shuffleon(isSuffled));
                                                               } else {
                                                          BlocProvider.of<AudioBloc>(context).add(AudioEvent.shuffleon(isSuffled));
                                                               }
                                                         },),
                                                        ],
                                                       
                                                        ),

                                     Spaces.Kheight20,
                                     ],
                                  )
                              ],
                             );
                             
                           } else {
                             return const SizedBox();
                           }
                         },) ;
              },
              orElse: ()=> const SizedBox());
          },
        ),
      ),
    );
  }

}