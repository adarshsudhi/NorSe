import 'dart:io';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/Platform/PlatFormDatasource.dart';
import 'package:sqflite/sqflite.dart';

class PlatformDataRepositoryimp extends PlatformDataRepository {
  final OnAudioQuery onAudioQuery;


  PlatformDataRepositoryimp({
    required this.onAudioQuery,
  });



  @override
  Future<bool> getpermissions() async {
    AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
    int version = info.version.sdkInt;
    if (version < 30) {
      PermissionStatus storagepermission = await Permission.storage.status;
      if (storagepermission.isDenied) {
        switch (version) {
          case 26 || 27 || 28:
            bool status = await onAudioQuery.permissionsRequest();
            return status? true : false;
    
          case 29:
            PermissionStatus status = await Permission.storage.request();
            return status.isGranted? true:false;

          default:
            return false;
        }
      } else {
        return true;
      }
    } else {
      if (version >= 33) {
        PermissionStatus permisson = await Permission.audio.status;
        PermissionStatus managestoragestatus =
            await Permission.manageExternalStorage.status;
        if (permisson.isDenied && managestoragestatus.isDenied) {
          switch (version) {
            case 33 || 34:
              PermissionStatus audiopermission =
                  await Permission.audio.request();
              PermissionStatus managestorage =
                  await Permission.manageExternalStorage.request();
              return audiopermission.isGranted && managestorage.isGranted
                  ? true
                  : false;

            default:
              return false;
          }
        } else {
          return true;
        }
      } else {
        PermissionStatus audiopermissionstatus =
            await Permission.storage.status;
        PermissionStatus managestoragestatus =
            await Permission.manageExternalStorage.status;
        if (audiopermissionstatus.isDenied && managestoragestatus.isDenied) {
          switch (version) {
            case 30 || 31 || 32:
              PermissionStatus audiopermission =
                  await Permission.storage.request();
              PermissionStatus managestorage =
                  await Permission.manageExternalStorage.request();
              return audiopermission.isGranted && managestorage.isGranted
                  ? true
                  : false;

            default:
              return false;
          }
        } else {
          return true;
        }
      }
    }
  }



  @override
  Future<Either<Failures, List<SongModel>>> getallsongs() async {
    try {
      List<SongModel> songs = await onAudioQuery.querySongs(
            sortType: SongSortType.DATE_ADDED,
            orderType: OrderType.DESC_OR_GREATER,
            uriType: UriType.EXTERNAL,
            path: '/storage/emulated/0');

      if (songs.isNotEmpty) {
        return right(songs);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  Future<Either<Failures, List<AlbumModel>>> getalbums() async {
    try {
      final songs = await onAudioQuery.queryAlbums(
          sortType: AlbumSortType.ALBUM, orderType: OrderType.ASC_OR_SMALLER,);
      if (songs.isNotEmpty) {
        return right(songs);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  
  @override
  Future<Either<Failures, List<SongModel>>> getalbumsongs(int id) async{
   try {
     List<SongModel> songs = await onAudioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID,id);
     if (songs.isNotEmpty) {
       return right(songs);
     }
     return left(const Failures.clientfailure());
   } catch (e) {
     throw Exception(e.toString());
   }
  }
  
  @override
  Future<Either<Failures, bool>> backupdata() async{
    try {
    String documentsDirectory = await getDatabasesPath();
    Database database = await openDatabase(
      join(documentsDirectory, 'nebula.db'),
    );
    String dbpath = database.path;
      if (await databaseExists(dbpath)) {
         String backupPath = join('/storage/emulated/0/Documents', 'backup.db');
         File file =await File(dbpath).copy(backupPath);
         if (await file.exists()) {
            return right(true);
         }
         return left(const Failures.clientfailure());
      }
       return right(true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failures, bool>> restoredata() async{
    try {
    String documentsDirectory = await getDatabasesPath();
    Database database = await openDatabase(
      join(documentsDirectory, 'nebula.db'),
    );
    String dbpath = database.path;
      if (await databaseExists(dbpath)) {
         await File(dbpath).delete();
         String backupPath = join('/storage/emulated/0/Documents', 'backup.db');
         File file =await File(backupPath).copy(dbpath);
         if (await file.exists()) {
            return right(true);
         }
         return left(const Failures.clientfailure());
      }
       return right(true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
