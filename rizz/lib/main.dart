/// This file is the "start-up" for the app.
library main;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'login/login.dart';
import 'style.dart';

/// [main] intializes Firebase, then calls
/// ```dart
/// runApp(const MainApp());
/// ```
/// which takes the user to the [LoginPage].
///
Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        primarySwatch:const MaterialColor(
      0xFFEDCDBB,
      <int, Color>{
        50: Color.fromRGBO(237, 205, 187, 1),
        100: Color.fromRGBO(237, 205, 187, 1),
        200: Color.fromRGBO(237, 205, 187, 1),
        300: Color.fromRGBO(237, 205, 187, 1),
        400: Color.fromRGBO(237, 205, 187, 1),
        500: Color.fromRGBO(237, 205, 187, 1),
        600: Color.fromRGBO(237, 205, 187, 1),
        700: Color.fromRGBO(237, 205, 187, 1),
        800: Color.fromRGBO(237, 205, 187, 1),
        900: Color.fromRGBO(237, 205, 187, 1),
      },),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
