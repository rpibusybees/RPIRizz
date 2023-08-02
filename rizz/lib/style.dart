import 'package:flutter/material.dart';

class RizzTheme {
  RizzTheme._();
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
  static const TextTheme rizzText = TextTheme(
    displaySmall: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 48,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        ),
      ],
    ),
    displayLarge: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 32,
    ),
    titleMedium: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Color.fromRGBO(49, 49, 49, 1),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
