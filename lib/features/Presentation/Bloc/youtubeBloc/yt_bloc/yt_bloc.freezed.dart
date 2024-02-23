// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yt_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$YtEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String id) getvideoinfoevent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? getvideoinfoevent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? getvideoinfoevent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getinfo value) getvideoinfoevent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getinfo value)? getvideoinfoevent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getinfo value)? getvideoinfoevent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YtEventCopyWith<$Res> {
  factory $YtEventCopyWith(YtEvent value, $Res Function(YtEvent) then) =
      _$YtEventCopyWithImpl<$Res, YtEvent>;
}

/// @nodoc
class _$YtEventCopyWithImpl<$Res, $Val extends YtEvent>
    implements $YtEventCopyWith<$Res> {
  _$YtEventCopyWithImpl(this._value, this._then);

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
    extends _$YtEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl with DiagnosticableTreeMixin implements _Started {
  const _$StartedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YtEvent.started()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'YtEvent.started'));
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
    required TResult Function(String id) getvideoinfoevent,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? getvideoinfoevent,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? getvideoinfoevent,
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
    required TResult Function(_Getinfo value) getvideoinfoevent,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getinfo value)? getvideoinfoevent,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getinfo value)? getvideoinfoevent,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements YtEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetinfoImplCopyWith<$Res> {
  factory _$$GetinfoImplCopyWith(
          _$GetinfoImpl value, $Res Function(_$GetinfoImpl) then) =
      __$$GetinfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$GetinfoImplCopyWithImpl<$Res>
    extends _$YtEventCopyWithImpl<$Res, _$GetinfoImpl>
    implements _$$GetinfoImplCopyWith<$Res> {
  __$$GetinfoImplCopyWithImpl(
      _$GetinfoImpl _value, $Res Function(_$GetinfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$GetinfoImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetinfoImpl with DiagnosticableTreeMixin implements _Getinfo {
  const _$GetinfoImpl(this.id);

  @override
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YtEvent.getvideoinfoevent(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'YtEvent.getvideoinfoevent'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetinfoImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetinfoImplCopyWith<_$GetinfoImpl> get copyWith =>
      __$$GetinfoImplCopyWithImpl<_$GetinfoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String id) getvideoinfoevent,
  }) {
    return getvideoinfoevent(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? getvideoinfoevent,
  }) {
    return getvideoinfoevent?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? getvideoinfoevent,
    required TResult orElse(),
  }) {
    if (getvideoinfoevent != null) {
      return getvideoinfoevent(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Getinfo value) getvideoinfoevent,
  }) {
    return getvideoinfoevent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Getinfo value)? getvideoinfoevent,
  }) {
    return getvideoinfoevent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Getinfo value)? getvideoinfoevent,
    required TResult orElse(),
  }) {
    if (getvideoinfoevent != null) {
      return getvideoinfoevent(this);
    }
    return orElse();
  }
}

abstract class _Getinfo implements YtEvent {
  const factory _Getinfo(final String id) = _$GetinfoImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$GetinfoImplCopyWith<_$GetinfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$YtState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Video videoinfo) vidoeinfo,
    required TResult Function() loader,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Video videoinfo)? vidoeinfo,
    TResult? Function()? loader,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Video videoinfo)? vidoeinfo,
    TResult Function()? loader,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Videoinfo value) vidoeinfo,
    required TResult Function(_Loading value) loader,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Videoinfo value)? vidoeinfo,
    TResult? Function(_Loading value)? loader,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Videoinfo value)? vidoeinfo,
    TResult Function(_Loading value)? loader,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YtStateCopyWith<$Res> {
  factory $YtStateCopyWith(YtState value, $Res Function(YtState) then) =
      _$YtStateCopyWithImpl<$Res, YtState>;
}

