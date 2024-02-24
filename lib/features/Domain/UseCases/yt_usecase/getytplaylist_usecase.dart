import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class Getplaylistusecase {
  final APIRepository repository;
  Getplaylistusecase({
    required this.repository,
  });
  Future<Either<Failures,dynamic>>call(String id,String mode)=>repository.getplaylist(id, mode);
}
