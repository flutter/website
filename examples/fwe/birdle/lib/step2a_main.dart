import 'package:flutter/material.dart';
import 'game.dart';

// #docregion Tile
class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// #enddocregion Tile
