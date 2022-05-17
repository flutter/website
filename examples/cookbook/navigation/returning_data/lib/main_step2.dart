import 'package:flutter/material.dart';
// ignore_for_file: unused_local_variable

void main() {
  runApp(
    const MaterialApp(
      title: 'Returning Data',
      home: HomeScreen(),
    ),
  );
}

// #docregion HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returning Data Demo'),
      ),
      // Create the SelectionButton widget in the next step.
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}
// #enddocregion HomeScreen

// #docregion SelectionButton
class SelectionButton extends StatelessWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );
  }
}
// #enddocregion SelectionButton

// #docregion SelectionScreen
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              // #docregion Yep
              child: ElevatedButton(
                onPressed: () {
                  // Pop here with "Yep"...
                },
                child: const Text('Yep!'),
              ),
              // #enddocregion Yep
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // #docregion Nope
              child: ElevatedButton(
                onPressed: () {
                  // Pop here with "Nope"...
                },
                child: const Text('Nope.'),
              ),
              // #enddocregion Nope
            )
          ],
        ),
      ),
    );
  }
}
// #enddocregion SelectionScreen
