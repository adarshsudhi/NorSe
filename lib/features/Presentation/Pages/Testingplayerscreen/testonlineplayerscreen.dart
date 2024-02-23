import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nebula/features/Data/Models/onlinesongmodel.dart';
import 'package:nebula/features/Presentation/Bloc/Lyrics_bloc/lyrics_bloc.dart';
import 'package:nebula/features/Presentation/CustomWidgets/onlinequeue.dart';
import '../../../../configs/constants/Spaces.dart';
import 'package:nebula/injection_container.dart' as di;
import '../../../Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../../Domain/Entity/PlaylistEntity/PlaylistEntity.dart';
import '../../../Domain/Entity/SearchSongEntity/SearchEntity.dart';
import '../../../Domain/Entity/SongsDetailsEntity/SongsEntity.dart';
import '../../../Domain/UseCases/Sql_UseCase/addtodownloads_Usecase.dart';
import '../../Bloc/Library/song/library_bloc/library_bloc.dart';
import '../../Bloc/Library/song/songlike_bloc/songlike_bloc.dart';
import '../../Bloc/LocalData/localdata_bloc.dart';
import '../../Bloc/audio_bloc/audio_bloc.dart';
import '../MainHomePage/MainHomePage.dart';


class Onlineplayerscreen extends StatefulWidget {
  static const String onlineplayerscreen ='./onlinescreen';
  const Onlineplayerscreen({super.key});
  
  get currentscreen => null;

  @override
  State<Onlineplayerscreen> createState() => _OnlineplayerscreenState();
}

class _OnlineplayerscreenState extends State<Onlineplayerscreen> {

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
              onlinesongs: (state) {
                return StreamBuilder(
                         stream:state.valueStream,
                         builder: (context, snapshot) {
                           if (snapshot.hasData && snapshot.data != null) {
                      PlayerState duplayer = PlayerState(false,ProcessingState.loading);
      
                      final songindex = snapshot.data!.maybeMap(orElse: () => 0,onlinestreams: (value) => value.index,);
      
                     _controller = PageController(initialPage: songindex,viewportFraction: 1);
      
                      PlayerState playerState = snapshot.data!.maybeMap(orElse: () => duplayer,onlinestreams: (value) => value.playerState,);
                         
                      audios = List.from(state.audios);
      
                      audios.isNotEmpty?
                      BlocProvider.of<SonglikeBloc>(context).add(SonglikeEvent.checkifpresent(audios[songindex].id)):null;
      
                            
                             return Stack(
                              children: [
                                 SizedBox(
                                 height: MediaQuery.sizeOf(context).height,
                                 width: MediaQuery.sizeOf(context).width,
                                 child: ImageFiltered(
                                 imageFilter: ImageFilter.blur(sigmaX:60,sigmaY:60),
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
                                    Navigator.pushNamed(context,Onlinequeue.onlinequeuescreen,
                                    arguments: Onlinequeue(audios: audios,audioPlayer: state.audioPlayer,));
                                  }, icon: const Icon(Icons.queue_music,color: Colors.white,))
                                 ],
                                 leading: IconButton(onPressed: (){
                                 Navigator.pop(context);
                                  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
                                   ),
                                   FlipCard(
                                    front: SizedBox(
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
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                        child: Hero(
                                          tag: '2',
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: CachedNetworkImage(imageUrl: img,fit: BoxFit.fill,)),
                                        ),
                                      ),
                                    );
                                  },
                                 ),
                               ),
                               onFlip: () {
                                 BlocProvider.of<LyricsBloc>(context).add(LyricsEvent.getlyrics(audios[songindex].id));
                               },
                               back:SizedBox(
                                  height: MediaQuery.sizeOf(context).height/2.55,
                                  width: MediaQuery.sizeOf(context).width,                                
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
                                    child: Container(                                                      
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                            BlocBuilder<LyricsBloc,LyricsState>(
                                              builder: (context, state) {
                                                return state.maybeWhen(
                                                  lyrics: (lyrics) {
                                                    return ListView(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                                          child: Text(lyrics,style: Spaces.Getstyle(20,Colors.white,FontWeight.normal),textAlign: TextAlign.center,),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                  loader: () => const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: CircularProgressIndicator(color: Colors.white,)),
                                                  orElse: ()=>Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(':)',style: Spaces.Getstyle(60,Colors.white, FontWeight.normal),)
                                                         , const Column(
                                                          crossAxisAlignment:  CrossAxisAlignment.center,
                                                            children: [
                                                               Textutil(text: 'Lyrics ', fontsize: 40, color: Colors.white, fontWeight: FontWeight.normal),
                                                               Textutil(text: 'Not available ', fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal)
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ));
                                            },
                                                                                      )
                                        ],
                                      ),
                                    ),
                                  ),
                               )
                               ),
                                  
