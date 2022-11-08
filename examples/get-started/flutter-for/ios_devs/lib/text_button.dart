
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: 
       // #docregion textbutton
        CupertinoButton(
          onPressed: () {
            // this closure gets called when your button is tapped
          },
          child: const Text('Do something'),
        )
       // #enddocregion textbutton
      ),
    );
  }
}