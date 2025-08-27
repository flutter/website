import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../game_internals/board_state.dart';
import '../game_internals/playing_area.dart';
import '../game_internals/playing_card.dart';

class FirestoreController {
  static final _log = Logger('FirestoreController');

  final FirebaseFirestore instance;

  final BoardState boardState;

  /// For now, there is only one match. But in order to be ready
  /// for match-making, put it in a Firestore collection called matches.
  late final _matchRef = instance.collection('matches').doc('match_1');

  late final _areaOneRef = _matchRef
      .collection('areas')
      .doc('area_one')
      .withConverter<List<PlayingCard>>(
        fromFirestore: _cardsFromFirestore,
        toFirestore: _cardsToFirestore,
      );

  late final _areaTwoRef = _matchRef
      .collection('areas')
      .doc('area_two')
      .withConverter<List<PlayingCard>>(
        fromFirestore: _cardsFromFirestore,
        toFirestore: _cardsToFirestore,
      );

  late final StreamSubscription<void> _areaOneFirestoreSubscription;
  late final StreamSubscription<void> _areaTwoFirestoreSubscription;

  late final StreamSubscription<void> _areaOneLocalSubscription;
  late final StreamSubscription<void> _areaTwoLocalSubscription;

  FirestoreController({required this.instance, required this.boardState}) {
    // Subscribe to the remote changes (from Firestore).
    _areaOneFirestoreSubscription = _areaOneRef.snapshots().listen((snapshot) {
      _updateLocalFromFirestore(boardState.areaOne, snapshot);
    });
    _areaTwoFirestoreSubscription = _areaTwoRef.snapshots().listen((snapshot) {
      _updateLocalFromFirestore(boardState.areaTwo, snapshot);
    });

    // Subscribe to the local changes in game state.
    _areaOneLocalSubscription = boardState.areaOne.playerChanges.listen((_) {
      _updateFirestoreFromLocalAreaOne();
    });
    _areaTwoLocalSubscription = boardState.areaTwo.playerChanges.listen((_) {
      _updateFirestoreFromLocalAreaTwo();
    });

    _log.fine('Initialized');
  }

  void dispose() {
    _areaOneFirestoreSubscription.cancel();
    _areaTwoFirestoreSubscription.cancel();
    _areaOneLocalSubscription.cancel();
    _areaTwoLocalSubscription.cancel();

    _log.fine('Disposed');
  }

  /// Takes the raw JSON snapshot coming from Firestore and attempts to
  /// convert it into a list of [PlayingCard]s.
  List<PlayingCard> _cardsFromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()?['cards'] as List<Object?>?;

    if (data == null) {
      _log.info('No data found on Firestore, returning empty list');
      return [];
    }

    try {
      return data
          .cast<Map<String, Object?>>()
          .map(PlayingCard.fromJson)
          .toList();
    } catch (e) {
      throw FirebaseControllerException(
        'Failed to parse data from Firestore: $e',
      );
    }
  }

  /// Takes a list of [PlayingCard]s and converts it into a JSON object
  /// that can be saved into Firestore.
  Map<String, Object?> _cardsToFirestore(
    List<PlayingCard> cards,
    SetOptions? options,
  ) {
    return {'cards': cards.map((c) => c.toJson()).toList()};
  }

  /// Updates Firestore with the local state of [area].
  Future<void> _updateFirestoreFromLocal(
    PlayingArea area,
    DocumentReference<List<PlayingCard>> ref,
  ) async {
    try {
      _log.fine('Updating Firestore with local data (${area.cards}) ...');
      await ref.set(area.cards);
      _log.fine('... done updating.');
    } catch (e) {
      throw FirebaseControllerException(
        'Failed to update Firestore with local data (${area.cards}): $e',
      );
    }
  }

  /// Sends the local state of `boardState.areaOne` to Firestore.
  void _updateFirestoreFromLocalAreaOne() {
    _updateFirestoreFromLocal(boardState.areaOne, _areaOneRef);
  }

  /// Sends the local state of `boardState.areaTwo` to Firestore.
  void _updateFirestoreFromLocalAreaTwo() {
    _updateFirestoreFromLocal(boardState.areaTwo, _areaTwoRef);
  }

  /// Updates the local state of [area] with the data from Firestore.
  void _updateLocalFromFirestore(
    PlayingArea area,
    DocumentSnapshot<List<PlayingCard>> snapshot,
  ) {
    _log.fine('Received new data from Firestore (${snapshot.data()})');

    final cards = snapshot.data() ?? [];

    if (listEquals(cards, area.cards)) {
      _log.fine('No change');
    } else {
      _log.fine('Updating local data with Firestore data ($cards)');
      area.replaceWith(cards);
    }
  }
}

class FirebaseControllerException implements Exception {
  final String message;

  FirebaseControllerException(this.message);

  @override
  String toString() => 'FirebaseControllerException: $message';
}
