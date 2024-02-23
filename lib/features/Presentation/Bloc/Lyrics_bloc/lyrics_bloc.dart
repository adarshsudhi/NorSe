// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/getlyrices_usecase.dart';
import 'package:nebula/injection_container.dart' as di;
import '../../../../configs/Error/Errors.dart';


part 'lyrics_bloc.freezed.dart';
part 'lyrics_event.dart';
part 'lyrics_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
   LyricsBloc() : super(const _Initial()) {
    on<_Getlyrics>((event, emit)async{
       emit(const LyricsState.loader());
       Either<Failures,String> res = await di.di<Getlyricesusecase>().call(event.id);
       res.fold((l) {
        log('Lyrics failed');
        emit(const LyricsState.initial());
       }, (r) {
        log('calling here all');
          emit(LyricsState.lyrics(r));
        });
    });
  }
}
