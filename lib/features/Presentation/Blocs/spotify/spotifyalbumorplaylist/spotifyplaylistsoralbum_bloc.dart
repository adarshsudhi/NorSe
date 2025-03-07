import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotify/spotify.dart';

part 'spotifyplaylistsoralbum_event.dart';
part 'spotifyplaylistsoralbum_state.dart';
part 'spotifyplaylistsoralbum_bloc.freezed.dart';

class SpotifyplaylistsoralbumBloc extends Bloc<SpotifyplaylistsoralbumEvent, SpotifyplaylistsoralbumState> {
  SpotifyplaylistsoralbumBloc() : super(const _Initial()) {
    on<_albumtracks>((event, emit) async{
      emit(const SpotifyplaylistsoralbumState.loadingtracks());
      
      SpotifyApi api = event.spotify;
      String albumid = event.id;
      Pages<TrackSimple> tracksimplepages = api.albums.tracks(albumid);
      Iterable<TrackSimple> tracksiterable = await tracksimplepages.all();
      var tracks = tracksiterable.toList();
      emit(SpotifyplaylistsoralbumState.tracks(tracks));
    });
   on<_playlisttracks>((event, emit)async {
       emit(const SpotifyplaylistsoralbumState.loadingtracks());
      
      SpotifyApi api = event.spotify;
      Pages<Track> tracksimplepages = api.playlists.getTracksByPlaylistId(event.id);
      Iterable<Track> playlistiterable = await tracksimplepages.all();
      List<Track> list = playlistiterable.toList();

      emit(SpotifyplaylistsoralbumState.playlisttracks(list));
   });

   on<_getartisttoptrack>((event, emit)async{

      emit(const SpotifyplaylistsoralbumState.loadingtracks());
      
      SpotifyApi api = event.spotify;

      Iterable<Track> tracksimplepages  = await api.artists.topTracks(event.id, Market.IN);

      List<Track> list = tracksimplepages.toList();

      emit(SpotifyplaylistsoralbumState.playlisttracks(list));
   });
  }
}
