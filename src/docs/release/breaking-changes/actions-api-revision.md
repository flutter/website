---
title: Actions API revision
description: Removes need for FocusNode in invocations, map Intent types to Actions.
---

## Summary

In Flutter an [`Intent`][] is an object that's typically bound
to a keyboard key combination using the [`Shortcuts`][] widget.
An `Intent` can be bound to an [`Action`][],
which can update the application's state or perform other operations.
In the course of using this API, we identified several drawbacks
in the design, so we have updated the Actions API to make it easier
to use and understand.

In the previous Actions API design, actions were mapped from a
[`LocalKey`][] to an `ActionFactory` that created a new
`Action` each time the `invoke` method was called.
In the current API, actions are mapped from the type of the `Intent`
to an `Action` instance (with a `Map<Type, Action>`),
and they are not created anew for each invocation.

## Context

The original Actions API design was oriented towards invoking actions from
widgets, and having those actions act in the context of the widget.
Teams have been using actions, and found several limitations in that
design that needed to be addressed:

1. Actions couldn’t be invoked from outside of the widget hierarchy.
   Examples of this include processing a script of commands,
   some undo architectures, and some controller architectures.

1. The mapping from shortcut key to `Intent` and then to
   `Action` wasn't always clear, since the data structures
   mapped LogicalKeySet =>Intent and then
   `LocalKey` => `ActionFactory`. The new mapping is still
   `LogicalKeySet` to `Intent` but then it maps `Type`
   (`Intent` type) to `Action`, which is more direct and
   readable, since the type of the intent is written in the mapping.

1. If the key binding for an action was in another part of the
   widget hierarchy, it was not always possible for the `Intent`
   to have access to the state necessary to decide if the
   intent/action should be enabled or not.

To address these issues, we made some significant changes to the API.
The mapping of actions was made more intuitive,
and the enabled interface was moved to the `Action` class.
Some unnecessary arguments were removed from the `Action`’s
`invoke` method and its constructor, and actions were allowed
to return results from their invoke method.
Actions were made into generics, accepting the type of `Intent`
they handle, and `LocalKeys` were no longer used for identifying
which action to run, and the type of the `Intent` is used instead.

The majority of these changes were made in the PRs for
[Revise Action API][] and [Make Action.enabled be
isEnabled(Intent intent) instead][], and are
described in detail in [the design
doc](/go/actions-and-shortcuts-design-revision).

## Description of change

Here are the changes made to address the above problems:

1. The `Map<LocalKey, ActionFactory>` that was given to the [`Actions`][] widget
   is now a `Map<Type, Action<Intent>>` (the type is the type of the Intent to
   be passed to the Action).
1. The `isEnabled` method was moved from the `Intent` class to the `Action`
   class.
1. The `FocusNode` argument to `Action.invoke` and `Actions.invoke` methods was removed.
1. Invoking an action no longer creates a new instance of the `Action`.
1. The `LocalKey` argument to the `Intent` constructor was removed.
1. The `LocalKey` argument to `CallbackAction` was removed.
1. The `Action` class is now a generic (`Action<T extends Intent>`) for better
   type safety.
1. The `OnInvokeCallback` used by `CallbackAction` no longer takes a `FocusNode`
   argument.
1. The `ActionDispatcher.invokeAction` signature has changed to not accept an
   optional `FocusNode`, but instead take an optional `BuildContext`.
1. The `LocalKey` static constants (named key by convention) in `Action`
   subclasses have been removed.
1. The `Action.invoke` and `ActionDispatcher.invokeAction` methods now return
   the result of invoking the action as an `Object`.
1. The `Action` class may now be listened to for state changes.
1. The `ActionFactory` typedef has been removed, as it is no longer used.

## Example analyzer failures

Here are some example analyzer failures that might be encountered where an
outdated use of the Actions API might be the cause of the problem. The specifics
of the error might differ, and there may be other failures caused by these
changes.

<!-- skip -->
```
error: MyActionDispatcher.invokeAction' ('bool Function(Action<Intent>, Intent, {FocusNode focusNode})') isn't a valid override of 'ActionDispatcher.invokeAction' ('Object Function(Action<Intent>, Intent, [BuildContext])'). (invalid_override at [main] lib/main.dart:74)

error: MyAction.invoke' ('void Function(FocusNode, Intent)') isn't a valid override of 'Action.invoke' ('Object Function(Intent)'). (invalid_override at [main] lib/main.dart:231)

error: The method 'isEnabled' isn't defined for the type 'Intent'. (undefined_method at [main] lib/main.dart:97)

error: The argument type 'Null Function(FocusNode, Intent)' can't be assigned to the parameter type 'Object Function(Intent)'. (argument_type_not_assignable at [main] lib/main.dart:176)

error: The getter 'key' isn't defined for the type 'NextFocusAction'. (undefined_getter at [main] lib/main.dart:294)

error: The argument type 'Map<LocalKey, dynamic>' can't be assigned to the parameter type 'Map<Type, Action<Intent>>'. (argument_type_not_assignable at [main] lib/main.dart:418)
```

