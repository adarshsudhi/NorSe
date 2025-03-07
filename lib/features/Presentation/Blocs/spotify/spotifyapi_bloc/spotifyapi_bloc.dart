import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:norse/features/Domain/UseCases/spotifyusecase/connectspotifyusecase.dart';
import 'package:norse/injection_container.dart' as di;
import 'package:spotify/spotify.dart';

part 'spotifyapi_event.dart';
part 'spotifyapi_state.dart';
part 'spotifyapi_bloc.freezed.dart';

class SpotifyapiBloc extends Bloc<SpotifyapiEvent, SpotifyapiState> {
  SpotifyapiBloc() : super(const _Initial()) {
    final spotifyconnection = di.di<Connectspotifyusecase>();
    on<_ConnectApi>((event, emit) async{
            emit(const SpotifyapiState.loading());
            await spotifyconnection.call(event.context);
    });
    on<_GrantedAccess>((event,emit)async{
           

           SpotifyApi spotifyApi = event.spotifyapi;
           User user = event.user;

           //USER DETAILS THATS NEED TO BE DISPLAYED

           Map<String,dynamic> userdetails = {
              'name':user.displayName,
              'birthdate':user.birthdate,
              'followers':user.followers!.total,
              'images':user.images,
              'email':user.email,
              'country':user.country,
              'id':user.id,
              'href':user.href
           };


          // List of playlist sample

          Iterable<PlaylistSimple> playlistiterable = await spotifyApi.playlists.me.all();

          List<PlaylistSimple> userplaylist = playlistiterable.toList();
          
          log("user playlists ${userplaylist.length.toString()}");
          // list of artists

          CursorPages<Artist> artistsCursorpage= spotifyApi.me.following(FollowingType.artist);

          Iterable<Artist> iterableartist =await artistsCursorpage.all();
          
          List<Artist> userartists = iterableartist.toList();

          log("user artist ${userartists.length.toString()}");
          //Lists of newreleases,

          Pages<AlbumSimple>  albumsample = spotifyApi.browse.newReleases();
          
          Iterable<AlbumSimple> iterablealbum = await albumsample.all();

          List<AlbumSimple> newReleases = iterablealbum.toList();

          log("user albums ${newReleases.length.toString()}");


          CursorPages<PlayHistory> feauturediterabel = spotifyApi.me.recentlyPlayed();

          Iterable<PlayHistory> featured = await feauturediterabel.all();

          List<PlayHistory>  recentlyplayed = featured.toList();

          log("user featured ${recentlyplayed.length.toString()}");


          Pages<AlbumSimple> savedalbums = spotifyApi.me.savedAlbums();

          Iterable<AlbumSimple> iterableSaved = await  savedalbums.all();

          log(iterablealbum.length.toString());

          List<AlbumSimple> savedalbumsofuser = iterableSaved.toList();

          log("Saved albums : ${savedalbumsofuser.length}");

        
            emit(SpotifyapiState.userSaved(
              userdetails,
              userplaylist, 
              userartists, 
              newReleases, 
              recentlyplayed, 
              savedalbumsofuser,spotifyApi,user));
    });
  }
}
