import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_aquarium/src/app/presentation/pages/temperature_page.dart';
import 'package:smart_aquarium/src/app/presentation/providers/aquarium_provider.dart';
import 'package:smart_aquarium/src/core/theme/app_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AquariumProvider aquariumProvider = Provider.of(context);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [AppPalette.darkGradientStart, AppPalette.darkGradientEnd]
                : [AppPalette.lightGradientStart, AppPalette.lightGradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "title".i18n(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Lottie.asset(
              "lib/assets/animations/aquarium.json",
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(context, TemperaturePage.route()),
              child: Hero(
                tag: 'temperature',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: ValueListenableBuilder(
                    valueListenable: aquariumProvider.temperature,
                    builder: (context, value, _) {
                      return Text(
                        '$value°C',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontFamily: 'Poppins',
                                  color: Theme.of(context).primaryColor,
                                ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
