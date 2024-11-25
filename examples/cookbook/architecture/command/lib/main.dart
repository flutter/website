import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(
      viewModel: HomeViewModel(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // #docregion ListenableBuilder
        body: ListenableBuilder(
          listenable: viewModel.load,
          builder: (context, child) {
            if (viewModel.load.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // #enddocregion ListenableBuilder

            if (viewModel.load.error != null) {
              return Center(
                child: Text('Error: ${viewModel.load.error}'),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              if (viewModel.user == null) {
                return const Center(
                  child: Text('No user'),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${viewModel.user!.name}'),
                    Text('Email: ${viewModel.user!.email}'),
                  ],
                ),
              );
            },
          ),
          // #docregion ListenableBuilder
        ),
        // #enddocregion ListenableBuilder
      ),
    );
  }
}

class User {
  User({required this.name, required this.email});

  final String name;
  final String email;
}

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command(_load)..execute();
  }

  User? _user;
  User? get user => _user;

  late final Command load;

  Future<void> _load() async {
    // load user
    await Future.delayed(const Duration(seconds: 2));
    _user = User(name: 'John Doe', email: 'john@example.com');
    notifyListeners();
  }
}

// #docregion HomeViewModel2
// #docregion getUser
// #docregion load1
// #docregion UiState1
class HomeViewModel2 extends ChangeNotifier {
  // #enddocregion HomeViewModel2

  User? get user => null;
  // #enddocregion getUser
  // #enddocregion load1

  bool get running => false;

  Exception? get error => null;

  // #docregion load1
  void load() {
    // load user
  }
  // #enddocregion load1

  // #docregion load2
  void load2() {
    if (running) {
      return;
    }

    // load user
  }
  // #enddocregion load2

  // #docregion load1
  // #docregion HomeViewModel2
  // #docregion getUser
}
// #enddocregion HomeViewModel2
// #enddocregion getUser
// #enddocregion load1
// #enddocregion UiState1

// #docregion HomeViewModel3
class HomeViewModel3 extends ChangeNotifier {
  User? get user => null;

  bool get runningLoad => false;

  Exception? get errorLoad => null;

  bool get runningEdit => false;

  Exception? get errorEdit => null;

  void load() {
    // load user
  }

  void edit(String name) {
    // edit user
  }
}
// #enddocregion HomeViewModel3

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
