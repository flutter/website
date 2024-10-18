---
title: State management
description: Learn how to manage state in Flutter.
prev:
  title: Layouts
  path: /get-started/fundamentals/layout
next:
  title: Handling user input
  path: /get-started/fundamentals/user-input
---

The _state_ of a Flutter app refers to all the objects it uses
to display its UI or manage system resources.
State management is how we organize our app
to most effectively access these objects
and share them between different widgets.

This page explores many aspects of state management, including:

* Using a [`StatefulWidget`]
* Sharing state between widgets using constructors,
  [`InheritedWidget`]s, and callbacks
* Using [`Listenable`]s to notify other widgets
  when something changes
* Using Model-View-ViewModel (MVVM)
  for your application's architecture

For other introductions to state management, check out these resources:

* Video: [Managing state in Flutter][managing-state-video].
  This video shows how to use the [riverpod][] package.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial:
[State management][].
This shows how to use `ChangeNotifer` with the [provider][] package.

This guide doesn't use third-party packages
like provider or Riverpod. Instead,
it only uses primitives available in the Flutter framework.

## Using a StatefulWidget

The simplest way to manage state is to use a `StatefulWidget`,
which stores state within itself.
For example, consider the following widget:

```dart
class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        TextButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('Increment'),
        )
      ],
    );
  }
}
```

This code illustrates two important concepts
when thinking about state management:

* **Encapsulation**
: The widget that uses `MyCounter` has no visibility into
  the underlying `count` variable
  and no means to access or change it.
* **Object lifecycle**
: The `_MyCounterState` object and its `count` variable
  are created the first time that `MyCounter` is built,
  and exist until it's removed from the screen.
  This is an example of _ephemeral state_.

You might find the following resources to be useful:

* Article: [Ephemeral state and app state][ephemeral-state]
* API docs: [StatefulWidget][]

## Sharing state between widgets

Some scenarios where an app needs to store state
include the following:

* To **update** the shared state and notify other parts of the app
* To **listen** for changes to the shared state
  and rebuild the UI when it changes

This section explores how you can effectively share state
between different widgets in your app.
The most common patterns are:

* **Using widget constructors**
  (sometimes called "prop drilling" in other frameworks)
* **Using `InheritedWidget`** (or a similar API,
  such as the [provider][] package).
* **Using callbacks** to notify a parent widget
  that something has changed

### Using widget constructors

Since Dart objects are passed by reference,
it's very common for widgets to define the
objects they need to use in their constructor.
Any state you pass into a widget's constructor
can be used to build its UI:

```dart
class MyCounter extends StatelessWidget {
  final int count;
  const MyCounter({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}
```

This makes it obvious for other users of your widget to know
what they need to provide in order to use it:

```dart
Column(
  children: [
    MyCounter(
      count: count,
    ),
    MyCounter(
      count: count,
    ),
    TextButton(
      child: Text('Increment'),
      onPressed: () {
        setState(() {
          count++;
        });
      },
    )
  ],
)
```

Passing the shared data for your app through widget constructors
makes it clear to anyone reading the code that there are shared dependencies.
This is a common design pattern called _dependency injection_
and many frameworks take advantage of it or provide tools to make it easier.

### Using InheritedWidget

Manually passing data down the widget tree can be verbose
and cause unwanted boilerplate code,
so Flutter provides _`InheritedWidget`_,
which provides a way to efficiently host data in a parent widget
so that child widgets can get access them without storing them as a field.

To use `InheritedWidget`, extend the `InheritedWidget` class
and implement the static method `of()`
using `dependOnInheritedWidgetOfExactType`.
A widget calling `of()` in a build method
creates a dependency that is managed by the Flutter framework,
so that any widgets that depend on this `InheritedWidget` rebuild
when this widget re-builds with new data
and `updateShouldNotify` returns true.

```dart
class MyState extends InheritedWidget {
  const MyState({
    super.key,
    required this.data,
    required super.child,
  });

  final String data;

  static MyState of(BuildContext context) {
    // This method looks for the nearest `MyState` widget ancestor.
    final result = context.dependOnInheritedWidgetOfExactType<MyState>();

    assert(result != null, 'No MyState found in context');

    return result!;
  }

  @override
  // This method should return true if the old widget's data is different
  // from this widget's data. If true, any widgets that depend on this widget
  // by calling `of()` will be re-built.
  bool updateShouldNotify(MyState oldWidget) => data != oldWidget.data;
}
```

Next, call the `of()` method
from the `build()`method of the widget
that needs access to the shared state:

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = MyState.of(context).data;
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
```


### Using callbacks

You can notify other widgets when a value changes by exposing a callback.
Flutter provides the `ValueChanged` type,
which declares a function callback with a single parameter:

```dart
typedef ValueChanged<T> = void Function(T value);
```

By exposing `onChanged` in your widget's constructor,
you provide a way for any widget that is using this widget
to respond when your widget calls `onChanged`.

```dart
class MyCounter extends StatefulWidget {
  const MyCounter({super.key, required this.onChanged});

