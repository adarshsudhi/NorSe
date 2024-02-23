// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class GetSearchedAlbumsUseCase {
  final APIRepository repository;
  GetSearchedAlbumsUseCase({
    required this.repository,
  });
  Future<List<AlbumSongEntity>>call(String Query){
     return repository.GetSearchedAlbums(Query);
  }
}
