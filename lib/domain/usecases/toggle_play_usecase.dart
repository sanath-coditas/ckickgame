import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class TogglePlayUsecase {
  final PersonRepository personRepository;
  TogglePlayUsecase({
    required this.personRepository,
  });
  Future<Either<Failure, void>> togglePlay() async{
    return await personRepository.togglePlay();
  }
}
