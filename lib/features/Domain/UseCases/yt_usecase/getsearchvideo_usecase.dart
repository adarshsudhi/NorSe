// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Getsearchvideousecase {
  final APIRepository repository;
  Getsearchvideousecase({
    required this.repository,
  });
  Future<Either<Failures,VideoSearchList>> call(String query)async{
    return repository.getsearchvideo(query);
  }
}
