import 'package:dartz/dartz.dart';
import 'package:nebula/features/Data/Models/usermodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/SqlQuerys/Sqllocaldatasource.dart';
import 'package:nebula/features/Domain/Entity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';
import '../../../../configs/Error/Errors.dart';

class Sqlrepositoryimp extends Sqlrepository {
  final Sqldatasourcerepository sqldatasourcerepository;

  Sqlrepositoryimp({
    required this.sqldatasourcerepository,
  });

  @override
  Future<Database> intializedatabase() => sqldatasourcerepository.intializedatabase();

  @override
  Future<bool> addtodownloads(AlbumElements song ) => sqldatasourcerepository.addtodownloads(song);

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>>
      QueryDownloaddata() => sqldatasourcerepository.QueryDownloaddata();

  @override
  Future<Either<Failures, bool>> removefromdownloads(String id) => sqldatasourcerepository.removefromdownloads(id);

  @override
  Future<Either<Failures, bool>> addtorecent(AlbumElements song) => sqldatasourcerepository.addtorecent(song);

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallrecent() => sqldatasourcerepository.getallrecent();

  @override
  Future<Either<Failures, bool>> removefromRecents(String id) => sqldatasourcerepository.removefromRecents(id);

  @override
  Future<Either<Failures, String>> addtofav(AlbumElements song, bool isadded) => sqldatasourcerepository.addtofav(song, isadded);

  @override
  Future<Either<Failures, bool>> removefromfav(String id) => sqldatasourcerepository.removefromfav(id);

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallfavs() => sqldatasourcerepository.getallfavs();

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> updateplaylist(
      String table, List<Map<String, dynamic>> newitems) => sqldatasourcerepository.updateplaylist(table, newitems);

  @override
  Future<Either<Failures, bool>> Addtoplaylist(
      String tbname, AlbumElements song) => sqldatasourcerepository.Addtoplaylist(tbname, song);

  @override
  Future<Either<Failures, bool>> createplaylist(String playlistname) => sqldatasourcerepository.createplaylist(playlistname);

  @override
  Future<Either<Failures, bool>> deleteplaylist(
      String playlistid, String playlistname) => sqldatasourcerepository.deleteplaylist(playlistid, playlistname);

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallplaylist() => sqldatasourcerepository.getallplaylist();

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallsongsfromplaylists(
      String playlistid) => sqldatasourcerepository.getallsongsfromplaylists(playlistid);

  @override
  Future<Either<Failures, bool>> deletesongfromplaylist(
      String playlistname, String songid) => sqldatasourcerepository.deletesongfromplaylist(playlistname, songid);

  @override
  Future<Either<Failures, bool>> updateuserplaylist(
      String playlistname, List<Map<String, dynamic>> newform) => sqldatasourcerepository.updateuserplaylist(playlistname, newform);

  @override
  Future<Either<Failures, bool>> favsong(String songid) => sqldatasourcerepository.favsong(songid);

  @override
  Future<Either<Failures, bool>> clearecentsongs() => sqldatasourcerepository.clearecentsongs();

  @override
  Future<Either<Failures, bool>> cleardownloads() => sqldatasourcerepository.cleardownloads();
  
  @override
  Future<Either<Failures, String>> addtolibrary(String type, AlbumElements song) =>sqldatasourcerepository.addtolibrary(type, song);
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibrarysongs() => sqldatasourcerepository.getlibrarysongs();
  
  @override
  Future<bool> Checkifpresent(String id) => sqldatasourcerepository.Checkifpresent(id);
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibraryalbums() => sqldatasourcerepository.getlibraryalbums();
  
  @override
  Future<bool> checkforalbumpresent(String id) => sqldatasourcerepository.checkforalbumpresent(id);
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibraryplaylist() => sqldatasourcerepository.getlibraryplaylist();
  
  @override
  Future<bool> checkifplaylistpresent(String id) => sqldatasourcerepository.checkifplaylistpresent(id);
  
  @override
  Future<bool> userdetails(String mode,Usermodel user) => sqldatasourcerepository.userdetails(mode,user);
  
  @override
  Future<Map<String, dynamic>> getuserdetails() => sqldatasourcerepository.getuserdetails();
}
