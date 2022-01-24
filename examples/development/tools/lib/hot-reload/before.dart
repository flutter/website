// ignore_for_file: avoid_print, prefer_const_declarations, prefer_const_constructors

/// #docregion Build
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => print('tapped'));
  }
}
// #enddocregion Build

// #docregion Enum
enum Color {
  red,
  green,
  blue,
}
// #enddocregion Enum

// #docregion Class
class A<T> {
  T? i;
}
// #enddocregion Class

// #docregion SampleTable
final sampleTable = [
  Table(
    children: const [
      TableRow(
<<<<<<< HEAD
        children: [Text('T1')],
=======
        children: [Text("T1")],
>>>>>>> flutter-main
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
<<<<<<< HEAD
        children: [Text('T2')],
=======
        children: [Text("T2")],
>>>>>>> flutter-main
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
<<<<<<< HEAD
        children: [Text('T3')],
=======
        children: [Text("T3")],
>>>>>>> flutter-main
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
<<<<<<< HEAD
        children: [Text('T4')],
=======
        children: [Text("T4")],
>>>>>>> flutter-main
      )
    ],
  ),
];
// #enddocregion SampleTable

// #docregion Const
const foo = 1;
final bar = foo;
void onClick() {
  print(foo);
  print(bar);
}
// #enddocregion Const
