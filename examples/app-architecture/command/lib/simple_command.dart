// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';

class User {}

// #docregion Command
class Command extends ChangeNotifier {
  Command(this._action);

  bool get running => false;

  Exception? get error => null;

  bool get completed => false;

  void Function() _action;

  void execute() {
    // run _action
  }

  void clear() {
    // clear state
  }
}
// #enddocregion Command

// #docregion ViewModel
class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command(_load)..execute();
  }

  User? get user => null;

  late final Command load;

  void _load() {
    // load user
  }
}

// #enddocregion ViewModel
