// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotifyapi_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpotifyapiEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(BuildContext context) connectapi,
    required TResult Function(SpotifyApi spotifyapi, User user, Client client)
        grantedAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(BuildContext context)? connectapi,
    TResult? Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(BuildContext context)? connectapi,
    TResult Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ConnectApi value) connectapi,
    required TResult Function(_GrantedAccess value) grantedAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ConnectApi value)? connectapi,
    TResult? Function(_GrantedAccess value)? grantedAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ConnectApi value)? connectapi,
    TResult Function(_GrantedAccess value)? grantedAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotifyapiEventCopyWith<$Res> {
  factory $SpotifyapiEventCopyWith(
          SpotifyapiEvent value, $Res Function(SpotifyapiEvent) then) =
      _$SpotifyapiEventCopyWithImpl<$Res, SpotifyapiEvent>;
}

/// @nodoc
class _$SpotifyapiEventCopyWithImpl<$Res, $Val extends SpotifyapiEvent>
    implements $SpotifyapiEventCopyWith<$Res> {
  _$SpotifyapiEventCopyWithImpl(this._value, this._then);

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
    extends _$SpotifyapiEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'SpotifyapiEvent.started()';
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
    required TResult Function(BuildContext context) connectapi,
    required TResult Function(SpotifyApi spotifyapi, User user, Client client)
        grantedAccess,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(BuildContext context)? connectapi,
    TResult? Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(BuildContext context)? connectapi,
    TResult Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
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
    required TResult Function(_ConnectApi value) connectapi,
    required TResult Function(_GrantedAccess value) grantedAccess,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ConnectApi value)? connectapi,
    TResult? Function(_GrantedAccess value)? grantedAccess,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ConnectApi value)? connectapi,
    TResult Function(_GrantedAccess value)? grantedAccess,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements SpotifyapiEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$ConnectApiImplCopyWith<$Res> {
  factory _$$ConnectApiImplCopyWith(
          _$ConnectApiImpl value, $Res Function(_$ConnectApiImpl) then) =
      __$$ConnectApiImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$ConnectApiImplCopyWithImpl<$Res>
    extends _$SpotifyapiEventCopyWithImpl<$Res, _$ConnectApiImpl>
    implements _$$ConnectApiImplCopyWith<$Res> {
  __$$ConnectApiImplCopyWithImpl(
      _$ConnectApiImpl _value, $Res Function(_$ConnectApiImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$ConnectApiImpl(
      null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$ConnectApiImpl implements _ConnectApi {
  const _$ConnectApiImpl(this.context);

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'SpotifyapiEvent.connectapi(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectApiImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectApiImplCopyWith<_$ConnectApiImpl> get copyWith =>
      __$$ConnectApiImplCopyWithImpl<_$ConnectApiImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(BuildContext context) connectapi,
    required TResult Function(SpotifyApi spotifyapi, User user, Client client)
        grantedAccess,
  }) {
    return connectapi(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(BuildContext context)? connectapi,
    TResult? Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
  }) {
    return connectapi?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(BuildContext context)? connectapi,
    TResult Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
    required TResult orElse(),
  }) {
    if (connectapi != null) {
      return connectapi(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ConnectApi value) connectapi,
    required TResult Function(_GrantedAccess value) grantedAccess,
  }) {
    return connectapi(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ConnectApi value)? connectapi,
    TResult? Function(_GrantedAccess value)? grantedAccess,
  }) {
    return connectapi?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ConnectApi value)? connectapi,
    TResult Function(_GrantedAccess value)? grantedAccess,
    required TResult orElse(),
  }) {
    if (connectapi != null) {
      return connectapi(this);
    }
    return orElse();
  }
}

abstract class _ConnectApi implements SpotifyapiEvent {
  const factory _ConnectApi(final BuildContext context) = _$ConnectApiImpl;

