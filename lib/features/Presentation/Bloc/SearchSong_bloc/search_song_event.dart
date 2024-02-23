// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_song_bloc.dart';

abstract class SearchSongEvent extends Equatable {
  const SearchSongEvent();

  @override
  List<Object> get props => [];
}

class GetSearchSong extends SearchSongEvent {
  final String Querydata;
  const GetSearchSong({
    required this.Querydata,
  });
}
