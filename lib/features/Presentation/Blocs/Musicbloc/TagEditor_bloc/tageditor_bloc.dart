import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Domain/UseCases/Platform_UseCase/updateaudiotag_usecase.dart';
import 'package:norse/injection_container.dart' as di;

part 'tageditor_event.dart';
part 'tageditor_state.dart';
part 'tageditor_bloc.freezed.dart';

class TageditorBloc extends Bloc<TageditorEvent, TageditorState> {
  TageditorBloc() : super(const _Initial()) {
    on<_UpdateNewTagVal>((event, emit) async {
      emit(const TageditorState.loading());
      Map<String, dynamic> vals = {
        'title': event.title,
        'artist': event.artist,
        'album': event.album,
        'ganre': event.ganre,
        'path': event.path
      };
      final response = await di.di<EditAudioTagUseCase>().call(vals);
      response.fold((l) {
        emit(const TageditorState.loaded());
        Spaces.showtoast('Edit unsuccessfull');
      }, (r) {
        emit(const TageditorState.loaded());
        Spaces.showtoast('Edited successfully');
      });
    });
  }
}
