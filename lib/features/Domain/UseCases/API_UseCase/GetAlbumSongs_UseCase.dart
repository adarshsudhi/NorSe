// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

import '../../Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';

class GetAlbumSongsUseCase {
   final APIRepository repository;
  GetAlbumSongsUseCase({
    required this.repository,
  });
  Future<List<AlbumSongEntity>>call(String albumurl)async{
    return repository.GetAlbumSongs(albumurl);
  }
}
