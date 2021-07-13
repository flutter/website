---
title: Using Shortcuts and Actions
description: How to use Actions and Shortcuts in your Flutter app.
short-title: Shortcuts and Actions
---

## Using Shortcuts and Actions

This page describes how to bind physical keyboard events to actions in the user
interface. For instance, to define keyboard shortcuts in your application, this
page is for you.

## Overview

For a GUI application to do anything, it has to have actions: users want to tell
the application to _do_ something. Actions are often simple functions that
directly perform the action (such as set a value or save a file). In a larger
application, however, things are more complex: the code for invoking the action,
and the code for the action itself might need to be in different places.
Shortcuts (key bindings) might need definition at a level that knows nothing
about the actions they invoke.

That's where Flutter's shortcuts and actions system comes in. It allows
developers to define actions that fulfill intents bound to them. In this
context, an intent is a generic action that the user wishes to perform, and an
[`Intent`][] class instance represents these user intents in Flutter. An
`Intent` can be general purpose, fulfilled by different actions in different
contexts. An [`Action`][] can be a simple callback (as in the case of
the[`CallbackAction`][]) or something more complex that integrates with entire
undo/redo architectures (for example) or other logic.

![Using Shortcuts Diagram][]

[`Shortcuts`][] are key bindings that activate by pressing a key or combination
of keys. The key combinations reside in a table with their bound intent. When
the `Shortcuts` widget invokes them, it sends their matching intent to the
actions subsystem for fulfillment.

To illustrate the concepts in shortcuts and actions, this article creates a
simple app that allows a user to select and copy text in a text field using both
buttons and shortcuts.

### Why separate Actions from Intents?

You might wonder: why not just map a key combination directly to an action?  Why
have intents at all? This is because it is useful to have a separation of
concerns between where the key mapping definitions are (often at a high level),
and where the action definitions are (often at a low level), and because it is
important to be able to have a single key combination map to an intended
operation in an app, and have it adapt automatically to whichever action
fulfills that intended operation for the focused context.

For instance, Flutter has an `ActivateIntent` widget that maps each type of
control to its corresponding version of an `ActivateAction` (and that executes
the code that activates the control). This code often needs fairly private
access to do its work. If the extra layer of indirection that `Intent`s provide
didn't exist, it would be necessary to elevate the definition of the actions to
where the defining instance of the `Shortcuts` widget could see them, causing
the shortcuts to have more knowledge than necessary about which action to
invoke, and to have access to or provide state that it wouldn't necessarily have
or need otherwise. This allows your code to separate the two concerns to be more
independent.

Intents configure an action so that the same action can serve multiple uses. An
example of this is `DirectionalFocusIntent`, which takes a direction to move
the focus in, allowing the `DirectionalFocusAction` to know which direction to
move the focus. Just be careful: don't pass state in the `Intent` that applies
to all  invocations of an `Action`: that kind of state should be passed to the
constructor of the `Action` itself, to keep the `Intent` from needing to know
too much.

### Why not use callbacks?

You also might wonder: why not just use a callback instead of an `Action`
object? The main reason is that it's useful for actions to decide whether they
are enabled by implementing `isEnabled`. Also, it is often helpful if the key
bindings, and the implementation of those bindings, are in different places.

If indeed all that is needed is a callback, without all the complexity (or
flexibility) of `Actions` and `Shortcuts`, you can already use a `Focus` widget
for this. For example, here's the implementation of Flutter's simple
[`CallbackShortcuts`][] widget (available on the dev branch) that takes a map of
activators and executes callbacks for them:

```dart
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
```

This may be all that is needed for some apps.

## Shortcuts

As you'll see below, actions are useful on their own, but the most common use
case involves binding them to a keyboard shortcut. This is what the `Shortcuts`
widget is for.

It is inserted into the widget hierarchy to define key combinations that
represent the user's intent when that key combination is pressed. To convert
that intended purpose for the key combination into a concrete action, the
`Actions` widget used to map the `Intent` to an `Action`. For instance, you can
define a `SelectAllIntent`, and bind it to your own `SelectAllAction` or to your
`CanvasSelectAllAction`, and from that one key binding, the system invokes
either one, depending on which part of your application has focus. Let's see how
the key binding part works:

```dart
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
        builder: (BuildContext context) => TextButton(
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
```

The map given to a `Shortcuts` widget maps a `LogicalKeySet` (or a
`ShortcutActivator`, see note below) to an `Intent` instance. The logical key
set defines a set of one or more keys, and the intent indicates the intended
purpose of the keypress. The `Shortcuts` widget looks up keypresses in the map,
to find an `Intent` instance, which it gives to the action's `invoke()` method.

