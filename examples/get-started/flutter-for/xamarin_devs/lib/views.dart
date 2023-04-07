import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion Text
    return const Text(
      'I like Flutter!',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    // #enddocregion Text
  }
}

// #docregion AddRemoveElement
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  /// Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    }
    return CupertinoButton(
      onPressed: () {},
      child: const Text('Toggle Two'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: _getToggleChild()),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
// #enddocregion AddRemoveElement
