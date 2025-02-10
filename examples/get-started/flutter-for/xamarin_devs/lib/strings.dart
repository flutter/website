import 'package:flutter/material.dart';
// #docregion localization
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
// #enddocregion localization

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion access-string
    return const Text(Strings.welcomeMessage);
    // #enddocregion access-string
  }
}

// #docregion strings-class
class Strings {
  static const String welcomeMessage = 'Welcome To Flutter';
}
// #enddocregion strings-class

class CustomFontExample extends StatelessWidget {
  const CustomFontExample({super.key});

  // #docregion custom-font
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

  // #enddocregion custom-font
}
