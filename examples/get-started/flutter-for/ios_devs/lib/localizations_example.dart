import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        // Add app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale('en', 'US'), // English
        Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
    );
  }
}
