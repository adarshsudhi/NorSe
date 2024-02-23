import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import 'package:nebula/features/Domain/Entity/PlaylistEntity/PlaylistEntity.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/GetAlbumSongs_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/getplaylists_Usecase.dart';
import 'package:nebula/features/Domain/UseCases/Platform_UseCase/getalbumsongs_usecase.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:nebula/injection_container.dart' as di;

part 'albums_songs_event.dart';
part 'albums_songs_state.dart';

class AlbumsSongsBloc extends Bloc<AlbumsSongsEvent, AlbumsSongsState> {
  final GetAlbumSongsUseCase songsUseCase;
  final getplaylistdetailsUSeCase playlistUseCase;
  AlbumsSongsBloc(
    this.songsUseCase,
    this.playlistUseCase,
  ) : super(AlbumsSongsInitial()) {
    on<GetAlbumSongsEvent>((event, emit) async {
      emit(AlbumsSongsloading());
      List<AlbumSongEntity> songs = await songsUseCase.call(event.albumurl);
      emit(AlbumsSongsloaded(songs: songs));
    });

    on<GetPlaylistsSongsEvent>((event, emit) async {
      emit(AlbumsSongsloading());
      Either<Failures, List<playlistEntity>> songs =
          await playlistUseCase.call(event.id);
      songs.fold((l) {
        emit(playlistsongs(songs: const []));
      }, (r) {
        emit(playlistsongs(songs: r));
      });
    });

    on<Getsongsfromalbum>((event, emit) async{
        emit(AlbumsSongsloading());
        Either<Failures,List<SongModel>> res =await di.di<Getalbumsongsusecase>().call(event.id);
        res.fold((l) {
        log("Songs From albums failed");
        }, (r) => emit(Songsfromalbum(albumsongs: r)));
    });
  }
}
