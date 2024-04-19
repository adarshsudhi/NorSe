import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../../configs/Error/Errors.dart';
import '../../../../Domain/UseCases/yt_usecase/getaudiostream_usecase.dart';

part 'ytdownload_event.dart';
part 'ytdownload_state.dart';
part 'ytdownload_bloc.freezed.dart';

class YtdownloadBloc extends Bloc<YtdownloadEvent, YtdownloadState> {
  final Getaudiostreamusecase getaudiostreamusecase;
  YtdownloadBloc(this.getaudiostreamusecase) : super(const _Initial()) {
    
    StreamController<int> progresscontroller = StreamController<int>.broadcast();

    on<_Download>((event, emit) async{
      emit(const YtdownloadState.loading());
        Either<Failures, AudioOnlyStreamInfo> res = await getaudiostreamusecase.call(event.id);
        await res.fold((l) {
          log('Failed');
        }, (r) async{

  Directory temp = await getTemporaryDirectory();

  String tempDirectory = temp.path;

  AudioOnlyStreamInfo audio = r;

  Stream<List<int>> audioStream = YoutubeExplode().videos.streamsClient.get(r);

  String fileName = '${event.info.title}.${audio.container.name}'
      .replaceAll('.webm','')
      .replaceAll(':', '')
      .replaceAll('.mp4','')
      .replaceAll(r'\','')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', ''); 

   String path = "/storage/emulated/0/Music/$fileName.m4a";

   String artworkpath = '$tempDirectory/$fileName.jpg';

   await Dio().download(event.info.thumbnails.maxResUrl,artworkpath);

   File file = File(path);

   File img = File(artworkpath);

   Uint8List artworkbytes = img.readAsBytesSync();
   if (file.existsSync()) {
      Spaces.showtoast('already exists');
      emit(const YtdownloadState.initial());
   }else{
      
  IOSink output = file.openWrite(mode: FileMode.writeOnly);

  int len = audio.size.totalBytes;

  int count = 0;

  await for (List<int> data in audioStream) {
    
    count += data.length;

    int progress = ((count / len) * 100).ceil();

    progresscontroller.add(progress);

    emit(YtdownloadState.downloading(progresscontroller.stream));

    output.add(data);
  }

    await output.close();
    
    await MetadataGod.writeMetadata(
    file: path,
    metadata: Metadata(
      title: fileName.replaceAll('.m4a',''),
      artist: event.info.author,
      year: event.info.publishDate!.year,
      fileSize: file.lengthSync(),
      picture: Picture(mimeType: 'image/jpeg',
      data: artworkbytes)
    )).then((value) => emit(const YtdownloadState.initial()));

    Spaces.showtoast('Downloaded');
   }

    });
  });}
}