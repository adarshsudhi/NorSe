part of 'spotifyapi_bloc.dart';

@freezed
class SpotifyapiState with _$SpotifyapiState {
  const factory SpotifyapiState.initial() = _Initial;
  const factory SpotifyapiState.loading() = _Loading;
  const factory SpotifyapiState.userSaved(
    Map<String,dynamic> userdetails,
    List<PlaylistSimple> userplaylists,
    List<Artist> userartists,
    List<AlbumSimple> useralbums,
    List<PlayHistory> recentlyplayed,
    List<AlbumSimple> savedalbums,
    SpotifyApi spotifyapi,
    User user,
  ) = _UserSaved;
}
