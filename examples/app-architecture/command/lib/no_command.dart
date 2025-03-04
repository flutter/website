import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.viewModel});

  final HomeViewModel2 viewModel;

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
        // #docregion ListenableBuilder
        body: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            if (widget.viewModel.running) {
              return const Center(child: CircularProgressIndicator());
            }
            // #enddocregion ListenableBuilder

            if (widget.viewModel.error != null) {
              return Center(child: Text('Error: ${widget.viewModel.error}'));
            }

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
        // #enddocregion ListenableBuilder
      ),
    );
  }

  // #docregion _onViewModelChanged
  void _onViewModelChanged() {
    if (widget.viewModel.error != null) {
      widget.viewModel.clearError();
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
  // #enddocregion UiState1

  // #docregion load2
  void load2() {
    if (running) {
      return;
    }
    // load user
  }

  // #enddocregion load2
  void clearError() {}
  // #docregion UiState1
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
