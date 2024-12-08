---
title: Intro to Dart
description: Learn about the Dart programming language
prev:
  title: Fundamentals
  path: /get-started/fundamentals
next:
  title: Widgets
  path: /get-started/fundamentals/widgets
---

To get started with Flutter, 
you need to have some familiarity with 
the Dart programming language, which Flutter 
applications are written in.
This page is a gentle introduction to Dart, 
and if you're comfortable reading the 
code examples, feel free to skip this page. 
You do not need to be an expert in Dart to 
continue with this series.

## Dart

Flutter applications are built in [Dart][],
a language that will look familiar
to anyone who's written Java, Javascript,
or any other C-like language.  

:::note
Installing Flutter also installs Dart,
so you don't need to install Dart separately.
:::

The following example is a small program that 
fetches data from dart.dev, 
decodes the returned json, 
and prints it to the console. 
If you're confident in your ability to 
understand this program, 
feel free to skip to the page.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class Package {
  final String name;
  final String latestVersion; 
  final String? description;

  Package(this.name, this.latestVersion, {this.description});

  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';
  }
}

void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final httpPackageResponse = await http.get(httpPackageUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  final json = jsonDecode(httpPackageResponse.body);
  final package = Package(
    json['name'],
    json['latestVersion'],
    description: json['description'],
  );
  print(package);
}
```

This program has two parts: 
the `Package` class declaration, and the business logic, 
which is contained in the [`main`][] function.

The `Package` class contains many of the most common
features you'll use when working with [classes in Dart][].
This class has three members, 
and defines a constructor and a method.

The Dart language is [type safe][]; it uses 
static type checking to ensure that 
a variable's value always matches the
variable's static type. 
When defining a class, annotating the members with 
`String` is required, 
but it is often optional due to type inference. 
In the `main` function in this example 
there are many lines that start with `final variableName =`. 
These lines are type safe, 
despite not being explicitly given a type.

Dart also has built-in [sound null safety][]. 
In the example, the `description` member is 
declared with the type `String?`. 
The `?` at the end of `String?` means that 
this property can be null. 
The other two members cannot be null, 
and the program will not compile if 
you tried to set them to `null`. 
You can see this demonstrated in the constructor for 
the `Package` class. It takes two required,
positional arguments and one optional, named argument.

Next in the example is the `main` function. 
All Dart programs, including Flutter apps, 
start with a `main` function. 
The function showcases several basic Dart language features, 
including using libraries, marking functions as async, 
making function calls, using `if` statement control-flow,
and more.

:::note Where does initialization code go?
The main entrypoint in a starter
Flutter app is in `lib/main.dart`.
The default `main` method looks
like the following:

```dart title="lib/main.dart"
void main() {
  runApp(const MyApp());
}       
```

Perform any _quick_ initialization (less than a frame or two)
_before_ calling `runApp()`,
though be aware that the widget tree hasn't been created yet.
If you want to perform initialization that takes awhile,
such as loading data from disk or over a network,
do it in a way that won't block the main UI thread.
For more information, check out [Asynchronous programming][],
the [`FutureBuilder`][] API, [Deferred components][],
or the [Working with long lists][] cookbook recipe,
as appropriate.

Every stateful widget has an `initState()`
method that is called when the widget is
created and added to the widget tree.
You can override this method and perform
initialization there, though the first line of
this method _must_ be `super.initState()`.

Finally, hot reloading your app does _not_
call `initState` or `main` again.
Hot restart calls both.
:::

If these features aren't familiar to you, 
you can find resources to learn Dart on the 
[Bootstrap into Dart][] page.

## Next: Widgets

This page is an introduction to Dart,
and helps you become familiar with reading
Flutter and Dart code. It's okay if you don't
feel clear on all the code on this page, 
as long as you feel comfortable with the _syntax_
of the Dart language.
In the next section, you'll learn about the 
building block of Flutter apps: widgets.

[Asynchronous programming]: {{site.dart-site}}/libraries/async/async-await
[Dart]: {{site.dart-site}}
[Deferred components]: /perf/deferred-components
[`main`]: {{site.dart-site}}/language#hello-world
[classes in Dart]: {{site.dart-site}}/language/classes
[`FutureBuilder`]: {{site.api}}/flutter/widgets/FutureBuilder-class
[type safe]: {{site.dart-site}}/language/type-system
[sound null safety]: {{site.dart-site}}/null-safety
[Working with long lists]: /cookbook/lists/long-lists
[Bootstrap into Dart]: /resources/bootstrap-into-dart

## Feedback

As this section of the website is evolving, 
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="dart"
