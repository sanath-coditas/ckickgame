part of 'play_screen_bloc.dart';

abstract class PlayScreenEvent extends Equatable {
  const PlayScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPersonsEvent extends PlayScreenEvent{}
class IncreaseEvent extends PlayScreenEvent{}