import 'package:clickgame/presentation/screens/join_screen.dart';
import 'package:clickgame/presentation/screens/play_screen.dart';
import 'package:clickgame/presentation/screens/room_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGateway extends StatelessWidget {
  const AuthGateway({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return JoinScreen();
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('isGameStarted')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.map((e) => e.data()['isStarted']).first) {
                return PlayScreen();
              }
            }
            return const RoomScreen();
          },
        );
      },
    );
  }
}
