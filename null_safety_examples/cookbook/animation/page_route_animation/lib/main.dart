import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Page1(),
    ),
  );
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Text('Go!'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    // #docregion transitionsBuilder
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // #docregion Tween
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      // #enddocregion Tween

      // #docregion SlideTransition
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
      // #enddocregion SlideTransition
    },
    // #enddocregion transitionsBuilder
  );
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
