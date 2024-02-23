// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Getfavsongstatususecase {
  final Sqlrepository repo;
  Getfavsongstatususecase({
    required this.repo,
  });
  Future<Either<Failures,bool>>call(String songid)async{
    return repo.favsong(songid);
  }
}
