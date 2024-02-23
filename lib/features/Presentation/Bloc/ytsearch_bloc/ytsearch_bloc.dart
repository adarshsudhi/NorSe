import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getsearchvideo_usecase.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:nebula/injection_container.dart' as di;


part 'ytsearch_event.dart';
part 'ytsearch_state.dart';
part 'ytsearch_bloc.freezed.dart';


class YtsearchBloc extends Bloc<YtsearchEvent, YtsearchState> {
  YtsearchBloc() : super( const _Initial()) {
    on<_Getsearch>((event, emit) async{
       emit(const YtsearchState.loader());
       dartz.Either<Failures,VideoSearchList> videos = await di.di<Getsearchvideousecase>().call(event.query);
       videos.fold((l) {
        throw Exception('youtube search failed');
       }, (r) {
         emit(YtsearchState.searchedvideo(r,false,false));
       });
    });
  }
}
