// This file has only enough in it to satisfy `firestore_controller.dart`.

import 'dart:async';

import 'playing_card.dart';

class PlayingArea {
  final List<PlayingCard> cards = [];

  final StreamController<void> _playerChanges =
      StreamController<void>.broadcast();

  PlayingArea();

  Stream<void> get playerChanges => _playerChanges.stream;

  void dispose() {
    _playerChanges.close();
  }

  void replaceWith(List<PlayingCard> cards) {
  }
}
