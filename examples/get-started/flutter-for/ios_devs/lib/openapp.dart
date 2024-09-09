import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

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
      theme: CupertinoThemeData(brightness: Brightness.dark),
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
      child: SafeArea(
        child: Center(
          // #docregion open-app-example
          child: CupertinoButton(
            onPressed: () async {
              await launchUrl(
                Uri.parse('https://google.com'),
              );
            },
            child: const Text(
              'Open website',
            ),
          ),
          // #enddocregion open-app-example
        ),
      ),
    );
  }
}