  BuildContext get context;
  @JsonKey(ignore: true)
  _$$ConnectApiImplCopyWith<_$ConnectApiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GrantedAccessImplCopyWith<$Res> {
  factory _$$GrantedAccessImplCopyWith(
          _$GrantedAccessImpl value, $Res Function(_$GrantedAccessImpl) then) =
      __$$GrantedAccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SpotifyApi spotifyapi, User user, Client client});
}

/// @nodoc
class __$$GrantedAccessImplCopyWithImpl<$Res>
    extends _$SpotifyapiEventCopyWithImpl<$Res, _$GrantedAccessImpl>
    implements _$$GrantedAccessImplCopyWith<$Res> {
  __$$GrantedAccessImplCopyWithImpl(
      _$GrantedAccessImpl _value, $Res Function(_$GrantedAccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spotifyapi = null,
    Object? user = null,
    Object? client = null,
  }) {
    return _then(_$GrantedAccessImpl(
      null == spotifyapi
          ? _value.spotifyapi
          : spotifyapi // ignore: cast_nullable_to_non_nullable
              as SpotifyApi,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client,
    ));
  }
}

/// @nodoc

class _$GrantedAccessImpl implements _GrantedAccess {
  const _$GrantedAccessImpl(this.spotifyapi, this.user, this.client);

  @override
  final SpotifyApi spotifyapi;
  @override
  final User user;
  @override
  final Client client;

  @override
  String toString() {
    return 'SpotifyapiEvent.grantedAccess(spotifyapi: $spotifyapi, user: $user, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrantedAccessImpl &&
            (identical(other.spotifyapi, spotifyapi) ||
                other.spotifyapi == spotifyapi) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotifyapi, user, client);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GrantedAccessImplCopyWith<_$GrantedAccessImpl> get copyWith =>
      __$$GrantedAccessImplCopyWithImpl<_$GrantedAccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(BuildContext context) connectapi,
    required TResult Function(SpotifyApi spotifyapi, User user, Client client)
        grantedAccess,
  }) {
    return grantedAccess(spotifyapi, user, client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(BuildContext context)? connectapi,
    TResult? Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
  }) {
    return grantedAccess?.call(spotifyapi, user, client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(BuildContext context)? connectapi,
    TResult Function(SpotifyApi spotifyapi, User user, Client client)?
        grantedAccess,
    required TResult orElse(),
  }) {
    if (grantedAccess != null) {
      return grantedAccess(spotifyapi, user, client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_ConnectApi value) connectapi,
    required TResult Function(_GrantedAccess value) grantedAccess,
  }) {
    return grantedAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_ConnectApi value)? connectapi,
    TResult? Function(_GrantedAccess value)? grantedAccess,
  }) {
    return grantedAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_ConnectApi value)? connectapi,
    TResult Function(_GrantedAccess value)? grantedAccess,
    required TResult orElse(),
  }) {
    if (grantedAccess != null) {
      return grantedAccess(this);
    }
    return orElse();
  }
}

abstract class _GrantedAccess implements SpotifyapiEvent {
  const factory _GrantedAccess(
          final SpotifyApi spotifyapi, final User user, final Client client) =
      _$GrantedAccessImpl;

  SpotifyApi get spotifyapi;
  User get user;
  Client get client;
  @JsonKey(ignore: true)
  _$$GrantedAccessImplCopyWith<_$GrantedAccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SpotifyapiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)
        userSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UserSaved value) userSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UserSaved value)? userSaved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UserSaved value)? userSaved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotifyapiStateCopyWith<$Res> {
  factory $SpotifyapiStateCopyWith(
          SpotifyapiState value, $Res Function(SpotifyapiState) then) =
      _$SpotifyapiStateCopyWithImpl<$Res, SpotifyapiState>;
}

