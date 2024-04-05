import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tnpconnect/features/authentication/bloc/auth_bloc.dart';
import 'package:tnpconnect/features/authentication/ui/login_signup.dart';
import 'package:tnpconnect/features/bottombar/bloc/bottombar_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    log("in here");
    super.initState();

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize('27c656a5-9a56-4798-8d42-29b5087073fe');
    OneSignal.Notifications.requestPermission(true).then((value) {
      log("signal value: + $value");
    });
  }

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
    log(OneSignal.User.pushSubscription.id.toString());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())
            // ..add(UpdateDeviceID(OneSignal.User.pushSubscription.id.toString())),
            ),
        BlocProvider(
          create: (context) => BottomBarBloc()..add(BottomBarCompanyPostingsEvent()),
        ),
      ],
      child: const CheckLoginSignUp(),
    );
  }
}
