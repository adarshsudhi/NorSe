import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getaudiostream_usecase.dart';
import 'package:nebula/injection_container.dart' as di;
import 'package:nebula/features/Domain/UseCases/yt_usecase/getstreamManifest_usecase.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getvideoinfo_usecase.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../../configs/Error/Errors.dart';

part 'yt_event.dart';
part 'yt_state.dart';
part 'yt_bloc.freezed.dart';

class YtBloc extends Bloc<YtEvent, YtState> {
  final Getvideoinfousecase getvideoinfousecase;
  YtBloc(this.getvideoinfousecase) : super(const _Initial()) {
    on<_Getinfo>((event, emit) async{
      
    emit(const YtState.loader());

    Either<Failures, Video> info =await getvideoinfousecase.call(event.id);

    List<VideoOnlyStreamInfo> videos = await di.di<GetstreamManifestusecase>().call(event.id);

    final res = await di.di<Getaudiostreamusecase>().call(event.id);
    
    await info.fold((l) {
      log('Invalid url');
     }, (r) async{
        await res.fold((l) {},
         (t) async=> emit(YtState.vidoeinfo(r,videos,t)));
     });

    });
  }
}
