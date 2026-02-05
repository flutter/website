import 'package:flutter/cupertino.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          // #docregion first-route-on-pressed
          // Within the `FirstRoute` widget:
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                builder: (context) => const SecondRoute(),
              ),
            );
          },
          // #enddocregion first-route-on-pressed
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
          // #docregion second-route-on-pressed
          // Within the SecondRoute widget
          onPressed: () {
            Navigator.pop(context);
          },
          // #enddocregion second-route-on-pressed
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
