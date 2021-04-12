import 'package:flutter/material.dart';

void theme(BuildContext context) {
  // #docregion Theme
  Theme(
    // Create a unique theme with "ThemeData"
    data: ThemeData(
      accentColor: Colors.yellow,
    ),
    child: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  );
  // #enddocregion Theme

  // #docregion ThemeCopyWith
  Theme(
    // Find and extend the parent theme using "copyWith". See the next
    // section for more info on `Theme.of`.
    data: Theme.of(context).copyWith(accentColor: Colors.yellow),
    child: FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
  );
  // #enddocregion ThemeCopyWith
}
