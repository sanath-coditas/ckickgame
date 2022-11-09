// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_screen_bloc.dart';

abstract class RoomScreenEvent extends Equatable {
  const RoomScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPersonsEvent extends RoomScreenEvent {}

class LogOutUserEvent extends RoomScreenEvent {}

class EnablePlayEvent extends RoomScreenEvent {}

class DisablePlayEvent extends RoomScreenEvent {}

class ResetScoreEvent extends RoomScreenEvent {}
