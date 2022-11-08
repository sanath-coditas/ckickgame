import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/domain/entities/person.dart';
import 'package:clickgame/presentation/bloc/room_screen_bloc/room_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(TextConstants.roomText),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<RoomScreenBloc>(context).add(LogOutUserEvent());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
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
            return StreamBuilder<List<Person>>(
                stream: state.persons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Center(
                            child: Text(
                              snapshot.data![index].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(TextConstants.noUsersFoundText),
                    );
                  }
                  return const Center(child: Text(TextConstants.loadingText));
                });
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<RoomScreenBloc, RoomScreenState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return StreamBuilder(
              stream: state.persons,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.length >= 2) {
                  return FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<RoomScreenBloc>(context)
                          .add(EnablePlayEvent());
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
