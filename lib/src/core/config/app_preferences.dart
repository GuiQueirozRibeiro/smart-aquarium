import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_aquarium/src/core/config/app_config.dart';
import 'package:smart_aquarium/src/core/enums/app_theme_mode.dart';

class AppPreferences {
  late AppThemeMode themeMode;
  late Locale locale;

  AppPreferences._(this.themeMode, this.locale);

  AppPreferences.initial({
    AppThemeMode mode = AppThemeMode.light,
    Locale locale = const Locale('en'),
  }) : this._(mode, locale);

  void reset() {
    themeMode = AppThemeMode.system;
    locale = PlatformDispatcher.instance.locale;
  }

  AppPreferences.fromJson(Map<String, dynamic> json) {
    List<String> localeParts = json['locale'].split('_');
    if (localeParts.length == 2) {
      locale = Locale(localeParts[0], localeParts[1]);
    } else {
      locale = PlatformDispatcher.instance.locale;
    }
    themeMode =
        AppThemeMode.values[json['theme_mode'] ?? AppThemeMode.light.index];
  }

  Map<String, dynamic> toJson() => {
        'theme_mode': themeMode.index,
        'locale': locale.toString(),
      };

  Future<bool> save() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AppConfig.prefKey, json.encode(toJson()));
  }

  static Future<AppPreferences?> fromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeDataString = prefs.getString(AppConfig.prefKey);
      if (themeDataString == null || themeDataString.isEmpty) return null;
      return AppPreferences.fromJson(json.decode(themeDataString));
    } on Exception catch (error, stacktrace) {
      if (kDebugMode) {
        print(error);
        print(stacktrace);
      }
      return null;
    }
  }
}
