import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

abstract class Spotifyrepository{
   Future<void>connectwithspotify(BuildContext context);
}