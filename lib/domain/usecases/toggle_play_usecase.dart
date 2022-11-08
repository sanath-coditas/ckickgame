import 'package:clickgame/core/error/failure.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class TogglePlayUsecase {
  final PersonRepository personRepository;
  TogglePlayUsecase({
    required this.personRepository,
  });
  Future<Either<Failure, void>> enablePlay() async{
    return await personRepository.enablePlay();
  }
  Future<Either<Failure, void>> disablePlay() async{
    return await personRepository.disablePlay();
  }
}
