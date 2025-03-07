part of 'spotifyapi_bloc.dart';

@freezed
class SpotifyapiEvent with _$SpotifyapiEvent {
  const factory SpotifyapiEvent.started() = _Started;
  const factory SpotifyapiEvent.connectapi(BuildContext context) = _ConnectApi;
  const factory SpotifyapiEvent.grantedAccess(
    SpotifyApi spotifyapi,
    User user,
    Client client,
  ) = _GrantedAccess;
}