import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:norse/configs/APIEndpoints/API.dart';
import 'package:norse/features/Data/DataSource/RemoteDataSource/spotify/spotifyremoteapi.dart';
import 'package:norse/features/Presentation/Blocs/spotify/spotifyapi_bloc/spotifyapi_bloc.dart';
import 'package:spotify/spotify.dart';
import 'package:url_launcher/url_launcher.dart';

final _scopes = [
  AuthorizationScope.playlist.modifyPrivate,
  AuthorizationScope.playlist.modifyPublic,
  AuthorizationScope.library.read,
  AuthorizationScope.library.modify,
  AuthorizationScope.connect.readPlaybackState,
  AuthorizationScope.connect.modifyPlaybackState,
  AuthorizationScope.listen.readRecentlyPlayed,
  AuthorizationScope.follow.read
];

final appLinks = AppLinks();

String requestAuthorization() =>
      'https://accounts.spotify.com/authorize?client_id=${ApiEndpoints.clientid}&response_type=code&redirect_uri=${ApiEndpoints.redirecturl}&scope=${_scopes.join('%20')}';


class Spotifyremoteimplimentation extends SpotifyRemoteApi{

  @override
  Future<void> connectwithspotify(BuildContext context) async{

  final credentials = SpotifyApiCredentials(ApiEndpoints.clientid, ApiEndpoints.clientSecret);

  var grant = SpotifyApi.authorizationCodeGrant(credentials);
  var authUri =
      grant.getAuthorizationUrl(Uri.parse(ApiEndpoints.redirecturl), scopes: _scopes);

    appLinks.stringLinkStream.listen((e)async{
      try {
        log(Uri.parse(e).queryParameters.toString());
     
        var client = 
        await grant.handleAuthorizationResponse(Uri.parse(e).queryParameters);
        log(client.credentials.accessToken);
        SpotifyApi spotifyApi = SpotifyApi.fromClient(client);
        User user = await spotifyApi.me.get();
        BlocProvider.of<SpotifyapiBloc>(context).add(SpotifyapiEvent.grantedAccess(spotifyApi, user, client));
      } catch (e) {
        log(e.toString());
      }
     });
  await launchUrl(authUri);

 
  
  

  throw Exception('unimplimeted');
  }

}