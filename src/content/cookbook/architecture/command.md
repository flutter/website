---
title: Command pattern
description: Improve ViewModels with Commands
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/architecture/command"?>

Model-View-ViewModel (MVVM) is a design pattern 
that separates a feature of an application into three parts: 
the `Model`, the `ViewModel` and the `View`. 
Views and ViewModels make up the UI layer of an application. 
Repositories and services represent the data of an application, 
or the Model layer of MVVM.

ViewModels can become very complex 
as an application grows 
and features become bigger.
The command pattern helps to streamline running actions in ViewModels 
by encapsulating some of its complexity and avoiding code repetition.

In this guide, you will learn 
how to use the command pattern 
to improve your ViewModels.

# Challenges when implementing ViewModels

ViewModel classes in Flutter are typically implemented 
by extending the ChangeNotifier class. 
This allows ViewModels to call `notifyListeners()` to refresh Views
when data is updated.

<?code-excerpt "lib/no_command.dart (HomeViewModel2)" replace="/2//g"?>
```dart
class HomeViewModel extends ChangeNotifier {
  // ···
}
```

ViewModels contain a representation of the UI state, 
including the data being displayed. 
For example, this `HomeViewModel` exposes the `User` instance to the View.

<?code-excerpt "lib/no_command.dart (getUser)" replace="/null;/\/\/ .../g;/2//g"?>
```dart
class HomeViewModel extends ChangeNotifier {

  User? get user => // ...
  // ···
}
```

ViewModels also contain actions typically triggered by the View. 
For example, a `load` action in charge of loading the `user`.

<?code-excerpt "lib/no_command.dart (load1)" replace="/null;/\/\/ .../g;/2//g"?>
```dart
class HomeViewModel extends ChangeNotifier {

  User? get user => // ...
  // ···
  void load() {
    // load user
  }
  // ···
}
```

### UI state in ViewModels

Besides data, ViewModels also contain other types of UI state. 
For example, a `running` state or an `error` state. 
This allows the View to show to the user 
if the action is still running 
or if it was completed successfully.

<?code-excerpt "lib/no_command.dart (UiState1)" replace="/(null|false);/\/\/ .../g;/2//g"?>
```dart
class HomeViewModel extends ChangeNotifier {

  User? get user => // ...

  bool get running => // ...

  Exception? get error => // ...

  void load() {
    // load user
  }

  void load() {
    if (running) {
      return;
    }
    // load user
  }

  void clearError() {}
}
```

You can use the running state to display a progress indicator in the View:

<?code-excerpt "lib/no_command.dart (ListenableBuilder)" replace="/\.load//g;/body: //g;/^\),$/)/g"?>
```dart
ListenableBuilder(
  listenable: widget.viewModel,
  builder: (context, _) {
    if (widget.viewModel.running) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // ···
  },
)
```

Or use the running state to avoid executing the action multiple times:

<?code-excerpt "lib/main.dart (load2)"?>
```dart
void load2() {
  if (running) {
    return;
  }

  // load user
}
```

Managing the state of an action can get complicated 
once the ViewModel contains multiple actions. 
For example, adding an `edit()` action to the `HomeViewModel` 
can lead the following outcome:

<?code-excerpt "lib/no_command.dart (HomeViewModel3)" replace="/(null|false);/\/\/ .../g;/3//g"?>
```dart
class HomeViewModel extends ChangeNotifier {
  User? get user => // ...

  bool get runningLoad => // ...

  Exception? get errorLoad => // ...

  bool get runningEdit => // ...

  Exception? get errorEdit => // ...

  void load() {
    // load user
  }

  void edit(String name) {
    // edit user
  }
}
```

Sharing the running state 
between the `load()` and `edit()` actions might not always work, 
because you might want to show a different UI component 
when the `load()` action runs than when the `edit()` action runs,
and the same problem with the `error` state.

### Triggering UI actions from ViewModels

Another challenge with ViewModel classes 
is executing UI actions 
hen the ViewModel state changes. 

For example, to show a `SnackBar` when an error occurs, 
or to navigate to a different screen when an action completes.

To implement that, listen to the changes in the ViewModel, 
and perform the action depending on the state. 

In the View:

<?code-excerpt "lib/no_command.dart (addListener)"?>
```dart
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
```

<?code-excerpt "lib/no_command.dart (_onViewModelChanged)" remove="widget.viewModel.clearError();"?>
```dart
void _onViewModelChanged() {
  if (widget.viewModel.error != null) {
    // Show Snackbar
  }
}
```

You need to clear the error state each time you execute this action, 
otherwise this action will happen each time `notifyListeners()` is called.

<?code-excerpt "lib/no_command.dart (_onViewModelChanged)"?>
```dart
void _onViewModelChanged() {
  if (widget.viewModel.error != null) {
    widget.viewModel.clearError();
    // Show Snackbar
  }
}
```

## Command Pattern

You might find yourself repeating the above code over and over, 
having to implement a different running state 
for each action in every ViewModel. 
At that point, it makes sense to extract this code 
into a reusable pattern: a command.

