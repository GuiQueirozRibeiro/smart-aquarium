import 'package:flutter/material.dart';
import 'package:smart_aquarium/src/core/config/app_preferences.dart';
import 'package:smart_aquarium/src/core/enums/app_theme_mode.dart';

mixin AppManager<T extends Object> {
  late T _theme;
  late T _darkTheme;
  late Locale _locale;

  late AppPreferences _preferences;
  late ValueNotifier<AppThemeMode> _modeChangeNotifier;

  T get theme {
    if (_preferences.themeMode.isSystem) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.light ? _theme : _darkTheme;
    }
    return _preferences.themeMode.isDark ? _darkTheme : _theme;
  }

  T get lightTheme => _theme;
  T get darkTheme => _darkTheme;
  Locale get locale => _locale;

  AppThemeMode get mode => _preferences.themeMode;

  ValueNotifier<AppThemeMode> get modeChangeNotifier => _modeChangeNotifier;

  void initialize({
    required T light,
    required T dark,
    required AppThemeMode initialThemeMode,
    required Locale initialLocale,
  }) {
    _theme = light;
    _darkTheme = dark;
    _locale = initialLocale;
    _modeChangeNotifier = ValueNotifier(initialThemeMode);
    _preferences = AppPreferences.initial(
      mode: initialThemeMode,
      locale: initialLocale,
    );

    AppPreferences.fromPrefs().then((pref) {
      if (pref == null) {
        _preferences.save();
      } else {
        _preferences = pref;
        _locale = pref.locale;
        updateState();
      }
    });
  }

  void setLight() => setThemeMode(AppThemeMode.light);
  void setDark() => setThemeMode(AppThemeMode.dark);
  void setSystem() => setThemeMode(AppThemeMode.system);

  void setThemeMode(AppThemeMode mode) {
    _preferences.themeMode = mode;
    updateState();
    _modeChangeNotifier.value = mode;
    _preferences.save();
  }

  void setTheme({
    required T light,
    T? dark,
    bool notify = true,
  }) {
    _theme = light;
    if (dark != null) _darkTheme = dark;
    if (notify) updateState();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _preferences.locale = locale;
    _preferences.save();
    updateState();
  }

  void toggleThemeMode({bool useSystem = true}) {
    AppThemeMode nextMode = mode.next();
    if (!useSystem && nextMode.isSystem) {
      nextMode = nextMode.next();
    }
    setThemeMode(nextMode);
  }

  Future<bool> persist() async => _preferences.save();

  @mustCallSuper
  Future<bool> reset() async {
    _preferences.reset();
    _locale = _preferences.locale;
    updateState();
    modeChangeNotifier.value = mode;
    return _preferences.save();
  }

  void updateState();
}
