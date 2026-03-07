// ignore_for_file: unused_import, unused_field, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MainApp());
}

// #docregion MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          // #docregion TileInstance
          child: Tile('A', HitType.hit), // NEW
          // #enddocregion TileInstance
        ),
      ),
    );
  }
}
// #enddocregion MainApp

// #docregion Tile
class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    // #docregion Tile-Container
    return Container(
      width: 60,
      height: 60,
      // #docregion Tile-BoxDecoration
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        // #docregion Tile-Colors
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
        // #enddocregion Tile-Colors
      ),
      // #enddocregion Tile-BoxDecoration
      // #docregion Tile-Child
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      // #enddocregion Tile-Child
    );
    // #enddocregion Tile-Container
  }
}

// #enddocregion Tile
void docRegionTileUsage() {
  // #docregion TileUsage
  // main.dart line ~16
  // green
  Tile('A', HitType.hit);
  // grey
  Tile('A', HitType.miss);
  // yellow
  Tile('A', HitType.partial);
  // #enddocregion TileUsage
}
