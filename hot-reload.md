---
layout: page
title: Using Hot Reload
permalink: /hot-reload/
---

* TOC
{:toc}

## Using hot reload

Flutter's hot reload feature helps you quickly and easily experiment, build
UIs, add features, and fix bugs. Hot reload works by injecting updated source
code files into the running Dart Virtual Machine (VM). After the VM updates
classes with the new versions of fields and functions, the Flutter framework
automatically rebuilds the widget tree, allowing you to quickly view the effects
of your changes.

To hot reload a Flutter app:

1.  Run the app from a supported IntelliJ IDE or a terminal window. Either a
physical or virtual device can be the target.
1.  Modify one of the Dart files in your project. Most types of code changes can
be hot reloaded; for a list of changes that require a full restart, see
[Limitations](#limitations).
1.  If you're working in an IntelliJ IDE that supports Flutter's IDE tools,
select **Save All** (`cmd-s`/`ctrl-s`), or click the Hot Reload button on the toolbar:

   ![alt_text](/images/intellij/hot-reload.gif "image_tooltip")

   If you're running the app at the command line using `flutter run`, type `r` 
   in the terminal window. 

After a successful hot reload operation, you'll see a message in the console
similar to:

```
Performing hot reload...
Reloaded 1 of 448 libraries in 2,777ms.
```
The app is updated to reflect your change, and the current state of the app
— the value of the counter variable in the above example — is preserved. Your
app continues to execute from where it was prior to running the hot reload
command. The code is updated and execution continues.

A code change has a visible effect only if the modified Dart code is run again
after the change. The next sections describe common situations where the
modified code will _not_ run again after hot reload. In some cases, 
small changes to the Dart code will enable you to continue using hot reload
for your app.

## Compilation errors

When a code change introduces a compilation error, hot reload always generates
an error message similar to:
```
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
different behavior after hot reload versus a full restart.

For example, if you modify a class definition from extending StatelessWidget
to StatefulWidget (or the reverse), after hot reload the previous state of
your app is preserved. However, the state might not be compatible with the
new changes.

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

In these situations, a full restart is needed to see the updated app.

## Recent code change is included but app state is excluded

In Dart, [static fields are lazily initialized](https://news.dartlang.org/2012/02/static-variables-no-longer-have-to-be.html). This means that the first time you run a Flutter app and a static
field is read, it is set to whatever value its initializer was evaluated to.
Global variables and static fields are treated as state, and thus not 
reinitialized during hot reload.

If you change initializers of global variables and static fields, a full 
restart is necessary to see the changes. For example, consider the
following code:

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
void onClick(){
  print(foo);
  print(bar);
}
```
running the app for the first time prints `1` and `1`. Then if you make the
following change: 

```
const foo = 2;    //modified
final bar = foo;
void onClick(){
  print(foo);
  print(bar);
}
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

## Recent UI change is excluded

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

## Limitations

You might also encounter the rare cases where hot reload is not supported
at all. These include:

*  Enumerated types are changed to regular classes or regular classes are
changed to enumerated types. For example, if you change:

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
    class A<T> {
      T i;
    }
    ```
	to:

    ```
    class A<T, V> {
      T i;
      V v;
    }
    ```

In these situations, hot reload generates a diagnostic message and fails without
committing any changes.
