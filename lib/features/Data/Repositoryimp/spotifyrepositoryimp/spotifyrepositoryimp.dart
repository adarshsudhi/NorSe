import 'package:flutter/material.dart';
import 'package:norse/features/Data/DataSource/RemoteDataSource/spotify/spotifyremoteapi.dart';
import 'package:norse/features/Domain/Repositorys/spotifyrepository/spotifyrepository.dart';
import 'package:spotify/spotify.dart';

class Spotifyrepositoryimp  extends Spotifyrepository{
  final SpotifyRemoteApi spotifyRemoteApi;

  Spotifyrepositoryimp({required this.spotifyRemoteApi});
  @override
  Future<void> connectwithspotify(BuildContext context) => spotifyRemoteApi.connectwithspotify(context);
}