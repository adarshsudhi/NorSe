import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Getaudiostreamusecase {
  final APIRepository repository;
  const Getaudiostreamusecase({
    required this.repository,
  });
  Future<Either<Failures,AudioOnlyStreamInfo>> call(String id)async{
    return repository.getstream(id);
  }
}
