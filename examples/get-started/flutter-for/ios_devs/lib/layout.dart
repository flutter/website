import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

// #docregion ToggleWidget
class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
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
  // Default value for toggle.
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
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
// #enddocregion ToggleWidget

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // #docregion SimpleWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: CupertinoButton(
          onPressed: () {},
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: const Text('Hello'),
        ),
      ),
    );
  }
  // #enddocregion SimpleWidget
}

class RowExample extends StatelessWidget {
  const RowExample({super.key});

  // #docregion Row
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('Row One'),
        Text('Row Two'),
        Text('Row Three'),
        Text('Row Four'),
      ],
    );
  }
  // #enddocregion Row
}

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  // #docregion Column
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('Column One'),
        Text('Column Two'),
        Text('Column Three'),
        Text('Column Four'),
      ],
    );
  }
  // #enddocregion Column
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  // #docregion ListView
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Text('Row One'),
        Text('Row Two'),
        Text('Row Three'),
        Text('Row Four'),
      ],
    );
  }
  // #enddocregion ListView
}
