// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'joinscreen_bloc.dart';

abstract class JoinscreenEvent extends Equatable {
  const JoinscreenEvent();

  @override
  List<Object> get props => [];
}

class AddToRoomEvent extends JoinscreenEvent {
  final PersonModel person;
  const AddToRoomEvent({
    required this.person,
  });
}
