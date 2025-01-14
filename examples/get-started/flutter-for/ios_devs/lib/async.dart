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
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // #docregion load-data
  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }
  // #enddocregion load-data

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
