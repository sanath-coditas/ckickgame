import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FireStoreDataSource {
  Future<Either<Failure, void>> addToRoom({required PersonModel personModel});
  Future<Either<Failure, List<PersonModel>>> getPersons();
}

class FireStoreDataSourceImpl implements FireStoreDataSource {
  @override
  Future<Either<Failure, void>> addToRoom(
      {required PersonModel personModel}) async {
    try {
      final userCred = await FirebaseAuth.instance.signInAnonymously();
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userCred.user!.uid)
          .set(personModel.toJson());
      return const Right(null);
    } on AddToRoomFailure {
      return Left(AddToRoomFailure(message: 'Failed to add to Room....'));
    }
  }

  @override
  Future<Either<Failure, List<PersonModel>>> getPersons() async {
    try {
      List<PersonModel> persons = [];
      await FirebaseFirestore.instance
          .collection('players')
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          persons.add(PersonModel.fromJson(element.data()));
        }
      });
      return Right(persons);
    } on FetchFailure {
      return Left(FetchFailure(message: 'Failed to fetch..'));
    }
  }
}
