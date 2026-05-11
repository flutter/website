import 'package:flutter/material.dart';

import 'game.dart';

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
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Birdle'),
          ),
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
          for (final guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
                // #docregion TileLoop
                for (final letter in guess) Tile(letter.char, letter.type),
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
