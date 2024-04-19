import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/TopChartsEntity/topchartentity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../Entity/MusicEntity/PlaylistEntity/PlaylistEntity.dart';
import '../../Entity/MusicEntity/SearchSongEntity/SearchEntity.dart';

abstract class APIRepository {
  Future<List<AlbumSongEntity>> getAlbumSongs(String albumurl);
  Future<List<SearchEntity>> SearchSong(String Querydata);
  Future<SearchEntity> GetSong(String Songurl);
  Future<List<AlbumSongEntity>> GetSearchedAlbums(String Query);
  Future<void> DownloadSong(
      String DownloadUrl, ProgressCallback progressCallback, String Songpath);
  Future<void> DownloadArtwork(String DownloadUrl,
      ProgressCallback progressCallback, String artworkpath);
  Future<List<launchdataEntity>> trendingnow(String type);
  Future<Either<Failures, List<playlistEntity>>> getplaylistdetails(String id);
  Future<List<launchdataEntity>> getsearchPlaylists(String query);
  Future<Either<Failures, List<launchdataEntity>>> topsearches();
  Future<Either<Failures, List<topchartsEntity>>> topcharts();
  Future<Either<Failures, List<launchdataEntity>>> newlyreleased();
  Future<Either<Failures, List<launchdataEntity>>> gettopalbums();
  Future<Either<Failures,Video>> getvideoinfo(String id);
  Future<Either<Failures,AudioOnlyStreamInfo>> getstream(String id);
  Future<Either<Failures,Map<String, dynamic>>>getlyrices(String id);
  Future<Either<Failures,VideoSearchList>>getsearchvideo(String query);
  Future<dynamic>getplaylist(String id,String mode);
  Future<List<VideoOnlyStreamInfo>> getManifest(String id);
}
