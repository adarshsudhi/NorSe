import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nebula/features/Data/DataSource/RemoteDataSource/API/APIremotedatasource.dart';
import 'package:nebula/features/Domain/Entity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Entity/PlaylistEntity/PlaylistEntity.dart';
import 'package:nebula/features/Domain/Entity/TopChartsEntity/topchartentity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../configs/Error/Errors.dart';
import '../../../Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../../Domain/Entity/SearchSongEntity/SearchEntity.dart';

class APIRepositoryimp implements APIRepository {
  final APIremoteDatasource apIremoteDatasource;
  APIRepositoryimp({
    required this.apIremoteDatasource,
  });

  @override
  Future<List<AlbumSongEntity>> GetAlbumSongs(String albumurl) => apIremoteDatasource.GetAlbumSongs(albumurl);

  @override
  Future<List<SearchEntity>> SearchSong(String Querydata) => apIremoteDatasource.SearchSong(Querydata);
  @override
  Future<SearchEntity> GetSong(String Songurl) => apIremoteDatasource.GetSong(Songurl);

  @override
  Future<List<AlbumSongEntity>> GetSearchedAlbums(String Query) => apIremoteDatasource.GetSearchedAlbums(Query);

  @override
  Future<void> DownloadSong(String DownloadUrl,
      ProgressCallback progressCallback, String Songpath)
      => apIremoteDatasource.DownloadSong(DownloadUrl, progressCallback, Songpath);
  

  @override
  Future<void> DownloadArtwork(String DownloadUrl,
      ProgressCallback progressCallback, String artworkpath) => apIremoteDatasource.DownloadArtwork(
        DownloadUrl, progressCallback, artworkpath);

  @override
  Future<List<launchdataEntity>> trendingnow(String type) =>  apIremoteDatasource.trendingnow(type);

  @override
  Future<Either<Failures, List<playlistEntity>>> getplaylistdetails(
      String id) => apIremoteDatasource.getplaylistdetails(id);

  @override
  Future<List<launchdataEntity>> getsearchPlaylists(String query)=>apIremoteDatasource.getsearchPlaylists(query);

  @override
  Future<Either<Failures, List<launchdataEntity>>> topsearches()=>apIremoteDatasource.topsearches();

  @override
  Future<Either<Failures, List<topchartsEntity>>> topcharts() => apIremoteDatasource.topcharts();

  @override
  Future<Either<Failures, List<launchdataEntity>>> newlyreleased() =>apIremoteDatasource.newlyreleased();

  @override
  Future<Either<Failures, List<launchdataEntity>>> gettopalbums()=> apIremoteDatasource.gettopalbums();

  @override
  Future<Either<Failures, Video>> getvideoinfo(String id) => apIremoteDatasource.getvideoinfo(id);
  
  @override
  Future<Either<Failures, AudioOnlyStreamInfo>> getstream(String id) => apIremoteDatasource.getstream(id);
  
  @override
  Future<Either<Failures, String>> getlyrices(String id) => apIremoteDatasource.getlyrices(id);
  
  @override
  Future<Either<Failures, VideoSearchList>> getsearchvideo(String query)=>apIremoteDatasource.getsearchvideo(query);
  
  @override
  Future<dynamic> getplaylist(String id, String mode) => apIremoteDatasource.getplaylist(id, mode);
  
  @override
  Future<List<VideoOnlyStreamInfo>> getManifest(String id) => apIremoteDatasource.getManifest(id);

}
