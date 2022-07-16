// ignore_for_file: equal_elements_in_set

import 'package:flutter/material.dart';

void main() {
  // #docregion Syntax
  print(<Widget>{
    // this is the syntax for a Set<Widget> literal
    const SizedBox(),
    const SizedBox(),
  }.length);
  // #enddocregion Syntax

  // #docregion SyntaxExplain
  print(<Widget>{
    const SizedBox(/* location: Location(file: 'foo.dart', line: 12) */),
    const SizedBox(/* location: Location(file: 'foo.dart', line: 13) */),
  }.length);
  // #enddocregion SyntaxExplain
}
