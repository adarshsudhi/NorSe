// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:nebula/features/Domain/UseCases/Platform_UseCase/getalbuma_usecase.dart';
import 'package:nebula/features/Domain/UseCases/Platform_UseCase/getallsongs_UseCase.dart';

import '../../../../configs/Error/Errors.dart';

part 'localsong_bloc.freezed.dart';
part 'localsong_event.dart';
part 'localsong_state.dart';

class LocalsongBloc extends Bloc<LocalsongEvent, LocalsongState> {
  final getallsongsUsecase getallsongs;
  final Getallalbumsusecase getallalbumsusecase;
  LocalsongBloc(
    this.getallsongs,
    this.getallalbumsusecase,
  ) : super( const _Initial()) {
    on<_Getallsongs>((event, emit) async {
       emit(const LocalsongState.songs([],[],true,false));
       Either<Failures,List<AlbumModel>> albums = await getallalbumsusecase.call();
       Either<Failures, List<SongModel>> songs = await getallsongs.call('songs');
       songs.fold((l) {
        log('Internal Song Failed');
       }, (songs) {
             albums.fold((l) {log('Albums fetch failed');}, (r) => emit(LocalsongState.songs(songs,r,false,false)));
       });
      
    });
  }
}
