import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'command.dart';
import 'result.dart';

// #docregion Main
void main() {
  runApp(
    MainApp(
      themeRepository: ThemeRepository(
        SharedPreferencesService(),
      ),
    ),
  );
}
// #enddocregion Main

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late MainAppViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MainAppViewModel(widget.themeRepository);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // #docregion ListenableBuilder
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _viewModel.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: child,
        );
      },
      // #enddocregion ListenableBuilder
      child: Scaffold(
        appBar: AppBar(
          actions: [
            // #docregion AddThemeSwitch
            ThemeSwitch(
              viewmodel: ThemeSwitchViewModel(
                widget.themeRepository,
              ),
            )
            // #enddocregion AddThemeSwitch
          ],
          title: const Text('ToDo List'),
        ),
        body: const Placeholder(),
      ),
    );
  }
}

// #docregion ThemeSwitch
class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    super.key,
    required this.viewmodel,
  });

  final ThemeSwitchViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListenableBuilder(
        listenable: viewmodel,
        builder: (context, _) {
          return Switch(
            value: viewmodel.isDarkMode,
            onChanged: (_) {
              viewmodel.toggle.execute();
            },
          );
        },
      ),
    );
  }
}
// #enddocregion ThemeSwitch

// #docregion ThemeSwitchViewModel
class ThemeSwitchViewModel extends ChangeNotifier {
  ThemeSwitchViewModel(this._themeRepository) {
    load = Command0(_load)..execute();
    toggle = Command0(_toggle);
  }

  final ThemeRepository _themeRepository;

  bool _isDarkMode = false;

  /// If true show dark mode
  bool get isDarkMode => _isDarkMode;

  late Command0 load;

  late Command0 toggle;

  /// Load the current theme setting from the repository
  Future<Result<void>> _load() async {
    try {
      final result = await _themeRepository.isDarkMode();
      if (result is Ok<bool>) {
        _isDarkMode = result.value;
      }
      return result;
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  /// Toggle the theme setting
  Future<Result<void>> _toggle() async {
    try {
      _isDarkMode = !_isDarkMode;
      return await _themeRepository.setDarkMode(_isDarkMode);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
// #enddocregion ThemeSwitchViewModel

// #docregion ThemeRepository
class ThemeRepository {
  ThemeRepository(
    this._service,
  );

  final _darkModeController = StreamController<bool>.broadcast();

  final SharedPreferencesService _service;

  /// Get if dark mode is enabled
  Future<Result<bool>> isDarkMode() async {
    try {
      final value = await _service.isDarkMode();
      return Result.ok(value);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Set dark mode
  Future<Result<void>> setDarkMode(bool value) async {
    try {
      await _service.setDarkMode(value);
      _darkModeController.add(value);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Stream that emits theme config changes.
  /// ViewModels should call [isDarkMode] to get the current theme setting.
  Stream<bool> observeDarkMode() => _darkModeController.stream;
}
// #enddocregion ThemeRepository

// #docregion SharedPreferencesService
class SharedPreferencesService {
  static const String _kDartMode = 'darkMode';

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDartMode, value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kDartMode) ?? false;
  }
}
// #enddocregion SharedPreferencesService

// #docregion MainAppViewModel
/// Exposes the current theme setting and listens for changes.
class MainAppViewModel extends ChangeNotifier {
  MainAppViewModel(
    this._themeRepository,
  ) {
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
    try {
      final result = await _themeRepository.isDarkMode();
      if (result is Ok<bool>) {
        _isDarkMode = result.value;
      }
    } on Exception catch (_) {
      // handle error
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
// #enddocregion MainAppViewModel
