import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:smart_refrigerator/src/app/presentation/pages/dashboard_page.dart';
import 'package:smart_refrigerator/src/app/presentation/providers/refrigerator_provider.dart';
import 'package:smart_refrigerator/src/core/theme/app_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RefrigeratorProvider refrigeratorProvider = Provider.of(context);
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
            Gif(
              image: const AssetImage('lib/assets/animations/refrigerator.gif'),
              controller: gifController,
              autostart: Autostart.loop,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(context, DashboardPage.route()),
              child: Hero(
                tag: 'temperature',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: ValueListenableBuilder(
                    valueListenable: refrigeratorProvider.temperature,
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
