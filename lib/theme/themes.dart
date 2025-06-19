import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class HouzeoAppTheme {
  final _themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: blackColor,
        surface: backgroundColor,
        primary: primaryColor,
        surfaceTint: backgroundColor,
        secondary: secondaryColor,
        primaryContainer: secondaryColor,
        brightness: Brightness.light,
        onPrimaryContainer: secondaryColor),
    appBarTheme: const AppBarTheme(backgroundColor: backgroundColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor)),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    dividerColor: dividerColor,
    useMaterial3: true,
    textTheme: const TextTheme(),
  );

  get getThemeData => _themeData;
}
