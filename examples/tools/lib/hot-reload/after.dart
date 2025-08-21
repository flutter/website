// ignore_for_file: avoid_print, prefer_const_declarations

import 'package:flutter/material.dart';

// #docregion main
import 'package:flutter/widgets.dart';

void main() {
  runApp(const Center(child: Text('Hello', textDirection: TextDirection.ltr)));
}
// #enddocregion main

// #docregion enum
class Color {
  Color(this.i, this.j);
  final int i;
  final int j;
}
// #enddocregion enum

// #docregion class
class A<T, V> {
  T? i;
  V? v;
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
      TableRow(
        children: [Text('T10')], // modified
      ),
    ],
  ),
];
// #enddocregion sample-table

// #docregion const
const foo = 2; // modified
// #docregion final-foo
final bar = foo;
// #enddocregion final-foo
void onClick() {
  print(foo);
  print(bar);
}

// #enddocregion const
