part of 'room_screen_bloc.dart';

abstract class RoomScreenEvent extends Equatable {
  const RoomScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPersonsEvent extends RoomScreenEvent{
  
}