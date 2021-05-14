import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  // #docregion initState
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }
  // #enddocregion initState

  // #docregion dispose
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }
  // #enddocregion dispose

  // #docregion printLatestValue
  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }
  // #enddocregion printLatestValue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // #docregion TextField1
            TextField(
              onChanged: (text) {
                print('First text field: $text');
              },
            ),
            // #enddocregion TextField1
            // #docregion TextField2
            TextField(
              controller: myController,
            ),
            // #enddocregion TextField2
          ],
        ),
      ),
    );
  }
}
