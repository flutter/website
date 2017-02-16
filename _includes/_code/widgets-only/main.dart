import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('Hello World', style: new TextStyle(fontSize: 30.0)),
    );
  }
}
