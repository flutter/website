import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion InputHint
    return const Center(
      child: TextField(
        decoration: InputDecoration(hintText: 'This is a hint'),
      ),
    );
    // #enddocregion InputHint
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

// #docregion MyFormState
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
// #enddocregion MyFormState
