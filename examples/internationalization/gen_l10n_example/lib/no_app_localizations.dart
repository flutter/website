import 'package:material_ui/material_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion material-app
    return const MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      home: MyHomePage(),
    );
    // #enddocregion material-app
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Localization example')),
      body: Center(
        child: Text(MaterialLocalizations.of(context).okButtonLabel),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
