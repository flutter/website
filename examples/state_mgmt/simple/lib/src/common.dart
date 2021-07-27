import 'package:flutter/material.dart';

class SomeWidget extends StatelessWidget {
  const SomeWidget(this.child, {Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
