part of 'videoinfo_bloc.dart';

@freezed
class VideoinfoState with _$VideoinfoState {
  const factory VideoinfoState.initial() = _Initial;
  const factory VideoinfoState.info(
    bool isloading,
    Video video
  )= _Info;
}
