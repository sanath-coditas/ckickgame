import 'package:clickgame/data/datasources/firestore_datasource.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImpl implements PersonRepository {
  final FireStoreDataSource fireStoreDataSource;
  const PersonRepositoryImpl({required this.fireStoreDataSource});

  @override
  Future<Either<Failure, void>> addToRoom(
      {required PersonModel personModel}) async {
    return await fireStoreDataSource.addToRoom(personModel: personModel);
  }

  @override
  Future<Either<Failure, List<PersonModel>>> getPersons() async {
    return await fireStoreDataSource.getPersons();
  }
}
