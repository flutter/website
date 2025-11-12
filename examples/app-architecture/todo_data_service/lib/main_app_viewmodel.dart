import 'dart:async';

import 'package:flutter/material.dart';

import 'data/repositories/theme_repository.dart';
import 'utils/result.dart';

/// Exposes the current theme setting and listens for changes.
// #docregion MainAppViewModel
class MainAppViewModel extends ChangeNotifier {
  MainAppViewModel(this._themeRepository) {
    _subscription = _themeRepository.observeDarkMode().listen((isDarkMode) {
      _isDarkMode = isDarkMode;
      notifyListeners();
    });
    _load();
  }

  final ThemeRepository _themeRepository;
  StreamSubscription<bool>? _subscription;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> _load() async {
    final result = await _themeRepository.isDarkMode();
    if (result is Ok<bool>) {
      _isDarkMode = result.value;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

// #enddocregion MainAppViewModel
