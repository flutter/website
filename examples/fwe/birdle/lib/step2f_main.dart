// ignore_for_file: unused_import, unused_field, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'game.dart';

// #docregion Tile
class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

// #enddocregion Tile
