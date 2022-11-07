import 'package:clickgame/domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required super.name,
    required super.id,
    required super.numberOftimesClicked,
  });
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json['name'],
      id: json['id'],
      numberOftimesClicked: json['numberOftimesClicked'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'name': name,
      'id': id,
      'numberOftimesClicked': numberOftimesClicked,
    };
    return data;
  }
}
