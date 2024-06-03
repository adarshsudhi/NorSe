import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class AddtofaveUsecase {
  final Sqlrepository repo;

  AddtofaveUsecase({required this.repo});
  Future<Either<Failures,String>>call(AlbumElements song,bool isadded) async{
    return repo.addtofav(song,isadded);
  }
}