                               Column(
                                children: [
                                Padding(
                               padding: const EdgeInsets.only(right: 35,left: 35),
                               child: Text(audios[songindex].title,style: Spaces.Getstyle(35,Colors.white,FontWeight.bold),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
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
                                             secondaryTrackValue: snapshot.data!.mapOrNull(onlinestreams: (value) => value.buffer.inSeconds)!.toDouble(),
                                             thumbColor:const Color.fromARGB(255, 246, 246, 246),
                                             activeColor:  const Color.fromARGB(255, 255, 255, 255),
                                             inactiveColor: const Color.fromARGB(255, 115, 115, 115).withOpacity(0.6),
                                           value: snapshot.data!.mapOrNull(onlinestreams: (value) => value.pos.inSeconds,)!.toDouble(),
                                           max: snapshot.data!.mapOrNull(onlinestreams: (value) => value.dur.inSeconds,)!.toDouble(),
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
                                            snapshot.data!.mapOrNull(onlinestreams: (value) => value.pos.toString())!
                                            .toString()
                                            .split(".")[0]
                                            .replaceRange(0, 2, ""),
                                         style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 15),
                                       ),
                                       Text(
                                       snapshot.data!.mapOrNull(onlinestreams: (value) => value.dur.toString())!
                                    .toString()
                                        .split(".")[0]
                                        .replaceRange(0, 2, ""),
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
                                                        PlayIcons(iconscolors: const Color.fromARGB(255, 255, 255, 255),iconsize: 30,playicons: CupertinoIcons.backward_end_fill,ontap: () async{
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
                                                        PlayIcons(iconscolors: const Color.fromARGB(255, 255, 255, 255),iconsize: 30,playicons: CupertinoIcons.forward_end_fill,ontap: () async{
                                                       
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
                                   
                                             Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                               PlayIcons(playicons:Icons.download,iconscolors: const Color.fromARGB(255, 255, 255, 255), iconsize: 26, ontap: ()async{
                                                         
                                                                audios.isNotEmpty?
                                                                _downloadsong(audios, songindex):null;
                                   
                                                               
                                                               }),
                                                           
                                                               SizedBox(width: MediaQuery.sizeOf(context).width/1.8,),
                                       
                                                               //Libraru add icons buttons
                                       
                                                               BlocBuilder<SonglikeBloc,SonglikeState>(
                                                                builder: (context, state0) {
                               return state0.maybeWhen(
                                removed: () {
                                return PlayIcons(playicons:CupertinoIcons.heart_solid,iconscolors:const Color.fromARGB(255, 255, 255, 255), iconsize: 26, ontap: (){
                                 AlbumElements song = AlbumElements(
                                  id: audios[songindex].id, 
                                  name: audios[songindex].title, 
                                  year: '', 
                                  type: 'null', 
                                  language: 'null', 
                                  Artist: audios[songindex].artist, 
                                  url: audios[songindex].downloadurl, 
                                  image: audios[songindex].imageurl);
                                 BlocProvider.of<SonglikeBloc>(context).add(SonglikeEvent.addtolibray('song',song));
                                 _callallsongs();
                                  });
                                },
                                added: () {
                                   return PlayIcons(playicons:CupertinoIcons.heart_solid,iconscolors: Colors.red, iconsize: 26, ontap: (){
                                                                
                                 AlbumElements song = AlbumElements(
                                  id: audios[songindex].id, 
                                  name: audios[songindex].title, 
                                  year: '', 
                                  type: 'null', 
                                  language: 'null', 
                                  Artist: audios[songindex].artist, 
                                  url: audios[songindex].downloadurl, 
                                  image: audios[songindex].imageurl);
                                 BlocProvider.of<SonglikeBloc>(context).add(SonglikeEvent.addtolibray('song',song));
                                 _callallsongs();
                                  });
                                },
                                ispresent: (ispresent) {
                                  return PlayIcons(playicons:CupertinoIcons.heart_solid,iconscolors: ispresent?Colors.red: const Color.fromARGB(255, 255, 255, 255), iconsize: 26, ontap: (){
                                                                
                               AlbumElements song = AlbumElements(
                                  id: audios[songindex].id, 
                                  name: audios[songindex].title, 
                                  year: '', 
                                  type: 'null', 
                                  language: 'null', 
                                  Artist: audios[songindex].artist, 
                                  url: audios[songindex].downloadurl, 
                                  image: audios[songindex].imageurl);
                                 BlocProvider.of<SonglikeBloc>(context).add(SonglikeEvent.addtolibray('song',song));
                                 _callallsongs();
                                                               });
                                },
                                orElse:(){
                                return PlayIcons(playicons:CupertinoIcons.heart_solid,iconscolors: const Color.fromARGB(255, 255, 255, 255), iconsize: 26, ontap: (){
                                                                
                                AlbumElements song = AlbumElements(
                                  id: audios[songindex].id, 
                                  name: audios[songindex].title, 
                                  year: '', 
                                  type: 'null', 
                                  language: 'null', 
                                  Artist: audios[songindex].artist, 
                                  url: audios[songindex].downloadurl, 
                                  image: audios[songindex].imageurl);
                                 BlocProvider.of<SonglikeBloc>(context).add(SonglikeEvent.addtolibray('song',song));
                                 _callallsongs();
                                   });
                               });
                                                                },
                                                               )
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



     _callallsongs()async{
  if (mounted) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
    BlocProvider.of<LibraryBloc>(context).add(const LibraryEvent.getlibrarysong());
  });
  }
 }

   _downloadsong(List<OnlineSongModel> song,int index)async{
       final data = song[index];
       AlbumElements albumElements = AlbumElements(
       id: data.id,
       name: data.title,
        year: 'null',
        type: '',
        language: 'null',
        Artist: data.artist,
        url: data.downloadurl,
        image: data.imageurl);
       await di.di<addtodownloadsUsecase>().call(albumElements);
   }
}
  
  class PlayIcons extends StatelessWidget {
  final IconData playicons;
  final Color iconscolors;
  final double iconsize;
  final VoidCallback ontap;
  const PlayIcons({
    Key? key,
    required this.playicons,
    required this.iconscolors,
    required this.iconsize,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: IconButton(onPressed: ontap, icon: Icon(playicons,size: iconsize,color: iconscolors)));
  }
}
  
  Recents(List<dynamic> song,int index,BuildContext context,String albumname)async{
        if (song is List<AlbumSongEntity>) {
        final data = song[index];
       AlbumElements albumElements = AlbumElements(
       id: data.id,
       name: data.name,
        year: data.year,
        type: albumname,
        language: 'null',
        Artist: data.primaryArtists,
        url: data.songs,
        image: data.image);
       BlocProvider.of<LocaldataBloc>(context).add(LocaldataEvent.addtorecent(albumElements));
     } else if(song is List<SearchEntity>) {
           final data = song[index];
       AlbumElements albumElements = AlbumElements(
       id: data.id,
       name: data.name,
        year: data.year,
        type: albumname,
        language: 'null',
        Artist: data.primaryArtists,
        url: data.downloadUrl,
        image: data.image);
       BlocProvider.of<LocaldataBloc>(context).add(LocaldataEvent.addtorecent(albumElements));
     }else if(song is List<playlistEntity>){
        final data = song[index];
       AlbumElements albumElements = AlbumElements(
        id: data.id,
        name: data.name,
        year: 'null',
        type: albumname,
        language: 'null',
        Artist: data.primaryArtists,
        url: data.downloadUrl,
        image: data.images);
       BlocProvider.of<LocaldataBloc>(context).add(LocaldataEvent.addtorecent(albumElements));
     }
  }