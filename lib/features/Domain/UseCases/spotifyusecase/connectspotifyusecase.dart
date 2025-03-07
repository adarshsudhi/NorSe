import 'package:flutter/material.dart';
import 'package:norse/features/Domain/Repositorys/spotifyrepository/spotifyrepository.dart';
import 'package:spotify/spotify.dart';

class Connectspotifyusecase  {
  final Spotifyrepository repository;

  Connectspotifyusecase({required this.repository});
  Future<void> call(BuildContext context)async{
    return repository.connectwithspotify(context);
  }
}