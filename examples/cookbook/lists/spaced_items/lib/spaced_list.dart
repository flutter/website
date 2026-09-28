// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'main.dart';

void layoutBuilder() {
  // #docregion builder
  LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(child: Placeholder());
    },
  );
  // #enddocregion builder
}

void constrainedBox() {
  // #docregion constrainedBox
  LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Placeholder(),
        ),
      );
    },
  );
  // #enddocregion constrainedBox
}

void column() {
  // #docregion column
  LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemWidget(text: 'Item 1'),
              ItemWidget(text: 'Item 2'),
              ItemWidget(text: 'Item 3'),
            ],
          ),
        ),
      );
    },
  );
  // #enddocregion column
}

void intrinsic() {
  // #docregion intrinsic
  LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                ItemWidget(text: 'Item 1'),
                Spacer(),
                ItemWidget(text: 'Item 2'),
                Expanded(child: ItemWidget(text: 'Item 3')),
              ],
            ),
          ),
        ),
      );
    },
  );
  // #enddocregion intrinsic
}
