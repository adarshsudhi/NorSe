import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class PlatformDataRepository {
  Future<bool>getpermissions();
  Future<Either<Failures,List<SongModel>>>getallsongs();
  Future<Either<Failures,List<AlbumModel>>>getalbums();
  Future<Either<Failures,List<SongModel>>>getalbumsongs(int id);
  Future<Either<Failures,bool>>backupdata();
  Future<Either<Failures,bool>>restoredata();
  Future<void>initnotification();
  void showprogress(double progress,int id,String title,String auther);
}