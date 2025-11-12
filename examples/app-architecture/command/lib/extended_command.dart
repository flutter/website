import 'package:flutter/material.dart';

// #docregion HomeViewModel
class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command0(_load)..execute();
    edit = Command1<String>(_edit);
  }

  User? get user => null;

  // Command0 accepts 0 arguments
  late final Command0 load;

  // Command1 accepts 1 argument
  late final Command1<String> edit;

  Future<void> _load() async {
    // load user
  }

  Future<void> _edit(String name) async {
    // edit user
  }
}
// #enddocregion HomeViewModel

class User {}

class Command0 {
  Command0(Future<void> Function() any);

  void execute() {}
}

class Command1<T> {
  Command1(Future<void> Function(T) any);
}
