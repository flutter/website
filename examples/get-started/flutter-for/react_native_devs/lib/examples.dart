// ignore_for_file: avoid_print

import 'dart:convert';
// #docregion ImportDartIO
import 'dart:io';
// #enddocregion ImportDartIO

// #docregion PackageImport
import 'package:flutter/material.dart';
// #enddocregion PackageImport
// #docregion SharedPrefs
import 'package:shared_preferences/shared_preferences.dart';
// #enddocregion SharedPrefs

// #docregion Main
// Dart
void main() {
  print('Hello, this is the main function.');
}
// #enddocregion Main

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion ImageAsset
    return Image.asset('assets/background.png');
    // #enddocregion ImageAsset
  }
}

class NetworkImage extends StatelessWidget {
  const NetworkImage({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion ImageNetwork
    return Image.network('https://docs.flutter.dev/assets/images/docs/owl.jpg');
    // #enddocregion ImageNetwork
  }
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion ListView
    var data = [
      'Hello',
      'World',
    ];
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Text(data[index]);
      },
    );
    // #enddocregion ListView
  }
}

// #docregion CustomPaint
class MyCanvasPainter extends CustomPainter {
  const MyCanvasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.amber;
    canvas.drawCircle(const Offset(100.0, 200.0), 40.0, paint);
    final Paint paintRect = Paint()..color = Colors.lightBlue;
    final Rect rect = Rect.fromPoints(
      const Offset(150.0, 300.0),
      const Offset(300.0, 400.0),
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
    return const Scaffold(
      body: CustomPaint(painter: MyCanvasPainter()),
    );
  }
}
// #enddocregion CustomPaint

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion TextStyle
    const TextStyle textStyle = TextStyle(
      color: Colors.cyan,
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
    );

    return Center(
      child: Column(
        children: const <Widget>[
          Text('Sample text', style: textStyle),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.lightbulb_outline,
              size: 48.0,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
    // #enddocregion TextStyle
  }
}

class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion Icon
    return const Icon(Icons.lightbulb_outline, color: Colors.redAccent);
    // #enddocregion Icon
  }
}

// #docregion Swatch
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme:
              const TextSelectionThemeData(selectionColor: Colors.red)),
      home: const SampleAppPage(),
    );
  }
}
// #enddocregion Swatch

class ThemeExample extends StatelessWidget {
  const ThemeExample({super.key});

  // #docregion Theme
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
        brightness: Brightness.dark,
      ),
      home: const StylingPage(),
    );
  }
  // #enddocregion Theme
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

  // #docregion ThemeData
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.cyan,
        brightness: brightness,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        //...
      ),
    );
  }
  // #enddocregion ThemeData
}

class SharedPrefsExample extends StatefulWidget {
  const SharedPrefsExample({super.key});

  @override
  State<SharedPrefsExample> createState() => _SharedPrefsExampleState();
}

class _SharedPrefsExampleState extends State<SharedPrefsExample> {
  int? _counter;

  // #docregion SharedPrefsUpdate
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
  // #enddocregion SharedPrefsUpdate

  @override
  Widget build(BuildContext context) {
    return Text(_counter.toString());
  }
}

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  // #docregion Drawer
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: ListTile(
        leading: const Icon(Icons.change_history),
        title: const Text('Screen2'),
        onTap: () {
          Navigator.of(context).pushNamed('/b');
        },
      ),
    );
  }
  // #enddocregion Drawer
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  // #docregion Scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 20.0,
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
  // #enddocregion Scaffold
}

class GestureDetectorExample extends StatelessWidget {
  const GestureDetectorExample({super.key});

  // #docregion GestureDetector
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(title: const Text('Gestures')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Tap, Long Press, Swipe Horizontally or Vertically'),
          ],
        )),
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
  // #enddocregion GestureDetector
}

class HttpExample extends StatefulWidget {
  const HttpExample({super.key});

  @override
  State<HttpExample> createState() => _HttpExampleState();
}

class _HttpExampleState extends State<HttpExample> {
  String _ipAddress = '';
  // #docregion HTTP
  final url = Uri.parse('https://httpbin.org/ip');
  final httpClient = HttpClient();

  Future<void> getIPAddress() async {
    final request = await httpClient.getUrl(url);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    final String ip = jsonDecode(responseBody)['origin'];
    setState(() {
      _ipAddress = ip;
    });
  }
  // #enddocregion HTTP

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
  // #docregion TextEditingController
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
              });
        },
      ),
    ]);
  }
  // #enddocregion TextEditingController
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

  // #docregion FormSubmit
  void _submit() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Alert'),
              content: Text('Email: $_email, password: $_password'));
        },
      );
    }
  }
  // #enddocregion FormSubmit

  // #docregion FormState
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
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
  // #enddocregion FormState
}

class PlatformExample extends StatelessWidget {
  const PlatformExample({super.key});

  String whichPlatform(BuildContext context) {
    // #docregion Platform
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
    // #enddocregion Platform
  }

  @override
  Widget build(BuildContext context) {
    return Text(whichPlatform(context));
  }
}

class DismissableWidgets extends StatefulWidget {
  const DismissableWidgets({super.key});

  @override
  State<DismissableWidgets> createState() => _DismissableWidgetsState();
}

class _DismissableWidgetsState extends State<DismissableWidgets> {
  final List<Card> cards = [
    const Card(
      child: Text('Hello!'),
    ),
    const Card(
      child: Text('World!'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // #docregion Dismissable
    return Dismissible(
      key: Key(widget.key.toString()),
      onDismissed: (dismissDirection) {
        cards.removeLast();
      },
      child: Container(
          //...
          ),
    );
    // #enddocregion Dismissable
  }
}
