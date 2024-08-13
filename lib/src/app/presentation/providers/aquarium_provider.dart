// External packages
import 'package:flutter/material.dart';

class AquariumProvider extends ChangeNotifier {
  final _temperature = ValueNotifier<int>(24);

  ValueNotifier<int> get temperature => _temperature;

  Future<void> changeTemperature(int value) async {
    _temperature.value = value;
    notifyListeners();
  }
}
