import 'package:flutter/material.dart';
import 'game.dart';
import 'step2_main.dart' show Tile;

// #docregion GamePage
class GamePage extends StatelessWidget {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (var guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
                for (var letter in guess) Tile(letter.char, letter.type),
              ],
            ),
          GuessInput(
            onSubmitGuess: (String guess) {
              // TODO, handle guess
              print(guess); // Temporary
            }
          ),
        ],
      ),
    );
  }
}
// #enddocregion GamePage
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
  final void Function(String) onSubmitGuess;
  @override Widget build(BuildContext context) => const SizedBox();
}
