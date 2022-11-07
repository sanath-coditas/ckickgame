import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/presentation/bloc/room_screen_bloc/room_screen_bloc.dart';
import 'package:clickgame/presentation/screens/play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.roomText)),
      body: BlocBuilder<RoomScreenBloc, RoomScreenState>(
        builder: (context, state) {
          if (state is RoomScreenInitial) {
            BlocProvider.of<RoomScreenBloc>(context).add(GetPersonsEvent());
          }
          if (state is FailureState) {
            return Center(
              child: Text(state.errorMsg),
            );
          }
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(
                      state.persons[index].name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              itemCount: state.persons.length,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<RoomScreenBloc, RoomScreenState>(
        builder: (context, state) {
          if (state is SuccessState && state.persons.length >= 2) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlayScreen(),
                ));
              },
              child: const Icon(Icons.play_arrow),
            );
          } else {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.play_arrow),
            );
          }
        },
      ),
    );
  }
}
