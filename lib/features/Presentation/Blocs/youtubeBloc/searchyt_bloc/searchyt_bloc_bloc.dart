import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:nebula/injection_container.dart' as di;
import '../../../../../configs/Error/Errors.dart';
import '../../../../Domain/UseCases/yt_usecase/getsearchvideo_usecase.dart';


part 'searchyt_bloc_bloc.freezed.dart';
part 'searchyt_bloc_event.dart';
part 'searchyt_bloc_state.dart';

class SearchytBlocBloc extends Bloc<SearchytBlocEvent, SearchytBlocState> {
  SearchytBlocBloc() : super(const _Initial()) {
       on<_Started>((event, emit) => emit(const SearchytBlocState.initial()));
       on<_Getsearch>((event, emit) async{
       emit(const SearchytBlocState.loader());
       Either<Failures,VideoSearchList> videos = await di.di<Getsearchvideousecase>().call(event.query);
       videos.fold((l) {
        throw Exception('youtube search failed');
       }, (r) {
         emit(SearchytBlocState.searchedvideo(r,false,false));
       });
    });
    
  }
}
