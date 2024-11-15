import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data/repositories/theme_repository.dart';
import 'data/repositories/todo_repository.dart';
import 'data/services/database_service.dart';
import 'data/services/shared_preferences_service.dart';
import 'main_app_viewmodel.dart';
import 'ui/theme_config/viewmodel/theme_switch_viewmodel.dart';
import 'ui/theme_config/widgets/theme_switch.dart';
import 'ui/todo_list/viewmodel/todo_list_viewmodel.dart';
import 'ui/todo_list/widgets/todo_list_screen.dart';

void main() {
  late DatabaseService databaseService;
  if (kIsWeb) {
    throw UnsupportedError('Platform not supported');
  } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    // Initialize FFI SQLite
    sqfliteFfiInit();
    databaseService = DatabaseService(
      databaseFactory: databaseFactoryFfi,
    );
  } else {
    // Use default native SQLite
    databaseService = DatabaseService(
      databaseFactory: databaseFactory,
    );
  }

  runApp(
    MainApp(
      themeRepository: ThemeRepository(
        SharedPreferencesService(),
      ),
      todoRepository: TodoRepository(
        database: databaseService,
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.themeRepository,
    required this.todoRepository,
  });

  final ThemeRepository themeRepository;
  final TodoRepository todoRepository;

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
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _viewModel.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ThemeSwitch(
              viewmodel: ThemeSwitchViewModel(
                widget.themeRepository,
              ),
            )
          ],
          title: const Text('ToDo List'),
        ),
        body: TodoListScreen(
          viewModel: TodoListViewModel(
            todoRepository: widget.todoRepository,
          ),
        ),
      ),
    );
  }
}