  final ValueChanged<int> onChanged;

  @override
  State<MyCounter> createState() => _MyCounterState();
}
```

For example, this widget might handle the `onPressed` callback,
and call `onChanged` with its latest internal state for the `count` variable:

```dart
TextButton(
  onPressed: () {
    widget.onChanged(count++);
  },
),
```

### Dive deeper

For more information on sharing state between widgets,
check out the following resources:

* Article: [Flutter Architectural Overview—State management][architecture-state]
* Video: [Pragmatic state management][]
* Video: [InheritedWidgets][inherited-widget-video]
* Video: [A guide to Inherited Widgets][]
* Sample: [Provider shopper][]
* Sample: [Provider counter][]
* API Docs: [`InheritedWidget`][]

## Using listenables

Now that you've chosen how you want to share state in your app,
how do you update the UI when it changes?
How do you change the shared state in a way
that notifies other parts of the app?

Flutter provides an abstract class called `Listenable`
that can update one or more listeners.
Some useful ways to use listenables are:

* Use a `ChangeNotifier` and subscribe to it using a `ListenableBuilder`
* Use a `ValueNotifier` with a `ValueListenableBuilder`

### ChangeNotifier

To use `ChangeNotifier`, create a class that extends it,
and call `notifyListeners` whenever the class needs to notify its listeners.

```dart
class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
```

Then pass it to `ListenableBuilder`
to ensure that the subtree returned by the `builder` function
is re-built whenever the `ChangeNotifier` updates its listeners.

```dart
Column(
  children: [
    ListenableBuilder(
      listenable: counterNotifier,
      builder: (context, child) {
        return Text('counter: ${counterNotifier.count}');
      },
    ),
    TextButton(
      child: Text('Increment'),
      onPressed: () {
        counterNotifier.increment();
      },
    ),
  ],
)
```

### ValueNotifier

A [`ValueNotifier`] is a simpler version of a `ChangeNotifier`,
that stores a single value.
It implements the `ValueListenable` and `Listenable` interfaces,
so it's compatible
with widgets such as `ListenableBuilder` and `ValueListenableBuilder`.
To use it, create an instance of `ValueNotifier` with the initial value:

```dart
ValueNotifier<int> counterNotifier = ValueNotifier(0);
```

Then use the `value` field to read or update the value,
and notify any listeners that the value has changed.
Because `ValueNotifier` extends `ChangeNotifier`,
it is also a `Listenable` and can be used with a `ListenableBuilder`.
But you can also use `ValueListenableBuilder`,
which provides the value in the `builder` callback:

```dart
Column(
  children: [
    ValueListenableBuilder(
      valueListenable: counterNotifier,
      builder: (context, child, value) {
        return Text('counter: $value');
      },
    ),
    TextButton(
      child: Text('Increment'),
      onPressed: () {
        counterNotifier.value++;
      },
    ),
  ],
)
```

### Deep dive

To learn more about `Listenable` objects, check out the following resources:

* API Docs: [`Listenable`][]
* API Docs: [`ValueNotifier`][]
* API Docs: [`ValueListenable`][]
* API Docs: [`ChangeNotifier`][]
* API Docs: [`ListenableBuilder`][]
* API Docs: [`ValueListenableBuilder`][]
* API Docs: [`InheritedNotifier`][]

## Using MVVM for your application's architecture

Now that we understand how to share state
and notify other parts of the app when its state changes,
we're ready to start thinking about how to organize
the stateful objects in our app.

This section describes how to implement a design pattern that works well
with reactive frameworks like Flutter,
called _Model-View-ViewModel_ or _MVVM_.

### Defining the Model

The Model is typically a Dart class that does low-level tasks
such as making HTTP requests,
caching data, or managing system resources such as a plugin.
A model doesn't usually need to import Flutter libraries.

For example, consider a model that loads or updates the counter state
using an HTTP client:

```dart
import 'package:http/http.dart';

class CounterData {
  CounterData(this.count);

  final int count;
}

class CounterModel {
  Future<CounterData> loadCountFromServer() async {
    final uri = Uri.parse('https://myfluttercounterapp.net/count');
    final response = await get(uri);

    if (response.statusCode != 200) {
      throw ('Failed to update resource');
    }

    return CounterData(int.parse(response.body));
  }

