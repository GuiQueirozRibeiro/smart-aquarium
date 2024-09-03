import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:smart_refrigerator/src/app/presentation/pages/home_page.dart';
import 'package:smart_refrigerator/src/app/presentation/providers/refrigerator_provider.dart';
import 'package:smart_refrigerator/src/core/config/app_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/assets/i18n'];

    return AppConfig(builder: (theme, darkTheme, locale) {
      return ChangeNotifierProvider(
        create: (context) => RefrigeratorProvider(),
        child: MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          locale: locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            LocalJsonLocalization.delegate
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'ES'),
            Locale('pt', 'BR'),
          ],
          home: const HomePage(),
        ),
      );
    });
  }
}
