import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:smart_refrigerator/src/app_widget.dart';
import 'package:smart_refrigerator/src/core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppConfig.initialize();
  // await Future.wait([
  //   AppConfig.initialize(),
  //   Firebase.initializeApp(),
  // ]);

  runApp(const AppWidget());
}
