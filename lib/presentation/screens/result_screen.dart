import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/domain/entities/person.dart';
import 'package:clickgame/presentation/bloc/room_screen_bloc/room_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RoomScreenBloc>(context).add(TogglePlayEvent());
    BlocProvider.of<RoomScreenBloc>(context).add(ResetScoreEvent());
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.resultText)),
      body: Center(child: Text('Winner is ${person.name} ')),
    );
  }
}
