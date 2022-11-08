import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});	      
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double turns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
// #docregion AnimatedButton
        AnimatedRotation(
          duration: const Duration(seconds:1),
  turns: turns,
  curve: Curves.easeIn,
  child: TextButton(
   onPressed: () {
     setState(() {
       turns += .125;
     });
  }, child: Text('Tap me!')),
  )
  // #enddocregion AnimatedButton
      ),
      ),
    );
  }
}
