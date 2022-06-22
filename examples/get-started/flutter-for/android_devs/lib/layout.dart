// #docregion ToggleWidget
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
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
    } else {
      return ElevatedButton(
        onPressed: () {},
        child: const Text('Toggle Two'),
      );
    }
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
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 20.0, right: 30.0),
          ),
          onPressed: () {},
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
