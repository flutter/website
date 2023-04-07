import 'package:flutter/material.dart';
// #docregion Localization
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
// #enddocregion Localization

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion AccessString
    return const Text(Strings.welcomeMessage);
    // #enddocregion AccessString
  }
}

// #docregion StringsClass
class Strings {
  static const String welcomeMessage = 'Welcome To Flutter';
}
// #enddocregion StringsClass

class CustomFontExample extends StatelessWidget {
  const CustomFontExample({super.key});

  // #docregion CustomFont
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: const Center(
        child: Text(
          'This is a custom font text',
          style: TextStyle(fontFamily: 'MyCustomFont'),
        ),
      ),
    );
  }
  // #enddocregion CustomFont
}
