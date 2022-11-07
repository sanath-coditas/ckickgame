import 'package:clickgame/data/datasources/firestore_datasource.dart';
import 'package:clickgame/data/repositories/person_repository_impl.dart';
import 'package:clickgame/domain/repositories/person_repository.dart';
import 'package:clickgame/domain/usecases/add_to_room_usecase.dart';
import 'package:clickgame/presentation/bloc/join_screen_bloc/joinscreen_bloc.dart';
import 'package:clickgame/presentation/bloc/play_screen_bloc/play_screen_bloc.dart';
import 'package:clickgame/presentation/bloc/room_screen_bloc/room_screen_bloc.dart';
import 'package:kiwi/kiwi.dart';

import 'domain/usecases/get_persons_usecase.dart';

part 'dependency_injection.g.dart';

abstract class Injector {
  static KiwiContainer? container;
  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container!.resolve();

  //! Blocs
  @Register.factory(JoinScreenBloc)
  @Register.factory(RoomScreenBloc)
  @Register.factory(PlayScreenBloc)

  //! Usecases
  @Register.factory(AddToRoomUsecase)
  @Register.factory(GetPersonsUsecase)

  //! Repositories
  @Register.factory(PersonRepository, from: PersonRepositoryImpl)

  //! DataSources
  @Register.factory(FireStoreDataSource, from: FireStoreDataSourceImpl)

  // ignore: unused_element
  void _configure();
}
