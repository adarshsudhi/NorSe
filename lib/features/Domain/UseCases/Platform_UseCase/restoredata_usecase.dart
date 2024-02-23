// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/PlatformRepository/PlatformRepository.dart';

class Restoredatausecase {
  final PlatformRepository repository;
  Restoredatausecase({
    required this.repository,
  });
  Future<Either<Failures,bool>>call()async{
    return repository.restoredata();
  }
}
