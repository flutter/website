// ignore_for_file: avoid_print, prefer_const_declarations, prefer_const_constructors

// #docregion build
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => print('tapped'));
  }
}
// #enddocregion build

// #docregion enum
enum Color { red, green, blue }
// #enddocregion enum

// #docregion class
class A<T> {
  T? i;
}
// #enddocregion class

// #docregion sample-table
final sampleTable = [
  Table(
    children: const [
      TableRow(children: [Text('T1')]),
    ],
  ),
  Table(
    children: const [
      TableRow(children: [Text('T2')]),
    ],
  ),
  Table(
    children: const [
      TableRow(children: [Text('T3')]),
    ],
  ),
  Table(
    children: const [
      TableRow(children: [Text('T4')]),
    ],
  ),
];
// #enddocregion sample-table

// #docregion const
const foo = 1;
final bar = foo;
void onClick() {
  print(foo);
  print(bar);
}

// #enddocregion const
