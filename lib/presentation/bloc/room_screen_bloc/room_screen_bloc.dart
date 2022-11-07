import 'package:bloc/bloc.dart';
import 'package:clickgame/domain/entities/person.dart';
import 'package:clickgame/domain/usecases/get_persons_usecase.dart';
import 'package:equatable/equatable.dart';

part 'room_screen_event.dart';
part 'room_screen_state.dart';

class RoomScreenBloc extends Bloc<RoomScreenEvent, RoomScreenState> {
  final GetPersonsUsecase getPersonsUsecase;
  RoomScreenBloc(this.getPersonsUsecase) : super(RoomScreenInitial()) {
    on<GetPersonsEvent>((event, emit) async {
      emit(LoadingState());
      final getStatus = await getPersonsUsecase.getPersons();
      getStatus.fold((l) => emit(FailureState(errorMsg: l.message)),
          (r) => emit(SuccessState(persons: r)));
    });
  }
}
