---
title: LayoutBuilder optimization
description: LayoutBuilder and SliverLayoutBuilder call the builder function less often.
---

## Summary

This guide explains how to migrate Flutter applications after [the LayoutBuilder
optimization][1].

## Context

[LayoutBuilder][2] and [SliverLayoutBuilder][3] call the [builder][4] function
more often than necessary to fulfill their primary goal of allowing apps to adapt
their widget structure to parent layout constraints. This has led to less
efficient and jankier applications because widgets are rebuilt unnecessarily.

This transitively affects [OrientationBuilder][5] as well.

In order to improve app performance the [LayoutBuilder optimization][1] was made,
which results in calling the `builder` function less often.

Apps that rely on this function to be called with a certain frequency may break.
The app may exhibit some combination of the following symptoms:

* The `builder` function is not called when it would before the upgrade to the
  Flutter version that introduced the optimization.
* The UI of a widget is missing.
* The UI of a widget is not updating.

## Description of change

Prior to the optimization the builder function passed to `LayoutBuilder` or
`SliverLayoutBuilder` was called when any one of the following happened:

1. `LayoutBuilder` is rebuilt due to a widget configuration change (this typically
   happens when the widget that uses `LayoutBuilder` rebuilds due to `setState`,
   `didUpdateWidget` or `didChangeDependencies`).
1. `LayoutBuilder` is laid out and receives layout constraints from its parent
   that are _different_ from the last received constraints.
1. `LayoutBuilder` is laid out and receives layout constraints from its parent
   that are the _same_ as the constraints received last time.

After the optimization the builder function is no longer called in the latter
case. If the constraints are the same and the widget configuration did not
change, the builder function is not called.

Your app can break if it relies on the relayout to cause the rebuilding of the
`LayoutBuilder` rather than on an explicit call to `setState`. This usually
happens by accident. You meant to add `setState`, but you forgot because the app
continued functioning as you wanted, and therefore nothing reminded you to add
it.

## Migration guide

Look for usages of `LayoutBuilder` and `SliverLayoutBuilder` and make sure to
call `setState` any time the widget state changes.

**Example**: in the example below the contents of the builder function depend
on the value of the `_counter` field. Therefore, whenever the value is updated,
you should call `setState` to tell the framework to rebuild the widget. However,
this example may have previously worked even without calling `setState`, if the
`_ResizingBox` triggers a relayout of `LayoutBuilder`.

Code before migration (note the missing `setState` inside the `onPressed`
callback):

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  Counter({Key key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _ResizingBox(
            TextButton(
                onPressed: () {
                  _counter++;
                },
                child: Text('Increment Counter')),
            Text(_counter.toString()),
          );
        },
      ),
    ));
  }
}

class _ResizingBox extends StatefulWidget {
  _ResizingBox(this.child1, this.child2);

  final Widget child1;
  final Widget child2;

  @override
  State<StatefulWidget> createState() => _ResizingBoxState();
}

class _ResizingBoxState extends State<_ResizingBox>
    with SingleTickerProviderStateMixin {
  Animation animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    )
      ..forward()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100 + animation.value * 100,
          child: widget.child1,
        ),
        SizedBox(
          width: 100 + animation.value * 100,
          child: widget.child2,
        ),
      ],
    );
  }
}
```

Code after migration (`setState` added to `onPressed`):

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  Counter({Key key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _ResizingBox(
            TextButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: Text('Increment Counter')),
            Text(_counter.toString()),
          );
        },
      ),
    ));
  }
}

class _ResizingBox extends StatefulWidget {
  _ResizingBox(this.child1, this.child2);

  final Widget child1;
  final Widget child2;

  @override
  State<StatefulWidget> createState() => _ResizingBoxState();
}

class _ResizingBoxState extends State<_ResizingBox>
    with SingleTickerProviderStateMixin {
  Animation animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    )
      ..forward()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100 + animation.value * 100,
          child: widget.child1,
        ),
        SizedBox(
          width: 100 + animation.value * 100,
          child: widget.child2,
        ),
      ],
    );
  }
}
```

Watch for usages of `Animation` and `LayoutBuilder` in the same widget.
Animations have internal mutable state that changes on every frame. If the
logic of your builder function depends on the value of the animation, it may
require a `setState` to update in tandem with the animation. To do that, add an
[animation listener][7] that calls `setState`, like so:

<!-- skip -->
```dart
Animation animation = … create animation …;
animation.addListener(() {
  setState(() {
    // Intentionally empty. The state is inside the animation object.
  });
});
```

## Timeline

This change was released in Flutter v1.20.0.

## References

API documentation:
* [`LayoutBuilder`][2]
* [`SliverLayoutBuilder`][3]

Relevant issues:
* [Issue 6469][8]

Relevant PRs:
* [LayoutBuilder: skip calling builder when constraints are the same][6]

[1]: /go/layout-builder-optimization
[2]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[3]: {{site.api}}/flutter/widgets/SliverLayoutBuilder-class.html
[4]: {{site.api}}/flutter/widgets/LayoutBuilder/builder.html
[5]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
[6]: {{site.github}}/flutter/flutter/pull/55414
[7]: {{site.api}}/flutter/animation/Animation/addListener.html
[8]: {{site.github}}/flutter/flutter/issues/6469
