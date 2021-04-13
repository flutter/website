import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
// ignore_for_file: unused_local_variable

// #docregion Main
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Home Page')),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Text('Hello World'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: Text('A button'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
// #enddocregion Main

void containerExample(BuildContext context) {
  // #docregion Container
  Container(
    color: Theme.of(context).secondaryHeaderColor,
    child: Text(
      'Text with a background color',
      style: Theme.of(context).textTheme.headline6,
    ),
  );
  // #enddocregion Container
  // #docregion Container2
  Container(
    color: Colors.blue,
    child: Row(
      children: [
        Image.network('https://www.example.com/1.png'),
        Text('A'),
      ],
    ),
  );
  // #enddocregion Container2
}

class OneColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TwoColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LayoutBuilderExample extends StatelessWidget {
  @override
  // #docregion LayoutBuilder
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return OneColumnLayout();
        } else {
          return TwoColumnLayout();
        }
      },
    );
  }
  // #enddocregion LayoutBuilder
}

void exampleChannels() async {
  // #docregion MethodChannel
  // Dart side
  const channel = MethodChannel('foo');
  final String greeting = await channel.invokeMethod('bar', 'world');
  print(greeting);
  // #enddocregion MethodChannel
}

// #docregion FFI
typedef MessageBoxNative = Int32 Function(
  IntPtr hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  Int32 uType,
);

typedef MessageBoxDart = int Function(
  int hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  int uType,
);

void exampleFfi() {
  final user32 = DynamicLibrary.open('user32.dll');
  final MessageBox =
      user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

  final result = MessageBox(
    0, // No owner window
    'Test message'.toNativeUtf16(), // Message
    'Window caption'.toNativeUtf16(), // Window title
    0, // OK button only
  );
}
// #enddocregion FFI
