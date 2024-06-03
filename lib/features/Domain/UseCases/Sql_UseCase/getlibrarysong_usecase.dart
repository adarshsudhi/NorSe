import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/SqlQuerys/Sqllocaldatasource.dart';

class Getlibraryusecase {
  final Sqldatasourcerepository repo;

  Getlibraryusecase({required this.repo});
  Future<Either<Failures,List<Map<String,dynamic>>>> call(){
      return repo.getlibrarysongs();
  }
}