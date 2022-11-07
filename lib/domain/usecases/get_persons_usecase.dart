import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/entities/person.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class GetPersonsUsecase {
  final PersonRepository personRepository;
  GetPersonsUsecase({
    required this.personRepository,
  });
  Future<Either<Failure, List<Person>>> getPersons() async {
    return await personRepository.getPersons();
  }
}
