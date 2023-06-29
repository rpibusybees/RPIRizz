import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

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
