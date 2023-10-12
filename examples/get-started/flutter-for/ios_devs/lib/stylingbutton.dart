import 'package:flutter/cupertino.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          middle:
              // #docregion CustomFont
              Text(
        'Cupertino',
        style: TextStyle(
          fontSize: 40,
          fontFamily: 'BungeeSpice',
        ),
      )
          // #enddocregion CustomFont
          ),
      child: Center(
        // #docregion StylingButtonExample
        child: CupertinoButton(
          color: CupertinoColors.systemYellow,
          onPressed: () {},
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Do something',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // #enddocregion StylingButtonExample
      ),
    );
  }
}
