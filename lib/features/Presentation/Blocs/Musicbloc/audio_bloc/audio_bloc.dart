import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Data/Models/MusicModels/songmodel.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../../../../Domain/Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../../../Domain/Entity/MusicEntity/PlaylistEntity/PlaylistEntity.dart';
import '../../../../Domain/Entity/MusicEntity/SearchSongEntity/SearchEntity.dart';
import 'package:norse/injection_container.dart' as di;

part 'audio_bloc.freezed.dart';
part 'audio_event.dart';
part 'audio_state.dart';


class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(const _Initial()) {

    YoutubeExplode yt = di.di<YoutubeExplode>();

    //vr
    List<OnlineSongModel> onlinesongs = [];

    //forchecking

    List<OnlineSongModel> onlineaudiosforchecking = [];
    final onlineplayerstreamcontroller = BehaviorSubject<AudioState>();

    //offlinechecking
    List<Songmodel> sourcesforchecking = [];

    //Mainsource
    List<AudioSource> audiosources = [];

    final localplayercontroller = BehaviorSubject<AudioState>();

    //Localsongmodel
    List<Songmodel> song = [];

    AudioPlayer audioPlayer = AudioPlayer();

    //Onlinesongmodel
    late ConcatenatingAudioSource concatenatingAudioSource;

    clearall() async {
      song.clear();
      sourcesforchecking.clear();
      audiosources.clear();
    }

    parselocalsong(
        List<Map<String, dynamic>> favsongs, List<SongModel> songs) async {
      if (songs.isNotEmpty) {
        for (var item in songs) {
          Songmodel songmodel = Songmodel(
              id: item.id,
              title: item.title,
              subtitle: item.artist ?? 'unkown',
              uri: item.uri!);

          AudioSource source = AudioSource.uri(Uri.parse(songmodel.uri),
              tag: MediaItem(
                  id: songmodel.id.toString(),
                  title: songmodel.title,
                  artist: songmodel.subtitle));
          audiosources.add(source);
          song.add(songmodel);
          sourcesforchecking.add(songmodel);
        }
      } else {
        clearall();
        for (var element in favsongs) {
          Songmodel songmodel = Songmodel(
              id: int.parse(element['id']),
              title: element['title'],
              subtitle: element['artist'],
              uri: element['uri']);
          song.add(songmodel);
          sourcesforchecking.add(songmodel);

          AudioSource source = AudioSource.uri(
            Uri.parse(element['uri']),
            tag: MediaItem(
              id: element['id'],
              title: element['title'],
              artist: element['artist'],
            ),
          );
          audiosources.add(source);
        }
        return;
      }
    }
    parse({
      required String album,
      required List<Map<String, dynamic>> favsong,
      required List<AlbumSongEntity> allsongs,
      required List<SearchEntity> seachSongs,
      required List<playlistEntity> playlistsongs,
      required List<SongModel> localsongs,
      required List<Video> ytaudios,
    }) async {
      if (allsongs.isNotEmpty) {
        onlineaudiosforchecking.clear();
        onlinesongs.clear();

        for (var element in allsongs) {
          OnlineSongModel onlineSongModel = OnlineSongModel(
              album: album,
              id: element.id,
              title: element.name,
              imageurl: element.image,
              downloadurl: element.songs,
              artist: element.primaryArtists);
          onlinesongs.add(onlineSongModel);
          onlineaudiosforchecking.add(onlineSongModel);

          AudioSource source = AudioSource.uri(Uri.parse(element.songs),
              tag: MediaItem(
                  id: element.id,
                  title: element.name,
                  artist: element.primaryArtists,
                  artUri: Uri.parse(element.image)));
          audiosources.add(source);
        }
      } else if (playlistsongs.isNotEmpty) {
        onlineaudiosforchecking.clear();
        onlinesongs.clear();

        for (var element in playlistsongs) {
          OnlineSongModel onlineSongModel = OnlineSongModel(
              album: element.more_info['more_info']['music'],
              id: element.id,
              title: element.name,
              imageurl: element.images,
              downloadurl: element.downloadUrl,
              artist: element.primaryArtists);
          onlinesongs.add(onlineSongModel);
          onlineaudiosforchecking.add(onlineSongModel);

          AudioSource source = AudioSource.uri(Uri.parse(element.downloadUrl),
              tag: MediaItem(
                  id: element.id,
                  title: element.name,
                  artist: element.primaryArtists,
                  artUri: Uri.parse(element.images)));
          audiosources.add(source);
        }
      } else if (seachSongs.isNotEmpty) {
        onlineaudiosforchecking.clear();
        onlinesongs.clear();

        for (var element in seachSongs) {
          OnlineSongModel onlineSongModel = OnlineSongModel(
              album: element.moreinfo['music'],
              id: element.id,
              title: element.name,
              imageurl: element.image,
              downloadurl: element.downloadUrl,
              artist: element.primaryArtists);
          onlinesongs.add(onlineSongModel);
          onlineaudiosforchecking.add(onlineSongModel);

          AudioSource source = AudioSource.uri(Uri.parse(element.downloadUrl),
              tag: MediaItem(
                  id: element.id,
                  title: element.name,
                  artist: element.primaryArtists,
                  artUri: Uri.parse(element.image)));
          audiosources.add(source);
        }
      }
    }

