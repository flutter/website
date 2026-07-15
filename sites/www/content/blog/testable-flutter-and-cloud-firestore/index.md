---
title: "Testable Flutter and Cloud Firestore"
description: "Using dependency injection to test apps using Flutter and Firebase"
publishDate: 2020-10-15
author: craiglabenz
image: images/1pQJzBr81G169df-ffo24Cg.webp
category: spotlight
layout: blog
---

<DashImage figure src="images/1pQJzBr81G169df-ffo24Cg.webp" />


## Why Cloud Firestore?

The [FlutterFire](https://firebase.flutter.dev/) tech stack, consisting of Flutter and Firebase (and specifically Cloud Firestore), unlock unprecedented development velocity as you build and launch your app. In this article, you’ll explore a robust integration between these two technologies with a focus on testing and using clean architectural patterns. However, instead of jumping straight to the final implementation, you’ll build your way there, one step at a time, so the reasoning behind each step is clear.

## What you’ll build

To demonstrate a clean way to implement Cloud Firestore as your app’s backend, you’ll build a modified version of the classic Flutter counter app. The only difference is that the timestamp of each click is stored in Cloud Firestore, and the count displayed is derived from the number of persisted timestamps. You’ll use `Provider` and `ChangeNotifier` to keep the dependencies and state management code clean, and you’ll update the generated test to keep the code *correct*!

## Before you get started

This article assumes that you have [watched and followed the steps in this tutorial](https://www.youtube.com/watch?v=Mx24wiPilHg) to integrate your app with Firebase. To recap:

1. Create a new Flutter project, and call it `firebasecounter.`

1. Create a Firebase app [in the Firebase console](https://console.firebase.google.com/).

1. Link your app to iOS and/or Android, depending on your development environment and target audience.
> Note: If you configure your app to work on an Android client, make sure that you [create a `debug.keystore` file](https://gist.github.com/henriquemenezes/70feb8fff20a19a65346e48786bedb8f) before generating your SHA1 certificate.

After you generate your iOS or Android apps in Firebase, you are ready to proceed. The rest of the video contains great content that you will likely need for real projects, but it’s not required for this tutorial.

## In case you get stuck

If any of the steps in this tutorial do not work for you, consult [this public repo](https://github.com/craiglabenz/flutter-firestore-counter), which breaks down the changes into distinct commits. Throughout the tutorial, you will find links to each commit where appropriate. Feel free to use this to verify that you’ve followed along as intended!

## Create a simple state manager

To begin the process of integrating your app with Cloud Firestore, you must first refactor the generated code so that the initial `StatefulWidget` communicates with a separate class instead of its own attributes. This allows you to eventually instruct that separate class to use Cloud Firestore.

Next to your project’s auto-generated main.dart file, create a new file named `counter_manager.dart`, and copy the following code in it:

```dart
class CounterManager {
  /// Create a private integer to store the count. Make this private
  /// so that Widgets can't modify it directly, but instead must 
  /// use official methods.
  int _count = 0;

  /// Publicly accessible reference to our state.
  int get count => _count;

  /// Publicly accessible state mutator.
  void increment() => _count++;
}
```


With this code in place, add the following line to the top of `firebasecounter/lib/main.dart`:

```dart
import 'package:firebasecounter/counter_manager.dart';
```


Then, change `_MyHomePageState`’s code to this:

```dart
class _MyHomePageState extends State<MyHomePage> {
  final manager = CounterManager();

  void _incrementCounter() {
    setState(() => manager.increment());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '${manager.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```


After saving this code change, your app might appear to crash and show a red error screen. This is because you introduced a new variable, `manager`, whose opportunity to be initialized has passed. This is a common experience with Flutter when you change the way your state *is initialized*, and is easily solved with a hot restart.

After a hot restart, you should be back where you started: at a count of 0 and able to click the Floating Action Button as much as you want.

This is a good time to run the single test that Flutter provides in any new project. You can find its definition at `test/widget_test.dart`, and execute it by running:

```bash
$ flutter test
```


Assuming that the test passes, you should be ready to continue!
> Note: If you got stuck in this section, compare your changes to [this commit](https://github.com/craiglabenz/flutter-firestore-counter/commit/483dd3b3833bf710b04db4a3ba347b1d1ecbe5de) in the tutorial’s repo.

## Persist timestamps

The initial app description mentioned persisting the timestamp of each click. So far, you haven’t added any infrastructure to satisfy that second requirement, so create another new file named `app_state.dart`, and add the following class:

```dart
/// Container for the entirety of the app's state. An instance of 
/// this class should be able to inform what is rendered at any
/// point in time.
class AppState {
  /// Full click history. For super important auditing purposes.
  /// The count of clicks becomes this list's `length` attribute.
  final List<DateTime> clicks;

  /// Default generative constructor. Const-friendly, for optimal 
  /// performance.
  const AppState([List<DateTime> clicks])
      : clicks = clicks ?? const <DateTime>[];
      
  /// Convenience helper.
  int get count => clicks.length;

  /// Copy method that returns a new instance of AppState instead
  /// of mutating the existing copy.
  AppState copyWith(DateTime latestClick) => AppState([
    latestClick,
    ...clicks,
  ]);
}
```


From this point forward, the `AppState` class’s job is to represent the state of what should be rendered. The class contains no method that can mutate itself, only a single `copyWith` method that other classes will use.

Keeping testing in mind, you can begin making changes to the `CounterManager` concept. Having a single class won’t work in the long run, because the app eventually interacts with Cloud Firestore. Yet you don’t want to create real records every time you run the tests. To that end, you need an abstract interface that defines how the app should behave.

Open `counter_manager.dart` again, and add the following code at the top of the file:

```dart
import 'package:firebasecounter/app_state.dart';

/// Interface that defines the functions required to manipulate
/// the app state.
///
/// Defined as an abstract class so that tests can operate on a 
/// version that does not communicate with Firebase.
abstract class ICounterManager {
  /// Any `CounterManager` must have an instance of the state 
  /// object.
  AppState state;

  /// Handler for when a new click must be stored. Does not require 
  /// any parameters, because it only causes the timestamp to 
  /// persist.
  void increment();
}
```


The next step is to update `CounterManager` to explicitly descend from `ICounterManager`. Update its definition to this:

```dart
class CounterManager implements ICounterManager {
  AppState state = AppState();

  void increment() => state = state.copyWith(DateTime.now());
}
```


At this point, our helper code looks pretty good, but `main.dart` has fallen behind. There is no reference to `ICounterManager` in `main.dart`, when, in fact, that is the *only* Manager class it should know about. In `main.dart`, update apply the following changes:

1. Add the missing import to the top of the `main.dart`:

```dart
import 'package:firebasecounter/app_state.dart';
```


2. Update `_MyHomePageState` as follows:

```dart
class _MyHomePageState extends State<MyHomePage> {
  final ICounterManager manager;
  _MyHomePageState({@required this.manager});

  void _incrementCounter() => setState(() => manager.increment());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '${manager.state.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```


This change should remove any red squiggly lines in your IDE from `_MyHomePageState`, but now `MyHomePage` complains because its `createState()` method doesn’t supply all required arguments to `_MyHomePageState`. You could make `MyHomePage` require this variable and pass the object through to its `State`-based class, but that could lead to long chains of widgets requiring and passing objects that they don’t actually care about, simply because some descendent widget requires it and some ancestor widget supplies it. Clearly, this needs a better strategy.

Enter: [Provider](https://pub.dev/packages/provider)

## Using `Provider` to access application state

`Provider` is a library that streamlines the use of Flutter’s `InheritedWidget` pattern. `Provider` allows a widget high in your widget tree to be directly accessible by all of its descendants. This may feel like a global variable, but the alternative is to pass your data models down through every intermediate widget, many of whom will have no intrinsic interest in them. This “variables [bucket brigade](https://en.wikipedia.org/wiki/Bucket_brigade)” anti-pattern blurs your app’s separation of concerns and can make refactoring layouts unnecessarily tedious. `InheritedWidget` and `Provider` bypass those problems by allowing widgets anywhere in your widget tree to get the data models they need directly.

To add `Provider` to your application, open `pubspec.yaml`, and add it under the dependencies section:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Add this
  provider: ^4.3.2+2
```


After adding that line to your `pubspec.yaml` file, run the following to download `Provider` onto your machine:

```bash
$ flutter pub get
```


Next to `main.dart`, create a new file named `dependencies.dart` and copy the following code into it:

```dart
import 'package:firebasecounter/counter_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DependenciesProvider extends StatelessWidget {
  final Widget child;
  DependenciesProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ICounterManager>(create: (context) => CounterManager()),
      ],
      child: child,
    );
  }
}
```


A few notes about `DependenciesProvider`:

1. It uses `MultiProvider`, despite having only one entry in its list. This technically could be collapsed to a single `Provider` widget, but a real app will likely contain many such services, so it’s often best to start with `MultiProvider` right away.

1. It requires a `child` widget, which follows the Flutter convention for widget composition and allows us to insert this helper near the top of the widget tree, making the `ICounterManager` instance available to the entire app.

Next, make the new `DependenciesProvider` available to the entire app. A simple way to do this is to wrap the entire `MaterialApp` widget with it. Open `main.dart`, and update the `main` method to look like this:

```dart
void main() {
  runApp(
    DependenciesProvider(child: MyApp()),
  );
}
```


You also need to import `dependencies.dart` in `main.dart`:

```dart
import 'package:firebasecounter/dependencies.dart';
```


## Using a `Consumer` widget

You already saw the `MultiProvider` widget in action (which is really just a nicer way to declare a series of single `Provider` widgets). The next step is to access the `ICounterManager` object by using the [`Consumer`](https://pub.dev/documentation/provider/latest/provider/Consumer-class.html) widget.

## Dependency injection

If you’ve written a Flutter application using Cloud Firestore, then you probably discovered that Firestore can make good unit tests harder to write. After all, how do you avoid generating real records in your database when a Firestore integration is wired directly into your widget tree?

If you’ve had this experience, then you found the limitations of baking your dependencies directly into your UI code, which, in Flutter’s case, is widgets. This is the power of dependency injection: if your widgets accept helper classes that facilitate their interaction with dependencies (like Firebase, the device’s file system, or even network requests), then you can supply mocks or fakes instead of the real classes during tests. This allows you to test whether your widgets behave as expected without waiting on slow network requests, filling up your filesystem, or incurring Firebase billing charges.

To achieve this, you need to refactor the app so that there is a clean point where the tests can inject fakes that mimic real Cloud Firestore behavior. Luckily, the `Consumer` widget is perfect for this job.

Open `main.dart` and replace your `MyApp` widget with the following code:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<ICounterManager>(
        builder: (context, manager, _child) => MyHomePage(
          manager: manager,
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}
```


Also, import `Provider` at the top of `main.dart`:

```dart
import 'package:provider/provider.dart';
```


Wrapping `MyHomePage` in a `Consumer` widget allows you to reach arbitrarily high in the widget tree to access the desired resources and inject them into the widgets that need them. It may feel like unnecessary work in this tutorial, because you only reach back one layer to `MyApp()`, but this could stretch through dozens of widgets in real production apps.

Next, in the same file, make this edit to `MyHomePage`:
> Note: Don’t worry if you see a red screen after saving this change. More edits are needed to complete the refactor!

```dart
class MyHomePage extends StatefulWidget {
  final ICounterManager manager;
  MyHomePage({@required this.manager, Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```


This simple constructor change allows the code to accept the variable passed in the previous snippet.

Finally, complete the refactor by making this edit to `_MyHomePageState`:

```dart
class _MyHomePageState extends State<MyHomePage> {

  // No longer expect to receive a `ICounterManager object`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              // Reference `widget.manager` instead of
              // `manager` directly
              '${widget.manager.state.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Reference `widget.manager` instead of `manager` directly
        onPressed: () => setState(() => widget.manager.increment()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

> Note: You will likely have to perform a hot restart to fix your app.

As you might recall, all `State` objects contain a reference to their containing `StatefulWidget` wrappers in the `widget` attribute. Thus, the `_MyHomePageState` object can access this new `manager` attribute by changing its code from `manager` to `widget.manager`.

And, that’s it! You’ve injected dependencies into the widgets that need them instead of hardcoding production implementations.

## Test the app

If you run `flutter test` right now, you’ll see that the test suite no longer passes. When you inspect `widget_test.dart`, the reason might be clear: the test function instantiates `MyApp()`, but doesn’t wrap it with `DependenciesProvider` like you did in the real code, so the `Consumer` widget added within `MyApp` cannot find a satisfying `Provider` in its ancestor widgets.

This is where dependency injection begins to pay dividends. Instead of mimicking the production code in tests (by wrapping `MyApp` with `DependenciesProvider`), change the test to initialize `MyHomePage`. Update `widget_test.dart` to look like this:

```dart
import 'package:firebasecounter/counter_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebasecounter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(
          manager: CounterManager(),
          title: 'Test Widget',
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
```


By using a `MyHomePage` instance directly (along with a wrapping `MaterialApp` to provide valid `BuildContext` objects), you have set yourself up to have a unit-tested integration to Cloud Firestore!
> Note: If you got stuck in this section, compare your changes to [this commit](https://github.com/craiglabenz/flutter-firestore-counter/commit/bb68c1d3bb3746eca5f2dea16bd799c98ff232f1) in the tutorial’s repo.

## Implementing Cloud Firestore

So far, you’ve moved around a lot of code and introduced several helper classes, but you haven’t changed anything about how the app works. The good news is that everything is in place to begin writing some code that knows about Cloud Firestore. To start, open `pubspec.yaml`, and add these two lines:

```yaml
dependencies:
  # Add this
  cloud_firestore: ^0.14.1
  # Add this
  firebase_core: ^0.5.0
  flutter:
    sdk: flutter
  provider: ^4.3.2+2
```


As always when you apply changes to `pubspec.yaml` (unless your IDE does this for you), run the following command to download and link your new libraries:

```bash
$ flutter pub get
```

> Note: If you have not yet created your database: visit the Firebase console for your project, click on the **Cloud Firestore** tab, and click the **Create Database** button.

## Waiting on Firebase

The first step to successfully use Cloud Firestore is to initialize Firebase and, most critically, *not attempting to use any Firebase resources until this task is successful*. Luckily, you can contain that logic with one `StatefulWidget` instead of sprinkling that task all over your code.

Create a new file at `firebasecounter/lib/firebase_waiter.dart` and add the following code:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseWaiter extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final Widget waitingChild;
  const FirebaseWaiter({
    @required this.builder,
    this.waitingChild,
    Key key,
  }) : super(key: key);

  @override
  _FirebaseWaiterState createState() => _FirebaseWaiterState();
}

class _FirebaseWaiterState extends State<FirebaseWaiter> {
  Future<FirebaseApp> firebaseReady;

  @override
  void initState() {
    super.initState();
    firebaseReady = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<FirebaseApp>(
        future: firebaseReady,
        builder: (context, snapshot) => //
            snapshot.connectionState == ConnectionState.done
                ? widget.builder(context)
                : widget.waitingChild,
      );
}
```


This class uses the pattern in Flutter of leveraging certain widgets to completely handle a specific dependency or problem within your app. To use this `FirebaseWaiter` widget, return to `main.dart`, and apply the following change to `MyApp`:

```dart
// Add this import at the top
import 'package:firebasecounter/firebase_waiter.dart';

// Replace `MyApp` with this
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirebaseWaiter(
        builder: (context) => Consumer<ICounterManager>(
          builder: (context, manager, _child) => MyHomePage(
            manager: manager,
            title: 'Flutter Demo Home Page',
          ),
        ),
        // This is a great place to put your splash page!
        waitingChild: Scaffold(
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
```


Now, the app is able to wait for Firebase’s initialization, but can skip this process during tests by simply not using `FirebaseWaiter`.
> Note: The above changes may cause Flutter to complain about missing Firebase plugins. If it does, completely kill your app and start debugging again, which allows Flutter to install all platform-specific dependencies.

## Getting data from Cloud Firestore

First, import Cloud Firestore by adding the following line to the top of `counter_manager.dart`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
```


Next, also in `counter_manager.dart`, add the following class:

```dart
class FirestoreCounterManager implements ICounterManager {
  AppState state;
  final FirebaseFirestore _firestore;

FirestoreCounterManager()
      : _firestore = FirebaseFirestore.instance,
        state = const AppState() {
    _watchCollection();
  }

void _watchCollection() {
    // Part 1
    _firestore
        .collection('clicks')
        .snapshots()
        // Part 2
        .listen((QuerySnapshot snapshot) {
      // Part 3
      if (snapshot.docs.isEmpty) return;
      // Part 4
      final _clicks = snapshot.docs
          .map<DateTime>((doc) {
            final timestamp = doc.data()['timestamp'];
            return (timestamp != null)
                ? (timestamp as Timestamp).toDate()
                : null;
          })
          // Part 5
          .where((val) => val != null)
          // Part 6
          .toList();
      // Part 7
      state = AppState(_clicks);
    });
  }

  @override
  void increment() {
    _firestore.collection('clicks').add({
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
```

> Note: This class is almost correct, but creates a bug that is explored later. If you add this code to your app and run it right now, you will see that the behavior is not what you want. Read on for a thorough explanation of what is happening!

There’s a lot going on here, so let’s step through it.

First, `FirestoreCounterManager` implements the `ICounterManager` interface, so it’s an eligible candidate to use in production widgets. (Eventually, it will be supplied by`DependenciesProvider`!) `FirestoreCounterManager` also maintains an instance of `FirebaseFirestore`, which is the live connection to the production database. `FirestoreCounterManager` also calls `_watchCollection()` during its initialization to set up a connection to the specific data you care about, and this is where things get interesting.

The `_watchCollection()` method does a lot and deserves its own examination.

In Part 1, `_watchCollection()` calls `_firestore.collection('clicks').snapshots()`, which returns a stream of updates any time data in the collection changes.

In Part 2, `_watchCollection()` immediately registers a listener to that stream using `.listen()`. The callback passed to `listen()` receives a new `QuerySnapshot` object on each change to the data. This update object is called a snapshot because it reflects the correct state of the database at one time, but, at any point, could be replaced by a new snapshot.

In Part 3, the callback short-circuits if the collection is empty.

In Part 4, the callback loops over the snapshot’s documents and returns a list of mixed `null` and `DateTime` values.

In Part 5, the callback discards any `null` values. These arise from the bug that will be fixed shortly, but this sort of defensive coding is always a good idea when dealing with data from Cloud Firestore.

In Part 6, the callback addresses the fact that `map()` returns an iterator, not a list. Calling `.toList()` on an iterator forces it to process the entire collection, which is what you want.

And last, in Part 7, the callback updates the `state` object.

To use the new class, open `dependencies.dart`, and replace its contents with this:

```dart
import 'package:firebasecounter/counter_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DependenciesProvider extends StatelessWidget {
  final Widget child;
  DependenciesProvider({@required this.child});

@override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ICounterManager>(
            create: (context) => FirestoreCounterManager()),
      ],
      child: child,
    );
  }
}
```


## Diagnosing the bug

If you run this code as is, you’ll *almost* see the desired behavior. Everything seems correct, except the screen is always rendered one click behind reality. What is happening?

The issue arises from an incompatibility with the initial counter implementation and the current, stream-based implementation. The `FloatingActionButton`’s `onPressed` handler looks like this:

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () => setState(() => widget.manager.increment()),
  ...
)
```


That handler calls `increment()` and immediately invokes `setState()`, which tells Flutter to re-render.

This worked great when synchronously updating state held in the device’s memory. However, the new stream-based implementation starts a series of asynchronous steps. This means that, as-is, the code calls `setState()` immediately and then, only at an unknown future point, does the `manager` object update its `state` attribute. In short, the `setState()` call in the `onPressed` handler is happening too early! What’s worse, because all this activity happens inside a callback, deep within `FirestoreCounterManager` that no widgets know anything about, there is no `Future` that the widgets can `await` to solve the problem.

It’s almost as if the `manager` object needs to be able to tell the widgets when to redraw. 🤔

Enter: [ChangeNotifier](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple#changenotifier)
> Note: If you got stuck during this section, compare your changes with [this commit](https://github.com/craiglabenz/flutter-firestore-counter/commit/3bf17b9bfac6c907b8650e1c668fa19b1160a51d) in the public repo. These changes include Xcode and build.gradle changes resulting from adding Firebase, but you can likely focus on changes to the Dart files.

## Using `ChangeNotifier` to re-render the widget tree

`ChangeNotifier` is a class that does exactly what its name suggests: it notifies widgets when changes occur that require a re-render.

The first step in this process is to update the `ICounterManager` interface to extend `ChangeNotifier`. To do this, open `firebasecounter/lib/counter_manager.dart`, and make the following changes to the `ICounterManager` declaration:

```dart
// Add `extends ChangeNotifier` to your declaration
abstract class ICounterManager extends ChangeNotifier {
  // Everything inside the class is the same.
}
```


If you haven’t imported `flutter/material.dart` yet, open `firebasecounter/lib/counter_manager.dart`, and add it to the top:

```dart
import 'package:flutter/material.dart';
```


You’re now ready to update the definitions of `CounterManager` and `FirestoreCounterManager`. For `CounterManager`, replace its code with the following implementation:

```dart
class CounterManager extends ChangeNotifier implements ICounterManager {
  AppState state = AppState();

  /// Copies the state object with the timestamp of the most
  /// recent click and tells the stream to update.
  void increment() {
    state = state.copyWith(DateTime.now());
    // Adding this line is how `ChangeNotifier` tells widgets to
    // re-render themselves.
    notifyListeners();
  }
}
```


And, for `FirebaseCounterManager`, apply the following changes:

1. Edit its signature to match this:

```dart
class FirestoreCounterManager extends ChangeNotifier
    implements ICounterManager {
    ...
}
```


2. Add the same `notifyListeners();` line to the end of `_watchCollection()`, as follows:

```dart
void _watchCollection() {
  _firestore
      .collection('clicks')
      .snapshots()
      .listen((QuerySnapshot snapshot) {
      
    // Generation of `_clicks` omitted for clarity, but do not
    // change that code.

    state = AppState(_clicks);
    
    // The only change necessary is to add this line!
    notifyListeners();
  });
}
```


You’ve now set up half of the changes necessary for the `ICounterManager` classes to tell the widgets to re-render any time the data changes. The `Manager` classes are telling the widgets to re-render, but if you run your app now, you’ll see that the widgets aren’t listening.

To fix this, open `dependencies.dart` and replace the implementation of `DependenciesProvider` with the following:

```dart
class DependenciesProvider extends StatelessWidget {
  final Widget child;
  DependenciesProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // `Provider` has been replaced by ChangeNotifierProvider
        ChangeNotifierProvider<ICounterManager>(
          create: (context) => FirestoreCounterManager(),
        ),
      ],
      child: child,
    );
  }
}
```


As a last change, remove `setState` from `_MyHomePageState` to skip an unnecessary re-render. Update its `FloatingActionButton` to look like this:

```dart
      floatingActionButton: FloatingActionButton(
        // Remove setState()!
        onPressed: widget.manager.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
```


And, that’s it! `ChangeNotifierProvider` makes sure that the widgets are “listeners”, so that when `notifyListeners()` is called by an `ICounterManager` class, the widgets get the message to re-render.

At this point, you should be able to hot restart your app and see everything working!

Note: If you got stuck during this section, compare your changes against [this commit](https://github.com/craiglabenz/flutter-firestore-counter/commit/dfb584f62d094d8fdb6067ea11ff3551b9186aed) of the public repo.

## Fixing the tests

While the last round of changes successfully implemented the desired functionality, unfortunately, they also broke the tests. Next, you’ll apply a few more tweaks to get everything working again, and you’ll be done.

In `widget_test.dart`, the code passes a `CounterManager` instance directly without an accompanying `ChangeNotifierListener`. The way this was handled in the widget tree was to wrap everything in `DependenciesProvider`, but that class knows about Firestore, and the whole point of this is to keep Firestore out of the tests.

One solution is to create `TestDependenciesProvider`, which can contain the testing versions of all of the dependencies. Open `firebasecounter/lib/dependencies.dart`, and add the following class:

```dart
class TestDependenciesProvider extends StatelessWidget {
  final Widget child;
  TestDependenciesProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ICounterManager>(
          create: (context) => CounterManager(),
        ),
      ],
      child: child,
    );
  }
}
```


This class is almost identical to `DependenciesProvider`, but `TestDependenciesProvider` provides an instance of `CounterManager()` instead of `FirestoreCounterManager()`.

Now, in `test/widget_test.dart`, update the test widget initialization to this:

```dart
await tester.pumpWidget(
  TestDependenciesProvider(
    child: MaterialApp(
      home: Consumer<ICounterManager>(
        builder: (context, manager, _child) => MyHomePage(
          manager: manager,
          title: 'Flutter Test Home Page',
        ),
      ),
    ),
  ),
);
```


If you haven’t yet, add these two imports near the top of `test/widget_test.dart`:

```dart
import 'package:firebasecounter/dependencies.dart';
import 'package:provider/provider.dart';
```


Run your tests again, and, viola!

Note: If you got stuck during this section, compare your changes against [this commit](https://github.com/craiglabenz/flutter-firestore-counter/commit/cb8c876abfa80b013bb122ed289163ab5587f5cc) of the public repo.

## Wrapping up

In this article, you remodeled the classic Flutter counter app so that it persists all activity to Cloud Firestore. You also avoided mixing business logic into any widgets, meaning that the app is easy to test.

The state management techniques covered here are viable for many apps, but they aren’t the only or best ways. The Flutter community is rich with excellent state management solutions that are worth your investigation. Here are a few to consider:

1. [Flutter Bloc](https://pub.dev/packages/flutter_bloc) is particularly useful for anyone with [Redux](https://redux.js.org/) experience.

1. This [Flutter Firebase and DDD video tutorial series](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iS5p-IezFFgqP6YvAJy84U) by [Reso Coder](https://www.youtube.com/resocoder) walks you through the entire process of using Flutter Bloc, Cloud Firestore, and several other excellent libraries.

1. This [more direct port of Redux](https://pub.dev/packages/flutter_redux) is also popular.

1. The newest entry on the list; the creator of `Provider` released a new package, [Riverpod](https://pub.dev/packages/riverpod), which is `Provider`’s successor.

For more information on state management, see the [State Management docs](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro) on flutter.dev.

Whichever state management solution you choose, good luck, and happy coding!