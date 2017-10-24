---
layout: page
title: Hot Reloading Flutter Apps
permalink: /hot-reload/
---

* TOC
{:toc}

## Using hot reload

Flutter's hot reload feature helps you quickly and easily experiment, build
UIs, add features and fix bugs. Hot reload works by injecting updated source
code files into the running Dart Virtual Machine (VM). After the VM updates
classes with the new versions of fields and functions, the Flutter framework
automatically rebuilds the widget tree, allowing you to quickly view the effects
of your changes.

To hot reload a Flutter app:

1.  Run the app from a supported IntelliJ IDE or a terminal window. Either a
physical or virtual device can be the target.
1.  Modify one of the Dart files in your project. Most types of code changes can
be hot reloaded; for a list of changes that require a full restart, see
[Understanding limitations](#understanding-limitations).
1.  If you're working in an IntelliJ IDE that supports Flutter's IDE tools,
click the Hot Reload button on the toolbar:

![alt_text](/images/intellij/hot-reload.gif "image_tooltip")

If you're running the app at the command line using `flutter run`, type `r` in
the terminal window. 

After a successful hot reload operation, you'll see a message in the console
similar to:

```
Performing hot reload...
Reloaded 1 of 448 libraries in 2,777ms.
```
The app's UI is updated to reflect your change, and the current state of the app
— the value of the counter variable in the above example — is preserved. Your
app continues to execute from where it was prior to running the hot reload
command. The code is updated and execution continues.

## Troubleshooting hot reload

When you start working with hot reload and using it frequently, you'll likely
encounter the types of code changes that might need a full app restart:



*   Initializing global variables
*   Initializing static fields
*   Changing the `main()` method of the app

You can adapt your code to work around the above cases so that hot reload is
still an option, for example by evaluating an initialization expression after
making a change. To do this in IntelliJ, you could select the `reinitialize`
option from the context menu in a field declaration. Without adaptations,
however, hot reload will generate an exception in these cases.

This section gives detailed examples of edge cases for hot reload where there
is no active call stack in the Dart VM. They apply to most Flutter app
development cycles. Other subtle interactions that can occur when there is an
active call stack (such as when an animation is in progress) are not covered
here.

### Recent UI change is excluded

Even when a hot reload operation appears successful and generates no exceptions,
some code changes might not be visible in the refreshed UI. This behavior is
common after changes to the app's `main()` method.

As a general rule, if the modified code is downstream of the root widget's
build method, then hot reload behaves as expected. However, if the modified code
won't be re-executed as a result of rebuilding the widget tree, then you won't
see its effects after hot reload.

For example, consider the following code:
```
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => print('tapped'));
  }
}
```

After running this app, you might change the code as follows:

```
import 'package:flutter/widgets.dart';
void main() {
  runApp(
    const Center(
      child: const Text('Hello', textDirection: TextDirection.ltr)));
  }
```


With a full restart, the program starts from the beginning, executes the new
version of `main()`, and builds a widget tree that displays the text `Hello`.

However, if you hot reload the app after this change, `main()` is not 
re-executed, and the widget tree is rebuilt with the unchanged instance of 
`MyApp` as the root widget. The result is no visible change after hot reload.


### Recent code change is included but app state is excluded

In Dart, [static fields are lazily initialized](https://news.dartlang.org/2012/02/static-variables-no-longer-have-to-be.html). This means that the first time you run a Flutter app and a static field is read,
it is set to whatever value its initializer was evaluated to. Thus if you change
initializers of global variables and static fields, those changes are not
visible after hot reload. A full restart is necessary for this type of change
to take effect. 

For example, consider the following code:

```
final sampleTable = [
  new Table("T1"),
  new Table("T2"),
  new Table("T3"),
  new Table("T4"),
];
```
After running the app, if you make the following change:
```
final sampleTable = [
  new Table("T1"),
  new Table("T2"),
  new Table("T3"),
  new Table("T10"),    //modified
];
```
and then hot reload, the change is not reflected. 

Conversely, in the following example:
```
const foo = 1;
final bar = foo;
print(foo);
print(bar);
```


running the app for the first time prints `1` and `1`. Then if you make the
following change: 

```
const foo = 2;    //modified
final bar = foo;
print(foo);
print(bar);
```
and hot reload, it now prints `2` and `1`. While changes to `const` field values
are always hot reloaded, the static field initializer is not rerun.
Conceptually, `const` fields are treated like aliases instead of state.

The Dart VM detects initializer changes and flags when a set of changes needs a
full restart to take effect. The flagging mechanism is triggered for most of the
initialization work in the above example, but not for cases like:

```
final bar = foo;
```

To be able to update `foo` and view the change after hot reload, consider
redefining the field as `const` or using a getter to return the value, rather
than using `final`. For example:

```
const bar = foo;
```
or:

```
get bar => foo;
```

Read more about the [differences between the `const` and `final` keywords](https://news.dartlang.org/2012/06/const-static-final-oh-my.html) in Dart. 


### Previous state is combined with new code 

If code changes affect the state of your app (or its dependencies), the Flutter
framework gives you two options for reconciling old data with new code: throw
away state or modify the existing state. Throwing away state is what happens
during a full restart. Depending on the situation, you might prefer to apply
changes in a more selective way, by marking the widget tree as dirty and
recomputing the derived layout trees, while leaving the UI state alone. 

Modifying the existing state is what happens during hot reload; however, in this
scenario the data your app has to work with is not fully consistent with the
data it would have if it executed from scratch. Thus your app might behave
differently after hot reload versus a full restart.

For example, if you modify a class definition from extending StatelessWidget to
StatefulWidget (or the reverse), after hot reload the previous state of your
app is preserved. However, the state might not be compatible with the new
changes.

Consider the following code:

```
class myWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return new GestureDetector(onTap: () => print('T'));
  }
}
```
After running the app, if you make the following change:

```
class myWidget extends StatefulWidget {
  @override
  State createState() => new myWidgetState();
}
class myWidgetState {
...
...
}
```

and then hot reload, the console displays an assertion failure similar to:

```
myWidget is not a subtype of StatelessWidget
```

## Understanding limitations

In addition to edge cases, you might also encounter the rare scenarios where hot
reload is not supported at all.  These include:

*   Changed source files have compilation errors
*   Enumerated types are renamed into regular classes or regular classes are
renamed into enumerated types. For example, if you change:

    ```
enum Color {
  red,
  green,
  blue
}
    ```
to:
   ```
class Color {
  Color(this.i, this.j);
  final Int i;
  final Int j;
    	}
    ```

*   Generic type declarations are modified. For example, if you change:
    ```
Class A<T> {
  T i;
};
    ```
	to:

    ```
Class A<T, V> {
  T i;
  V v;
};
    ```

In these situations, hot reload generates a diagnostic message and fails without
committing any changes.
