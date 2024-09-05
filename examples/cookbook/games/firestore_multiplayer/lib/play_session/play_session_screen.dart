// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../game_internals/board_state.dart';

// #docregion imports
import 'package:cloud_firestore/cloud_firestore.dart';
import '../multiplayer/firestore_controller.dart';
// #enddocregion imports

class PlaySessionScreen extends StatefulWidget {
  const PlaySessionScreen({super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  late final BoardState _boardState;

  // #docregion controller
  FirestoreController? _firestoreController;
  // #enddocregion controller

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void dispose() {
    _boardState.dispose();
    // #docregion dispose
    _firestoreController?.dispose();
    // #enddocregion dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _boardState = BoardState(onWin: _playerWon);

    // #docregion init-state
    final firestore = context.read<FirebaseFirestore?>();
    if (firestore == null) {
      _log.warning("Firestore instance wasn't provided. "
          'Running without _firestoreController.');
    } else {
      _firestoreController = FirestoreController(
        instance: firestore,
        boardState: _boardState,
      );
    }
    // #enddocregion init-state
  }

  void _playerWon() {}
}
