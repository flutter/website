// box.dart
import 'package:flutter/material.dart';

/// A simple blue 30x30 box.
class DeferredBox extends StatelessWidget {
  const DeferredBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
  }
}
