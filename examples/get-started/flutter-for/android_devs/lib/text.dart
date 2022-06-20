import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  // #docregion CustomFont
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample App'),
      ),
      body: const Center(
        child: Text(
          'This is a custom font text',
          style: TextStyle(fontFamily: 'MyCustomFont'),
        ),
      ),
    );
  }
  // #docregion CustomFont

}
