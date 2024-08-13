import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:smart_aquarium/src/app/presentation/providers/aquarium_provider.dart';
import 'package:smart_aquarium/src/app/presentation/widgets/circular_slider.dart';
import 'package:smart_aquarium/src/core/utils/dialog_mixin.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  static route() => MaterialPageRoute(builder: (_) => const TemperaturePage());

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> with DialogMixin {
  double _currentTemperature = 24.0;

  Future<void> changeTemperature() async {
    final aquariumProvider = Provider.of<AquariumProvider>(
      context,
      listen: false,
    );
    showLoadingIndicator();
    try {
      await aquariumProvider.changeTemperature(_currentTemperature.toInt());
      showSuccessMessage('send_success'.i18n());
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adjust_temperature".i18n()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Hero(
              tag: 'temperature',
              child: CircularSlider(
                initialValue:
                    Provider.of<AquariumProvider>(context, listen: false)
                        .temperature
                        .value
                        .toDouble(),
                onChanged: (value) => setState(
                  () => _currentTemperature = value,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: changeTemperature,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: theme.textTheme.titleLarge?.copyWith(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              child: Text('change_temperature'.i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
