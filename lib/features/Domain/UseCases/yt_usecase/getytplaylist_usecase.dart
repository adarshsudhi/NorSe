import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class Getplaylistusecase {
  final APIRepository repository;
  Getplaylistusecase({
    required this.repository,
  });
  Future<dynamic>call(String id,String mode)=>repository.getplaylist(id, mode);
}
