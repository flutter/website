--- 
title: "State restoration on iOS"
description: "How to restore the state of your iOS app after it's been killed by the OS."
---

When a user runs a mobile app and then selects another
app to run, the first app is moved to the background,
or _backgrounded_. The operating system (both iOS and Android)
often kill the backgrounded app to release memory or
improve performance for the app running in the foreground.

When the user selects the app again, bringing it
back to the foreground, the OS relaunches it.
But, unless you've set up a way to save the
state of the app before it was sent to the background,
you've lost the state and the app starts from
scratch. The user has lost the continuity they expect
and are generally annoyed. (Imagine filling out a
lengthy form and being interrupted by a phone call
before hitting **Submit**...)

So, how can you restore the state of the app so that
it looks like it did before it was sent to the
background?

Flutter has a solution for that scenario with the
[`RestorationManager`][] (and related) classes
in the [services][] library.
With the `RestorationManager`, the Flutter Framework
provides the state data to the engine _as the state
changes_, so that the app is ready when the OS signals
that it's about to kill the app.

The `RestorationManager` manages the restoration
data, which is serialized to a tree of [`RestorationBuckets`[],
that are synchronized with the Flutter engine.

You must decide what state you want to save and restore,
but you can only save specific types to a `RestorationBucket`,
namely: null, bool, int, double, String, Uint8List
(and other typed data), List, Map, and child `RestorationBuckets`.

## Enabling state restoration

Most every Flutter app contains a `main` method that calls the
[`runApp`][] function. You can use `runApp`
to set up the framework and the bindings that bind
the Dart code to the native Flutter engine.
In this case, set up the `RestorationManager` in the
`runApp` function.  For example:

```dart
void main() {
  /...

  runApp(
    const RootRestorationScope(
      restorationId: 'root',
      child: myApp(),
    ),
  );
}
```

[`runApp`]: {{site.api}}/flutter/widgets/runApp.html

## Add RestorableMixin to the State class

The easiest way to implement restorable state is to
add the [`RestorableMixin`][] to the app's `State` class.

```dart
class _MyAppState extends State<MyApp> with RestorationMixin
```

Once you've added the restore state mixin,
your IDE asks you to implement an abstract method
called [`restoreState`][]. The `restoreState` method calls
[`registerForRestoration`][] to register a property
that you want to save. For example:

```dart
@override
void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  registerForRestoration(_appState, 'state');
} 
```

Call `registerForRestoration` once for every
piece of state that you want to save and restore.

---
You might also want to check out packages on pub.dev that
help with state restoration, such as [`statePersistence`][].

[`registerForRestoration`]: {{site.api}}/flutter/widgets/RestorationMixin/registerForRestoration.html
[`restoreState`]: {{site.api}}/flutter/widgets/RestorationMixin/restoreState.html
[`statePersistence`]: {{site.pub-pkg}}/state_persistence

## Testing state restoration

For advice on testing, see
[Testing state restoration][] on the
[`RestorationManager`][] page.

[Testing state restoration]: {{site.api}}/flutter/services/RestorationManager-class.html#testing-state-restoration

---------------------

## Enabling state restoration

To enable state restoration on iOS,
a restoration identifier has to be assigned to the
[`FlutterViewController`][].
If you are using the standard embedding (produced by flutter create),
use with the following steps:

1. In the app's directory, open `ios/Runner.xcodeproj` with Xcode.
1. Select `Main.storyboard` under **Runner/Runner**
   in the Project Navigator on the left.
1. Select the Flutter View Controller under
   **Flutter View Controller Scene** in the view hierarchy.
1. Navigate to the **Identity Inspector** in the panel on the right.
1. Enter a unique restoration ID in the provided field.
1. Save the project.


[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[`RestorationBuckets`]: {{site.api}}/flutter/services/RestorationBucket-class.html
[`RestorationManager`]: {{site.api}}/flutter/services/RestorationManager-class.html
[services]: {{site.api}}/flutter/services/services-library.html


