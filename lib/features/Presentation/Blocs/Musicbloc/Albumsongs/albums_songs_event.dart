// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'albums_songs_bloc.dart';

abstract class AlbumsSongsEvent extends Equatable {
  const AlbumsSongsEvent();

  @override
  List<Object> get props => [];
}

class GetAlbumSongsEvent extends AlbumsSongsEvent {
  final String albumurl;
  GetAlbumSongsEvent({
    required this.albumurl,
  });
}

class GetPlaylistsSongsEvent extends AlbumsSongsEvent {
 final String id;
  GetPlaylistsSongsEvent({
    required this.id,
  });
}

class Getsongsfromalbum extends AlbumsSongsEvent{
  final int id;

  Getsongsfromalbum({required this.id});
}