{{site.alert.note}}
  `ShortcutActivator` is a replacement (as of Flutter 2.3.0) for
  `LogicalKeySet`. It allows for more flexible and correct activation of
  shortcuts. `LogicalKeySet` is a `ShortcutActivator`, of course, but there is
  also `SingleActivator`, which takes a single key and the optional modifiers to
  be pressed before the key, and `CharacterActivator`, which activates a shortcut
  based on the character produced by a key sequence, instead of the logical keys
  themselves. `ShortcutActivator` is also meant to be subclassed to allow for
  custom ways of activating shortcuts from key events.
{{site.alert.end}}

### The ShortcutManager

The shortcut manager, a longer-lived object than the `Shortcuts` widget, passes
on key events when it receives them. It contains the logic for deciding how to
handle the keys, the logic for walking up the tree to find other shortcut
mappings, and maintains a map of key combinations to intents.

While the default behavior of the `ShortcutManager` is usually desirable, the
`Shortcuts` widget takes a `ShortcutManager` that you can subclass to customize
its functionality.

For example, if you wanted to log each key that a `Shortcuts` widget handled,
you could make a `LoggingShortcutManager`:

```dart
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
```

Now, every time the `Shortcuts` widget handles a shortcut, it prints out the key
event and relevant context.

## Actions

`Actions` allow for the definition of operations that the application can
perform by invoking them with an `Intent`. Actions can be enabled or disabled,
and receive the intent instance that invoked them as an argument to allow
configuration by the intent.

### Defining actions

Actions, in their simplest form, are just subclasses of `Action<Intent>` with an
`invoke()` method. Here's a simple action that simply invokes a function on the
provided model:

```dart
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);
  final Model model;

  @override
  void invoke(covariant SelectAllIntent intent) => model.selectAll();
}
```

Or, if it's too much of a bother to create a new class, use a `CallbackAction`:

```dart
CallbackAction(onInvoke: (Intent intent) => model.selectAll());
```

Once you have an action, you add it to your application using the [`Actions`][]
widget, which takes a map of `Intent` types to `Action`s:

```dart
@override
Widget build(BuildContext context) {
  return Actions(
    actions: <Type, Action<Intent>>{
      SelectAllIntent: SelectAllAction(model),
    },
    child: child,
  );
}
```

The `Shortcuts` widget uses the `Focus` widget's context and `Actions.invoke` to
find which action to invoke. If the `Shortcuts` widget doesn't find a matching
intent type in the first `Actions` widget encountered, it considers the next
ancestor `Actions` widget, and so on, until it reaches the root of the widget
tree, or finds a matching intent type and invokes the corresponding action.

### Invoking Actions

The actions system has several ways to invoke actions.  By far the most common
way is through the use of a `Shortcuts` widget covered in the previous section,
but there are other ways to interrogate the actions subsystem and invoke an
action. It's possible to invoke actions that are not bound to keys.

For instance, to find an action associated with an intent, you can use:

```dart
Action<SelectAllIntent>? selectAll = Actions.maybeFind<SelectAllIntent>(context);
```

This returns an `Action` associated with the `SelectAllIntent` type if one is
available in the given `context`.  If one isn't available, it returns null. If
an associated `Action` should always be available, then use `find` instead of
`maybeFind`, which throws an exception when it doesn't find a matching `Intent`
type.

To invoke the action (if it exists), call:

```dart
Object? result = selectAll?.invoke(SelectAllIntent());
```

Combine that into one call with the following:

```dart
Object? result = Actions.maybeInvoke<SelectAllIntent>(context, SelectAllIntent());
```

Sometimes you want to invoke an action as a result of pressing a button or
another control. Do this with the `Actions.handler` function, which creates a
handler closure if the intent has a mapping to an enabled action, and returns
null if it doesn't, so that the button is disabled if there is no matching
enabled action in the context:

```dart
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
```

The `Actions` widget only invokes actions when `isEnabled(Intent intent)`
returns true, allowing the action to decide if the dispatcher should consider it
for invocation.  If the action isn't enabled, then the `Actions` widget gives
another enabled action higher in the widget hierarchy (if it exists) a chance to
execute.

The previous example uses a `Builder` because `Actions.handler` and
`Actions.invoke` (for example) only finds actions in the provided `context`, and
if the example passes the `context` given to the `build` function, the framework
starts looking _above_ the current widget.  Using a `Builder` allows the
framework to find the actions defined in the same `build` function.

You can invoke an action without needing a `BuildContext`, but since the
`Actions` widget requires a context to find an enabled action to invoke, you
need to provide one, either by creating your own `Action` instance, or by
finding one in an appropriate context with `Actions.find`.

To invoke the action, pass the action to the `invoke` method on an
`ActionDispatcher`, either one you created yourself, or one retrieved from an
existing `Actions` widget using the `Actions.of(context)` method. Check whether
the action is enabled before calling `invoke`. Of course, you can also just call
`invoke` on the action itself, passing an `Intent`, but then you opt out of any
services that an action dispatcher might provide (like logging, undo/redo, and
so on).

