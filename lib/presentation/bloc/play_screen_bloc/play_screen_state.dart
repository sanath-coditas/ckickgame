part of 'play_screen_bloc.dart';

abstract class PlayScreenState extends Equatable {
  const PlayScreenState();
  
  @override
  List<Object> get props => [];
}

class PlayScreenInitial extends PlayScreenState {}


class LoadingState extends PlayScreenState {}

class SuccessState extends PlayScreenState {
  final Stream<List<Person>> persons;
  const SuccessState({
    required this.persons,
  });
}

class FailureState extends PlayScreenState {
  final String errorMsg;
  const FailureState({
    required this.errorMsg,
  });
}
