part of 'localsong_bloc.dart';

@freezed
class LocalsongState with _$LocalsongState {
  const factory LocalsongState.songs(
    List<SongModel> songlist,
    List<AlbumModel> albums,
    bool isloading,
    bool failed,
  ) = _Songs;
  const factory LocalsongState.initial() = _Initial;
}
