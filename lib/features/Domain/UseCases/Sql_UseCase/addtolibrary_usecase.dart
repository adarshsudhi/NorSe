import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/SqlQuerys/Sqllocaldatasource.dart';
import '../../Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';

class Addtolibraryusecase {
   final Sqldatasourcerepository repo;

  Addtolibraryusecase({required this.repo}); 

  Future<Either<Failures,String>> call(String type,AlbumElements song)async{
    return repo.addtolibrary(type,song);
  }
   
}