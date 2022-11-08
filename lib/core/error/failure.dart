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

class LogoutFailure extends Failure{
  LogoutFailure({required super.message});
}
class ToggleFailure extends Failure{
  ToggleFailure({required super.message});
}
class IncreaseFailure extends Failure{
  IncreaseFailure({required super.message});

}