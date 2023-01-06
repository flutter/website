import 'package:flutter/material.dart';

// #docregion AppLocalizationsImport
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// #enddocregion AppLocalizationsImport

// #docregion LocalizationDelegatesImport
import 'package:flutter_localizations/flutter_localizations.dart';
// #enddocregion LocalizationDelegatesImport

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
// #docregion MaterialApp
    return const MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English, no country code
        Locale('es'), // Spanish, no country code
      ],
      home: MyHomePage(),
    );
// #enddocregion MaterialApp
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
      // #docregion InternationalizedTitle
      appBar: AppBar(
        // The [AppBar] title text should update its message
        // according to the system locale of the target platform.
        // Switching between English and Spanish locales should
        // cause this text to update.
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      // #enddocregion InternationalizedTitle
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
                builder: (BuildContext context) {
                  // #docregion Placeholder
                  // Examples of internationalized strings.
                  return Column(
                    children: <Widget>[
                      // Returns 'Hello John'
                      Text(AppLocalizations.of(context).hello('John')),
                      // Returns 'no wombats'
                      Text(AppLocalizations.of(context).nWombats(0)),
                      // Returns '1 wombat'
                      Text(AppLocalizations.of(context).nWombats(1)),
                      // Returns '5 wombats'
                      Text(AppLocalizations.of(context).nWombats(5)),
                      // Returns 'he'
                      Text(AppLocalizations.of(context).pronoun('male')),
                      // Returns 'she'
                      Text(AppLocalizations.of(context).pronoun('female')),
                      // Returns 'they'
                      Text(AppLocalizations.of(context).pronoun('other')),
                    ],
                  ),
                  // #enddocregion Placeholder
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
