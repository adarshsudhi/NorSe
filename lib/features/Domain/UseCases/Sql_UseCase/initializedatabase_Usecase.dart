// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';
import 'package:sqflite/sqflite.dart';

class initializedbusecase {
   final Sqlrepository repository;
  initializedbusecase({
    required this.repository,
  });
  Future<Database>call()async{
    return repository.intializedatabase();
  }
}
