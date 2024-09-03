// External packages
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RefrigeratorProvider extends ChangeNotifier {
  final _temperature = ValueNotifier<int>(24);

  ValueNotifier<int> get temperature => _temperature;

  final ref = FirebaseDatabase.instance.ref();

  Future<void> changeTemperature(int value) async {
    _temperature.value = value;
    notifyListeners();

    await ref.child("values/desired_temperature").set(value);
  }
}
