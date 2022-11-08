import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, void>> addToRoom({required PersonModel personModel});
  Future<Either<Failure, Stream<List<PersonModel>>>> getPersons();
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, void>> togglePlay();
  Future<Either<Failure, void>> increaseClickCount();
  Future<Either<Failure, void>> resetScore();
}
