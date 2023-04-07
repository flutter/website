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
            // #docregion FirstRouteOnPressed
            // Within the `FirstRoute` widget
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            }
            // #enddocregion FirstRouteOnPressed
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
          // #docregion SecondRouteOnPressed
          // Within the SecondRoute widget
          onPressed: () {
            Navigator.pop(context);
          }
          // #enddocregion SecondRouteOnPressed
          ,
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
