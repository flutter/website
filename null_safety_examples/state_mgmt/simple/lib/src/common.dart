import 'package:flutter/material.dart';

class SomeWidget extends StatelessWidget {
  final Widget child;

  SomeWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