/// @nodoc
class _$YtStateCopyWithImpl<$Res, $Val extends YtState>
    implements $YtStateCopyWith<$Res> {
  _$YtStateCopyWithImpl(this._value, this._then);

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
    extends _$YtStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YtState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'YtState.initial'));
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
    required TResult Function(Video videoinfo) vidoeinfo,
    required TResult Function() loader,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Video videoinfo)? vidoeinfo,
    TResult? Function()? loader,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Video videoinfo)? vidoeinfo,
    TResult Function()? loader,
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
    required TResult Function(_Videoinfo value) vidoeinfo,
    required TResult Function(_Loading value) loader,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Videoinfo value)? vidoeinfo,
    TResult? Function(_Loading value)? loader,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Videoinfo value)? vidoeinfo,
    TResult Function(_Loading value)? loader,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements YtState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$VideoinfoImplCopyWith<$Res> {
  factory _$$VideoinfoImplCopyWith(
          _$VideoinfoImpl value, $Res Function(_$VideoinfoImpl) then) =
      __$$VideoinfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Video videoinfo});

  $VideoCopyWith<$Res> get videoinfo;
}

/// @nodoc
class __$$VideoinfoImplCopyWithImpl<$Res>
    extends _$YtStateCopyWithImpl<$Res, _$VideoinfoImpl>
    implements _$$VideoinfoImplCopyWith<$Res> {
  __$$VideoinfoImplCopyWithImpl(
      _$VideoinfoImpl _value, $Res Function(_$VideoinfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoinfo = null,
  }) {
    return _then(_$VideoinfoImpl(
      null == videoinfo
          ? _value.videoinfo
          : videoinfo // ignore: cast_nullable_to_non_nullable
              as Video,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoCopyWith<$Res> get videoinfo {
    return $VideoCopyWith<$Res>(_value.videoinfo, (value) {
      return _then(_value.copyWith(videoinfo: value));
    });
  }
}

/// @nodoc

class _$VideoinfoImpl with DiagnosticableTreeMixin implements _Videoinfo {
  const _$VideoinfoImpl(this.videoinfo);

  @override
  final Video videoinfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YtState.vidoeinfo(videoinfo: $videoinfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'YtState.vidoeinfo'))
      ..add(DiagnosticsProperty('videoinfo', videoinfo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoinfoImpl &&
            (identical(other.videoinfo, videoinfo) ||
                other.videoinfo == videoinfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoinfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoinfoImplCopyWith<_$VideoinfoImpl> get copyWith =>
      __$$VideoinfoImplCopyWithImpl<_$VideoinfoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Video videoinfo) vidoeinfo,
    required TResult Function() loader,
  }) {
    return vidoeinfo(videoinfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Video videoinfo)? vidoeinfo,
    TResult? Function()? loader,
  }) {
    return vidoeinfo?.call(videoinfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Video videoinfo)? vidoeinfo,
    TResult Function()? loader,
    required TResult orElse(),
  }) {
    if (vidoeinfo != null) {
      return vidoeinfo(videoinfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Videoinfo value) vidoeinfo,
    required TResult Function(_Loading value) loader,
  }) {
    return vidoeinfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Videoinfo value)? vidoeinfo,
    TResult? Function(_Loading value)? loader,
  }) {
    return vidoeinfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Videoinfo value)? vidoeinfo,
    TResult Function(_Loading value)? loader,
    required TResult orElse(),
  }) {
    if (vidoeinfo != null) {
      return vidoeinfo(this);
    }
    return orElse();
  }
}

abstract class _Videoinfo implements YtState {
  const factory _Videoinfo(final Video videoinfo) = _$VideoinfoImpl;

  Video get videoinfo;
  @JsonKey(ignore: true)
  _$$VideoinfoImplCopyWith<_$VideoinfoImpl> get copyWith =>
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
    extends _$YtStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YtState.loader()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'YtState.loader'));
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
    required TResult Function(Video videoinfo) vidoeinfo,
    required TResult Function() loader,
  }) {
    return loader();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Video videoinfo)? vidoeinfo,
    TResult? Function()? loader,
  }) {
    return loader?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Video videoinfo)? vidoeinfo,
    TResult Function()? loader,
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
    required TResult Function(_Videoinfo value) vidoeinfo,
    required TResult Function(_Loading value) loader,
  }) {
    return loader(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Videoinfo value)? vidoeinfo,
    TResult? Function(_Loading value)? loader,
  }) {
    return loader?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Videoinfo value)? vidoeinfo,
    TResult Function(_Loading value)? loader,
    required TResult orElse(),
  }) {
    if (loader != null) {
      return loader(this);
    }
    return orElse();
  }
}

abstract class _Loading implements YtState {
  const factory _Loading() = _$LoadingImpl;
}
