// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_injection.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => JoinScreenBloc(addToRoomUsecase: c<AddToRoomUsecase>()))
      ..registerFactory((c) => RoomScreenBloc(c<GetPersonsUsecase>()))
      ..registerFactory(
          (c) => PlayScreenBloc(getPersonsUsecase: c<GetPersonsUsecase>()))
      ..registerFactory(
          (c) => AddToRoomUsecase(personRepository: c<PersonRepository>()))
      ..registerFactory(
          (c) => GetPersonsUsecase(personRepository: c<PersonRepository>()))
      ..registerFactory<PersonRepository>((c) =>
          PersonRepositoryImpl(fireStoreDataSource: c<FireStoreDataSource>()))
      ..registerFactory<FireStoreDataSource>((c) => FireStoreDataSourceImpl());
  }
}
