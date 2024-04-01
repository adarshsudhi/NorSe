part of 'audio_bloc.dart';

@freezed
class AudioState with _$AudioState {
  const factory AudioState.initial() = _Initial;

  const factory AudioState.Localsongs(
    bool isloading,
    bool isfailed,
    List<Songmodel> audios,
    ValueStream<AudioState>valueStream,
    int index,
    AudioPlayer audioPlayer
  ) = _Localsongs;

  const factory AudioState.LocalStreams(
  Duration pos,
  Duration Dur,
  PlayerState playerState,
  int index
  ) = _Localstreams;

    const factory AudioState.onlinesongs(
    bool isloading,
    bool isfailed,
    List<OnlineSongModel> audios,
    ValueStream<AudioState>valueStream,
    int index,
    AudioPlayer audioPlayer
  ) = _Onlinesongs;

  const factory AudioState.onlinestreams(
  Duration pos,
  Duration dur,
  PlayerState playerState,
  Duration buffer,
  int index
  ) = _Onlinestreams;

}
