import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Clearallrecentsusecase {
  final Sqlrepository repository;
  Clearallrecentsusecase({
    required this.repository,
  });
  Future<Either<Failures,bool>>call()async{
    return repository.clearecentsongs();
  }
}
