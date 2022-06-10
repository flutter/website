import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Foo foo = Foo();

  // #docregion Expect
  expect(foo.runtimeType.toString(), equals('Foo'));
  // #enddocregion Expect
}

class Foo {
  Foo() {}
}
