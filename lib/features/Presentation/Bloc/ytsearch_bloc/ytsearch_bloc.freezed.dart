// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ytsearch_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$YtsearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String query) getsearchdetails,
    required TResult Function() freestate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String query)? getsearchdetails,
    TResult? Function()? freestate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String query)? getsearchdetails,
    TResult Function()? freestate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getsearch value) getsearchdetails,
    required TResult Function(_Freestate value) freestate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getsearch value)? getsearchdetails,
    TResult? Function(_Freestate value)? freestate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getsearch value)? getsearchdetails,
    TResult Function(_Freestate value)? freestate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YtsearchEventCopyWith<$Res> {
  factory $YtsearchEventCopyWith(
          YtsearchEvent value, $Res Function(YtsearchEvent) then) =
      _$YtsearchEventCopyWithImpl<$Res, YtsearchEvent>;
}

/// @nodoc
class _$YtsearchEventCopyWithImpl<$Res, $Val extends YtsearchEvent>
    implements $YtsearchEventCopyWith<$Res> {
  _$YtsearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$YtsearchEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'YtsearchEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String query) getsearchdetails,
    required TResult Function() freestate,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String query)? getsearchdetails,
    TResult? Function()? freestate,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String query)? getsearchdetails,
    TResult Function()? freestate,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getsearch value) getsearchdetails,
    required TResult Function(_Freestate value) freestate,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getsearch value)? getsearchdetails,
    TResult? Function(_Freestate value)? freestate,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getsearch value)? getsearchdetails,
    TResult Function(_Freestate value)? freestate,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements YtsearchEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetsearchImplCopyWith<$Res> {
  factory _$$GetsearchImplCopyWith(
          _$GetsearchImpl value, $Res Function(_$GetsearchImpl) then) =
      __$$GetsearchImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$GetsearchImplCopyWithImpl<$Res>
    extends _$YtsearchEventCopyWithImpl<$Res, _$GetsearchImpl>
    implements _$$GetsearchImplCopyWith<$Res> {
  __$$GetsearchImplCopyWithImpl(
      _$GetsearchImpl _value, $Res Function(_$GetsearchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$GetsearchImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetsearchImpl implements _Getsearch {
  const _$GetsearchImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'YtsearchEvent.getsearchdetails(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetsearchImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetsearchImplCopyWith<_$GetsearchImpl> get copyWith =>
      __$$GetsearchImplCopyWithImpl<_$GetsearchImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String query) getsearchdetails,
    required TResult Function() freestate,
  }) {
    return getsearchdetails(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String query)? getsearchdetails,
    TResult? Function()? freestate,
  }) {
    return getsearchdetails?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String query)? getsearchdetails,
    TResult Function()? freestate,
    required TResult orElse(),
  }) {
    if (getsearchdetails != null) {
      return getsearchdetails(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getsearch value) getsearchdetails,
    required TResult Function(_Freestate value) freestate,
  }) {
    return getsearchdetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getsearch value)? getsearchdetails,
    TResult? Function(_Freestate value)? freestate,
  }) {
    return getsearchdetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getsearch value)? getsearchdetails,
    TResult Function(_Freestate value)? freestate,
    required TResult orElse(),
  }) {
    if (getsearchdetails != null) {
      return getsearchdetails(this);
    }
    return orElse();
  }
}

abstract class _Getsearch implements YtsearchEvent {
  const factory _Getsearch(final String query) = _$GetsearchImpl;

