// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class addtodownloadsUsecase {
  final Sqlrepository Repository;
  addtodownloadsUsecase({
    required this.Repository,
  });
  Future<bool>call(AlbumElements song)async{
    return Repository.addtodownloads(song);
  }
}