/// @nodoc
class _$SpotifyapiStateCopyWithImpl<$Res, $Val extends SpotifyapiState>
    implements $SpotifyapiStateCopyWith<$Res> {
  _$SpotifyapiStateCopyWithImpl(this._value, this._then);

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
    extends _$SpotifyapiStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'SpotifyapiState.initial()';
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
    required TResult Function() loading,
    required TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)
        userSaved,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_UserSaved value) userSaved,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UserSaved value)? userSaved,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UserSaved value)? userSaved,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SpotifyapiState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SpotifyapiStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'SpotifyapiState.loading()';
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
    required TResult Function() loading,
    required TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)
        userSaved,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UserSaved value) userSaved,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UserSaved value)? userSaved,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UserSaved value)? userSaved,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SpotifyapiState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$UserSavedImplCopyWith<$Res> {
  factory _$$UserSavedImplCopyWith(
          _$UserSavedImpl value, $Res Function(_$UserSavedImpl) then) =
      __$$UserSavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Map<String, dynamic> userdetails,
      List<PlaylistSimple> userplaylists,
      List<Artist> userartists,
      List<AlbumSimple> useralbums,
      List<PlayHistory> recentlyplayed,
      List<AlbumSimple> savedalbums,
      SpotifyApi spotifyapi,
      User user});
}

