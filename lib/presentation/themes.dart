import 'package:flutter/material.dart';

const Color shadow6 = Color(0x0F000000);
const Color shadow12 = Color(0x1F000000);

const ButtonStyle buttonStyle = ButtonStyle(
  padding: WidgetStatePropertyAll(EdgeInsets.zero),
);

final lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF007AFF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF34C759),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0x4D000000),
    error: Color(0xFFFF3830),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFF7F6F2),
    onSurface: Color(0xFF000000),
    surfaceContainer: Color(0xFFFFFFFF),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF000000),
      fontSize: 32,
      height: 1.1875,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF000000),
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    sizeConstraints: BoxConstraints(
      minWidth: 56,
      minHeight: 56,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0x4D000000),
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(style: buttonStyle),
  textButtonTheme: const TextButtonThemeData(style: buttonStyle),
);

final darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF0A84FF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF32D74B),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0x66FFFFFF),
    error: Color(0xFFFF453A),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFF161618),
    onSurface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFF252528),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 32,
      height: 1.1875,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF000000),
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    sizeConstraints: BoxConstraints(
      minWidth: 56,
      minHeight: 56,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0x66FFFFFF),
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(style: buttonStyle),
  textButtonTheme: const TextButtonThemeData(style: buttonStyle),
);
