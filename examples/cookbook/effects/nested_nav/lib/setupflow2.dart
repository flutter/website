import 'package:flutter/material.dart';

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
  // #docregion SetupFlow2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildFlowAppBar(),
      body: const SizedBox(),
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      title: const Text('Bulb Setup'),
    );
  }
  // #enddocregion SetupFlow2
}
