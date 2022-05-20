// ignore_for_file: unused_local_variable

import 'dart:ffi';

import 'package:ffi/ffi.dart';
// #docregion Main
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
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
  const OneColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TwoColumnLayout extends StatelessWidget {
  const TwoColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LayoutBuilderExample extends StatelessWidget {
  const LayoutBuilderExample({super.key});

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

Future<void> exampleChannels() async {
  // #docregion MethodChannel
  // Dart side
  const channel = MethodChannel('foo');
  final String greeting = await channel.invokeMethod('bar', 'world');
  print(greeting);
  // #enddocregion MethodChannel
}
