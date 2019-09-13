// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'dart:html';
import 'package:dartpad_picker/dartpad_picker.dart';

void main() {
  if (isMobile()) {
    querySelector('.dash-dartpad').style.display = 'none';
    return;
  }

  var dartPadHost = querySelector('#dartpad-host');
  var select = querySelector('#dartpad-select');

  var snippets = [
    Snippet('Counter', counter),
    Snippet('Square', square),
    Snippet('Todos', todos),
  ];

  DartPadPicker(dartPadHost, select, snippets);
}

// Mobile browser detection

final RegExp _mobileRegex =
    RegExp(r'Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini');
bool isMobile() {
  return _mobileRegex.hasMatch(window.navigator.userAgent);
}

// Snippets

var counter = r'''
import 'package:flutter_web/material.dart';
import 'package:flutter_web_test/flutter_web_test.dart';
import 'package:flutter_web_ui/ui.dart' as ui;

class Counter extends StatefulWidget {
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  double val;

  void initState() {
    super.initState();
    val = 0;
  }

  void change() {
    setState(() {
      val += 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('$val'))),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => change(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          child: Counter(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  runApp(MyApp());
}

'''
    .trim();
var square = r'''
import 'package:flutter_web/material.dart';
import 'package:flutter_web_ui/ui.dart' as ui;

class SpinningSquare extends StatefulWidget {
  @override
  _SpinningSquareState createState() => _SpinningSquareState();
}

class _SpinningSquareState extends State<SpinningSquare>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    // We use 3600 milliseconds instead of 1800 milliseconds because 0.0 -> 1.0
    // represents an entire turn of the square whereas in the other examples
    // we used 0.0 -> math.pi, which is only half a turn.
    _animation = AnimationController(
      duration: const Duration(milliseconds: 3600),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Container(
        width: 150.0,
        height: 150.0,
        color: const Color(0xFF00FF00),
      ),
    );
  }


  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

void main() async {
  await ui.webOnlyInitializePlatform();
  runApp(Center(child: SpinningSquare()));
}

'''
    .trim();

var todos = r'''
// import 'package:flutter_web/widgets.dart';
import 'package:flutter_web_ui/ui.dart' as ui;
import 'package:flutter_web/material.dart';

class IconTodo extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String labelText;

  IconTodo(this.icon, this.hintText, this.labelText);

  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      margin: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: false,
        decoration: InputDecoration(
            icon: Icon(icon),
            border: OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText),
      ),
    );
  }
}

class ThreeThings extends StatelessWidget {
  final myIcons = <String, IconData>{
    'accessibility': Icons.accessibility_new,
    'phone': Icons.perm_phone_msg,
    'sun': Icons.brightness_low,
  };

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      IconTodo(myIcons['accessibility'], 'Schedule exercise', '1'),
      IconTodo(myIcons['phone'], 'Pick a friend to call', '2'),
      IconTodo(myIcons['sun'], 'Do something outside', '3'),
    ]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hi',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todos For My Health'),
        ),
        body: Container(
          child: ThreeThings(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  runApp(MyApp());
}

'''
    .trim();
