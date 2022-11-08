import 'package:clickgame/presentation/bloc/join_screen_bloc/joinscreen_bloc.dart';
import 'package:clickgame/presentation/bloc/play_screen_bloc/play_screen_bloc.dart';
import 'package:clickgame/presentation/bloc/room_screen_bloc/room_screen_bloc.dart';
import 'package:clickgame/presentation/screens/auth_gateway.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dependency_injection.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => kiwi.KiwiContainer().resolve<JoinScreenBloc>(),
        ),
        BlocProvider(
          create: (context) => kiwi.KiwiContainer().resolve<RoomScreenBloc>(),
        ),
        BlocProvider(
          create: (context) => kiwi.KiwiContainer().resolve<PlayScreenBloc>(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: AuthGateway()),
    );
  }
}