/// @nodoc
class __$$UserSavedImplCopyWithImpl<$Res>
    extends _$SpotifyapiStateCopyWithImpl<$Res, _$UserSavedImpl>
    implements _$$UserSavedImplCopyWith<$Res> {
  __$$UserSavedImplCopyWithImpl(
      _$UserSavedImpl _value, $Res Function(_$UserSavedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userdetails = null,
    Object? userplaylists = null,
    Object? userartists = null,
    Object? useralbums = null,
    Object? recentlyplayed = null,
    Object? savedalbums = null,
    Object? spotifyapi = null,
    Object? user = null,
  }) {
    return _then(_$UserSavedImpl(
      null == userdetails
          ? _value._userdetails
          : userdetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      null == userplaylists
          ? _value._userplaylists
          : userplaylists // ignore: cast_nullable_to_non_nullable
              as List<PlaylistSimple>,
      null == userartists
          ? _value._userartists
          : userartists // ignore: cast_nullable_to_non_nullable
              as List<Artist>,
      null == useralbums
          ? _value._useralbums
          : useralbums // ignore: cast_nullable_to_non_nullable
              as List<AlbumSimple>,
      null == recentlyplayed
          ? _value._recentlyplayed
          : recentlyplayed // ignore: cast_nullable_to_non_nullable
              as List<PlayHistory>,
      null == savedalbums
          ? _value._savedalbums
          : savedalbums // ignore: cast_nullable_to_non_nullable
              as List<AlbumSimple>,
      null == spotifyapi
          ? _value.spotifyapi
          : spotifyapi // ignore: cast_nullable_to_non_nullable
              as SpotifyApi,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$UserSavedImpl implements _UserSaved {
  const _$UserSavedImpl(
      final Map<String, dynamic> userdetails,
      final List<PlaylistSimple> userplaylists,
      final List<Artist> userartists,
      final List<AlbumSimple> useralbums,
      final List<PlayHistory> recentlyplayed,
      final List<AlbumSimple> savedalbums,
      this.spotifyapi,
      this.user)
      : _userdetails = userdetails,
        _userplaylists = userplaylists,
        _userartists = userartists,
        _useralbums = useralbums,
        _recentlyplayed = recentlyplayed,
        _savedalbums = savedalbums;

  final Map<String, dynamic> _userdetails;
  @override
  Map<String, dynamic> get userdetails {
    if (_userdetails is EqualUnmodifiableMapView) return _userdetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userdetails);
  }

  final List<PlaylistSimple> _userplaylists;
  @override
  List<PlaylistSimple> get userplaylists {
    if (_userplaylists is EqualUnmodifiableListView) return _userplaylists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userplaylists);
  }

  final List<Artist> _userartists;
  @override
  List<Artist> get userartists {
    if (_userartists is EqualUnmodifiableListView) return _userartists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userartists);
  }

  final List<AlbumSimple> _useralbums;
  @override
  List<AlbumSimple> get useralbums {
    if (_useralbums is EqualUnmodifiableListView) return _useralbums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_useralbums);
  }

  final List<PlayHistory> _recentlyplayed;
  @override
  List<PlayHistory> get recentlyplayed {
    if (_recentlyplayed is EqualUnmodifiableListView) return _recentlyplayed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentlyplayed);
  }

  final List<AlbumSimple> _savedalbums;
  @override
  List<AlbumSimple> get savedalbums {
    if (_savedalbums is EqualUnmodifiableListView) return _savedalbums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedalbums);
  }

  @override
  final SpotifyApi spotifyapi;
  @override
  final User user;

  @override
  String toString() {
    return 'SpotifyapiState.userSaved(userdetails: $userdetails, userplaylists: $userplaylists, userartists: $userartists, useralbums: $useralbums, recentlyplayed: $recentlyplayed, savedalbums: $savedalbums, spotifyapi: $spotifyapi, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSavedImpl &&
            const DeepCollectionEquality()
                .equals(other._userdetails, _userdetails) &&
            const DeepCollectionEquality()
                .equals(other._userplaylists, _userplaylists) &&
            const DeepCollectionEquality()
                .equals(other._userartists, _userartists) &&
            const DeepCollectionEquality()
                .equals(other._useralbums, _useralbums) &&
            const DeepCollectionEquality()
                .equals(other._recentlyplayed, _recentlyplayed) &&
            const DeepCollectionEquality()
                .equals(other._savedalbums, _savedalbums) &&
            (identical(other.spotifyapi, spotifyapi) ||
                other.spotifyapi == spotifyapi) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_userdetails),
      const DeepCollectionEquality().hash(_userplaylists),
      const DeepCollectionEquality().hash(_userartists),
      const DeepCollectionEquality().hash(_useralbums),
      const DeepCollectionEquality().hash(_recentlyplayed),
      const DeepCollectionEquality().hash(_savedalbums),
      spotifyapi,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSavedImplCopyWith<_$UserSavedImpl> get copyWith =>
      __$$UserSavedImplCopyWithImpl<_$UserSavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)
        userSaved,
  }) {
    return userSaved(userdetails, userplaylists, userartists, useralbums,
        recentlyplayed, savedalbums, spotifyapi, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
  }) {
    return userSaved?.call(userdetails, userplaylists, userartists, useralbums,
        recentlyplayed, savedalbums, spotifyapi, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            Map<String, dynamic> userdetails,
            List<PlaylistSimple> userplaylists,
            List<Artist> userartists,
            List<AlbumSimple> useralbums,
            List<PlayHistory> recentlyplayed,
            List<AlbumSimple> savedalbums,
            SpotifyApi spotifyapi,
            User user)?
        userSaved,
    required TResult orElse(),
  }) {
    if (userSaved != null) {
      return userSaved(userdetails, userplaylists, userartists, useralbums,
          recentlyplayed, savedalbums, spotifyapi, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UserSaved value) userSaved,
  }) {
    return userSaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UserSaved value)? userSaved,
  }) {
    return userSaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UserSaved value)? userSaved,
    required TResult orElse(),
  }) {
    if (userSaved != null) {
      return userSaved(this);
    }
    return orElse();
  }
}

abstract class _UserSaved implements SpotifyapiState {
  const factory _UserSaved(
      final Map<String, dynamic> userdetails,
      final List<PlaylistSimple> userplaylists,
      final List<Artist> userartists,
      final List<AlbumSimple> useralbums,
      final List<PlayHistory> recentlyplayed,
      final List<AlbumSimple> savedalbums,
      final SpotifyApi spotifyapi,
      final User user) = _$UserSavedImpl;

  Map<String, dynamic> get userdetails;
  List<PlaylistSimple> get userplaylists;
  List<Artist> get userartists;
  List<AlbumSimple> get useralbums;
  List<PlayHistory> get recentlyplayed;
  List<AlbumSimple> get savedalbums;
  SpotifyApi get spotifyapi;
  User get user;
  @JsonKey(ignore: true)
  _$$UserSavedImplCopyWith<_$UserSavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
