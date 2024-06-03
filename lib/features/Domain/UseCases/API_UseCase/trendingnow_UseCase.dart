// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

class trendingnowUseCase {
  final APIRepository repository;
  trendingnowUseCase({
    required this.repository,
  });
  Future<List<launchdataEntity>>call(String type)async{
    return repository.trendingnow(type);
  }
}
