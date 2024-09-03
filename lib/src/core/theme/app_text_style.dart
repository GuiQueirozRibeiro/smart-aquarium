import 'package:flutter/material.dart';
import 'package:smart_refrigerator/src/core/theme/app_palette.dart';

class AppTextStyle {
  const AppTextStyle._();

  static const FontWeight _defaultFontWeight = FontWeight.normal;

  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textColor = brightness == Brightness.dark
        ? AppPalette.darkTextPrimary
        : AppPalette.lightTextPrimary;

    return TextTheme(
      displayLarge: _textStyle(
        fontSize: 57,
        height: 1.15,
        color: textColor,
      ),
      displayMedium: _textStyle(
        fontSize: 45,
        height: 1.15,
        color: textColor,
      ),
      displaySmall: _textStyle(
        fontSize: 36,
        height: 1.25,
        color: textColor,
      ),
      headlineLarge: _textStyle(
        fontSize: 32,
        height: 1.25,
        color: textColor,
      ),
      headlineMedium: _textStyle(
        fontSize: 28,
        height: 1.30,
        color: textColor,
      ),
      headlineSmall: _textStyle(
        fontSize: 24,
        height: 1.33,
        color: textColor,
      ),
      titleLarge: _textStyle(
        fontSize: 22,
        height: 1.30,
        color: textColor,
      ),
      titleMedium: _textStyle(
        fontSize: 16,
        height: 1.50,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: _textStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelLarge: _textStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: _textStyle(
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: _textStyle(
        fontSize: 11,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: _textStyle(
        fontSize: 16,
        height: 1.50,
        color: textColor,
      ),
      bodyMedium: _textStyle(
        fontSize: 14,
        height: 1.45,
        color: textColor,
      ),
      bodySmall: _textStyle(
        fontSize: 12,
        height: 1.33,
        color: textColor,
      ),
    );
  }

  static TextTheme lightTextTheme = _buildTextTheme(Brightness.light);
  static TextTheme darkTextTheme = _buildTextTheme(Brightness.dark);

  static TextStyle _textStyle({
    required double fontSize,
    required double height,
    required Color color,
    FontWeight fontWeight = _defaultFontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
    );
  }
}
