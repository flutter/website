import 'package:flutter/material.dart';

class SetupFlow extends StatefulWidget {
  const SetupFlow({super.key, required this.setupPageRoute});

  final String setupPageRoute;

  @override
  State<SetupFlow> createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  // #docregion SetupFlow2
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildFlowAppBar(), body: const SizedBox());
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(title: const Text('Bulb Setup'));
  }

  // #enddocregion SetupFlow2
}