    on<_YtPlayerEvent>((event, emit) async{

      emit(const AudioState.loading());
      List<String> artist = [];

       state.mapOrNull(
        Localsongs: (value) => emit(value.copyWith(isloading: true)),
      );

      if (audiosources.isNotEmpty) {
        onlinesongs.clear();
        onlinesongs = [];
        onlineaudiosforchecking.clear();
        sourcesforchecking.clear();
        sourcesforchecking = [];
        audiosources.clear();
        audiosources = [];
      }
      
      Map<String,dynamic> audiodetails = event.audiodetails;

      String songtitle = audiodetails['title'];

      var songartist = audiodetails['artist'] as List<Artist>;
      
      for (var ar in songartist) {
        artist.add(ar.name ?? "unknown");
      }

      log('Called');
      
      VideoSearchList searchlist = await yt.search.search(songtitle,filter: TypeFilters.video);

      Video song = searchlist.first;

      log('Called');

      StreamManifest streamManifest = await yt.videos.streams.getManifest(song.id);

      UnmodifiableListView<AudioOnlyStreamInfo> audioonly =  streamManifest.audioOnly;
      log('Called here');

      List<AudioOnlyStreamInfo> audioOnlyStreamInfo = List.from(audioonly);
      log('Called here');

      AudioOnlyStreamInfo audio = audioOnlyStreamInfo[0];

      log(audio.url.toString());

     OnlineSongModel onlineSongModel = OnlineSongModel(
        id: song.id.toString(), 
        title: song.title, 
        imageurl: audiodetails['image'], 
        downloadurl: audio.url.toString(), 
        album: audiodetails['album'], 
        artist: artist.join(","));

          onlinesongs.add(onlineSongModel);
          onlineaudiosforchecking.add(onlineSongModel);

          AudioSource source = AudioSource.uri(Uri.parse(onlineSongModel.downloadurl),
              tag: MediaItem(
                  id: onlineSongModel.id,
                  title: onlineSongModel.title,
                  artist: onlineSongModel.artist,
                  artUri: Uri.parse(onlineSongModel.imageurl)));
          audiosources.add(source);

                Stream<AudioState> streams = Rx.combineLatest5(
          audioPlayer.playerStateStream,
          audioPlayer.durationStream,
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.currentIndexStream,
          (play, dur, pos, buf, playstate) =>
              AudioState.onlinestreams(pos, dur!, play, buf, playstate!));

      streams.listen((event) {
        onlineplayerstreamcontroller.sink.add(event);
      });

      concatenatingAudioSource = ConcatenatingAudioSource(
          children: audiosources, useLazyPreparation: false);
      emit(AudioState.onlinesongs(false, false, onlinesongs,
          onlineplayerstreamcontroller.stream, 0, audioPlayer));
      await audioPlayer.setAudioSource(concatenatingAudioSource,
          initialIndex: 0, initialPosition: Duration.zero);
      await audioPlayer.play();
    });

