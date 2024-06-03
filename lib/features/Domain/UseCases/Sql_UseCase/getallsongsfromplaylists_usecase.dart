// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Getallsongsfromplaylistsusecase {
  final Sqlrepository Repositorys;
  Getallsongsfromplaylistsusecase({
    required this.Repositorys,
  });
  Future<Either<Failures,List<Map<String,dynamic>>>> call(String playlistid){
    return Repositorys.getallsongsfromplaylists(playlistid);
  }
}
