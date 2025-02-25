import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'nn_intl.dart';

void main() {
  runApp(
    // #docregion material-app
    const MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        NnMaterialLocalizations.delegate, // Add the newly created delegate
      ],
      supportedLocales: [Locale('en', 'US'), Locale('nn')],
      home: Home(),
    ),
    // #enddocregion material-app
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('nn'),
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListTile(
            leading: const Icon(Icons.change_history),
            title: const Text('Change history'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Text(
              'Long press hamburger icon in the app bar (aka the drawer menu)'
              'to see a localized tooltip for the `nn` locale. ',
            ),
          ),
        ),
      ),
    );
  }
}
