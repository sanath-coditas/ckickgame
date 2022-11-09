import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/presentation/bloc/play_screen_bloc/play_screen_bloc.dart';
import 'package:clickgame/presentation/screens/result_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../domain/entities/person.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    late Person winner;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: const Text(TextConstants.playText)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Center(
              child: Countdown(
                seconds: 10,
                build: (BuildContext context, double time) => Text(
                  time.round().toString(),
                  style: const TextStyle(fontSize: 60, color: Colors.red),
                ),
                interval: const Duration(milliseconds: 100),
                onFinished: ()  {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        person: winner,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            BlocBuilder<PlayScreenBloc, PlayScreenState>(
              builder: (context, state) {
                if (state is PlayScreenInitial) {
                  BlocProvider.of<PlayScreenBloc>(context)
                      .add(GetPersonsEvent());
                }
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SuccessState) {
                  return StreamBuilder<List<Person>>(
                      stream: state.persons,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasData) {
                          snapshot.data!.sort(((a, b) => b.numberOftimesClicked
                              .compareTo(a.numberOftimesClicked)));
                          winner = snapshot.data![0];
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            // child: AnimatedList(
                            //   itemBuilder: (context, index, animation) {
                            //     return buildTile(snapshot.data![index]);
                            //   },
                            //   initialItemCount: snapshot.data!.length,
                            // ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return buildTile(snapshot.data![index]);
                              },
                              itemCount: snapshot.data!.length,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text(TextConstants.noUsersFoundText),
                          );
                        }
                        return const Center(
                            child: Text(TextConstants.loadingText));
                      });
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
      ),
      floatingActionButton: SizedBox(
          width: 200,
          height: 50,
          child: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<PlayScreenBloc>(context).add(IncreaseEvent());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text(
              'Press',
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}

Widget buildTile(Person person) => ListTile(
      trailing: Text(
        person.numberOftimesClicked.toString(),
        style: (FirebaseAuth.instance.currentUser!.uid == person.id)
            ? const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            : const TextStyle(fontSize: 20),
      ),
      title: Text(
        person.name,
        style: (FirebaseAuth.instance.currentUser!.uid == person.id)
            ? const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            : const TextStyle(fontSize: 20),
      ),
    );
