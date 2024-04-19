import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nebula/features/Presentation/CustomWidgets/backgroundGradient.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../configs/constants/Spaces.dart';
import '../../Data/Models/MusicModels/songmodel.dart';
import '../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';

class Reorder extends StatefulWidget {
  final List<Songmodel> audios;
  final int index;
  final AudioPlayer audioPlayer;
  const Reorder({
    Key? key,
    required this.audios,
    required this.index,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  State<Reorder> createState() => _ReorderState();
}

class _ReorderState extends State<Reorder> {

  int songindex = 0;

  late StreamSubscription<int?> _streamSubscription;

  late List<Songmodel> audios;

  @override
  void initState() {
     if (mounted) {
       setState(() {
        audios = List.from (widget.audios);
     });
     }
     _streamSubscription = widget.audioPlayer.currentIndexStream.listen((event) {
      if (mounted) {
        setState(() {
        songindex = event!;
      });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  _clear()async{
  for (int i = audios.length - 1; i >= 0; i--) {
  if (i == songindex) {
    continue;
  } else {
    audios.removeAt(i);
    setState((){});
  }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
              BlocProvider.of<AudioBloc>(context).add(AudioEvent.clearqueueexceptplaying('local',songindex));   
              await _clear();
          }, icon: const Icon(Icons.clear_all_outlined,color: Colors.white,)),
          const SizedBox(width: 5,)
        ],
       surfaceTintColor: Colors.transparent,
       leading: IconButton(onPressed: (){
         Navigator.pop(context);
       }, icon: const Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
       backgroundColor: Colors.transparent,
       title: const Textutil(text: 'Playing queue', fontsize:20, color:Colors.white, fontWeight:FontWeight.bold),
      ),
      body: Stack(
        children: [
              
              const backgroundgradient(),
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
                          Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                      Colors.black,
                       Colors.black,
                       Colors.transparent
                     ])
                   ),
                 ),
               ), 
              
          SafeArea(
            child: Column(
             children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10,),
                  Textutil(text: '${songindex+1}/${ audios.length}', fontsize: 20, color: Colors.white, fontWeight:FontWeight.bold)
                ],
              ),
              Spaces.Kheight10,
               Expanded(
                 child: ReorderableListView(
                     proxyDecorator: (child, index, animation) {
                       return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),),
              Spaces.kheigth5,
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),)
            ],
          ),
           const SizedBox(width: 10,),
            QueryArtworkWidget(
             id: audios[index].id, 
             type: ArtworkType.AUDIO,
             nullArtworkWidget: SizedBox(
               height: 50,
                width: 50,
              child: Image.asset('assets/musical-note.png',
               color: Colors.white.withOpacity(0.5),),
                 ),
             keepOldArtwork: true,
             artworkBorder: BorderRadius.circular(10),
             ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textutil(text: audios[index].title, fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal),
                      Textutil(text: audios[index].subtitle, fontsize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20,),
                ],
                 ),
                );
                     },
                  onReorder:(oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                   newIndex -= 1;
                  }
                  

                    BlocProvider.of<AudioBloc>(context).add(AudioEvent.updatequeue('local',newIndex,oldIndex));
                    Songmodel item = audios.removeAt(oldIndex);
                    audios.insert(newIndex, item);
                    setState(() {});
                     },
                     children: List.generate(audios.length,
                      (index) => GestureDetector(
                       key: Key(audios[index].id.toString()),
                       onTap: () async{
                          
                       },
                       child: songindex == index?
                      Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),),
              Spaces.kheigth5,
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),)
            ],
          ),
           const SizedBox(width: 10,),
            QueryArtworkWidget(
              keepOldArtwork: true,
              size: 250,
              id: audios[index].id, 
              nullArtworkWidget: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset('assets/musical-note.png',
              color: Colors.white.withOpacity(0.5),),
               ),
              artworkBorder: BorderRadius.circular(10),
              type: ArtworkType.AUDIO),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textutil(text: audios[index].title, fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal),
                      Textutil(text: audios[index].subtitle, fontsize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              const Row(
                children: [
                  Icon(Icons.bar_chart,color: Colors.white,),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
                ],
             ),
         ):
                       //second
                       GestureDetector(
                        onTap: () async {
                           await widget.audioPlayer.seek(Duration.zero,index: index);
                        },
                        child: Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),),
              Spaces.kheigth5,
              Container(height: 2,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),)
            ],
          ),
           const SizedBox(width: 10,),
            QueryArtworkWidget(
              keepOldArtwork: true,
              size: 250,
              nullArtworkWidget:SizedBox(
                  height: 50,
                   width: 50,
                   child: Image.asset('assets/musical-note.png',
                    color: Colors.white.withOpacity(0.5),),
                         ),
              id : audios[index].id, 
              artworkBorder: BorderRadius.circular(10),
              type: ArtworkType.AUDIO),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textutil(text: audios[index].title, fontsize: 16, color: Colors.white, fontWeight: FontWeight.normal),
                      Textutil(text: audios[index].subtitle, fontsize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
              ),
               const SizedBox(width: 20,),
               IconButton(onPressed: (){
                     BlocProvider.of<AudioBloc>(context).add(AudioEvent.removeitemfromqueue('local',index));
                     setState(() {
                       audios.remove(audios[index]);
                     });
               }, icon: const Icon(Icons.remove,color: Colors.white,))
                ],
             ),
         )
         ))))
               )
             ],
                        ),
          ),
        ],
      )
    );
  }
}




