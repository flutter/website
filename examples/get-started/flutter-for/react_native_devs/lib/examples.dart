// ignore_for_file: avoid_print

import 'dart:convert';
// #docregion import-dart-io
import 'dart:io';
// #enddocregion import-dart-io

// #docregion package-import
import 'package:flutter/material.dart';
// #enddocregion package-import
// #docregion shared-prefs
import 'package:shared_preferences/shared_preferences.dart';
// #enddocregion shared-prefs

// #docregion main
// Dart
void main() {
  print('Hello, this is the main function.');
}
// #enddocregion main

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion image-asset
    return Image.asset('assets/background.png');
    // #enddocregion image-asset
  }
}

class NetworkImage extends StatelessWidget {
  const NetworkImage({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion image-network
    return Image.network('https://docs.flutter.dev/assets/images/docs/owl.jpg');
    // #enddocregion image-network
  }
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion list-view
    var data = ['Hello', 'World'];
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Text(data[index]);
      },
    );
    // #enddocregion list-view
  }
}

// #docregion custom-paint
class MyCanvasPainter extends CustomPainter {
  const MyCanvasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.amber;
    canvas.drawCircle(const Offset(100, 200), 40, paint);
    final Paint paintRect = Paint()..color = Colors.lightBlue;
    final Rect rect = Rect.fromPoints(
      const Offset(150, 300),
      const Offset(300, 400),
    );
    canvas.drawRect(rect, paintRect);
  }

  @override
  bool shouldRepaint(MyCanvasPainter oldDelegate) => false;
}

class MyCanvasWidget extends StatelessWidget {
  const MyCanvasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CustomPaint(painter: MyCanvasPainter()));
  }
}
// #enddocregion custom-paint

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion text-style
    const TextStyle textStyle = TextStyle(
      color: Colors.cyan,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    );

    return const Center(
      child: Column(
        children: <Widget>[
          Text('Sample text', style: textStyle),
          Padding(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.lightbulb_outline,
              size: 48,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
    // #enddocregion text-style
  }
}

class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion icon
    return const Icon(Icons.lightbulb_outline, color: Colors.redAccent);
    // #enddocregion icon
  }
}

// #docregion swatch
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: const SampleAppPage(),
    );
  }
}
// #enddocregion swatch

class ThemeExample extends StatelessWidget {
  const ThemeExample({super.key});

  // #docregion theme
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.cyan, brightness: Brightness.dark),
      home: const StylingPage(),
    );
  }

  // #enddocregion theme
}

class StylingPage extends StatelessWidget {
  const StylingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class SampleAppPage extends StatelessWidget {
  const SampleAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class ThemeDataExample extends StatelessWidget {
  const ThemeDataExample({super.key, required this.brightness});

  final Brightness brightness;

  // #docregion theme-data
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.cyan, brightness: brightness),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        //...
      ),
    );
  }

  // #enddocregion theme-data
}

class SharedPrefsExample extends StatefulWidget {
  const SharedPrefsExample({super.key});

  @override
  State<SharedPrefsExample> createState() => _SharedPrefsExampleState();
}

class _SharedPrefsExampleState extends State<SharedPrefsExample> {
  int? _counter;

  // #docregion shared-prefs-update
  Future<void> updateCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int? counter = prefs.getInt('counter');
    if (counter is int) {
      await prefs.setInt('counter', ++counter);
    }
    setState(() {
      _counter = counter;
    });
  }
  // #enddocregion shared-prefs-update

  @override
  Widget build(BuildContext context) {
    return Text(_counter.toString());
  }
}

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  // #docregion drawer
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: ListTile(
        leading: const Icon(Icons.change_history),
        title: const Text('Screen2'),
        onTap: () {
          Navigator.of(context).pushNamed('/b');
        },
      ),
    );
  }

  // #enddocregion drawer
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  // #docregion scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 20,
        child: ListTile(
          leading: const Icon(Icons.change_history),
          title: const Text('Screen2'),
          onTap: () {
            Navigator.of(context).pushNamed('/b');
          },
        ),
      ),
      appBar: AppBar(title: const Text('Home')),
      body: Container(),
    );
  }

  // #enddocregion scaffold
}

class GestureDetectorExample extends StatelessWidget {
  const GestureDetectorExample({super.key});

  // #docregion gesture-detector
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(title: const Text('Gestures')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tap, Long Press, Swipe Horizontally or Vertically'),
            ],
          ),
        ),
      ),
      onTap: () {
        print('Tapped');
      },
      onLongPress: () {
        print('Long Pressed');
      },
      onVerticalDragEnd: (value) {
        print('Swiped Vertically');
      },
      onHorizontalDragEnd: (value) {
        print('Swiped Horizontally');
      },
    );
  }

  // #enddocregion gesture-detector
}

class HttpExample extends StatefulWidget {
  const HttpExample({super.key});

  @override
  State<HttpExample> createState() => _HttpExampleState();
}

class _HttpExampleState extends State<HttpExample> {
  String _ipAddress = '';
  // #docregion http
  final url = Uri.parse('https://httpbin.org/ip');
  final httpClient = HttpClient();

  Future<void> getIPAddress() async {
    final request = await httpClient.getUrl(url);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    final ip = jsonDecode(responseBody)['origin'] as String;
    setState(() {
      _ipAddress = ip;
    });
  }
  // #enddocregion http

  @override
  Widget build(BuildContext context) {
    return Text(_ipAddress);
  }
}

class TextEditingExample extends StatefulWidget {
  const TextEditingExample({super.key});

  @override
  State<TextEditingExample> createState() => _TextEditingExampleState();
}

class _TextEditingExampleState extends State<TextEditingExample> {
  // #docregion text-editing-controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Type something',
            labelText: 'Text Field',
          ),
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: Text('You typed ${_controller.text}'),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // #enddocregion text-editing-controller
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final formKey = GlobalKey<FormState>();
  String? _email = '';
  final String _password = '';

  // #docregion form-submit
  void _submit() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: Text('Email: $_email, password: $_password'),
          );
        },
      );
    }
  }
  // #enddocregion form-submit

  // #docregion form-state
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value != null && value.contains('@')) {
                return null;
              }
              return 'Not a valid email.';
            },
            onSaved: (val) {
              _email = val;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
          ),
          ElevatedButton(onPressed: _submit, child: const Text('Login')),
        ],
      ),
    );
  }

  // #enddocregion form-state
}

class PlatformExample extends StatelessWidget {
  const PlatformExample({super.key});

  String whichPlatform(BuildContext context) {
    // #docregion platform
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return 'iOS';
    }
    if (platform == TargetPlatform.android) {
      return 'android';
    }
    if (platform == TargetPlatform.fuchsia) {
      return 'fuchsia';
    }
    return 'not recognized ';
    // #enddocregion platform
  }

  @override
  Widget build(BuildContext context) {
    return Text(whichPlatform(context));
  }
}

class DismissibleWidgets extends StatefulWidget {
  const DismissibleWidgets({super.key});

  @override
  State<DismissibleWidgets> createState() => _DismissibleWidgetsState();
}

class _DismissibleWidgetsState extends State<DismissibleWidgets> {
  final List<Card> cards = [
    const Card(child: Text('Hello!')),
    const Card(child: Text('World!')),
  ];

  @override
  Widget build(BuildContext context) {
    // #docregion dismissible
    return Dismissible(
      key: Key(widget.key.toString()),
      onDismissed: (dismissDirection) {
        cards.removeLast();
      },
      child: Container(
        //...
      ),
    );
    // #enddocregion dismissible
  }
}
