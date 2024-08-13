// External packages
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_aquarium/src/core/config/app_manager.dart';
import 'package:smart_aquarium/src/core/config/app_preferences.dart';
import 'package:smart_aquarium/src/core/config/inherited_app_config.dart';
import 'package:smart_aquarium/src/core/enums/app_theme_mode.dart';
import 'package:smart_aquarium/src/core/theme/app_theme.dart';

// Core module imports

typedef AppConfigBuilder = Widget Function(
  ThemeData light,
  ThemeData dark,
  Locale locale,
);

class AppConfig extends StatefulWidget {
  final AppConfigBuilder builder;
  static const String prefKey = 'core_preferences';

  const AppConfig({
    super.key,
    required this.builder,
  });

  @override
  State<AppConfig> createState() => _AppConfigState();

  static AppThemeMode? _themeMode;
  static Locale? _locale;

  static AppThemeMode? get themeMode => _themeMode;
  static Locale? get locale => _locale;

  static AppManager<ThemeData> of(BuildContext context) {
    context
        .dependOnInheritedWidgetOfExactType<InheritedAppConfig<ThemeData>>()!;
    return context.findAncestorStateOfType<State<AppConfig>>()!
        as AppManager<ThemeData>;
  }

  static AppManager<ThemeData>? maybeOf(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<InheritedAppConfig<ThemeData>>();
    final state = context.findAncestorStateOfType<State<AppConfig>>();
    if (state == null) return null;
    return state as AppManager<ThemeData>;
  }

  static Future<void> initialize() async {
    final prefs = await AppPreferences.fromPrefs();
    _themeMode = prefs?.themeMode ?? AppThemeMode.system;
    _locale = prefs?.locale ?? PlatformDispatcher.instance.locale;
  }
}

class _AppConfigState extends State<AppConfig>
    with WidgetsBindingObserver, AppManager<ThemeData> {
  @override
  void initState() {
    super.initState();
    initialize(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initialThemeMode: AppConfig.themeMode!,
      initialLocale: AppConfig.locale!,
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (mode.isSystem && mounted) setState(() {});
  }

  @override
  Future<bool> reset() async {
    setTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      notify: false,
    );
    return super.reset();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedAppConfig<ThemeData>(
      manager: this,
      child: Builder(
        builder: (_) => widget.builder(
          theme,
          mode.isLight ? theme : darkTheme,
          locale,
        ),
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    modeChangeNotifier.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