  String get query;
  @JsonKey(ignore: true)
  _$$GetsearchImplCopyWith<_$GetsearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FreestateImplCopyWith<$Res> {
  factory _$$FreestateImplCopyWith(
          _$FreestateImpl value, $Res Function(_$FreestateImpl) then) =
      __$$FreestateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FreestateImplCopyWithImpl<$Res>
    extends _$YtsearchEventCopyWithImpl<$Res, _$FreestateImpl>
    implements _$$FreestateImplCopyWith<$Res> {
  __$$FreestateImplCopyWithImpl(
      _$FreestateImpl _value, $Res Function(_$FreestateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FreestateImpl implements _Freestate {
  const _$FreestateImpl();

  @override
  String toString() {
    return 'YtsearchEvent.freestate()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FreestateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String query) getsearchdetails,
    required TResult Function() freestate,
  }) {
    return freestate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String query)? getsearchdetails,
    TResult? Function()? freestate,
  }) {
    return freestate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String query)? getsearchdetails,
    TResult Function()? freestate,
    required TResult orElse(),
  }) {
    if (freestate != null) {
      return freestate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getsearch value) getsearchdetails,
    required TResult Function(_Freestate value) freestate,
  }) {
    return freestate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getsearch value)? getsearchdetails,
    TResult? Function(_Freestate value)? freestate,
  }) {
    return freestate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getsearch value)? getsearchdetails,
    TResult Function(_Freestate value)? freestate,
    required TResult orElse(),
  }) {
    if (freestate != null) {
      return freestate(this);
    }
    return orElse();
  }
}

abstract class _Freestate implements YtsearchEvent {
  const factory _Freestate() = _$FreestateImpl;
}

/// @nodoc
mixin _$YtsearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            VideoSearchList videos, bool isloading, bool isfailed)
        searchedvideo,
    required TResult Function() loader,
    required TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)
        fres,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult? Function()? loader,
    TResult? Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult Function()? loader,
    TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searchedvideo value) searchedvideo,
    required TResult Function(_Loading value) loader,
    required TResult Function(_Free value) fres,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searchedvideo value)? searchedvideo,
    TResult? Function(_Loading value)? loader,
    TResult? Function(_Free value)? fres,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searchedvideo value)? searchedvideo,
    TResult Function(_Loading value)? loader,
    TResult Function(_Free value)? fres,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YtsearchStateCopyWith<$Res> {
  factory $YtsearchStateCopyWith(
          YtsearchState value, $Res Function(YtsearchState) then) =
      _$YtsearchStateCopyWithImpl<$Res, YtsearchState>;
}

/// @nodoc
class _$YtsearchStateCopyWithImpl<$Res, $Val extends YtsearchState>
    implements $YtsearchStateCopyWith<$Res> {
  _$YtsearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$YtsearchStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'YtsearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            VideoSearchList videos, bool isloading, bool isfailed)
        searchedvideo,
    required TResult Function() loader,
    required TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)
        fres,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult? Function()? loader,
    TResult? Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult Function()? loader,
    TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searchedvideo value) searchedvideo,
    required TResult Function(_Loading value) loader,
    required TResult Function(_Free value) fres,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searchedvideo value)? searchedvideo,
    TResult? Function(_Loading value)? loader,
    TResult? Function(_Free value)? fres,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searchedvideo value)? searchedvideo,
    TResult Function(_Loading value)? loader,
    TResult Function(_Free value)? fres,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements YtsearchState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SearchedvideoImplCopyWith<$Res> {
  factory _$$SearchedvideoImplCopyWith(
          _$SearchedvideoImpl value, $Res Function(_$SearchedvideoImpl) then) =
      __$$SearchedvideoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({VideoSearchList videos, bool isloading, bool isfailed});
}

