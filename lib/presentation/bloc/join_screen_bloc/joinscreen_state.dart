// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'joinscreen_bloc.dart';

abstract class JoinscreenState extends Equatable {
  const JoinscreenState();

  @override
  List<Object> get props => [];
}

class JoinscreenInitial extends JoinscreenState {}

class LoadingState extends JoinscreenState {}

class SuccessState extends JoinscreenState {}

class FailureState extends JoinscreenState {
  final String errorMsg;
  const FailureState({
    required this.errorMsg,
  });
  
}
