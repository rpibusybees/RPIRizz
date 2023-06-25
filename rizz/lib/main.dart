import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'login.dart';

class RizzColors {
  RizzColors._();
  static const ColorScheme rizzColors = ColorScheme(
    background: Color.fromRGBO(255, 248, 245, 1),
    surface: Color.fromRGBO(255, 237, 219, 1),
    primary: Color.fromRGBO(237, 205, 187, 1),
    secondary: Color.fromRGBO(188, 83, 100, 1),
    tertiary: Color.fromRGBO(227, 183, 160, 1),
    error: Color.fromRGBO(186, 45, 69, 1),
    onPrimary: Color.fromRGBO(245, 220, 215, 1),
    onSecondary: Color.fromRGBO(191, 146, 112, 1),
    onPrimaryContainer: Color.fromRGBO(49, 49, 49, .7),
    onBackground: Color.fromRGBO(123, 133, 142, 1),
    onSurface: Color.fromRGBO(189, 194, 199, 1),
    onError: Color.fromRGBO(70, 129, 244, 1),
    brightness: Brightness.light,
  );
}

class RizzText {
  static const TextTheme rizzText = TextTheme(
    labelMedium: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}

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
        colorScheme: RizzColors.rizzColors,
        fontFamily: 'Poppins',
        textTheme: RizzText.rizzText,
      ),
      home: const LoginPage(),
    );
  }
}
