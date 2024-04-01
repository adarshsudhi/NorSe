import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Domain/Entity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Entity/SearchSongEntity/SearchEntity.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/getnewlyreleased_Usecase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/getsearchsongs_usecase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/gettopCharts_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/gettopalbums_Usecase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/gettopsearches_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/trendingnow_UseCase.dart';
import '../../../Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import 'package:nebula/injection_container.dart' as di;

part 'trending_song_event.dart';
part 'trending_song_state.dart';

class TrendingSongBloc extends Bloc<TrendingSongEvent, TrendingSongState> {
  final trendingnowUseCase trendingnow;
  final GettopserachesUseCase topsearches;
  final GettopChatsUseCase topCharts;
  final newlyreleasedUsecase newtrending;
  final gettopalbumsUseCase gettopalbums;
  TrendingSongBloc(
    this.trendingnow,
    this.topsearches,
    this.topCharts, this.newtrending, this.gettopalbums,
  ) : super(TrendingSongInitial()) {
    on<TrendingSongs>(getTrendingSongs);
  }
  FutureOr<void>getTrendingSongs(TrendingSongs event,Emitter<TrendingSongState> emit)async{
  try {
      emit(TrendingSongLoading());
       List<launchdataEntity> trending = await trendingnow.call('hindi,malayalam,tamil');
       List<launchdataEntity>malayalam = await trendingnow.call('malayalam');
       List<launchdataEntity>tamil = await trendingnow.call('tamil');
       List<SearchEntity> picks = await di.di<Getsearchsongsusecase>().call('bollywood');
       List<launchdataEntity>english = await trendingnow.call('english');
       List<launchdataEntity>hindi = await trendingnow.call('hindi');
       Either<Failures,List<launchdataEntity>> newly = await newtrending.call();
        log('working here');
       Either<Failures,List<launchdataEntity>> topalbums = await gettopalbums.call();
      newly.fold((l) => 
       Spaces.showtoast('error'),
       (newrelease) => topalbums.fold((l) =>
        Spaces.showtoast('Error'), (albums) => 
        emit(Songstate(topalbums: albums,hindi: hindi,Tamil: tamil, Malayalam: malayalam,trendingnow: trending,English: english,newlyreleased: newrelease,picks: picks))
       ));     
} catch (e) {
   log(e.toString());
}
    }


}
