// ignore: file_names
import 'package:nebula/features/Domain/Repositorys/PlatformRepository/PlatformRepository.dart';

class GetpermissionUseCase {
  final PlatformRepository repository;
  GetpermissionUseCase({
    required this.repository,
  });
  Future<bool>call()async{
    return repository.getpermissions();
  }
}
