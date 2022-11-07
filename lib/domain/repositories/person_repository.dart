import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, void>> addToRoom({required PersonModel personModel});
  Future<Either<Failure, List<PersonModel>>> getPersons();
}
