import 'package:clickgame/constants/text_constants.dart';
import 'package:clickgame/data/models/person_model.dart';
import 'package:clickgame/presentation/bloc/join_screen_bloc/joinscreen_bloc.dart';
import 'package:clickgame/presentation/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/input_widget.dart';

class JoinScreen extends StatelessWidget {
  JoinScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.joinText),
      ),
      body: BlocBuilder<JoinScreenBloc, JoinscreenState>(
        builder: (context, state) {
          if (state is JoinscreenInitial) {
            return InputWidget(
                formKey: _formKey, nameController: _nameController);
          }
          if (state is LoadingState) {
            return const Center(
              child: Text(TextConstants.loadingText),
            );
          }
          if (state is SuccessState) {
            return const Center(
              child: Text(TextConstants.clickOnContinueText),
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
      floatingActionButton: BlocBuilder<JoinScreenBloc, JoinscreenState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return SizedBox(
              width: 100,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RoomScreen()));
                },
                child: const Text(TextConstants.continueText),
              ),
            );
          }
          return FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<JoinScreenBloc>(context).add(AddToRoomEvent(
                    person: PersonModel(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  numberOftimesClicked: 0,
                )));
              }
            },
            child: const Icon(
              Icons.arrow_forward_outlined,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
