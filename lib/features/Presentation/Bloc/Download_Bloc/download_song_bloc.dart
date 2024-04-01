import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/DownloadArtwork_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/DownloadSong_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/Platform_UseCase/shownotification_usecase.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../configs/constants/Spaces.dart';

part 'download_song_event.dart';
part 'download_song_state.dart';

class DownloadSongBloc extends Bloc<DownloadSongEvent, DownloadSongState> {
  final DownloadSongUseCase downloadSongUseCase;
  final DownloadArworkUseCase downloadArworkUseCase;
  final Shownotificationusecase shownotificationusecase;
  DownloadSongBloc(
    this.downloadSongUseCase,
    this.downloadArworkUseCase,
    this.shownotificationusecase,
  ) : super(DownloadSongInitial()) { 

    Audiotagger tagger = Audiotagger();

    List<Map<String,dynamic>> streams = [];


    additem(String id,int index,bool isloading)async{
      
           if (!streams.any((element) => element['id'] == id)) {
            
           final StreamController<double> controller = StreamController<double>.broadcast();

           Map<String,dynamic> m = {
               'id':id,
               'stream':controller,
            };

           streams.add(m);

           }
 } 
  
    on<DownloadStated>((event, emit) async{

      await additem(event.key,event.itemstreamindex,true);
 
      try {
      (streams.firstWhere((element) => element['id'] == event.key)['stream'] as StreamController<double>).add(0.0); 
      emit(DownloadSongStarted(streams: streams));
      Directory temp = await getTemporaryDirectory();
      String path = "/storage/emulated/0/Music/${event.songname}.m4a";
      String artworkpath = '${temp.path}/${event.albumname}.jpg';
      File file = File(path);
      if (file.existsSync()) {
         Spaces.showtoast('File exists in $path');
      }else{
      try { 
       emit(DownloadSongStarted(streams: streams));
       await downloadSongUseCase.call(event.url, (count, total) async{ 
            emit(DownloadSongStarted(streams: streams));
            double progress = (count/total) * 100;
            (streams.firstWhere((element) => element['id'] == event.key)['stream'] as StreamController<double>).add(progress);        
        },path);

        await downloadArworkUseCase.call(event.artworkurl, (count, total) {}, artworkpath);
        
        Tag tag = Tag(
        title: event.songname,
        artist: event.artists,
        artwork: artworkpath,
        album: event.albumname,
        comment: 'Nebula'
       );
       await shownotificationusecase.call(0.0,event.itemstreamindex,event.songname,'null');
       emit(DownloadSongFinished());
       await tagger.writeTags(path: path, tag: tag);
       for (int i = streams.length - 1; i >= 0; i--) {
           if (streams[i]['id'] == event.key) {
               streams.removeAt(i);
           }
       }
     } catch (e) {
       log(e.toString());
       }
      }
         } catch (e) {
           log(e.toString());
         }
       
    },
    transformer: concurrent(),
    ); 
  }
  
}

