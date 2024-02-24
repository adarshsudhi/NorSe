part of 'ytsearch_bloc.dart';

@freezed
class YtsearchState with _$YtsearchState {
  const factory YtsearchState.initial() = _Initial;
  const factory YtsearchState.searchedvideo(
    VideoSearchList videos,
    bool isloading,
    bool isfailed,
  )=_Searchedvideo;
  const factory YtsearchState.loader() = _Loading;
  const factory YtsearchState.fres(
    List<Video> videos,
    List<Video> videos1,
    bool isloading,
    bool isfailed,
  ) = _Free;
}