### Action dispatchers

Most of the time, you just want to invoke an action, have it do its thing, and
forget about it. Sometimes, however, you might want to log the executed actions.

This is where replacing the default `ActionDispatcher` with a custom dispatcher
comes in.  You pass your `ActionDispatcher` to the `Actions` widget, and it
invokes actions from any `Actions` widgets below that one that doesn't set a
dispatcher of its own.

The first thing `Actions` does when invoking an action is look up the
`ActionDispatcher` and pass the action to it for invocation. If there is none,
it creates a default `ActionDispatcher` that simply invokes the action.

If you want a log of all the actions invoked, however, you can create your own
`LoggingActionDispatcher` to do the job:

```dart
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
```

Then you pass that to your top-level `Actions` widget:

```dart
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
```

This logs every action as it executes, like so:

```dart
flutter: Action invoked: SelectAllAction#906fc(SelectAllIntent#a98e3) from Builder(dependencies: _[ActionsMarker])
```

## Putting it together

The combination of `Actions` and `Shortcuts` is powerful: you can define generic
intents that map to specific actions at the widget level. Here's a simple app
that illustrates the concepts described above. The app creates a text field that
also has "select all" and "copy to clipboard" buttons next to it. The buttons
invoke actions to accomplish their work. All the invoked actions and
shortcuts are logged.

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-starting_code:null_safety-true
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A text field that also has buttons to select all the text and copy the
/// selected text to the clipboard.
class CopyableTextField extends StatefulWidget {
  const CopyableTextField({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CopyableTextField> createState() => _CopyableTextFieldState();
}

class _CopyableTextFieldState extends State<CopyableTextField> {
  late TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        ClearIntent: ClearAction(controller),
        CopyIntent: CopyAction(controller),
        SelectAllIntent: SelectAllAction(controller),
      },
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          body: Center(
            child: Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  child: TextField(controller: controller),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: Actions.handler<CopyIntent>(context, const CopyIntent()),
                ),
                IconButton(
                  icon: const Icon(Icons.select_all),
                  onPressed: Actions.handler<SelectAllIntent>(context, const SelectAllIntent()),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

/// A ShortcutManager that logs all keys that it handles.
class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event, {LogicalKeySet? keysPressed}) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}

/// An ActionDispatcher that logs all the actions that it invokes.
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

/// An intent that is bound to ClearAction in order to clear its
/// TextEditingController.
class ClearIntent extends Intent {
  const ClearIntent();
}

/// An action that is bound to ClearIntent that clears its
/// TextEditingController.
class ClearAction extends Action<ClearIntent> {
  ClearAction(this.controller);

  final TextEditingController controller;

  @override
  Object? invoke(covariant ClearIntent intent) {
    controller.clear();
  }
}

/// An intent that is bound to CopyAction to copy from its
/// TextEditingController.
class CopyIntent extends Intent {
  const CopyIntent();
}

/// An action that is bound to CopyIntent that copies the text in its
/// TextEditingController to the clipboard.
class CopyAction extends Action<CopyIntent> {
  CopyAction(this.controller);

  final TextEditingController controller;

  @override
  Object? invoke(covariant CopyIntent intent) {
    final String selectedString = controller.text.substring(
      controller.selection.baseOffset,
      controller.selection.extentOffset,
    );
    Clipboard.setData(ClipboardData(text: selectedString));
  }
}

/// An intent that is bound to SelectAllAction to select all the text in its
/// controller.
class SelectAllIntent extends Intent {
  const SelectAllIntent();
}

/// An action that is bound to SelectAllAction that selects all text in its
/// TextEditingController.
class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.controller);

  final TextEditingController controller;

  @override
  Object? invoke(covariant SelectAllIntent intent) {
    controller.selection = controller.selection.copyWith(
      baseOffset: 0,
      extentOffset: controller.text.length,
      affinity: controller.selection.affinity,
    );
  }
}

/// The top level application class.
///
/// Shortcuts defined here are in effect for the whole app,
/// although different widgets may fulfill them differently.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'Shortcuts and Actions Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Shortcuts(
        manager: LoggingShortcutManager(),
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.escape): const ClearIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC): const CopyIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA): const SelectAllIntent(),
        },
        child: const CopyableTextField(title: title),
      ),
    );
  }
}

void main() => runApp(const MyApp());
```


[`Action`]: {{site.api}}/flutter/widgets/Action-class.html
[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`CallbackAction`]: {{site.api}}/flutter/widgets/CallbackAction-class.html
[`CallbackShortcuts`]: http://master-api.flutter.dev/flutter/widgets/CallbackShortcuts-class.html
[`Intent`]: {{site.api}}/flutter/widgets/Intent-class.html
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html
[Using Shortcuts Diagram]: /images/using_shortcuts.png