## Migration guide

Significant changes area required to update existing code
to the new API.

### Actions mapping for pre-defined actions

To update the action maps in the `Actions` widget for
predefined actions in Flutter, like `ActivateAction`
and `SelectAction`, do the following:

* Update the argument type of the `actions` argument
* Use an instance of a specific `Intent` class in the
  `Shortcuts` mapping, rather than an `Intent(TheAction.key)`
  instance.

Code before migration:

<!-- skip -->
```dart
class MyWidget extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent> {
        LogicalKeySet(LogicalKeyboardKey.enter): Intent(ActivateAction.key),
      },
      child: Actions(
        actions: <LocalKey, ActionFactory>{
          Activate.key: () => ActivateAction(),
        },
        child: Container(),
      )
    );
  }
}
```

Code after migration:

<!-- skip -->
```dart
class MyWidget extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent> {
        LogicalKeySet(LogicalKeyboardKey.enter): ActivateIntent,
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: ActivateAction(),
        },
        child: Container(),
      )
    );
  }
}
```

### Custom actions

To migrate your custom actions, eliminate the `LocalKeys`
you've defined, and replace them with `Intent` subclasses,
as well as changing the type of the argument to the `actions`
argument of the `Actions` widget.

Code before migration:

<!-- skip -->
```dart
class MyAction extends Action {
  MyAction() : super(key);

  /// The [LocalKey] that uniquely identifies this action to an [Intent].
  static const LocalKey key = ValueKey<Type>(RequestFocusAction);

  @override
  void invoke(FocusNode node, MyIntent intent) {
    // ...
  }
}

class MyWidget extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent> {
        LogicalKeySet(LogicalKeyboardKey.enter): Intent(MyAction.key),
      },
      child: Actions(
        actions: <LocalKey, ActionFactory>{
          MyAction.key: () => MyAction(),
        },
        child: Container(),
      )
    );
  }
}
```

Code after migration:

<!-- skip -->
```dart
// You may need to create new Intent subclasses if you used
// a bare LocalKey before.
class MyIntent extends Intent {
  const MyIntent();
}

class MyAction extends Action<MyIntent> {
  @override
  Object invoke(MyIntent intent) {
    // ...
  }
}

class MyWidget extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent> {
        LogicalKeySet(LogicalKeyboardKey.enter): MyIntent,
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          MyIntent: MyAction(),
        },
        child: Container(),
      )
    );
  }
}
```

### Custom `Actions` and `Intents` with arguments

To update actions that use intent arguments or hold state,
you need to modify the arguments to the `invoke` method.
In the example below, the code keeps the value of the
argument in the intent as part of the action instance.
This is because in the old design there is a new instance
of the action created each time it's executed,
and the resulting action could be kept by the
[`ActionDispatcher`][] to record the state.

In the example of post migration code below,
the new `MyAction` returns the state as the result
of calling `invoke`, since a new instance isn't created
for each invocation. This state is returned to the caller of
`Actions.invoke`, or `ActionDispatcher.invokeAction`,
depending on how the action is invoked.

Code before migration:

<!-- skip -->
```dart
class MyIntent extends Intent {
  const MyIntent({this.argument});

  final int argument;
}

class MyAction extends Action {
  MyAction() : super(key);

  /// The [LocalKey] that uniquely identifies this action to an [Intent].
  static const LocalKey key = ValueKey<Type>(RequestFocusAction);

  int state;

  @override
  void invoke(FocusNode node, MyIntent intent) {
    // ...
    state = intent.argument;
  }
}
```

Code after migration:

<!-- skip -->
```dart
class MyIntent extends Intent {
  const MyIntent({this.argument});

  final int argument;
}

class MyAction extends Action<MyIntent> {
  @override
  int invoke(Intent intent) {
    // ...
    return intent.argument;
  }
}
```

## Timeline

Landed in version: 1.18<br>
In stable release: 1.20

## References

API documentation:
* [`Action`][]
* [`ActionDispatcher`][]
* [`Actions`][]
* [`Intent`][]
* [`Shortcuts`][]

Relevant issues:
* [Issue 53276][]

Relevant PRs:
* [Revise Action API][]
* [Make Action.enabled be isEnabled(Intent intent) instead][]

[`Action`]: {{site.api}}/flutter/widgets/Action-class.html
[`ActionDispatcher`]: {{site.api}}/flutter/widgets/ActionDispatcher-class.html
[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`Intent`]: {{site.api}}/flutter/widgets/Intent-class.html
[Issue 53276]: {{site.github}}/flutter/flutter/issues/53276
[`LocalKey`]: {{site.api}}/flutter/foundation/LocalKey-class.html
[Make Action.enabled be isEnabled(Intent intent) instead]: {{site.github}}/flutter/flutter/pull/55230
[Revise Action API]: {{site.github}}/flutter/flutter/pull/42940
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html
