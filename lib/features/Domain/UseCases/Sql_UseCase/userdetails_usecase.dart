// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nebula/features/Data/Models/usermodel.dart';
import 'package:nebula/features/Domain/Repositorys/SqlReposiotory/Sqlreppository.dart';

class Userdetailsusecase {
   final Sqlrepository repository;
  const Userdetailsusecase({
    required this.repository,
  });
  Future<bool>call(String mode,Usermodel user)async{
    return repository.userdetails(mode, user);
  }
}
