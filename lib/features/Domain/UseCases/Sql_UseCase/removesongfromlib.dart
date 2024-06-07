import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Removesongfromlibusecase {
  final Sqlrepository repo;

  Removesongfromlibusecase({required this.repo});

  Future<Either<Failures, bool>> call(String id) {
    return repo.removesongfromlib(id);
  }
}
