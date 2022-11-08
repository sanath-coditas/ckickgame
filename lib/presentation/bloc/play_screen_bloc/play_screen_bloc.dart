import 'package:bloc/bloc.dart';
import 'package:clickgame/domain/usecases/get_persons_usecase.dart';
import 'package:clickgame/domain/usecases/increase_click_count.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/person.dart';

part 'play_screen_event.dart';
part 'play_screen_state.dart';

class PlayScreenBloc extends Bloc<PlayScreenEvent, PlayScreenState> {
  final GetPersonsUsecase getPersonsUsecase;
  final IncreaseClickCountUsecase increaseClickCountUsecase;
  PlayScreenBloc(this.increaseClickCountUsecase,
      {required this.getPersonsUsecase})
      : super(PlayScreenInitial()) {
    on<GetPersonsEvent>((event, emit) async {
      emit(LoadingState());
      final getStatus = await getPersonsUsecase.getPersons();
      getStatus.fold((l) => emit(FailureState(errorMsg: l.message)),
          (r) => emit(SuccessState(persons: r)));
    });
    on<IncreaseEvent>((event, emit) async {
      final getStatus = await increaseClickCountUsecase.increaseClickCount();
      getStatus.fold(
          (l) => emit(FailureState(errorMsg: l.message)), (r) => null);
    });
  }
}
