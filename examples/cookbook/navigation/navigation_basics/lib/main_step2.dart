import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          // #docregion first-route-on-pressed
          // Within the `FirstRoute` widget:
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
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
