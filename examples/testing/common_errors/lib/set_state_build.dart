import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  // #docregion problem
  Widget build(BuildContext context) {
    // Don't do this.
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(title: Text('Alert Dialog'));
      },
    );

    return const Center(
      child: Column(children: <Widget>[Text('Show Material Dialog')]),
    );
  }

  // #enddocregion problem
}

// #docregion solution
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
            // Immediately show a dialog upon loading the second screen.
            Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) => const MyDialog(),
              ),
            );
          },
        ),
      ),
    );
  }
}
// #enddocregion solution

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(title: Text('Alert Dialog'));
  }
}
