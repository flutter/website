import 'package:flutter/material.dart';

// #docregion SetupFlow
class SetupFlow extends StatefulWidget {
  const SetupFlow({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

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
