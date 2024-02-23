import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Getlibraryalbumsusecase {
  final Sqlrepository repo;

  Getlibraryalbumsusecase({required this.repo});
  Future<Either<Failures,List<Map<String,dynamic>>>>call()async{
    return repo.getlibraryalbums();
  }
}