// ignore_for_file: unused_import, unused_field, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'game.dart';
import 'step2_main.dart'
    show Tile; // Use Tile from step2 for simplicity, or just define it here.

// But actually the excerpt tool just reads the file, so redefining `Tile` is fine, we just don't tag it.
class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});
  final String letter;
  final HitType hitType;
  @override
  Widget build(BuildContext context) {
    return Container(); // Omitted for brevity since it's not tagged here.
  }
}

// #docregion MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // #docregion AppBar
        appBar: AppBar(
          title: Align(alignment: Alignment.centerLeft, child: Text('Birdle')),
        ),
        // #enddocregion AppBar
        body: Center(child: GamePage()),
      ),
    );
  }
}
// #enddocregion MainApp

// #docregion GamePage
class GamePage extends StatelessWidget {
  GamePage({super.key});

  // This manages game logic, and is out of scope for this lesson.
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // #docregion Column
      child: Column(
        spacing: 5.0,
        children: [
          // #docregion Rows
          for (var guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
                // #docregion TileLoop
                for (var letter in guess) Tile(letter.char, letter.type),
                // #enddocregion TileLoop
              ],
            ),
          // #enddocregion Rows
        ],
      ),
      // #enddocregion Column
    );
  }
}

// #enddocregion GamePage
