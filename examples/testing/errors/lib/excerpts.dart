import './backend.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// #docregion CatchError
import 'dart:async';

void main() {
  MyBackend myBackend = MyBackend();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    myBackend.sendError(error, stack);
  });
}
// #enddocregion CatchError

// #docregion CustomError
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? widget) {
        Widget error = Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
    );
  }
}
// #enddocregion CustomError

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // #docregion OnPressed
    return OutlinedButton(
      child: Text('Click me!'),
      onPressed: () async {
        final channel = const MethodChannel('crashy-custom-channel');
        await channel.invokeMethod('blah');
      },
    );
    // #enddocregion OnPressed
  }
}
