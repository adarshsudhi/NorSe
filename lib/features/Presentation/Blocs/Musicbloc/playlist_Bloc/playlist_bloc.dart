import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/addtoplaylist_usecase.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/createplaylist_usecase.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/getallplaylist_usecase.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/removeplaylist_usecase.dart';
import 'package:nebula/injection_container.dart' as di;


part 'playlist_event.dart';
part 'playlist_state.dart';
part 'playlist_bloc.freezed.dart';


class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(const _Initial()){
     on<_Createplaylist>((event, emit) async{
      Either<Failures,bool> res = await di.di<Createplaylistusecase>().call(event.playlistname);
      res.fold((l) {
        log('playlist Failed');
      }, (r) {
        Spaces.showtoast('Created');
      });
     });
     on<_Getallplaylist>((event, emit) async{
      log('Working');
       Either<Failures,List<Map<String,dynamic>>> res = await di.di<Getallplaylistusecase>().call();
       res.fold((l) {
        log('no playlists');
        emit(const PlaylistState.allplaylists([]));
       }, (r) => emit(PlaylistState.allplaylists(r)));
     });

     on<_Removeplaylist>((event, emit) async{
        Either<Failures,bool> res = await di.di<Removeplaylistusecase>().call(event.playlistid,event.playlistname);
       res.fold((l) {
        log('Remove failed');
       }, (r) {
        Spaces.showtoast('Deleted');
       });
     });
     on<_Addtoplaylist>((event, emit) async{
        Either<Failures,bool> res = await di.di<Addtoplaylistusecase>().call(event.tbname,event.song);
        res.fold((l) {
        log('adding failed');
       }, (r) {
        if (r) {
          Spaces.showtoast('Added');
        } else {
          Spaces.showtoast('Already Exists');
        }
       });
     });
  }
}
