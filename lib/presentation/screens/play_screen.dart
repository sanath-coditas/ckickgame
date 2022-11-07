import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/presentation/bloc/play_screen_bloc/play_screen_bloc.dart';
import 'package:clickgame/presentation/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.playText)),
      body: Column(
        children: [
          Center(
            child: Countdown(
              seconds: 20,
              build: (BuildContext context, double time) => Text(
                time.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                // print('Timer is done!');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ResultScreen(),
                ));
              },
            ),
          ),
          BlocBuilder<PlayScreenBloc, PlayScreenState>(
            builder: (context, state) {
              if (state is PlayScreenInitial) {
                BlocProvider.of<PlayScreenBloc>(context).add(GetPersonsEvent());
              }
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SuccessState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.persons[index].name),
                      );
                    },
                    itemCount: state.persons.length,
                  ),
                );
              }
              if (state is FailureState) {
                return Center(
                  child: Text(state.errorMsg),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
