import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
// ignore_for_file: unused_local_variable

// #docregion Main
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  const Text('Hello World'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('A button'),
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
        const Text('A'),
      ],
    ),
  );
  // #enddocregion Container2
}

class OneColumnLayout extends StatelessWidget {
  const OneColumnLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TwoColumnLayout extends StatelessWidget {
  const TwoColumnLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LayoutBuilderExample extends StatelessWidget {
  const LayoutBuilderExample({Key? key}) : super(key: key);

  @override
  // #docregion LayoutBuilder
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const OneColumnLayout();
        } else {
          return const TwoColumnLayout();
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
  final messageBox =
      user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

  final result = messageBox(
    0, // No owner window
    'Test message'.toNativeUtf16(), // Message
    'Window caption'.toNativeUtf16(), // Window title
    0, // OK button only
  );
}
// #enddocregion FFI