A command is a class that encapsulates a ViewModel action, 
and exposes the different states that an action can have.

class Command extends ChangeNotifier {
  Command(this._action);

  bool get running => ...;

  Exception? get error => ...;

  bool get completed => ...;

  Future<void> Function() _action;

  Future<void> execute() async {
    // run _action
  }

  void clear() {
    // clear state
  }
}

In the ViewModel, instead of defining an action directly with a method, you create a Command object:

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command(_load);
  }
  
  User? get user => ...;

  late final Command load;

  void _load() {
    // load user
  }
}

The previous load() method becomes _load(), and instead the Command load gets exposed to the View. The previous running and error states can be removed, as they are now part of the Command.
Executing a Command
Instead of calling viewModel.load() to run the load action, now you have to call viewModel.load.execute().

The execute() method can also be called from within the ViewModel. For example, to run the load Command when the ViewModel is created:

HomeViewModel() {
  load = Command(_load)..execute();
}

The execute() method sets the running state to true and resets the error and completed states. When the action finishes, the running state will change to false and the completed state will be true.

When the running state is true, it prevents the Command from being launched multiple times before completing. This prevents users from attempting to tap multiple times on a button while an action is executing.

The Command’s execute() method could also capture any thrown Exceptions by the action implementation automatically and expose them in the error state.

The following is what a command class might look like. It’s been simplified for demo purposes. You can see a full implementation at the end of this page.

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
Listening to the Command state
The Command class extends from ChangeNotifier, allowing Views to listen to its states.

In the ListenableBuilder, instead of passing the ViewModel as listenable, pass the Command:

ListenableBuilder(
  listenable: viewModel.load,
  builder: (context, child) {
    if (viewModel.load.running) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // rest of builder
  },
)

As well listen to changes in the Command state in order to run UI actions:

viewModel.load.addListener(() { 
  if (viewModel.load.error != null) {
    viewModel.load.clear();

    // Show SnackBar
  }
});

Combining Command and ViewModel
When combined with the ViewModel, use the child argument to stack multiple ListenableBuilder. For example, you can listen to the running and error states of the Command before showing the ViewModel data.

ListenableBuilder(
  listenable: viewModel.load,
  builder: (context, child) {
    if (viewModel.load.running) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.load.error != null) {
      return Center(
        child: ErrorIndicator(error: viewModel.load.error),
      );
    }

    return child;
  },
  child: ListenableBuilder(
    listenable: viewModel,
    builder: (context, _) {
      // rest of the screen
    },
  ),
)

You can have multiple Commands in a single ViewModel, simplifying the implementation of ViewModels and minimizing the amount of repeated code.

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command(_load)..execute();
    delete = Command(_delete);
  }
  
  User? get user => ...;

  late final Command load;
  late final Command delete;

  Future<void> _load() async {
    // load user
  }

  Future<void> _delete() async {
    // delete user
  }
}

Extending the Command pattern
The Command pattern can be extended in multiple ways, for example, you can have different implementations to support a different number of arguments.

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command0(_load)..execute();
    edit = Command1(_edit);
  }
  
  User? get user => ...;

  // Command0 accepts 0 arguments
  late final Command0 load;

  // Command1 accepts 1 argument
  late final Command1 edit;

  Future<void> _load() async {
    // load user
  }

  Future<void> _edit(String name) async {
    // edit user
  }
}
Putting it all together
In this guide, you have learned how to use the Command design pattern to improve the implementation of ViewModels when using the MVVM design pattern.

Below you can find the full Command class as implemented in the Compass App example for the Flutter Architecture guidelines. It also uses the Result class, which you can learn more about in the Architecture Cookbook Recipe: Result Class.

This implementation also includes two types of Command, a Command0, for actions without parameters, and a Command1, which takes one parameter.

You can also check on pub.dev for different ready-to-use implementations of the Command pattern, like the flutter_command package.

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

/// Facilitates interaction with a ViewModel.
///
/// Encapsulates an action,
/// exposes its running and error states,
/// and ensures that it can't be launched again until it finishes.
///
/// Use [Command0] for actions without arguments.
/// Use [Command1] for actions with one argument.
///
/// Actions must return a [Result].
///
/// Consume the action result by listening to changes,
/// then call to [clearResult] when the state is consumed.
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  /// True when the action is running.
  bool get running => _running;

  Result<T>? _result;

  /// true if action completed with error
  bool get error => _result is Error;

  /// true if action completed successfully
  bool get completed => _result is Ok;

  /// Get last action result
  Result? get result => _result;

  /// Clear last action result
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Internal execute implementation
  Future<void> _execute(CommandAction0<T> action) async {
    // Ensure the action can't launch multiple times.
    // e.g. avoid multiple taps on button
    if (_running) return;

    // Notify listeners.
    // e.g. button shows loading state
    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] without arguments.
/// Takes a [CommandAction0] as action.
class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  /// Executes the action.
  Future<void> execute() async {
    await _execute(() => _action());
  }
}

/// [Command] with one argument.
/// Takes a [CommandAction1] as action.
class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  /// Executes the action with the argument.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}