/// @nodoc
class __$$SearchedvideoImplCopyWithImpl<$Res>
    extends _$YtsearchStateCopyWithImpl<$Res, _$SearchedvideoImpl>
    implements _$$SearchedvideoImplCopyWith<$Res> {
  __$$SearchedvideoImplCopyWithImpl(
      _$SearchedvideoImpl _value, $Res Function(_$SearchedvideoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = null,
    Object? isloading = null,
    Object? isfailed = null,
  }) {
    return _then(_$SearchedvideoImpl(
      null == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as VideoSearchList,
      null == isloading
          ? _value.isloading
          : isloading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isfailed
          ? _value.isfailed
          : isfailed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SearchedvideoImpl implements _Searchedvideo {
  const _$SearchedvideoImpl(this.videos, this.isloading, this.isfailed);

  @override
  final VideoSearchList videos;
  @override
  final bool isloading;
  @override
  final bool isfailed;

  @override
  String toString() {
    return 'YtsearchState.searchedvideo(videos: $videos, isloading: $isloading, isfailed: $isfailed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchedvideoImpl &&
            const DeepCollectionEquality().equals(other.videos, videos) &&
            (identical(other.isloading, isloading) ||
                other.isloading == isloading) &&
            (identical(other.isfailed, isfailed) ||
                other.isfailed == isfailed));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(videos), isloading, isfailed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchedvideoImplCopyWith<_$SearchedvideoImpl> get copyWith =>
      __$$SearchedvideoImplCopyWithImpl<_$SearchedvideoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            VideoSearchList videos, bool isloading, bool isfailed)
        searchedvideo,
    required TResult Function() loader,
    required TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)
        fres,
  }) {
    return searchedvideo(videos, isloading, isfailed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult? Function()? loader,
    TResult? Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
  }) {
    return searchedvideo?.call(videos, isloading, isfailed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult Function()? loader,
    TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
    required TResult orElse(),
  }) {
    if (searchedvideo != null) {
      return searchedvideo(videos, isloading, isfailed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searchedvideo value) searchedvideo,
    required TResult Function(_Loading value) loader,
    required TResult Function(_Free value) fres,
  }) {
    return searchedvideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searchedvideo value)? searchedvideo,
    TResult? Function(_Loading value)? loader,
    TResult? Function(_Free value)? fres,
  }) {
    return searchedvideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searchedvideo value)? searchedvideo,
    TResult Function(_Loading value)? loader,
    TResult Function(_Free value)? fres,
    required TResult orElse(),
  }) {
    if (searchedvideo != null) {
      return searchedvideo(this);
    }
    return orElse();
  }
}

abstract class _Searchedvideo implements YtsearchState {
  const factory _Searchedvideo(final VideoSearchList videos,
      final bool isloading, final bool isfailed) = _$SearchedvideoImpl;

  VideoSearchList get videos;
  bool get isloading;
  bool get isfailed;
  @JsonKey(ignore: true)
  _$$SearchedvideoImplCopyWith<_$SearchedvideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$YtsearchStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'YtsearchState.loader()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            VideoSearchList videos, bool isloading, bool isfailed)
        searchedvideo,
    required TResult Function() loader,
    required TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)
        fres,
  }) {
    return loader();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult? Function()? loader,
    TResult? Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
  }) {
    return loader?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult Function()? loader,
    TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
    required TResult orElse(),
  }) {
    if (loader != null) {
      return loader();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searchedvideo value) searchedvideo,
    required TResult Function(_Loading value) loader,
    required TResult Function(_Free value) fres,
  }) {
    return loader(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searchedvideo value)? searchedvideo,
    TResult? Function(_Loading value)? loader,
    TResult? Function(_Free value)? fres,
  }) {
    return loader?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searchedvideo value)? searchedvideo,
    TResult Function(_Loading value)? loader,
    TResult Function(_Free value)? fres,
    required TResult orElse(),
  }) {
    if (loader != null) {
      return loader(this);
    }
    return orElse();
  }
}

abstract class _Loading implements YtsearchState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$FreeImplCopyWith<$Res> {
  factory _$$FreeImplCopyWith(
          _$FreeImpl value, $Res Function(_$FreeImpl) then) =
      __$$FreeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Video> videos,
      List<Video> videos1,
      List<Video> videos2,
      bool isloading,
      bool isfailed});
}

