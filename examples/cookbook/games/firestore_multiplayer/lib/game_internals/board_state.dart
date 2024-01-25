// This file has only enough in it to satisfy `firestore_controller.dart`.

import 'package:flutter/foundation.dart';

import 'playing_area.dart';

class BoardState {
  final VoidCallback onWin;

  final PlayingArea areaOne = PlayingArea();

  final PlayingArea areaTwo = PlayingArea();

  BoardState({required this.onWin});

  void dispose() {
    areaOne.dispose();
    areaTwo.dispose();
  }
}
