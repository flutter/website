import 'package:flutter/material.dart';

// #docregion Ephemeral
class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: (newIndex) {
        setState(() {
          _index = newIndex;
        });
      },
      // #enddocregion Ephemeral
      items: [
        BottomNavigationBarItem(title: Text('abc'), icon: Icon(Icons.title)),
        BottomNavigationBarItem(title: Text('def'), icon: Icon(Icons.map)),
      ],
      // #docregion Ephemeral
    );
  }
}
// #enddocregion Ephemeral
