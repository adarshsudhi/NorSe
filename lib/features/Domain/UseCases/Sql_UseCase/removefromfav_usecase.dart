import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class removefromfavusecase {
  final Sqlrepository repository;

  removefromfavusecase({required this.repository});
  Future<Either<Failures,bool>>call(String id)async{
    return repository.removefromfav(id);
  }
}