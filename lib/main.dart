import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/authentication/bloc/auth_bloc.dart';
import 'package:tnpconnect/features/authentication/ui/login_signup.dart';
import 'package:tnpconnect/features/bottombar/bloc/bottombar_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckLoginEvent()),
        ),
        BlocProvider(
          create: (context) => BottomBarBloc()..add(BottomBarProfileEvent()),
        ),
      ],
      child: const CheckLoginSignUp(),
    );
  }
}
