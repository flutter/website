import 'package:flutter/material.dart';

// #docregion SetupFlow
class SetupFlow extends StatefulWidget {
  const SetupFlow({super.key, required this.setupPageRoute});

  final String setupPageRoute;

  @override
  State<SetupFlow> createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

// #enddocregion SetupFlow
