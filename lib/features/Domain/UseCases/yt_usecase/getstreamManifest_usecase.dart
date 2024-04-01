import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class GetstreamManifestusecase {
  final APIRepository repository;
  GetstreamManifestusecase({
    required this.repository,
  });
  Future<List<VideoOnlyStreamInfo>>call(String id)async{
    return repository.getManifest(id);
  }
}
