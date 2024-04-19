// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Addtoplaylistusecase {
  final Sqlrepository repo;
  Addtoplaylistusecase({
    required this.repo,
  });
  Future<Either<Failures,bool>>call(String tbname,AlbumElements song){
    return repo.Addtoplaylist(tbname, song);
  }
}
