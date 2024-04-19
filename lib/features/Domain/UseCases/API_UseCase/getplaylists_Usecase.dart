// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/PlaylistEntity/PlaylistEntity.dart';
import 'package:nebula/features/Domain/Repositorys/APIRepository/APIrepository.dart';

import '../../../../configs/Error/Errors.dart';

class getplaylistdetailsUSeCase {
  final APIRepository repository;
  getplaylistdetailsUSeCase({
    required this.repository,
  });
  Future<Either<Failures, List<playlistEntity>>> call(String id) async {
    return repository.getplaylistdetails(id);
  }
}
