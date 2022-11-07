import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class AddToRoomUsecase {
  final PersonRepository personRepository;

  const AddToRoomUsecase({required this.personRepository});
  Future<Either<Failure, void>> addToRoom(PersonModel personModel) async {
    return await personRepository.addToRoom(personModel: personModel);
  }
}
