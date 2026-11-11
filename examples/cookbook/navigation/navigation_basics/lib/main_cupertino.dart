// DartPad doesn't support `cupertino_ui` yet,
// so this example imports Cupertino from the Flutter SDK.
// To run locally, depend on `cupertino_ui` and use this import instead:
// import 'package:cupertino_ui/cupertino_ui.dart';
// ignore: deprecated_member_use until DartPad supports cupertino_ui.
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CupertinoApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                builder: (context) => const SecondRoute(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