    on<_Dispose>((event, emit) async {
      if (audiosources.isNotEmpty) {
        song.clear();
        song = [];
        onlinesongs.clear();
        onlinesongs = [];
        onlineaudiosforchecking.clear();
        sourcesforchecking.clear();
        song.clear();
        sourcesforchecking = [];
        audiosources.clear();
        audiosources = [];
      }

      await audioPlayer.stop();
      emit(const AudioState.initial());
    });

    on<_Localaudio>((event, emit) async {
      emit(const AudioState.loading());
      state.mapOrNull(
        Localsongs: (value) => emit(value.copyWith(isloading: true)),
      );

      if (audiosources.isNotEmpty) {
        song.clear();
        song = [];
        sourcesforchecking.clear();
        song.clear();
        onlineaudiosforchecking = [];
        onlinesongs.clear();
        sourcesforchecking = [];
        audiosources.clear();
        audiosources = [];
      }

      await parselocalsong(event.favsongs, event.songs);

      var streams = Rx.combineLatest4(
          audioPlayer.playerStateStream,
          audioPlayer.currentIndexStream,
          audioPlayer.durationStream,
          audioPlayer.positionStream,
          (b, c, stat, pos) => AudioState.LocalStreams(pos, stat!, b, c!));

      streams.listen((event) {
        localplayercontroller.sink.add(event);
      });

      concatenatingAudioSource = ConcatenatingAudioSource(
          children: audiosources, useLazyPreparation: true);

      emit(AudioState.Localsongs(false, false, song,
          localplayercontroller.stream, event.index, audioPlayer));
      await audioPlayer.setAudioSource(
        concatenatingAudioSource,
        initialIndex: event.index,
        initialPosition: Duration.zero,
      );
      await audioPlayer.play();
    });

    ///Online event
    on<_Onlineaudio>((event, emit) async {
      emit(const AudioState.loading());
      state.mapOrNull(
        onlinesongs: (value) => emit(value.copyWith(isloading: true)),
      );
      if (audiosources.isNotEmpty) {
        onlinesongs.clear();
        onlinesongs = [];
        song.clear();
        onlineaudiosforchecking.clear();
        sourcesforchecking = [];
        audiosources.clear();
        audiosources = [];
      }

      await parse(
          album: event.name,
          favsong: const [],
          allsongs: event.allsongs,
          seachSongs: event.deachSongs,
          playlistsongs: event.playlistsongs,
          localsongs: const [],
          ytaudios: []);

      Stream<AudioState> streams = Rx.combineLatest5(
          audioPlayer.playerStateStream,
          audioPlayer.durationStream,
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.currentIndexStream,
          (play, dur, pos, buf, playstate) =>
              AudioState.onlinestreams(pos, dur!, play, buf, playstate!));

      streams.listen((event) {
        onlineplayerstreamcontroller.sink.add(event);
      });

      concatenatingAudioSource = ConcatenatingAudioSource(
          children: audiosources, useLazyPreparation: false);
      emit(AudioState.onlinesongs(false, false, onlinesongs,
          onlineplayerstreamcontroller.stream, event.index, audioPlayer));
      await audioPlayer.setAudioSource(concatenatingAudioSource,
          initialIndex: event.index, initialPosition: Duration.zero);
      await audioPlayer.seek(Duration.zero, index: event.index);
      await audioPlayer.play();
    });

    on<_Pause>((event, emit) async => await audioPlayer.pause());

    on<_Resume>((event, emit) async => await audioPlayer.play());

    on<_Loopon>((event, emit) async => await audioPlayer
        .setLoopMode(event.islooped ? LoopMode.one : LoopMode.off));

    on<_Shuffleon>((event, emit) async => await audioPlayer
        .setShuffleModeEnabled(event.isshuffled ? true : false));

    on<_Seeknextaudio>((event, emit) async => await audioPlayer.seekToNext());

    on<_Seekpreviousaudio>(
        (event, emit) async => await audioPlayer.seekToPrevious());

