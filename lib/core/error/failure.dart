abstract class Failure {
  final String message;

  Failure({required this.message});
}

class AddToRoomFailure extends Failure {
  AddToRoomFailure({required super.message});
}

class FetchFailure extends Failure {
  FetchFailure({required super.message});
}
