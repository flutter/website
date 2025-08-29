import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortcutsExample extends StatelessWidget {
  const ShortcutsExample({super.key});

  // #docregion shortcuts
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
            const SelectAllIntent(),
      },
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>>{
          SelectAllIntent: SelectAllAction(model),
        },
        child: Builder(
          builder: (context) => TextButton(
            onPressed: Actions.handler<SelectAllIntent>(
              context,
              const SelectAllIntent(),
            ),
            child: const Text('SELECT ALL'),
          ),
        ),
      ),
    );
  }

  // #enddocregion shortcuts
}

// #docregion logging-shortcut-manager
class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, KeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}
// #enddocregion logging-shortcut-manager

class SelectAllIntent extends Intent {
  const SelectAllIntent({this.controller});

  final TextEditingController? controller;
}

class Model {
  void selectAll() {}
}

Model model = Model();

// #docregion select-all-action
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final Model model;

  @override
  void invoke(covariant SelectAllIntent intent) => model.selectAll();
}
// #enddocregion select-all-action

void callbackActionSample() {
  // #docregion callback-action
  CallbackAction(onInvoke: (intent) => model.selectAll());
  // #enddocregion callback-action
}

class SelectAllExample extends StatelessWidget {
  const SelectAllExample({super.key, required this.child});

  final Widget child;

  // #docregion select-all-usage
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{SelectAllIntent: SelectAllAction(model)},
      child: child,
    );
  }

  // #enddocregion select-all-usage
}

late BuildContext context;

void findAndInvokeExample() {
  // #docregion maybe-find
  Action<SelectAllIntent>? selectAll = Actions.maybeFind<SelectAllIntent>(
    context,
  );
  // #enddocregion maybe-find
  // #docregion invoke-action
  Object? result;
  if (selectAll != null) {
    result = Actions.of(
      context,
    ).invokeAction(selectAll, const SelectAllIntent());
  }
  // #enddocregion invoke-action
  print('$result');
}

void maybeInvokeExample() {
  // #docregion maybe-invoke
  Object? result = Actions.maybeInvoke<SelectAllIntent>(
    context,
    const SelectAllIntent(),
  );
  // #enddocregion maybe-invoke
  print('$result');
}

class HandlerExample extends StatelessWidget {
  const HandlerExample(this.controller, {super.key});

  final TextEditingController controller;

  // #docregion handler
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{SelectAllIntent: SelectAllAction(model)},
      child: Builder(
        builder: (context) => TextButton(
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            SelectAllIntent(controller: controller),
          ),
          child: const Text('SELECT ALL'),
        ),
      ),
    );
  }

  // #enddocregion handler
}

// #docregion logging-action-dispatcher
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);

    return null;
  }

  @override
  (bool, Object?) invokeActionIfEnabled(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    print('Action invoked: $action($intent) from $context');
    return super.invokeActionIfEnabled(action, intent, context);
  }
}
// #enddocregion logging-action-dispatcher

class LoggingActionDispatcherExample extends StatelessWidget {
  const LoggingActionDispatcherExample({super.key});

  // #docregion logging-action-dispatcher-usage
  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{SelectAllIntent: SelectAllAction(model)},
      child: Builder(
        builder: (context) => TextButton(
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            const SelectAllIntent(),
          ),
          child: const Text('SELECT ALL'),
        ),
      ),
    );
  }

  // #enddocregion logging-action-dispatcher-usage
}

class CallbackShortcutsExample extends StatefulWidget {
  const CallbackShortcutsExample({super.key});

  @override
  State<CallbackShortcutsExample> createState() =>
      _CallbackShortcutsExampleState();
}

class _CallbackShortcutsExampleState extends State<CallbackShortcutsExample> {
  int count = 0;

  // #docregion callback-shortcuts
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
          setState(() => count = count + 1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown): () {
          setState(() => count = count - 1);
        },
      },
      child: Focus(
        autofocus: true,
        child: Column(
          children: <Widget>[
            const Text('Press the up arrow key to add to the counter'),
            const Text('Press the down arrow key to subtract from the counter'),
            Text('count: $count'),
          ],
        ),
      ),
    );
  }

  // #enddocregion callback-shortcuts
}
