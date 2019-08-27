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
    // Snippet('Strings', strings),
    // Snippet('Collection literals', collectionLiterals),
    // Snippet('Classes', classes),
    // Snippet('Compute Pi', piMonteCarlo),
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
  _SpinningSquareState createState() => new _SpinningSquareState();
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
    _animation = new AnimationController(
      duration: const Duration(milliseconds: 3600),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new RotationTransition(
        turns: _animation,
        child: new Container(
          width: 150.0,
          height: 150.0,
          color: const Color(0xFF00FF00),
        ));
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

void main() async {
  await ui.webOnlyInitializePlatform();
  runApp(new Center(child: new SpinningSquare()));
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
        ));
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

var strings = '''
main() {
  print('a single quoted string');
  print("a double quoted string");

  // Strings can be combined with the + operator.
  print("cat" + "dog");

  // Triple quotes define a multi-line string.
  print(\'''triple quoted strings
are for multiple lines\''');

  // Dart supports string interpolation.
  var pi = 3.14;
  print('pi is \$pi');
  print('tau is \${2 * pi}');
}
'''
    .trim();

var collectionLiterals = r'''
// A list literal.
var lostNumbers = [4, 8, 15, 16, 23, 42];

// A map literal.
var nobleGases = {
  'He': 'Helium',
  'Ne': 'Neon',
  'Ar': 'Argon',
};

// A set literal.
var frogs = {
  'Tree',
  'Poison dart',
  'Glass',
};

main() {
  print(lostNumbers.last);
  print(nobleGases['Ne']);
  print(frogs.difference({'Poison dart'}));
}

'''
    .trim();

var classes = r'''
// Abstract classes can't be instantiated.
abstract class Item {
  use();
}

// Classes can implement other classes.
class Chest<T> implements Item {
  List<T> contents;

  // Constructors can assign arguments to instance variables using `this`.
  Chest(this.contents);

  use() => print("$this has ${contents.length} items.");
}

class Sword implements Item {
  int damage = 5;

  use() => print("$this dealt $damage damage.");
}

// Classes can extend other classes.
class DiamondSword extends Sword {
  int damage = 50;
}

main() {
  // The 'new' keyword is optional.
  var chest = Chest<Item>([
    DiamondSword(),
    Sword(),
  ]);

  chest.use();

  for (var item in chest.contents) {
    item.use();
  }
}

'''
    .trim();

var piMonteCarlo = r'''
import 'dart:async';
import 'dart:math' show Random;

main() async {
  print('Compute π using the Monte Carlo method.');
  await for (var estimate in computePi().take(100)) {
    print('π ≅ $estimate');
  }
}

/// Generates a stream of increasingly accurate estimates of π.
Stream<double> computePi({int batch: 100000}) async* {
  var total = 0;
  var count = 0;
  while (true) {
    var points = generateRandom().take(batch);
    var inside = points.where((p) => p.isInsideUnitCircle);
    total += batch;
    count += inside.length;
    var ratio = count / total;
    // Area of a circle is A = π⋅r², therefore π = A/r².
    // So, when given random points with x ∈ <0,1>,
    // y ∈ <0,1>, the ratio of those inside a unit circle
    // should approach π / 4. Therefore, the value of π
    // should be:
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x, y;
  const Point(this.x, this.y);
  bool get isInsideUnitCircle => x * x + y * y <= 1;
}
'''
    .trim();
