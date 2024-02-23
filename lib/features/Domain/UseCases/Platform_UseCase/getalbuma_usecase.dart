// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/Platform/PlatFormDatasource.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Getallalbumsusecase {
  final PlatformDataRepository repository; 
  Getallalbumsusecase({
    required this.repository,
  });
  Future<Either<Failures,List<AlbumModel>>>call(){
    return repository.getalbums();
  }
}
