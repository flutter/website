import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // #docregion addListener
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }
  // #enddocregion addListener

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // #docregion CommandListenable
        // #docregion ListenableBuilder
        body: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(child: CircularProgressIndicator());
            }
            // #enddocregion CommandListenable

            if (widget.viewModel.load.error != null) {
              return Center(
                child: Text('Error: ${widget.viewModel.load.error}'),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              // #enddocregion ListenableBuilder
              if (widget.viewModel.user == null) {
                return const Center(child: Text('No user'));
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${widget.viewModel.user!.name}'),
                    Text('Email: ${widget.viewModel.user!.email}'),
                  ],
                ),
              );
              // #docregion ListenableBuilder
            },
          ),
          // #docregion CommandListenable
        ),
        // #enddocregion ListenableBuilder
        // #enddocregion CommandListenable
      ),
    );
  }

  // #docregion _onViewModelChanged
  void _onViewModelChanged() {
    if (widget.viewModel.load.error != null) {
      widget.viewModel.load.clear();
      // Show Snackbar
    }
  }

  // #enddocregion _onViewModelChanged
}

class User {
  User({required this.name, required this.email});

  final String name;
  final String email;
}

// #docregion HomeViewModel
class HomeViewModel extends ChangeNotifier {
  // #docregion ViewModelInit
  HomeViewModel() {
    load = Command(_load)..execute();
  }
  // #enddocregion ViewModelInit

  User? get user => null;

  late final Command load;

  Future<void> _load() async {
    // load user
  }
}
// #enddocregion HomeViewModel

// #docregion HomeViewModel2
class HomeViewModel2 extends ChangeNotifier {
  HomeViewModel2() {
    load = Command(_load)..execute();
    delete = Command(_delete);
  }

  User? get user => null;

  late final Command load;

  late final Command delete;

  Future<void> _load() async {
    // load user
  }

  Future<void> _delete() async {
    // delete user
  }
}
// #enddocregion HomeViewModel2

// #docregion Command
class Command extends ChangeNotifier {
  Command(this._action);

  bool _running = false;
  bool get running => _running;

  Exception? _error;
  Exception? get error => _error;

  bool _completed = false;
  bool get completed => _completed;

  final Future<void> Function() _action;

  Future<void> execute() async {
    if (_running) {
      return;
    }

    _running = true;
    _completed = false;
    _error = null;
    notifyListeners();

    try {
      await _action();
      _completed = true;
    } on Exception catch (error) {
      _error = error;
    } finally {
      _running = false;
      notifyListeners();
    }
  }

  void clear() {
    _running = false;
    _error = null;
    _completed = false;
  }
}

// #enddocregion Command
