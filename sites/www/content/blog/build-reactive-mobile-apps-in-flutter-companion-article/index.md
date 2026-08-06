---
title: "Build reactive mobile apps in Flutter — companion article"
description: >-
  Learn the principles and patterns behind building
  reactive mobile apps and managing state in Flutter.
publishDate: 2018-06-01
author: filiph
image: images/1DnixY5zJXnLe_x_eqSKkUA.webp
category: tutorial
layout: blog
---

**UPDATE (March 2019) —** If you’re just starting to learn about Flutter and state management, I recommend you read the [state management section at flutter.dev](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro) instead of this article. I wrote both this article and the section at flutter.dev, and I think the latter is more approachable and exhaustive. It is also newer.

At Google I/O, Matt and I gave a talk about state management called [Build reactive mobile apps in Flutter](https://www.youtube.com/watch?v=RS36gBEp8OI). If you missed it, you can watch it below:

<YoutubeEmbed id="RS36gBEp8OI" title="Build reactive mobile apps with Flutter (Google I/O '18)" fullwidth="true"/>

The code for the talk is on github:

<GitHubEmbed repo="filiph/state_experiments" title="state_experiments - Companion repository to the &quot;Build reactive mobile apps in Flutter&quot; talk" image="images/0k6VwvGyERET4BiU0.webp" />

This article is about the things that didn’t fit into the 33-minute session.

## ValueNotifier

`ValueNotifier` is a basic implementation of observable that comes with the Flutter framework. It has a value, listeners (callbacks), and it calls the listeners any time the value changes. The functionality is implemented in about [200](https://github.com/flutter/flutter/blob/b9a7f1b915349210c7a80b1ac158ed43fd88f612/packages/flutter/lib/src/foundation/change_notifier.dart#L203) lines of Dart code, the vast majority of which are documentation comments.

You can use `ValueNotifier` like this:

```dart
final counter = ValueNotifier(0);

counter.addListener(_myCallback);

counter.value = 10;  // Calls _myCallback.
counter.value += 1;  // Also calls _myCallback.

counter.removeListener(_myCallback);

counter.value += 1;  // Doesn't call anything.

counter.dispose();
```

In other words, whenever you set the `value` to something new, all the registered listeners are called.

You can extend `ValueNotifier` to get more functionality. This makes the most sense with mutable values.

```dart
class CartObservable extends ValueNotifier<Cart> {
  CartObservable(Cart value) : super(value);

  void add(Product product) {
    value.add(product);
    notifyListeners();
  }
}
```

The advantage of `ValueNotifier` is that it’s simple, easy to understand, and included with Flutter. It’s also completely synchronous, which might be an advantage in some cases. In itself, it won’t help you with access (you’ll have to pass around the object somehow — through `InheritedWidget` or, for shallow widget trees, through constructors), and you’ll still have to manually call `setState()` and manage listeners.

## Firebase / Cloud Firestore references

In the talk, we show how to use the `StreamBuilder` widget to automatically rebuild UI on state change.

[Cloud Firestore](https://firebase.google.com/docs/firestore/) (and its older sibling, [Firebase Realtime Database](https://firebase.google.com/docs/database/)) have great Flutter plugins ([`cloud_firestore`](https://pub.dartlang.org/packages/cloud_firestore) and [`firebase_database`](https://pub.dartlang.org/packages/firebase_database)), and these plugins use Streams. So, for example, you can just plug your Firestore snapshots into a StreamBuilder, and you’re done.

```dart
StreamBuilder(
  stream: Firestore.instance.collection('baby').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return const Text('Loading...');
    return ListView.builder(
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) {
        DocumentSnapshot ds = snapshot.data.documents[index];
        return Text("${ds['name']} ${ds['votes']}");
      }
    );
  },
);
```

This is really all you need if your app only presents data, or if its business logic is very straightforward. You can learn more in the [Firebase for Flutter codelab](https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html#0).

Of course, once your app grows, you can move away from exposing the raw Firebase stream to the widgets, and wrap it instead. For example, a business logic component can internally communicate with a real time database but the widgets don’t need to know about it.

## InheritedWidget

We used `InheritedWidget` extensively in our talk: implicitly with `ScopedModel`, which builds on `InheritedWidget`, and explicitly with BLoC, to pass around references to data streams. `InheritedWidget` is part of the core Flutter platform, and provides an easy means to make data accessible anywhere in a widget tree.

Defining an `InheritedWidget` is simple:

```dart
class MyInheritedValue extends InheritedWidget {
  const MyInheritedValue({
    Key key,
    @required this.value,
    @required Widget child,
  }) : assert(value != null),
       assert(child != null),
       super(key: key, child: child);

  final int value;

  static MyInheritedValue of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedValue);
  }

  @override
  bool updateShouldNotify(MyInheritedValue old) =>
      value != old.value;
}
```

It’s also easy to provide it to an ancestor:

```dart
Widget build(BuildContext context) {
  return MyInheritedValue(
    value: 42,
    child: ...
  );
}
```

And it’s easy to use it down the tree.

```dart
MyInheritedValue.of(context).value
```

While `InheritedWidget` is useful for keeping your widget tree DRY and encapsulated (since references to data do not need to be passed explicitly), note that the data is immutable. In order to use `InheritedWidget` to track changing data, either a) wrap it in a `StatefulWidget` or b) use streams or `ValueNotifier` inside the `InheritedWidget`.

## Redux

What more can be said about Redux that hasn’t already been said elsewhere? Suffice to say that Dart has an [implementation](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/redux) of Redux, and there’s a Flutter [extension](https://pub.dartlang.org/packages/flutter_redux) that provides an elegant Widget framework on top.

In practice, the widget structure looks very similar to Scoped Model, where a `StoreProvider` gives access to state throughout the widget tree, via the `StoreConnector`.

There’s a simple example of using Redux to manage state in Flutter’s default incrementer app [on the pub site](https://pub.dartlang.org/packages/flutter_redux). There’s also a more sophisticated example with a [todo sample app](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/redux). If you’re interested in using Redux in Flutter, check these out.

## Business Logic Components (BLoC)

If you’re interested in the concept of business logic components, check out Paolo Soares’ talk from DartConf (January 2018):

<YoutubeEmbed id="PLHln7wHgPE" title="Flutter / AngularDart - Code sharing, better together (DartConf 2018)" fullwidth="true"/>

The BLoC pattern was conceived by Cong Hui, Paolo Soares, and Wenfan Huang at Google. As you can see in Paolo’s talk, there is a lot more to BLoC than what we discussed in our I/O session. Among other things, BLoC allows Google to share code between Flutter (mobile) and AngularDart (web) apps, and Paolo shares some guidance about that. Here, I’d like to focus on the things that apply to Flutter regardless of whether you’re also using the component elsewhere.

With that, some additional notes about this pattern:

* BLoC doesn’t assume a particular way to get access to the component. In the talk, I’m showing how you might do that with `InheritedWidget` but nothing stops you from passing it down manually through constructors, or using some form of automatic dependency injection.

* You should avoid having one BLoC as a parameter of another BLoC. Instead, plug only the required outputs to the applicable inputs. This helps avoid [tight coupling](https://stackoverflow.com/questions/2832017/what-is-the-difference-between-loose-coupling-and-tight-coupling-in-the-object-o).

* Large apps need more than one BLoC. A good pattern is to use one top-level component for each screen, and one for each complex-enough widget. Too many BLoCs can become cumbersome, though. Also, if you have hundreds upon hundreds of observables (streams) in your app, that has a negative impact on performance. In other words: don’t over-engineer your app.

* In a hierarchy of BLoCs, the top-level (screen) BLoC is normally responsible for plugging streams of children BLoCs to each other. More on that in a later article.

* BLoC is compatible with server logic. The pattern doesn’t force you to re-implement that logic on the client (like Flux/Redux would). Just wrap the server-side logic with a component.

* One disadvantage that stems from the asynchronicity of streams is that when you build a `StreamBuilder`, it always shows `initialData` first (because it is available synchronously) and only *then* does it show the first event coming from the `Stream`. This can lead to a flash (one frame) of missing data. There are ways to prevent this — stay tuned for a more detailed article. **UPDATE**: If using `rxdart` version `0.19.0` and above, [you can just use `ValueObservable`](https://twitter.com/filiphracek/status/1050798900968181761) for outputs and the flash of async is no longer an issue.

* The inside of the BLoC is often implemented in a purely functional-reactive way (no auxiliary state, pure transformations of one stream to another). But don’t feel obligated to do it this way. Sometimes, it’s easier and more readable/maintainable to express the business logic through hybrid imperative-functional approach (like I was doing in the I/O talk, although that was mainly to save time).

Some people asked for a more complex BLoC sample. I recreated the shopping app into a more realistic example where the catalog of products is fetched from the network page by page, and we have an infinite list of these products. Also, for each product in the catalog, we want to change the presentation of the ProductSquare slightly when the product is already in the catalog. The network calls are simulated but the complexity of wiring different things together is there.

<DashImage figure src="images/1DnixY5zJXnLe_x_eqSKkUA.webp" alt="You can see how, in this version of the sample, the products are loaded in batches, and the `ProductSquare`s show whether the product is in the cart (by underlining the product name, for simplicity)." caption="You can see how, in this version of the sample, the products are loaded in batches, and the `ProductSquare`s show whether the product is in the cart (by underlining the product name, for simplicity)." />

You can find the code in the companion repository, at [`lib/src/bloc_complex`](https://github.com/filiph/state_experiments/tree/master/shared/lib/src/bloc_complex). There’s a README file with more information about this version.

We hope the talk and this article have been useful. You might want to watch [other Flutter talks and videos on YouTube](https://www.youtube.com/playlist?list=PLOU2XLYxmsIJ7dsVN4iRuA7BT8XHzGtCr).
