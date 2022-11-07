import 'package:bloc/bloc.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:clickgame/domain/usecases/add_to_room_usecase.dart';
import 'package:equatable/equatable.dart';

part 'joinscreen_event.dart';
part 'joinscreen_state.dart';

class JoinScreenBloc extends Bloc<JoinscreenEvent, JoinscreenState> {
  final AddToRoomUsecase addToRoomUsecase;
  JoinScreenBloc({required this.addToRoomUsecase})
      : super(JoinscreenInitial()) {
    on<JoinscreenEvent>((event, emit) {});
    on<AddToRoomEvent>((event, emit) async {
      emit(LoadingState());
      final addedStatus = await addToRoomUsecase.addToRoom(event.person);
      addedStatus.fold((l) => emit(FailureState(errorMsg: l.message)),
          (r) => emit(SuccessState()));
    });
  }
}
