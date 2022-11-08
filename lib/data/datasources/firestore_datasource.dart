import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FireStoreDataSource {
  Future<Either<Failure, void>> addToRoom({required PersonModel personModel});
  Future<Either<Failure, Stream<List<PersonModel>>>> getPersons();
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, void>> togglePlay();
  Future<Either<Failure, void>> increaseClickCount();
  Future<Either<Failure, void>> resetScore();
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
  Future<Either<Failure, Stream<List<PersonModel>>>> getPersons() async {
    try {
      // Stream<List<PersonModel>> persons;
      // final stream =  FirebaseFirestore.instance.collection('players');
      var ref = FirebaseFirestore.instance.collection('players');

      final personsStream = ref.snapshots().map((list) =>
          list.docs.map((doc) => PersonModel.fromJson(doc.data())).toList());

      return Right(personsStream);
    } on FetchFailure {
      return Left(FetchFailure(message: 'Failed to fetch..'));
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } on LogoutFailure {
      return Left(LogoutFailure(message: 'Unable to Logout..'));
    }
  }

  @override
  Future<Either<Failure, void>> togglePlay() async {
    try {
      bool? boolValue;
      await FirebaseFirestore.instance
          .collection('isGameStarted')
          .doc('value')
          .get()
          .then((querySnapshot) {
        boolValue = querySnapshot.data()!['isStarted'];
      });
      boolValue = boolValue! ? false : true;
      await FirebaseFirestore.instance
          .collection('isGameStarted')
          .doc('value')
          .update(
        {'isStarted': boolValue},
      );

      return const Right(null);
    } on ToggleFailure {
      return Left(ToggleFailure(message: 'Failed to toggle....'));
    }
  }

  @override
  Future<Either<Failure, void>> increaseClickCount() async {
    try {
      int val = 0;
      await FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((querySnapshot) {
        val = querySnapshot.data()!['numberOftimesClicked'];
      });
      await FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'numberOftimesClicked': val + 1});

      return const Right(null);
    } on IncreaseFailure {
      return Left(IncreaseFailure(message: 'Failed to increase....'));
    }
  }

  @override
  Future<Either<Failure, void>> resetScore() async {
    try {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'numberOftimesClicked': 0});
      return const Right(null);
    } on IncreaseFailure {
      return Left(IncreaseFailure(message: 'Failed to increase....'));
    }
  }
}
