import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class updateplaylistusecase {
  final Sqlrepository repository;

  updateplaylistusecase({required this.repository});
  Future<Either<Failures,List<Map<String,dynamic>>>>call(String table,List<Map<String,dynamic>> newitems){
    return repository.updateplaylist(table, newitems);
  } 
}