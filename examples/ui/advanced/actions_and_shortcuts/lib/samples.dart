import 'package:flutter/material.dart';

// #docregion CallbackShortcuts
class CallbackShortcuts extends StatelessWidget {
  const CallbackShortcuts({
    Key? key,
    required this.bindings,
    required this.child,
  }) : super(key: key);

  final Map<ShortcutActivator, VoidCallback> bindings;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (FocusNode node, RawKeyEvent event) {
        KeyEventResult result = KeyEventResult.ignored;
        // Activates all key bindings that match, returns handled if any handle it.
        for (final ShortcutActivator activator in bindings.keys) {
          if (activator.accepts(event, RawKeyboard.instance)) {
            bindings[activator]!.call();
            result = KeyEventResult.handled;
          }
        }
        return result;
      },
      child: child,
    );
  }
}
// #enddocregion CallbackShortcuts

class ShortcutsExample extends StatelessWidget {
// #docregion ShortcutsExample
@override
Widget build(BuildContext context) {
  return Shortcuts(
    shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
      SelectAllIntent(),
    },
    child: Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(),
      },
      child: Builder(
        builder: (BuildContext context) =>
            TextButton(
              child: const Text('SELECT ALL'),
              onPressed: Actions.handler<SelectAllIntent>(
                context,
                SelectAllIntent(),
              ),
            ),
      ),
    ),
  );
}
// #enddocregion ShortcutsExample
}

// #docregion LoggingShortcutManager
class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}
// #enddocregion LoggingShortcutManager

// #docregion SelectAllAction
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);
  final Model model;

  @override
  void invoke(covariant SelectAllIntent intent) => model.selectAll();
}
// #enddocregion SelectAllAction

void callbackActionSample() {
// #docregion CallbackAction
  CallbackAction(onInvoke: (Intent intent) => model.selectAll());
// #enddocregion CallbackAction
}

class SelectAllExample extends StatelessWidget {
  SelectAllExample({required this.child});

  final Widget child;

// #docregion SelectAllExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(model),
      },
      child: child,
    );
  }
// #enddocregion SelectAllExample
}
void findAndInvokeExample() {
// #docregion MaybeFindExample
  Action<SelectAllIntent>? selectAll = Actions.maybeFind<SelectAllIntent>(context);
// #enddocregion MaybeFindExample
// #docregion InvokeActionExample
  Object? result = selectAll?.invoke(SelectAllIntent());
// #enddocregion InvokeActionExample
}
void maybeInvokeExample() {
// #docregion MaybeInvokeExample
  Object? result = Actions.maybeInvoke<SelectAllIntent>(context, SelectAllIntent());
// #enddocregion MaybeInvokeExample
}

class HandlerExample extends StatelessWidget {
// #docregion HandlerExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(),
      },
      child: Builder(
        builder: (BuildContext context) => TextButton(
          child: const Text('SELECT ALL'),
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            SelectAllIntent(controller: controller),
          ),
        ),
      ),
    );
  }
// #enddocregion HandlerExample
}

// #docregion LoggingActionDispatcher
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
      covariant Action<Intent> action,
      covariant Intent intent, [
        BuildContext? context,
      ]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);
  }
}
// #enddocregion LoggingActionDispatcher

class LoggingActionDispatcherExample extends StatelessWidget {
// #docregion LoggingActionDispatcherExample
  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        SelectAllIntent: SelectAllAction(),
      },
      child: Builder(
        builder: (BuildContext context) => TextButton(
          child: const Text('SELECT ALL'),
          onPressed: Actions.handler<SelectAllIntent>(
            context,
            SelectAllIntent(),
          ),
        ),
      ),
    );
  }
// #enddocregion LoggingActionDispatcherExample
}