import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation basics',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // #docregion push-route
          child: const Text('Open second screen'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
          // #enddocregion push-route
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Pop current screen'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
