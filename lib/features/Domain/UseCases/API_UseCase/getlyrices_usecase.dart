// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class Getlyricesusecase {
  final APIRepository repository;
  const Getlyricesusecase({
    required this.repository,
  });
  Future<Either<Failures,String>>call(String id)async{
    return repository.getlyrices(id);
  }
}
