import 'package:flutter/material.dart';
import 'package:smart_refrigerator/src/core/theme/app_palette.dart';
import 'package:smart_refrigerator/src/core/theme/app_text_style.dart';

class AppTheme {
  // Light Theme
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppPalette.lightPrimary,
    textTheme: AppTextStyle.lightTextTheme,
    colorScheme: const ColorScheme.light(
      primary: AppPalette.lightPrimary,
      secondary: AppPalette.lightSecondary,
    ),
    scaffoldBackgroundColor: AppPalette.lightBackground,
    fontFamily: 'Montserrat',
  );

  // Dark Theme
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppPalette.darkPrimary,
    textTheme: AppTextStyle.darkTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: AppPalette.darkPrimary,
      secondary: AppPalette.darkSecondary,
    ),
    scaffoldBackgroundColor: AppPalette.darkBackground,
    fontFamily: 'Montserrat',
  );
}
