import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nebula/features/Domain/Entity/PlaylistEntity/PlaylistEntity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../../configs/Error/Errors.dart';
import '../../../../Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../../../Domain/Entity/LaunchDataEntity/LaunchDataEntity.dart';
import '../../../../Domain/Entity/SearchSongEntity/SearchEntity.dart';
import '../../../../Domain/Entity/TopChartsEntity/topchartentity.dart';

abstract class APIremoteDatasource {
  Future<List<AlbumSongEntity>> GetAlbumSongs(String albumurl);
  Future<List<SearchEntity>> SearchSong(String Querydata);
  Future<SearchEntity> GetSong(String Songurl);
  Future<List<AlbumSongEntity>> GetSearchedAlbums(String Query);
  Future<void> DownloadSong(
      String DownloadUrl, ProgressCallback progressCallback, String Songpath);
  Future<void> DownloadArtwork(String DownloadUrl,
      ProgressCallback progressCallback, String artworkpath);
  Future<List<launchdataEntity>> trendingnow(String type);
  Future<List<Map<String, dynamic>>> decrypt(String encriptedmediaurl);
  Future<Either<Failures, List<playlistEntity>>> getplaylistdetails(String id);
  Future<List<launchdataEntity>> getsearchPlaylists(String query);
  Future<Either<Failures, List<launchdataEntity>>> topsearches();
  Future<Either<Failures, List<topchartsEntity>>> topcharts();
  Future<Either<Failures, List<launchdataEntity>>> newlyreleased();
  Future<Either<Failures, List<launchdataEntity>>> gettopalbums();
  Future<Either<Failures,Video>> getvideoinfo(String id);
  Future<Either<Failures,AudioOnlyStreamInfo>> getstream(String id);
  Future<Either<Failures,String>>getlyrices(String id);
  Future<Either<Failures,VideoSearchList>>getsearchvideo(String query);
  Future<dynamic>getplaylist(String id,String mode);
  Future<List<VideoOnlyStreamInfo>> getManifest(String id);
}
