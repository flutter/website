---
title: Trackpad gestures can trigger GestureRecognizer
description: Trackpad gestures on most platforms now send `PointerPanZoom` sequences and can trigger pan, drag, and scale `GestureRecognizer` callbacks. 
---

## Summary

Trackpad gestures on most platforms now send `PointerPanZoom` sequences and
can trigger pan, drag, and scale `GestureRecognizer` callbacks. 

## Context

Scrolling on Flutter Desktop prior to version 3.3.0 used `PointerScrollEvent`
messages to represent discrete scroll deltas. This system worked well for mouse
scroll wheels, but wasn't a good fit for trackpad scrolling. Trackpad scrolling
is expected to cause momentum, which depends not only on the scroll deltas, but
also the timing of when fingers are released from the trackpad. In addition, trackpad
pinching-to-zoom could not be represented.

Three new `PointerEvent`s have been introduced: `PointerPanZoomStartEvent`,
`PointerPanZoomUpdateEvent`, and `PointerPanZoomEndEvent`. Relevant `GestureRecognizer`s
have been updated to register interest in trackpad gesture sequences, and will
emit `onDrag`, `onPan`, and/or `onScale` callbacks in response to movements
of two or more fingers on the trackpad.

This means both that code designed only for touch interactions might trigger upon
trackpad interaction, and that code designed to handle all desktop scrolling
might now only trigger upon mouse scrolling, and not trackpad scrolling.

## Description of change

The Flutter engine has been updated on all possible platforms to recognize
trackpad gestures and send them to the framework as `PointerPanZoom` events
instead of as `PointerScrollSignal` events. `PointerScrollSignal` events will
still be used to represent scrolling on a mouse wheel.

Depending on the platform and specific trackpad model, the new system might not
be used, if not enough data is provided to the Flutter engine by platform APIs.
This includes on Windows, where trackpad gesture support is dependent on the
trackpad's driver, and the Web platform, where not enough data is provided by
browser APIs, and trackpad scrolling must still use the old `PointerScrollSignal
system.

Developers should be prepared to receive both types of events and ensure their apps
or packages handle them in the appropriate manner.

`Listener` now has three new callbacks: `onPointerPanZoomStart`,
`onPointerPanZoomUpdate`, and `onPointerPanZoomEnd` which can be used to observe
trackpad scrolling and zooming events.

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent) {
          debugPrint('mouse scrolled ${event.scrollDelta}');
        }
      },
      onPointerPanZoomStart: (PointerPanZoomStartEvent event) {
        debugPrint('trackpad scroll started');
      },
      onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent event) {
        debugPrint('trackpad scrolled ${event.panDelta}');
      },
      onPointerPanZoomEnd: (PointerPanZoomEndEvent event) {
        debugPrint('trackpad scroll ended');
      },
      child: Container()
    );
  }
}
```

`PointerPanZoomUpdateEvent` contains a `pan` field to represent the cumulative
pan of the current gesture, a `panDelta` field to represent the difference in pan
since the last event, a `scale` event to represent the cumulative zoom of the
current gesture, and a `rotation` event to represent the cumulative rotation
(in radians) of the current gesture.

`GestureRecognizer`s now have methods to all the trackpad events from one
continuous trackpad gesture. Calling the `addPointerPanZoom` method on a
`GestureRecognizer` with a `PointerPanZoomStartEvent` will cause the recognizer
to register its interest in that trackpad interaction, and resolve conflicts
between multiple `GestureRecognizer`s that could potentially respond to the
gesture.

The following example shows the proper use of `Listener` and `GestureRecognizer`
to respond to trackpad interactions.

```dart
void main() => runApp(Foo());

class Foo extends StatefulWidget {
  late final PanGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    recognizer = PanGestureRecognizer()
    ..onStart = _onPanStart
    ..onUpdate = _onPanUpdate
    ..onEnd = _onPanEnd;
  }

  void _onPanStart(DragStartDetails details) {
    debugPrint('onStart');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    debugPrint('onUpdate');
  }

  void _onPanEnd(DragEndDetails details) {
    debugPrint('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: recognizer.addPointer,
      onPointerPanZoomStart: recognizer.addPointerPanZoom,
      child: Container()
    );
  }
}
```

