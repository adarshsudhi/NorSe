part of 'spotifyplaylistsoralbum_bloc.dart';

@freezed
class SpotifyplaylistsoralbumState with _$SpotifyplaylistsoralbumState {
  const factory SpotifyplaylistsoralbumState.initial() = _Initial;
  const factory SpotifyplaylistsoralbumState.loadingtracks() = _LoadingTracks;
  const factory SpotifyplaylistsoralbumState.tracks(
  List<TrackSimple> tracks,
  ) = _Tracks;
  const factory SpotifyplaylistsoralbumState.playlisttracks(
  List<Track> tracks,
  ) = _Playlisttracks;

}
