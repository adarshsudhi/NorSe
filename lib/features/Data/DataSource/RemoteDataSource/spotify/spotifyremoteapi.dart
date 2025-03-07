import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

abstract class SpotifyRemoteApi{
  Future<void>connectwithspotify(BuildContext context);
}