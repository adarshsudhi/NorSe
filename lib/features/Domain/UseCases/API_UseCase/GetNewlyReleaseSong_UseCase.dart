// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

import '../../Entity/SearchSongEntity/SearchEntity.dart';

class GetSongsUseCase {
  final APIRepository repository;
  GetSongsUseCase({
    required this.repository,
  });
 
  Future<SearchEntity>call(String Songurl)async{
    return repository.GetSong(Songurl);
  }
}
