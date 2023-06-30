import 'package:flutter/material.dart';
import 'package:flutter_encrypted_instant_message/home.dart';
import 'package:flutter_encrypted_instant_message/login.dart';
import 'package:flutter_encrypted_instant_message/signup.dart';

import 'package:loggy/loggy.dart';

void main() {
  runApp(const MyApp());
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.off,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen()
      },
    );
  }
}
