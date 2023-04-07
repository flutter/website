import 'package:flutter/material.dart';

// #docregion SetupFlow
class SetupFlow extends StatefulWidget {
  const SetupFlow({
    super.key,
    required this.setupPageRoute,
  });

  final String setupPageRoute;

  @override
  SetupFlowState createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
// #enddocregion SetupFlow