    on<_Updatequeue>((event, emit) async {
      if (event.mode == 'online') {
        final item = onlinesongs.removeAt(event.oldindex);
        onlinesongs.insert(event.newindex, item);
        final forchecking = onlineaudiosforchecking.removeAt(event.oldindex);
        onlineaudiosforchecking.insert(event.newindex, forchecking);
        concatenatingAudioSource.move(event.oldindex, event.newindex);
      } else {
        final item = song.removeAt(event.oldindex);
        song.insert(event.newindex, item);
        final forchecking = sourcesforchecking.removeAt(event.oldindex);
        sourcesforchecking.insert(event.newindex, forchecking);
        await concatenatingAudioSource.move(event.oldindex, event.newindex);
      }
    });

    on<_Removefromqueue>((event, emit) async {
      if (event.mode == 'online') {
        onlinesongs.removeAt(event.indextoberemoved);
        onlineaudiosforchecking.removeAt(event.indextoberemoved);
        await concatenatingAudioSource.removeAt(event.indextoberemoved);
      } else {
        sourcesforchecking.removeAt(event.indextoberemoved);
        song.removeAt(event.indextoberemoved);
        await concatenatingAudioSource.removeAt(event.indextoberemoved);
      }
    });

    on<_Addsongtoqueue>((event, emit) async {
      if (onlinesongs.isNotEmpty) {
        Spaces.showtoast(" Can't add Offline songs to Online Queue");
      } else {
        Directory temp = await getTemporaryDirectory();
        String tempDirectory = "${temp.path}${event.song.id}.jpg";
        File file = File(tempDirectory);
        String songuri = event.song.uri;
        AudioSource source = AudioSource.uri(
          Uri.parse(songuri),
          tag: MediaItem(
              id: event.song.id.toString(),
              title: event.song.title,
              artist: event.song.subtitle,
              artUri: Uri.directory(file.path)),
        );

        bool isexist =
            sourcesforchecking.any((element) => element.id == event.song.id);

        if (isexist) {
          Spaces.showtoast('added already');
        } else {
          sourcesforchecking.add(event.song);
          song.add(event.song);
          await concatenatingAudioSource.add(source);
          Spaces.showtoast('added');
        }
      }
    });

    on<_AddtoOnlinequeue>((event, emit) async {
      if (song.isNotEmpty) {
        Spaces.showtoast("Can't add Online songs to Offline queue");
      } else {
        AudioSource source = AudioSource.uri(
          Uri.parse(event.song.downloadurl),
          tag: MediaItem(
              id: event.song.id.toString(),
              title: event.song.title,
              artist: event.song.artist,
              artUri: Uri.parse(event.song.imageurl)),
        );

        bool isexist = onlineaudiosforchecking
            .any((element) => element.id == event.song.id);

        if (isexist) {
          Spaces.showtoast('already exists');
        } else {
          onlineaudiosforchecking.add(event.song);
          onlinesongs.add(event.song);
          await concatenatingAudioSource.add(source);
          Spaces.showtoast('added');
        }
      }
    });

    on<_Clearqueueexceptplaying>((event, emit) async {
      if (event.mode == 'online') {
        for (var i = concatenatingAudioSource.length - 1; i >= 0; i--) {
          if (i == event.currentplaying) {
            continue;
          } else {
            onlineaudiosforchecking.removeAt(i);
            onlinesongs.removeAt(i);
            concatenatingAudioSource.removeAt(i);
          }
        }
      } else {
        for (var i = concatenatingAudioSource.length - 1; i >= 0; i--) {
          if (i == event.currentplaying) {
            continue;
          } else {
            sourcesforchecking.removeAt(i);
            song.removeAt(i);
            concatenatingAudioSource.removeAt(i);
          }
        }
      }
    });
    on<_ClearSpecificAudio>((event, emit) async {
      if (song.isNotEmpty && sourcesforchecking.isNotEmpty) {
        int index =
            sourcesforchecking.indexWhere((element) => element.id == event.id);
        int index1 = song.indexWhere((element) => element.id == event.id);
        sourcesforchecking.removeAt(index);
        song.removeAt(index1);
        await concatenatingAudioSource.removeAt(index);
      }
    });

    on<_Started>((event, emit) async {
      song.clear();
      song = [];
      sourcesforchecking.clear();
      song.clear();
      onlineaudiosforchecking = [];
      onlinesongs.clear();
      sourcesforchecking = [];
      audiosources.clear();
      audiosources = [];
      await audioPlayer.stop();
      emit(const AudioState.initial());
    });
  }
}
