import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
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
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  // #docregion loadData
  Future<void> loadData() async {
    var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = jsonDecode(response.body);
    });
  }
  // #enddocregion loadData
}
