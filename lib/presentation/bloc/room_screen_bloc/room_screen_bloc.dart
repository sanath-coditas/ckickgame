import 'package:bloc/bloc.dart';
import 'package:clickgame/domain/entities/person.dart';
import 'package:clickgame/domain/usecases/get_persons_usecase.dart';
import 'package:clickgame/domain/usecases/log_out_usecase.dart';
import 'package:clickgame/domain/usecases/reset_score_usecase.dart';
import 'package:clickgame/domain/usecases/toggle_play_usecase.dart';
import 'package:equatable/equatable.dart';

part 'room_screen_event.dart';
part 'room_screen_state.dart';

class RoomScreenBloc extends Bloc<RoomScreenEvent, RoomScreenState> {
  final GetPersonsUsecase getPersonsUsecase;
  final LogoutUsecase logoutUsecase;
  final TogglePlayUsecase togglePlayUsecase;
  final ResetScoreUsecase resetScoreUsecase;
  RoomScreenBloc(
      {required  this.getPersonsUsecase,
      required this.logoutUsecase,
      required this.togglePlayUsecase,
      required this.resetScoreUsecase})
      : super(RoomScreenInitial()) {
    on<GetPersonsEvent>((event, emit) async {
      emit(LoadingState());
      final getStatus = await getPersonsUsecase.getPersons();
      getStatus.fold((l) => emit(FailureState(errorMsg: l.message)),
          (r) => emit(SuccessState(persons: r)));
    });

    on<LogOutUserEvent>((event, emit) async {
      final status = await logoutUsecase.logOutUser();
      status.fold((l) => emit(FailureState(errorMsg: l.message)), (r) => null);
    });

    on<EnablePlayEvent>((event, emit) async {
      final status = await togglePlayUsecase.enablePlay();
      status.fold((l) => emit(FailureState(errorMsg: l.message)), (r) => null);
    });
    
    on<DisablePlayEvent>((event, emit) async {
      final status = await togglePlayUsecase.disablePlay();
      status.fold((l) => emit(FailureState(errorMsg: l.message)), (r) => null);
    });
    on<ResetScoreEvent>((event, emit) async {
      final status = await resetScoreUsecase.resetScore();
      status.fold((l) => emit(FailureState(errorMsg: l.message)), (r) => null);
    });
  }
}
