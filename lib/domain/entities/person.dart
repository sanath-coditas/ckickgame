import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final String id;
  final int numberOftimesClicked;

  const Person(
      {required this.name,
      required this.id,
      required this.numberOftimesClicked});

  @override
  List<Object?> get props => [name, id, numberOftimesClicked];
}
