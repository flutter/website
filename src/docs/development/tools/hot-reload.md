---
title: Hot reload
description: Speed up development using Flutter's hot reload feature.
---

Flutter's hot reload feature helps you quickly and easily experiment, build
UIs, add features, and fix bugs. Hot reload works by injecting updated source
code files into the running Dart Virtual Machine (VM). After the VM updates
classes with the new versions of fields and functions, the Flutter framework
automatically rebuilds the widget tree, allowing you to quickly view the effects
of your changes.

To hot reload a Flutter app:

 1. Run the app from a supported [Flutter editor](/docs/get-started/editor)
    or a terminal window. Either a physical or virtual device can be the target.
    Only Flutter apps in debug mode can be hot reloaded.
 1. Modify one of the Dart files in your project. Most types of code changes can
    be hot reloaded; for a list of changes that require a hot restart, see
    [Limitations](#limitations).
 1. If you're working in an IDE/editor that supports Flutter's IDE tools,
    select **Save All** (`cmd-s`/`ctrl-s`), or click the Hot Reload button on the
    toolbar:

    ![Hot reload]({% asset tools/android-studio/hot-reload.gif @path %}){:width="735px"}

    If you're running the app at the command line using `flutter run`, enter `r`
    in the terminal window.

After a successful hot reload operation, you'll see a message in the console
similar to:

```
Performing hot reload...
Reloaded 1 of 448 libraries in 2,777ms.
```
The app updates to reflect your change, and the current state of the
app&mdash;the value of the counter variable in the above example&mdash;is
preserved. Your app continues to execute from where it was prior to running
the hot reload command. The code updates and execution continues.

A code change has a visible effect only if the modified Dart code is run again
after the change. Specifically, a hot reload causes all the existing widgets to
rebuild. Only code involved in the rebuilding of the widgets are automatically
re-executed.

The next sections describe common situations where the
modified code will _not_ run again after hot reload. In some cases,
small changes to the Dart code will enable you to continue using hot reload
for your app.

## Compilation errors

When a code change introduces a compilation error, hot reload always generates
an error message similar to:

```nocode
Hot reload was rejected:
'/Users/obiwan/Library/Developer/CoreSimulator/Devices/AC94F0FF-16F7-46C8-B4BF-218B73C547AC/data/Containers/Data/Application/4F72B076-42AD-44A4-A7CF-57D9F93E895E/tmp/ios_testWIDYdS/ios_test/lib/main.dart': warning: line 16 pos 38: unbalanced '{' opens here
  Widget build(BuildContext context) {
                                     ^
'/Users/obiwan/Library/Developer/CoreSimulator/Devices/AC94F0FF-16F7-46C8-B4BF-218B73C547AC/data/Containers/Data/Application/4F72B076-42AD-44A4-A7CF-57D9F93E895E/tmp/ios_testWIDYdS/ios_test/lib/main.dart': error: line 33 pos 5: unbalanced ')'
    );
    ^
```

In this situation, simply correct the errors on the specified lines of
Dart code to keep using hot reload.

## Previous state is combined with new code

Flutter's hot reload feature, sometimes described as _stateful hot reload_,
preserves the state of your app. This design enables you to view
the effect of the most recent change only, without throwing away the
current state. For example, if your app requires a user to log in, you can
modify and hot reload a page several levels down in the navigation hierarchy,
without re-entering your login credentials. State is kept, which is
usually the desired behavior.

If code changes affect the state of your app (or its dependencies),
the data your app has to work with might not be fully consistent with
the data it would have if it executed from scratch. The result might be
different behavior after hot reload versus a hot restart.

For example, if you modify a class definition from extending StatelessWidget
to StatefulWidget (or the reverse), after hot reload the previous state of
your app is preserved. However, the state might not be compatible with the
new changes.

Consider the following code:

```dart
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => print('T'));
  }
}
```

After running the app, if you make the following change:

<!-- skip -->
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> { /*...*/ }
```

Then hot reload; the console displays an assertion failure similar to:

```nocode
MyWidget is not a subtype of StatelessWidget
```

In these situations, a hot restart is required to see the updated app.

## Recent code change is included but app state is excluded

In Dart, [static fields are lazily initialized][].
This means that the first time you run a Flutter app and a static
field is read, it is set to whatever value its initializer was evaluated to.
Global variables and static fields are treated as state, and are therefore not
reinitialized during hot reload.

If you change initializers of global variables and static fields, a full
restart is necessary to see the changes. For example, consider the
following code:

<!-- skip -->
```dart
final sampleTable = [
  Table("T1"),
  Table("T2"),
  Table("T3"),
  Table("T4"),
];
```

After running the app, if you make the following change:

<!-- skip -->
```dart
final sampleTable = [
  Table("T1"),
  Table("T2"),
  Table("T3"),
  Table("T10"),    // modified
];
```

and then hot reload, the change is not reflected.

Conversely, in the following example:

<!-- skip -->
```dart
const foo = 1;
final bar = foo;
void onClick() {
  print(foo);
  print(bar);
}
```

running the app for the first time prints `1` and `1`. Then, if you make the
following change:

<!-- skip -->
```dart
const foo = 2;    // modified
final bar = foo;
void onClick() {
  print(foo);
  print(bar);
}
```

and hot reload, it now prints `2` and `1`. While changes to `const` field values
are always hot reloaded, the static field initializer is not rerun.
Conceptually, `const` fields are treated like aliases instead of state.

The Dart VM detects initializer changes and flags when a set of changes needs a
hot restart to take effect. The flagging mechanism is triggered for most of the
initialization work in the above example, but not for cases like:

<!-- skip -->
```dart
final bar = foo;
```

To be able to update `foo` and view the change after hot reload, consider
redefining the field as `const` or using a getter to return the value, rather
than using `final`. For example:

<!-- skip -->
```dart
const bar = foo;
```

or:

<!-- skip -->
```dart
get bar => foo;
```

Read more about the [differences between the `const` and `final`
keywords](https://news.dartlang.org/2012/06/const-static-final-oh-my.html) in Dart.

## Recent UI change is excluded

Even when a hot reload operation appears successful and generates no exceptions,
some code changes might not be visible in the refreshed UI. This behavior is
common after changes to the app's `main()` method.

As a general rule, if the modified code is downstream of the root widget's
build method, then hot reload behaves as expected. However, if the modified code
won't be re-executed as a result of rebuilding the widget tree, then you won't
see its effects after hot reload.

For example, consider the following code:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => print('tapped'));
  }
}
```

After running this app, you might change the code as follows:

```dart
import 'package:flutter/widgets.dart';

void main() {
  runApp(const Center(
      child: const Text('Hello', textDirection: TextDirection.ltr)));
}
```


With a hot restart, the program starts from the beginning, executes the new
version of `main()`, and builds a widget tree that displays the text `Hello`.

However, if you hot reload the app after this change, `main()` is not
re-executed, and the widget tree is rebuilt with the unchanged instance of
`MyApp` as the root widget. The result is no visible change after hot reload.

## Limitations

You might also encounter the rare cases where hot reload is not supported at
all. These include:

* Enumerated types are changed to regular classes or regular classes are changed
  to enumerated types. For example, if you change:

  <!-- skip -->
  ```dart
  enum Color {
    red,
    green,
    blue
  }
  ```

  to:

  <!-- skip -->
  ```dart
  class Color {
    Color(this.i, this.j);
    final int i;
    final int j;
    }
  ```

* Generic type declarations are modified. For example, if you change:

  <!-- skip -->
  ```dart
  class A<T> {
    T i;
  }
  ```

  to:

  <!-- skip -->
  ```dart
  class A<T, V> {
    T i;
    V v;
  }
  ```

In these situations, hot reload generates a diagnostic message and fails without
committing any changes.

## How it works

When hot reload is invoked, the host machine looks at the edited code since the
last compilation. The following libraries are recompiled:

* Any libraries with changed code.
* The application's main library.
* The libraries from the main library leading to affected libraries.

In Dart 2, those libraries' Dart source code are turned into
[kernel files](https://github.com/dart-lang/sdk/tree/master/pkg/kernel) and
sent to the mobile device's Dart VM.

The Dart VM re-loads all libraries from the new kernel file. So far no code is
re-executed.

The hot reload mechanism then causes the Flutter framework to trigger a
rebuild/re-layout/repaint of all existing widgets and render objects.

[static fields are lazily initialized]: https://news.dartlang.org/2012/02/static-variables-no-longer-have-to-be.html
