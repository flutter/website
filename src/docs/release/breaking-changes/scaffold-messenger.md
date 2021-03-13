---
title: SnackBars managed by the ScaffoldMessenger
description: SnackBars are now managed by the ScaffoldMessenger, and persist across routes.
---

## Summary

The `SnackBar` API within the `Scaffold` is now handled by the
`ScaffoldMessenger`, one of which is
available by default within the context of a `MaterialApp`.

## Context

Prior to this change, `SnackBar`s would be shown by calling
on the `Scaffold` within the current `BuildContext`.
By calling `Scaffold.of(context).showSnackBar`,
the current `Scaffold` would animate a `SnackBar` into view.
This would only apply to the current `Scaffold`,
and would not persist across routes if they were changed
in the course of the `SnackBar`s presentation.
This would also lead to errors if `showSnackBar`
would be called in the course of executing an
asynchronous event, and the `BuildContext` became invalidated
by the route changing and the `Scaffold` being disposed of.

The `ScaffoldMessenger` now handles `SnackBar`s in order to
persist across routes and always be displayed on the current `Scaffold`.
By default, a root `ScaffoldMessenger` is included in the `MaterialApp`,
but you can create your own controlled scope for the `ScaffoldMessenger`
to further control _which_ `Scaffold`s receive your `SnackBar`s. 


## Description of change

The previous approach called upon the `Scaffold` to show a `SnackBar`.

<!-- skip -->
```dart
Scaffold(
  key: scaffoldKey,
  body: Builder(
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: const Text('snack'),
            duration: const Duration(seconds: 1),
            action: SnackBarAction(
              label: 'ACTION',
              onPressed: () { },
            ),
          ));
        },
        child: const Text('SHOW SNACK'),
      );
    },
  )
);
```

The new approach calls on the `ScaffoldMessenger` to show
the `SnackBar`. In this case, the `Builder` is no longer
required to provide a new scope with a `BuildContext` that
is "under" the `Scaffold`.

<!-- skip -->
```dart
Scaffold(
  key: scaffoldKey,
  body: GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('snack'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ),
      ));
    },
    child: const Text('SHOW SNACK'),
  ),
);
```

When presenting a `SnackBar` during a transition,
the `SnackBar` completes a `Hero` animation,
moving smoothly to the next page.

The `ScaffoldMessenger` creates a scope in which all descendant
`Scaffold`s register to receive `SnackBar`s,
which is how they persist across these transitions.
When using the root `ScaffoldMessenger` provided by the
`MaterialApp`, all descendant `Scaffold`s receive `SnackBar`s,
unless a new `ScaffoldMessenger` scope is created further down the tree.
By instantiating your own `ScaffoldMessenger`,
you can control which `Scaffold`s receive `SnackBar`s, and which do not based
on the context of your application.

The method `debugCheckHasScaffoldMessenger` is available to assert
that a given context has a `ScaffoldMessenger` ancestor.
Trying to present  a `SnackBar` without a `ScaffoldMessenger` ancestor
present results in an assertion such as the following:

```
No ScaffoldMessenger widget found.
Scaffold widgets require a ScaffoldMessenger widget ancestor.
Typically, the ScaffoldMessenger widget is introduced by the MaterialApp
at the top of your application widget tree.
```

## Migration guide

Code before migration:

<!-- skip -->
```dart
// The ScaffoldState of the current context was used for managing SnackBars.
Scaffold.of(context).showSnackBar(mySnackBar);
Scaffold.of(context).hideCurrentSnackBar(mySnackBar);
Scaffold.of(context).removeCurrentSnackBar(mySnackBar);

// If a Scaffold.key is specified, the ScaffoldState can be directly
// accessed without first obtaining it from a BuildContext via
// Scaffold.of. From the key, use the GlobalKey.currentState
// getter. This was previously used to manage SnackBars.
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
Scaffold(
  key: scaffoldKey,
  body: ...,
);

scaffoldKey.currentState.showSnackBar(mySnackBar);
scaffoldKey.currentState.hideCurrentSnackBar(mySnackBar);
scaffoldKey.currentState.removeCurrentSnackBar(mySnackBar);

```

Code after migration:

<!-- skip -->
```dart
// The ScaffoldMessengerState of the current context is used for managing SnackBars.
ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
ScaffoldMessenger.of(context).hideCurrentSnackBar(mySnackBar);
ScaffoldMessenger.of(context).removeCurrentSnackBar(mySnackBar);

// If a ScaffoldMessenger.key is specified, the ScaffoldMessengerState can be directly
// accessed without first obtaining it from a BuildContext via
// ScaffoldMessenger.of. From the key, use the GlobalKey.currentState
// getter. This is used to manage SnackBars.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
ScaffoldMessenger(
  key: scaffoldMessengerKey,
  child: ...
)

scaffoldMessengerKey.currentState.showSnackBar(mySnackBar);
scaffoldMessengerKey.currentState.hideCurrentSnackBar(mySnackBar);
scaffoldMessengerKey.currentState.removeCurrentSnackBar(mySnackBar);

// The root ScaffoldMessenger can also be accessed by providing a key to 
// MaterialApp.scaffoldMessengerKey. This way, the ScaffoldMessengerState can be directly accessed
// without first obtaining it from a BuildContext via ScaffoldMessenger.of. From the key, use
// the GlobalKey.currentState getter.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
MaterialApp(
  scaffoldMessengerKey: rootScaffoldMessengerKey,
  home: ...
)

rootScaffoldMessengerKey.currentState.showSnackBar(mySnackBar);
rootScaffoldMessengerKey.currentState.hideCurrentSnackBar(mySnackBar);
rootScaffoldMessengerKey.currentState.removeCurrentSnackBar(mySnackBar);
```

## Timeline

Landed in version: 1.23.0-13.0.pre<br>
In stable release: 2.0.0

## References

API documentation:
* [`Scaffold`][]
* [`ScaffoldMessenger`][]
* [`SnackBar`][]
* [`MaterialApp`][]

Relevant issues:
* [Issue #57218][]
* [Issue #62921][]

Relevant PRs:
* [ScaffoldMessenger][]
* [ScaffoldMessenger Migration][]

[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
[`ScaffoldMessenger`]: {{site.api}}/flutter/material/ScaffoldMessenger-class.html
[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Issue #57218]: {{site.github}}/flutter/flutter/issues/57218
[Issue #62921]: {{site.github}}/flutter/flutter/issues/62921
[ScaffoldMessenger]: {{site.github}}/flutter/flutter/pull/64101
[ScaffoldMessenger Migration]: {{site.github}}/flutter/flutter/pull/64170
