// ignore_for_file: avoid_print, prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';

// #docregion Main
import 'package:flutter/widgets.dart';

void main() {
  runApp(const Center(child: Text('Hello', textDirection: TextDirection.ltr)));
}
// #enddocregion Main

// #docregion Enum
class Color {
  Color(this.i, this.j);
  final int i;
  final int j;
}
// #enddocregion Enum

// #docregion Class
class A<T, V> {
  T? i;
  V? v;
}
// #enddocregion Class

// #docregion SampleTable
final sampleTable = [
  Table(
    children: const [
      TableRow(
        children: [Text('T1')],
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
        children: [Text('T2')],
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
        children: [Text('T3')],
      )
    ],
  ),
  Table(
    children: const [
      TableRow(
        children: [Text('T10')], // modified
      )
    ],
  ),
];
// #enddocregion SampleTable

// #docregion Const
const foo = 2; // modified
// #docregion FinalFoo
final bar = foo;
// #enddocregion FinalFoo
void onClick() {
  print(foo);
  print(bar);
}
// #enddocregion Const