  Future<CounterData> updateCountOnServer(int newCount) async {
    // ...
  }
}
```

This model doesn't use any Flutter primitives or make any assumptions
about the platform it's running on;
its only job is to fetch or update the count using its HTTP client.
This allows the model to be implemented with a Mock or Fake in unit tests,
and defines clear boundaries between your app's low-level components and the
higher-level UI components needed to build the full app.

The `CounterData` class defines the structure of the data
and is the true "model" of our application.
The model layer is typically responsible for the core algorithms
and data structures needed for your app.
If you are interested in other ways to define the model,
such as using immutable value types,
check out packages like [freezed][]
or [build_collection][] on pub.dev or use vscode plugin [jsontodart][]
to convert JSON to Dart class.


### Defining the ViewModel

A `ViewModel` binds the _View_ to the _Model_.
It protects the model from being accessed directly by the View,
and ensures that data flow starts from a change to the model.
Data flow is handled by the `ViewModel`, which uses `notifyListeners`
to inform the View that something changed.
The `ViewModel` is like a waiter in a restaurant
that handles the communication
between the kitchen (model) and the customers (views).

```dart
import 'package:flutter/foundation.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterModel model;
  int? count;
  String? errorMessage;
  CounterViewModel(this.model);

  Future<void> init() async {
    try {
      count = (await model.loadCountFromServer()).count;
    } catch (e) {
      errorMessage = 'Could not initialize counter';
    }
    notifyListeners();
  }

  Future<void> increment() async {
    var count = this.count;
    if (count == null) {
      throw('Not initialized');
    }
    try {
      await model.updateCountOnServer(count + 1);
      count++;
    } catch(e) {
      errorMessage = 'Count not update count';
    }
    notifyListeners();
  }
}
```

Notice that the `ViewModel` stores an `errorMessage`
when it receives an error from the Model.
This protects the View from unhandled runtime errors,
which could lead to a crash.
Instead, the `errorMessage` field
can be used by the view to show a user-friendly error message.


### Defining the View

Since our `ViewModel` is a `ChangeNotifier`,
any widget with a reference to it can use a `ListenableBuilder`
to rebuild its widget tree
when the `ViewModel` notifies its listeners:

```dart
ListenableBuilder(
  listenable: viewModel,
  builder: (context, child) {
    return Column(
      children: [
        if (viewModel.errorMessage != null)
          Text(
            'Error: ${viewModel.errorMessage}',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Colors.red),
          ),
        Text('Count: ${viewModel.count}'),
        TextButton(
          onPressed: () {
            viewModel.increment();
          },
          child: Text('Increment'),
        ),
      ],
    );
  },
)
```

This pattern allows the business logic of your application
to be separate from the UI logic
and low-level operations performed by the Model layer.

## Learn more about state management

This page touches the surface of state management as
there are many ways to organize and manage
the state of your Flutter application.
If you would like to learn more, check out the following resources:

* Article: [List of state management approaches][]
* Repository: [Flutter Architecture Samples][]

[A guide to Inherited Widgets]: {{site.youtube-site}}/watch?v=Zbm3hjPjQMk
[build_collection]: {{site.pub-pkg}}/built_collection
[Flutter Architecture Samples]: https://fluttersamples.com/
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[List of state management approaches]: /data-and-backend/state-mgmt/options
[Pragmatic state management]: {{site.youtube-site}}/watch?v=d_m5csmrf7I
[Provider counter]: https://github.com/flutter/samples/tree/main/provider_counter
[Provider shopper]: https://flutter.github.io/samples/provider_shopper.html
[State management]: /data-and-backend/state-mgmt/intro
[StatefulWidget]: /flutter/widgets/StatefulWidget-class.html
[`StatefulWidget`]: /flutter/widgets/StatefulWidget-class.html
[`ChangeNotifier`]: {{site.api}}/flutter/foundation/ChangeNotifier-class.html
[`InheritedNotifier`]: {{site.api}}/flutter/widgets/InheritedNotifier-class.html
[`ListenableBuilder`]: {{site.api}}/flutter/widgets/ListenableBuilder-class.html
[`Listenable`]: {{site.api}}/flutter/foundation/Listenable-class.html
[`ValueListenableBuilder`]: {{site.api}}/flutter/widgets/ValueListenableBuilder-class.html
[`ValueListenable`]: {{site.api}}/flutter/foundation/ValueListenable-class.html
[`ValueNotifier`]: {{site.api}}/flutter/foundation/ValueNotifer-class.html
[architecture-state]: /resources/architectural-overview#state-management
[ephemeral-state]: /data-and-backend/state-mgmt/ephemeral-vs-app
[freezed]: {{site.pub-pkg}}/freezed
[inherited-widget-video]: {{site.youtube-site}}/watch?v=og-vJqLzg2c
[managing-state-video]: {{site.youtube-site}}/watch?v=vU9xDLdEZtU
[provider]: {{site.pub-pkg}}/provider
[riverpod]: {{site.pub-pkg}}/riverpod
[jsontodart]: https://marketplace.visualstudio.com/items?itemName=BalaDhruv.j20

## Feedback

As this section of the website is evolving,
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="state-management"
