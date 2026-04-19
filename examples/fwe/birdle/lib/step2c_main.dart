// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'game.dart';

// #docregion Tile
class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    // NEW
    return Container(
      width: 60,
      height: 60,
      // TODO: Add needed widgets
    );
  }
}

// #enddocregion Tile
