import 'package:dartz/dartz.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

import '../../../../configs/Error/Errors.dart';

class GettopserachesUseCase {
  final APIRepository repo;
  GettopserachesUseCase({
    required this.repo,
  });
  Future<Either<Failures,List<launchdataEntity>>>call()async{
    return repo.topsearches();
  }
}
