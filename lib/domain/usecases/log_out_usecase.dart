// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase {
  final PersonRepository personRepository;
  LogoutUsecase({
    required this.personRepository,
  });
  Future<Either<Failure, void>> logOutUser() async {
    return await personRepository.logOut();
  }
}
