import 'package:flutter/material.dart';
import 'package:state_mgmt/src/set_state.dart' as set_state;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Code Excerpts',
      home: Material(
        child: SafeArea(
          child: PageView(
            children: [
              set_state.MyHomepage(),
            ],
          ),
        ),
      ),
    );
  }
}
