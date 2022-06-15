import 'package:flutter/material.dart';

// #docregion ExpandableFab
@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  ExpandableFabState createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
// #enddocregion ExpandableFab
