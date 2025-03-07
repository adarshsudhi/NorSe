part of 'spotifyplaylistsoralbum_bloc.dart';

@freezed
class SpotifyplaylistsoralbumEvent with _$SpotifyplaylistsoralbumEvent {
  const factory SpotifyplaylistsoralbumEvent.started() = _Started;
  const factory SpotifyplaylistsoralbumEvent.getalbumtracks(
    SpotifyApi spotify,
    User user,
    String id,
  ) = _albumtracks;
  const factory SpotifyplaylistsoralbumEvent.getplaylisttracks(
    SpotifyApi spotify,
    User user,
    String id,
  ) = _playlisttracks;

    const factory SpotifyplaylistsoralbumEvent.getartisttoptrack(
    SpotifyApi spotify,
    User user,
    String id,
  ) = _getartisttoptrack;



}