When using `GestureDetector`, this is done automatically, so code such as the
following example will issue its gesture update callbacks in response to both
touch and trackpad panning.

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        debugPrint('onStart');
      },
      onPanUpdate: (details) {
        debugPrint('onUpdate');
      },
      onPanEnd: (details) {
        debugPrint('onEnd');
      }
      child: Container()
    );
  }
}
```

## Migration guide

Migration steps depend on whether you want each gesture interaction in your
app to be usable via a trackpad, or whether it should be restricted to only
touch and mouse usage.

### For gesture interactions suitable for trackpad usage

#### Using `GestureDetector`

No change is needed, `GestureDetector` will automatically process trackpad
gesture events and trigger callbacks if recognized.

#### Using `GestureRecognizer` and `Listener`

Ensure that `onPointerPanZoomStart` is passed through to each recognizer from the
`Listener`. The `addPointerPanZoom` method of `GestureRecognizer must be called
for it to show interest and start tracking each trackpad gesture.

Code before migration:

```dart
void main() => runApp(Foo());

class Foo extends StatefulWidget {
  late final PanGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    recognizer = PanGestureRecognizer()
    ..onStart = _onPanStart
    ..onUpdate = _onPanUpdate
    ..onEnd = _onPanEnd;
  }

  void _onPanStart(DragStartDetails details) {
    debugPrint('onStart');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    debugPrint('onUpdate');
  }

  void _onPanEnd(DragEndDetails details) {
    debugPrint('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: recognizer.addPointer,
      child: Container()
    );
  }
}
```

Code after migration:

```dart
void main() => runApp(Foo());

class Foo extends StatefulWidget {
  late final PanGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    recognizer = PanGestureRecognizer()
    ..onStart = _onPanStart
    ..onUpdate = _onPanUpdate
    ..onEnd = _onPanEnd;
  }

  void _onPanStart(DragStartDetails details) {
    debugPrint('onStart');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    debugPrint('onUpdate');
  }

  void _onPanEnd(DragEndDetails details) {
    debugPrint('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: recognizer.addPointer,
      onPointerPanZoomStart: recognizer.addPointerPanZoom,
      child: Container()
    );
  }
}
```

#### Using raw `Listener`

The following code using PointerScrollSignal will no longer be called upon all
desktop scrolling. `PointerPanZoomUpdate` events should be captured to receive
trackpad gesture data.

Code before migration:

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent) {
          debugPrint('scroll wheel event');
        }
      }
      child: Container()
    );
  }
}
```

Code after

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent) {
          debugPrint('scroll wheel event');
        }
      },
      onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent event) {
        debugPrint('trackpad scroll event');
      }
      child: Container()
    );
  }
}
```

Please note: Use of raw `Listener` in this way could cause conflicts with other
gesture interactions as it does not participate in the gesture disambiguation arena.

### For gesture interactions not suitable for trackpad usage

#### Using `GestureDetector`

If using Flutter 3.3.0, `RawGestureDetector` can be used instead of `GestureDetector`
to ensure each `GestureRecognizer` created by the `GestureDetector` has
`supportedDevices` set to exclude `PointerDeviceKind.trackpad`. Starting in
version 3.4.0, there will be a `supportedDevices` parameter directly on
`GestureDetector`.

