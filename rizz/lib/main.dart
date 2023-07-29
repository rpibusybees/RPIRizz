/// This file is the "start-up" for the app.
library main;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'header.dart';
import 'login.dart';
import 'style.dart';
/// [main] intializes Firebase, then calls
/// ```dart
/// runApp(const MainApp());
/// ```
/// which takes the user to the [LoginPage].
///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

/// Runs [MainApp.build] which takes the user to the [LoginPage].
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rizz',
      theme: ThemeData(
        colorScheme: RizzTheme.rizzColors,
        fontFamily: 'Poppins',
        textTheme: RizzTheme.rizzText,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
