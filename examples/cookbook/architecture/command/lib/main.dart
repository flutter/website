import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(
      viewModel: HomeViewModel(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

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
              if (widget.viewModel.user == null) {
                return const Center(
                  child: Text('No user'),
                );
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
            },
          ),
        ),
      ),
    );
  }

  void _onViewModelChanged() {
    if (widget.viewModel.load.error != null) {
      // Show Snackbar
    }
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
