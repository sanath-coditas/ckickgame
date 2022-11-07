// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_screen_bloc.dart';

abstract class RoomScreenState extends Equatable {
  const RoomScreenState();

  @override
  List<Object> get props => [];
}

class RoomScreenInitial extends RoomScreenState {}

class LoadingState extends RoomScreenState {}

class SuccessState extends RoomScreenState {
  final List<Person> persons;
  const SuccessState({
    required this.persons,
  });
}

class FailureState extends RoomScreenState {
  final String errorMsg;
  const FailureState({
    required this.errorMsg,
  });
}
