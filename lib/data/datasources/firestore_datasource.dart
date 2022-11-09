import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FireStoreDataSource {
  Future<Either<Failure, void>> addToRoom({required PersonModel personModel});
  Future<Either<Failure, Stream<List<PersonModel>>>> getPersons();
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, void>> enablePlay();
  Future<Either<Failure, void>> disablePlay();
  Future<Either<Failure, void>> increaseClickCount();
  Future<Either<Failure, void>> resetScore();
}

class FireStoreDataSourceImpl implements FireStoreDataSource {
  @override
  Future<Either<Failure, void>> addToRoom(
      {required PersonModel personModel}) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      await FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personModel.toJson());
          
      await FirebaseFirestore.instance
          .collection('players')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'id': FirebaseAuth.instance.currentUser!.uid});
      return const Right(null);
    } on AddToRoomFailure {
      return Left(AddToRoomFailure(message: 'Failed to add to Room....'));
    } catch (e) {
      return Left(AddToRoomFailure(message: e.toString()));
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
    } catch (e) {
      return Left(FetchFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } on LogoutFailure {
      return Left(LogoutFailure(message: 'Unable to Logout..'));
    }catch(e){
      return Left(LogoutFailure(message: 'Unable to Logout..'));
    }
  }

  @override
  Future<Either<Failure, void>> enablePlay() async {
    try {
      await FirebaseFirestore.instance
          .collection('isGameStarted')
          .doc('value')
          .update(
        {'isStarted': true},
      );

      return const Right(null);
    } on ToggleFailure {
      return Left(ToggleFailure(message: 'Failed to toggle....'));
    } catch (e) {
      return Left(ToggleFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disablePlay() async {
    try {
      await FirebaseFirestore.instance
          .collection('isGameStarted')
          .doc('value')
          .update(
        {'isStarted': false},
      );

      return const Right(null);
    } on ToggleFailure {
      return Left(ToggleFailure(message: 'Failed to toggle....'));
    } catch (e) {
      return Left(ToggleFailure(message: e.toString()));
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
    } catch (e) {
      return Left(IncreaseFailure(message: e.toString()));
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
    } catch (e) {
      return Left(IncreaseFailure(message: e.toString()));
    }
  }
}