/// @nodoc
class __$$FreeImplCopyWithImpl<$Res>
    extends _$YtsearchStateCopyWithImpl<$Res, _$FreeImpl>
    implements _$$FreeImplCopyWith<$Res> {
  __$$FreeImplCopyWithImpl(_$FreeImpl _value, $Res Function(_$FreeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = null,
    Object? videos1 = null,
    Object? videos2 = null,
    Object? isloading = null,
    Object? isfailed = null,
  }) {
    return _then(_$FreeImpl(
      null == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<Video>,
      null == videos1
          ? _value._videos1
          : videos1 // ignore: cast_nullable_to_non_nullable
              as List<Video>,
      null == videos2
          ? _value._videos2
          : videos2 // ignore: cast_nullable_to_non_nullable
              as List<Video>,
      null == isloading
          ? _value.isloading
          : isloading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isfailed
          ? _value.isfailed
          : isfailed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FreeImpl implements _Free {
  const _$FreeImpl(final List<Video> videos, final List<Video> videos1,
      final List<Video> videos2, this.isloading, this.isfailed)
      : _videos = videos,
        _videos1 = videos1,
        _videos2 = videos2;

  final List<Video> _videos;
  @override
  List<Video> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  final List<Video> _videos1;
  @override
  List<Video> get videos1 {
    if (_videos1 is EqualUnmodifiableListView) return _videos1;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos1);
  }

  final List<Video> _videos2;
  @override
  List<Video> get videos2 {
    if (_videos2 is EqualUnmodifiableListView) return _videos2;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos2);
  }

  @override
  final bool isloading;
  @override
  final bool isfailed;

  @override
  String toString() {
    return 'YtsearchState.fres(videos: $videos, videos1: $videos1, videos2: $videos2, isloading: $isloading, isfailed: $isfailed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeImpl &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            const DeepCollectionEquality().equals(other._videos1, _videos1) &&
            const DeepCollectionEquality().equals(other._videos2, _videos2) &&
            (identical(other.isloading, isloading) ||
                other.isloading == isloading) &&
            (identical(other.isfailed, isfailed) ||
                other.isfailed == isfailed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_videos),
      const DeepCollectionEquality().hash(_videos1),
      const DeepCollectionEquality().hash(_videos2),
      isloading,
      isfailed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeImplCopyWith<_$FreeImpl> get copyWith =>
      __$$FreeImplCopyWithImpl<_$FreeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            VideoSearchList videos, bool isloading, bool isfailed)
        searchedvideo,
    required TResult Function() loader,
    required TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)
        fres,
  }) {
    return fres(videos, videos1, videos2, isloading, isfailed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult? Function()? loader,
    TResult? Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
  }) {
    return fres?.call(videos, videos1, videos2, isloading, isfailed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(VideoSearchList videos, bool isloading, bool isfailed)?
        searchedvideo,
    TResult Function()? loader,
    TResult Function(List<Video> videos, List<Video> videos1,
            List<Video> videos2, bool isloading, bool isfailed)?
        fres,
    required TResult orElse(),
  }) {
    if (fres != null) {
      return fres(videos, videos1, videos2, isloading, isfailed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searchedvideo value) searchedvideo,
    required TResult Function(_Loading value) loader,
    required TResult Function(_Free value) fres,
  }) {
    return fres(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searchedvideo value)? searchedvideo,
    TResult? Function(_Loading value)? loader,
    TResult? Function(_Free value)? fres,
  }) {
    return fres?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searchedvideo value)? searchedvideo,
    TResult Function(_Loading value)? loader,
    TResult Function(_Free value)? fres,
    required TResult orElse(),
  }) {
    if (fres != null) {
      return fres(this);
    }
    return orElse();
  }
}

abstract class _Free implements YtsearchState {
  const factory _Free(
      final List<Video> videos,
      final List<Video> videos1,
      final List<Video> videos2,
      final bool isloading,
      final bool isfailed) = _$FreeImpl;

  List<Video> get videos;
  List<Video> get videos1;
  List<Video> get videos2;
  bool get isloading;
  bool get isfailed;
  @JsonKey(ignore: true)
  _$$FreeImplCopyWith<_$FreeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
