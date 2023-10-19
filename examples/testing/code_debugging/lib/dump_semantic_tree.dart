import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Semantics(
          button: true,
          enabled: true,
          label: 'Clickable text here!',
          child: GestureDetector(
              onTap: () {
                debugDumpSemanticsTree();
                print('Clicked!');
              },
              child: Text('Click Me!', style: TextStyle(fontSize: 56))),
        ),
      ),
    );
  }
}
