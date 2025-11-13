import 'package:flutter/material.dart';

// #docregion localization-delegates-import
import 'package:flutter_localizations/flutter_localizations.dart';
// #enddocregion localization-delegates-import

// #docregion app-localizations-import
import 'l10n/app_localizations.dart';
// #enddocregion app-localizations-import

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion material-app
    return const MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      home: MyHomePage(),
    );
    // #enddocregion material-app
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #docregion internationalized-title
      appBar: AppBar(
        // The [AppBar] title text should update its message
        // according to the system locale of the target platform.
        // Switching between English and Spanish locales should
        // cause this text to update.
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      // #enddocregion internationalized-title
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add the following code
            Localizations.override(
              context: context,
              locale: const Locale('en'),
              // Using a Builder here to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (context) {
                  // #docregion placeholder
                  // Examples of internationalized strings.
                  return Column(
                    children: <Widget>[
                      // Returns 'Hello John'
                      Text(AppLocalizations.of(context)!.hello('John')),
                      // Returns 'no wombats'
                      Text(AppLocalizations.of(context)!.nWombats(0)),
                      // Returns '1 wombat'
                      Text(AppLocalizations.of(context)!.nWombats(1)),
                      // Returns '5 wombats'
                      Text(AppLocalizations.of(context)!.nWombats(5)),
                      // Returns 'he'
                      Text(AppLocalizations.of(context)!.pronoun('male')),
                      // Returns 'she'
                      Text(AppLocalizations.of(context)!.pronoun('female')),
                      // Returns 'they'
                      Text(AppLocalizations.of(context)!.pronoun('other')),
                    ],
                  );
                  // #enddocregion placeholder
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
