import 'package:dartz/dartz.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/Platform/PlatFormDatasource.dart';
import 'package:nebula/features/Domain/Repositorys/PlatformRepository/PlatformRepository.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../configs/Error/Errors.dart';

class PlatformRepositoryimp extends PlatformRepository {
  final PlatformDataRepository platformDataRepository;
  PlatformRepositoryimp({
    required this.platformDataRepository,
  });
  @override
  Future<bool> getpermissions() => platformDataRepository.getpermissions();
  
  @override
  Future<Either<Failures,List<SongModel>>>getallsongs() => platformDataRepository.getallsongs();
  
  @override
  Future<Either<Failures, List<AlbumModel>>> getalbums() => platformDataRepository.getalbums();
  
  @override
  Future<Either<Failures, List<SongModel>>> getalbumsongs(int id) => platformDataRepository.getalbumsongs(id);
  
  @override
  Future<Either<Failures, bool>> backupdata() => platformDataRepository.backupdata();
  
  @override
  Future<Either<Failures, bool>> restoredata() => platformDataRepository.restoredata();
  
  @override
  Future<void> initnotification() => platformDataRepository.initnotification();
  
  @override
  void showprogress(double progress,int id,String title,String auther) => platformDataRepository.showprogress(progress, id,title,auther);
}
