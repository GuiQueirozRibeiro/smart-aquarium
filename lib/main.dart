import 'package:flutter/material.dart';
import 'package:smart_aquarium/src/app_widget.dart';
import 'package:smart_aquarium/src/core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();

  runApp(const AppWidget());
}
