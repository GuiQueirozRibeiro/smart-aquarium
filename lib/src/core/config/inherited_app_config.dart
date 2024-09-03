import 'package:flutter/material.dart';
import 'package:smart_refrigerator/src/core/config/app_manager.dart';
import 'package:smart_refrigerator/src/core/enums/app_theme_mode.dart';

/// An inherited widget that saves provides current mode, theme, dark theme and
/// brightness to its children.
/// This is an internal widget and should not be used directly.
class InheritedAppConfig<T extends Object> extends InheritedWidget {
  final T theme;
  final T darkTheme;
  final AppThemeMode themeMode;
  final Locale locale;

  InheritedAppConfig({
    super.key,
    required AppManager<T> manager,
    required super.child,
  })  : themeMode = manager.mode,
        theme = manager.theme,
        darkTheme = manager.darkTheme,
        locale = manager.locale;

  @override
  bool updateShouldNotify(covariant InheritedAppConfig<T> oldWidget) {
    return oldWidget.themeMode != themeMode ||
        oldWidget.theme != theme ||
        oldWidget.darkTheme != darkTheme ||
        oldWidget.locale != locale;
  }
}
