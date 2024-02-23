import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/PlatformRepository/PlatformRepository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Getalbumsongsusecase {
  final PlatformRepository repo;

  Getalbumsongsusecase({required this.repo});
  Future<Either<Failures,List<SongModel>>>call(int id)async{
    return repo.getalbumsongs(id);
  }
}