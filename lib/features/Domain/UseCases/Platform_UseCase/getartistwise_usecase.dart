// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:norse/features/Domain/Repositorys/PlatformRepository/PlatformRepository.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../configs/Error/Errors.dart';

class GetArtistWiseUseCase {
  final PlatformRepository repository;
  GetArtistWiseUseCase({
    required this.repository,
  });
  Future<Either<Failures,List<ArtistModel>>>call()async{
    return repository.getartistwise();
  }
}
