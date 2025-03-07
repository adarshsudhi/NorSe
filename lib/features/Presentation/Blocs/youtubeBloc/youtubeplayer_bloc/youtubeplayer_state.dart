part of 'youtubeplayer_bloc.dart';

@freezed
class YoutubeplayerState with _$YoutubeplayerState {
  const factory YoutubeplayerState.initial() = _Initial;
  const factory YoutubeplayerState.youtubeplayerstate(
    Map<String,dynamic> info,
    int index,
    List<Video> video,
    bool isloading,
    bool isfailed,
  ) = _YoutubePlayerState;

  const factory YoutubeplayerState.loading() = _LoadingState;
  const factory YoutubeplayerState.switchstate() = _SwitchState;
}
