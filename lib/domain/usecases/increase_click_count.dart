// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class IncreaseClickCountUsecase {
  final PersonRepository personRepository;
  IncreaseClickCountUsecase({
    required this.personRepository,
  });
  Future<Either<Failure, void>> increaseClickCount() async{
    return await personRepository.increaseClickCount();
  }
}
