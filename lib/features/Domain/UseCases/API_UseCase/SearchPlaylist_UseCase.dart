// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class SearchPlaylistUseCase {
  final APIRepository repository;
  SearchPlaylistUseCase({
    required this.repository,
  });
  Future<List<launchdataEntity>>call(String query)async{
    return repository.getsearchPlaylists(query);
  }
  
}