Code before migration:

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        debugPrint('onStart');
      },
      onPanUpdate: (details) {
        debugPrint('onUpdate');
      },
      onPanEnd: (details) {
        debugPrint('onEnd');
      }
      child: Container()
    );
  }
}
```

Code after migration (Flutter 3.3.0):

```dart
// Example of code after the change.
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(
            supportedDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
              // Do not include PointerDeviceKind.trackpad
            }
          ),
          (recognizer) {
            recognizer
              ..onStart = (details) {
                debugPrint('onStart');
              }
              ..onUpdate = (details) {
                debugPrint('onUpdate');
              }
              ..onEnd = (details) {
                debugPrint('onEnd');
              };
          },
        ),
      },
      child: Container()
    );
  }
}
```

Code after migration: (Flutter 3.4.0):

<!-- skip -->
```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      supportedDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        // Do not include PointerDeviceKind.trackpad
      },
      onPanStart: (details) {
        debugPrint('onStart');
      },
      onPanUpdate: (details) {
        debugPrint('onUpdate');
      },
      onPanEnd: (details) {
        debugPrint('onEnd');
      }
      child: Container()
    );
  }
}
```

#### Using `RawGestureRecognizer`

Explicitly ensure that `supportedDevices` does not include `PointerDeviceKind.trackpad`.

Code before migration:

```dart
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(),
          (recognizer) {
            recognizer
              ..onStart = (details) {
                debugPrint('onStart');
              }
              ..onUpdate = (details) {
                debugPrint('onUpdate');
              }
              ..onEnd = (details) {
                debugPrint('onEnd');
              };
          },
        ),
      },
      child: Container()
    );
  }
}
```

Code after migration:

```dart
// Example of code after the change.
void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(
            supportedDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
              // Do not include PointerDeviceKind.trackpad
            }
          ),
          (recognizer) {
            recognizer
              ..onStart = (details) {
                debugPrint('onStart');
              }
              ..onUpdate = (details) {
                debugPrint('onUpdate');
              }
              ..onEnd = (details) {
                debugPrint('onEnd');
              };
          },
        ),
      },
      child: Container()
    );
  }
}
```

#### Using `GestureRecognizer` and `Listener`

After upgrading to Flutter 3.3.0, there won't be a change in behavior, as
`addPointerPanZoom` needs to be called on each `GestureRecognizer` to allow
it to track gestures. The following code will not receive pan gesture callbacks
when the trackpad is scrolled.

```dart
void main() => runApp(Foo());

class Foo extends StatefulWidget {
  late final PanGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    recognizer = PanGestureRecognizer()
    ..onStart = _onPanStart
    ..onUpdate = _onPanUpdate
    ..onEnd = _onPanEnd;
  }

  void _onPanStart(DragStartDetails details) {
    debugPrint('onStart');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    debugPrint('onUpdate');
  }

  void _onPanEnd(DragEndDetails details) {
    debugPrint('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: recognizer.addPointer,
      // recognizer.addPointerPanZoom is not called
      child: Container()
    );
  }
}
```

## Timeline

Landed in version: 3.3.0-0.0.pre
In stable release: 3.3.0

## References

API documentation:

* [`GestureDetector` (3.3.0)][]
* [`GestureDetector` (3.4.0)][]
* [`RawGestureDetector`][]
* [`GestureRecognizer`][]

Design Document
* [Flutter Trackpad Gestures][]

Relevant issues:

* [Issue 23604][]

Relevant PRs:

* [Support trackpad gestures in framework][]
* [iPad trackpad gestures][]
* [Linux trackpad gestures][]
* [Mac trackpad gestures][]
* [Win32 trackpad gestures][]
* [ChromeOS/Android trackpad gestures][]

[`GestureDetector` (3.3.0)]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[`GestureDetector` (3.4.0)]: {{site.master-api}}/flutter/widgets/GestureDetector-class.html
[`GestureRecognizer`]: {{site.api}}/flutter/gestures/GestureRecognizer-class.html
[`RawGestureDetector`]: {{site.api}}/flutter/widgets/RawGestureDetector-class.html
[Flutter Trackpad Gestures]: https://docs.google.com/document/d/1oRvebwjpsC3KlxN1gOYnEdxtNpQDYpPtUFAkmTUe-K8
[Issue 23604]: {{site.repo.flutter}}/issues/23604
[Support trackpad gestures in framework]: {{site.repo.flutter}}/pull/89944
[iPad trackpad gestures]: {{site.repo.engine}}/pull/31591
[Linux trackpad gestures]: {{site.repo.engine}}/pull/31592
[Mac trackpad gestures]: {{site.repo.engine}}/pull/31593
[Win32 trackpad gestures]: {{site.repo.engine}}/pull/31594
[ChromeOS/Android trackpad gestures]: {{site.repo.engine}}/pull/34060
