// ignore_for_file: unused_import, unused_field, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'game.dart';
import 'step2_main.dart' show Tile;
import 'step4_main.dart' show GuessInput;

// #docregion GamePage
// #docregion StatefulWidget
class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}
// #enddocregion StatefulWidget

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.5,
                      vertical: 2.5,
                    ),
                    child: Tile(letter.char, letter.type),
                  ),
              ],
            ),
          GuessInput(
            // #docregion GuessInputInstance
            onSubmitGuess: (String guess) {
              // #docregion setState
              setState(() {
                // NEW
                _game.guess(guess);
              });
              // #enddocregion setState
            },
            // #enddocregion GuessInputInstance
          ),
        ],
      ),
    );
  }
}

// #enddocregion GamePage
