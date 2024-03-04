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
import 'package:path_provider/path_provider.dart';
import '../../../../configs/constants/Spaces.dart';

part 'download_song_event.dart';
part 'download_song_state.dart';

class DownloadSongBloc extends Bloc<DownloadSongEvent, DownloadSongState> {
  final DownloadSongUseCase downloadSongUseCase;
  final DownloadArworkUseCase downloadArworkUseCase;
  DownloadSongBloc(
    this.downloadSongUseCase,
    this.downloadArworkUseCase,
  ) : super(DownloadSongInitial()) { 

    Audiotagger tagger = Audiotagger();

    List<Map<String,dynamic>> streams = [];



    additem(String id,int index,bool isloading)async{
      
           if (!streams.any((element) => element['id'] == id)) {
            
           final StreamController<double> controller = StreamController<double>.broadcast();
         
           Map<String,dynamic> m = {
               'id':id,
               'stream':controller,
               'isloading':isloading
            };

           streams.add(m);

           }
 } 
  
    on<DownloadStated>((event, emit) async{

      await additem(event.key,event.itemstreamindex,true);
 
      try {
      Directory temp = await getTemporaryDirectory();
      String tempDirectory = temp.path;
      String filename = event.songname;
      String path = "/storage/emulated/0/Music/$filename.m4a";
      String artworkpath = '$tempDirectory/$filename.jpg';
      File file = File(path);
      if (await file.exists()) {
         Spaces.showtoast('File exists in $path');
      }else{
      try {
       await downloadSongUseCase.call(event.url, (count, total) { 
           double progress = (count/total) * 100;
            (streams.firstWhere((element) => element['id'] == event.key)['stream'] as StreamController<double>).add(progress);
            emit(DownloadSongStarted(streams: streams));
        },path);
        await downloadArworkUseCase.call(event.artworkurl, (count, total) {}, artworkpath);
        
        Tag tag = Tag(
        title: filename,
        artist: event.artists,
        artwork: artworkpath,
        album: event.albumname,
        comment: 'Nebula'
       );
       emit(DownloadSongFinished());
       await tagger.writeTags(path: path, tag: tag);
       Spaces.showtoast("Downloaded to $path");
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

