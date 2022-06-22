import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

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

  Widget getBody() {
    bool showLoadingDialog = widgets.isEmpty;
    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
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
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      widgets = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(Uri.parse(dataURL));
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
  // #enddocregion loadData
}
