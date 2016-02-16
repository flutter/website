---
layout: page
title: Debugging Flutter Applications
permalink: /debugging/
---

There are a wide variety of tools and features to help debug Flutter
applications.

## The Dart Analyzer

Before running your applications, test your code with `flutter
analyze`. This tool (which is a wrapper around the `dartanalyzer`
tool) will analyze your code and help you find possible mistakes.
If you're using the
[Flutter plugin for Atom](https://atom.io/packages/flutter), this
is already happening for you.

The Dart analyzer makes heavy use of type annotations that you put in
your code to help track problems down. You are encouraged to use them
everywhere (avoiding `var`, untyped arguments, untyped list literals,
etc) as this is the quickest and least paintful way of tracking down
problems.

## Dart Observatory (statement-level single-stepping debugger and profiler)

If you started your application on an Android device using `flutter
start`, then, while it is running, you can open the Web page at
[http://localhost:8181/](http://localhost:8181/) to connect to your
application directly with a statement-level single-stepping debugger.
Observatory also supports profiling, examining the heap, etc.

For more information on Observatory, see [Observatory's
documentation](https://dart-lang.github.io/observatory/).

If you use Observatory for profiling, make sure to run your
application in release mode, by passing `--no-checked` to the `flutter
start` command. Otherwise, the main thing that will appear on your
profile will be the checked-mode asserts verifying the framework's
various invariants (see "Checked mode assertions" below).

### `debugger()` statement

When using the Dart Observatory (or another Dart debugger, such as the
debugger in the Atom IDE), you can insert programmatic breakpoints
using the `debugger()` statement. To use this, you have to put `import
'dart:developer';` at the top of the relevant file.

The `debugger()` statement takes an optional `when` argument which you
can specify to only break when a certain condition is true, as in:

<!-- import 'dart:developer'; -->
<!-- skip -->
```dart
void someFunction(double offset) {
  debugger(when: offset > 30.0);
  // ...
}
```

## `print` and `debugPrint` with `flutter logs`

The Dart `print()` function will output to the system console, which
you can view using `flutter logs` (which is basically a wrapper around
`adb logcat`).

If you output too much at once, then Android sometimes discards some
log lines. To avoid this, you can use `debugPrint()`, from Flutter's
`services` library. This is a wrapper around `print` which throttles
the output to a level that avoids being dropped by Android's kernel.

## Checked mode assertions

During development, you are highly encouraged to use Dart's "checked"
mode, sometimes referred to as "debug" mode. This is the default if
you use `flutter run`. In this mode, the Dart `assert` statement is
enabled, and the Flutter framework uses this to perform many runtime
checks verifying that invariants aren't being violated.

When an invariant is violated, it is reported to the console, with
some context information to help with tracking down the source of the
problem.

To turn off checked mode, and use release mode, run your application
using `flutter run --no-checked`.

## Dumping the application state

Each layer of the Flutter framework provides a function to dump its
current state to the console (using `debugPrint`).

### Widget layer

To dump the state of the Widgets library, call
[`debugDumpApp()`](http://docs.flutter.io/flutter/widgets/debugDumpApp.html).
You can call this more or less any time that the application is not in
the middle of running a build phase (i.e. anywhere not inside a
`build()` method), so long as the application has built at least once
(i.e. any time after calling `runApp()`).

For example, this application:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      routes: {
        '/': (RouteArguments args) => new AppHome()
      }
    )
  );
}

class AppHome extends StatelessComponent {
  Widget build(BuildContext context)  {
    return new Material(
      child: new Center(
        child: new FlatButton(
          onPressed: () { debugDumpApp(); },
          child: new Text('Dump App')
        )
      )
    );
  }
}
```

...will output something like this (the precise details will vary on
the version of the framework, the size of the device, and so forth):


```
android: I/flutter : WidgetFlutterBinding - CHECKED MODE
android: I/flutter : RenderObjectToWidgetAdapter<RenderBox>([GlobalObjectKey RenderView(551740147)]; renderObject: RenderView)
android: I/flutter :  └MaterialApp(state: _MaterialAppState(373548050))
android: I/flutter :    └MediaQuery(MediaQueryData(Size(411.4, 683.4), Orientation.portrait))
android: I/flutter :      └LocaleQuery(null)
android: I/flutter :        └Theme(Color(0xff2196f3) ThemeBrightness.light etc...)
android: I/flutter :          └DefaultTextStyle(inherit: true; color: Color(0xd0ff0000); family: "monospace"; size: 48.0; weight: 900; align: right; decoration: double Color(0x00ffff00) TextDecoration.underline)
android: I/flutter :            └DefaultAssetBundle()
android: I/flutter :              └Title("null"; color: Color(0xff2196f3))
android: I/flutter :                └Navigator([GlobalObjectKey _MaterialAppState(373548050)]; state: NavigatorState(726056041))
android: I/flutter :                  └Overlay([GlobalKey 1019314360]; state: OverlayState(808110653; entries: [OverlayEntry@293093314(opaque: false), OverlayEntry@893649780(opaque: false)]))
android: I/flutter :                    └Stack(renderObject: RenderStack)
android: I/flutter :                      ├_OverlayEntry([GlobalKey 578438069]; state: _OverlayEntryState(666522661))
android: I/flutter :                      │ └IgnorePointer(renderObject: RenderIgnorePointer)
android: I/flutter :                      │   └ModalBarrier()
android: I/flutter :                      │     └Listener(listeners: down; behavior: opaque; renderObject: RenderPointerListener)
android: I/flutter :                      │       └ConstrainedBox(BoxConstraints(biggest); renderObject: RenderConstrainedBox)
android: I/flutter :                      └_OverlayEntry([GlobalKey 654847632]; state: _OverlayEntryState(442518741))
android: I/flutter :                        └_ModalScope([GlobalKey 900364748]; state: _ModalScopeState(449821236))
android: I/flutter :                          └RepaintBoundary(renderObject: RenderRepaintBoundary)
android: I/flutter :                            └Focus([GlobalObjectKey MaterialPageRoute(780921576)]; state: FocusState(762448857))
android: I/flutter :                              └_FocusScope(this scope has focus)
android: I/flutter :                                └IgnorePointer(renderObject: RenderIgnorePointer)
android: I/flutter :                                  └_MaterialPageTransition(performance: Performance(⏭ 1.000; paused; for MaterialPageRoute(/)); state: _TransitionState(625205573))
android: I/flutter :                                    └Transform(renderObject: RenderTransform)
android: I/flutter :                                      └Opacity(opacity: 1.0; renderObject: RenderOpacity)
android: I/flutter :                                        └PageStorage([GlobalKey 311418987])
android: I/flutter :                                          └_ModalScopeStatus(active)
android: I/flutter :                                            └AppHome()
android: I/flutter :                                              └Material(state: _MaterialState(951717761))
android: I/flutter :                                                └AnimatedContainer(state: _AnimatedContainerState(91652829; has background))
android: I/flutter :                                                  └Container(has background)
android: I/flutter :                                                    └DecoratedBox(renderObject: RenderDecoratedBox)
android: I/flutter :                                                      └NotificationListener<LayoutChangedNotification>()
android: I/flutter :                                                        └InkFeatures([GlobalKey ink renderer]; renderObject: RenderInkFeatures)
android: I/flutter :                                                          └DefaultTextStyle(inherit: false; color: Color(0xdd000000); size: 14.0; weight: 400; baseline: alphabetic; height: 1.4285714285714286x)
android: I/flutter :                                                            └Center(renderObject: RenderPositionedBox)
android: I/flutter :                                                              └FlatButton(dirty; state: _FlatButtonState(859098856))
android: I/flutter :                                                                └Container(BoxConstraints(88.0<=w<=Infinity, h=36.0); margin: EdgeDims(8.0, 8.0, 8.0, 8.0))
android: I/flutter :                                                                  └Padding(renderObject: RenderPadding relayoutSubtreeRoot=up1)
android: I/flutter :                                                                    └ConstrainedBox(BoxConstraints(88.0<=w<=Infinity, h=36.0); renderObject: RenderConstrainedBox relayoutSubtreeRoot=up2)
android: I/flutter :                                                                      └DefaultTextStyle(inherit: false; color: Color(0xdd000000); size: 14.0; weight: 500; baseline: alphabetic)
android: I/flutter :                                                                        └InkWell(state: _InkResponseState<InkResponse>(365061416))
android: I/flutter :                                                                          └GestureDetector(state: _GestureDetectorState(383331210; gestures: tap; behavior: opaque))
android: I/flutter :                                                                            └Listener(listeners: down; behavior: opaque; renderObject: RenderPointerListener relayoutSubtreeRoot=up3)
android: I/flutter :                                                                              └Container(padding: EdgeDims(0.0, 8.0, 0.0, 8.0))
android: I/flutter :                                                                                └Padding(renderObject: RenderPadding relayoutSubtreeRoot=up4)
android: I/flutter :                                                                                  └Center(renderObject: RenderPositionedBox relayoutSubtreeRoot=up5)
android: I/flutter :                                                                                    └Text("Dump App")
android: I/flutter :                                                                                      └RawText(renderObject: RenderParagraph relayoutSubtreeRoot=up6)
```

This is the "flattened" tree, showing all the widgets projected
through their various build functions. You'll see a lot of widgets in
there that don't appear in your application's source, because they are
inserted by the framework's widgets' build functions. For example,
[`InkFeatures`](http://docs.flutter.io/flutter/material/InkFeatures-class.html)
is an implementation detail of the
[`Material`](http://docs.flutter.io/flutter/material/Material-class.html)
widget.

Since the `debugDumpApp()` call is invoked when the button changes
from being pressed to being released, it coincides with the
[`FlatButton`](http://docs.flutter.io/flutter/material/FlatButton-class.html)
object calling
[`setState()`](http://docs.flutter.io/flutter/widgets/State/setState.html)
and thus marking itself dirty. That is why if you look at the dump you
will see that specific object marked "dirty". You can also see what
gesture listeners have been registered; in this case, a single
GestureDetector is listed, and it is listening only to a "tap"
gesture.

If you write your own widgets, you can add information by overriding
[`debugFillDescription()`](http://docs.flutter.io/flutter/material/Widget/debugFillDescription.html).
Add strings to the method's argument, and call the superclass method.

### Rendering layer

If you are trying to debug a layout issue, then the Widgets layer's
tree may be insufficiently detailed. In that case, you can dump the
rendering tree by calling
[`debugDumpRenderTree()`](http://docs.flutter.io/flutter/rendering/debugDumpRenderTree.html).
As with `debugDumpApp()`, you can call this more or less any time
except during a layout or paint phase. As a general rule, calling it
from a [frame
callback](http://docs.flutter.io/flutter/scheduler/Scheduler/addPersistentFrameCallback.html)
or an event handler is the best solution.

To call `debugDumpRenderTree()`, you need to add `import
'package:flutter/rendering.dart';` to your source file.

The output for the tiny example above would look something like this:

```
android: I/flutter : RenderView
android: I/flutter :  │ window size: Size(411.4, 683.4) (in device pixels)
android: I/flutter :  │ device pixel ratio: 3.5 (device pixels per logical pixel)
android: I/flutter :  │ root constraints: Size(411.4, 683.4) (in logical pixels)
android: I/flutter :  │
android: I/flutter :  └─child: RenderStack
android: I/flutter :    │ owner: Stack ← Overlay-[GlobalKey 584760605] ← Navigator-[GlobalObjectKey _MaterialAppState(13739219)] ← Title ← ⋯
android: I/flutter :    │ parentData: <none>
android: I/flutter :    │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :    │ size: Size(411.4, 683.4)
android: I/flutter :    │
android: I/flutter :    ├─child 1: RenderIgnorePointer
android: I/flutter :    │ │ owner: IgnorePointer ← _OverlayEntry-[GlobalKey 1033953914] ← Stack ← Overlay-[GlobalKey 584760605] ← ⋯
android: I/flutter :    │ │ parentData: offset=Offset(0.0, 0.0); top=null; right=null; bottom=null; left=null; width=null; height=null
android: I/flutter :    │ │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :    │ │ size: Size(411.4, 683.4)
android: I/flutter :    │ │ ignoring: false
android: I/flutter :    │ │
android: I/flutter :    │ └─child: RenderPointerListener
android: I/flutter :    │   │ owner: Listener ← ModalBarrier ← IgnorePointer ← _OverlayEntry-[GlobalKey 1033953914] ← ⋯
android: I/flutter :    │   │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :    │   │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :    │   │ size: Size(411.4, 683.4)
android: I/flutter :    │   │ listeners: down
android: I/flutter :    │   │ behavior: opaque
android: I/flutter :    │   │
android: I/flutter :    │   └─child: RenderConstrainedBox
android: I/flutter :    │       owner: ConstrainedBox ← Listener ← ModalBarrier ← IgnorePointer ← ⋯
android: I/flutter :    │       parentData: offset=Offset(0.0, 0.0)
android: I/flutter :    │       constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :    │       size: Size(411.4, 683.4)
android: I/flutter :    │       additionalConstraints: BoxConstraints(biggest)
android: I/flutter :    │    
android: I/flutter :    └─child 2: RenderRepaintBoundary
android: I/flutter :      │ owner: RepaintBoundary ← _ModalScope-[GlobalKey 332465101] ← _OverlayEntry-[GlobalKey 456282113] ← Stack ← ⋯
android: I/flutter :      │ parentData: offset=Offset(0.0, 0.0); top=null; right=null; bottom=null; left=null; width=null; height=null
android: I/flutter :      │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :      │ size: Size(411.4, 683.4)
android: I/flutter :      │
android: I/flutter :      └─child: RenderIgnorePointer
android: I/flutter :        │ owner: IgnorePointer ← _FocusScope ← Focus-[GlobalObjectKey MaterialPageRoute(383010119)] ← RepaintBoundary ← ⋯
android: I/flutter :        │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :        │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :        │ size: Size(411.4, 683.4)
android: I/flutter :        │ ignoring: false
android: I/flutter :        │
android: I/flutter :        └─child: RenderTransform
android: I/flutter :          │ owner: Transform ← _MaterialPageTransition ← IgnorePointer ← _FocusScope ← ⋯
android: I/flutter :          │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :          │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :          │ size: Size(411.4, 683.4)
android: I/flutter :          │ transform matrix:
android: I/flutter :          │   [0] 1.0,0.0,0.0,0.0
android: I/flutter :          │   [1] 0.0,1.0,0.0,0.0
android: I/flutter :          │   [2] 0.0,0.0,1.0,0.0
android: I/flutter :          │   [3] 0.0,0.0,0.0,1.0
android: I/flutter :          │ origin: null
android: I/flutter :          │ alignment: null
android: I/flutter :          │ transformHitTests: true
android: I/flutter :          │
android: I/flutter :          └─child: RenderOpacity
android: I/flutter :            │ owner: Opacity ← Transform ← _MaterialPageTransition ← IgnorePointer ← ⋯
android: I/flutter :            │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :            │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :            │ size: Size(411.4, 683.4)
android: I/flutter :            │ opacity: 1.0
android: I/flutter :            │
android: I/flutter :            └─child: RenderDecoratedBox
android: I/flutter :              │ owner: DecoratedBox ← Container ← AnimatedContainer ← Material ← ⋯
android: I/flutter :              │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :              │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :              │ size: Size(411.4, 683.4)
android: I/flutter :              │ decoration:
android: I/flutter :              │   backgroundColor: Color(0xfffafafa)
android: I/flutter :              │
android: I/flutter :              └─child: RenderInkFeatures
android: I/flutter :                │ owner: InkFeatures-[GlobalKey ink renderer] ← NotificationListener<LayoutChangedNotification> ← DecoratedBox ← Container ← ⋯
android: I/flutter :                │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :                │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :                │ size: Size(411.4, 683.4)
android: I/flutter :                │
android: I/flutter :                └─child: RenderPositionedBox
android: I/flutter :                  │ owner: Center ← DefaultTextStyle ← InkFeatures-[GlobalKey ink renderer] ← NotificationListener<LayoutChangedNotification> ← ⋯
android: I/flutter :                  │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :                  │ constraints: BoxConstraints(w=411.4, h=683.4)
android: I/flutter :                  │ size: Size(411.4, 683.4)
android: I/flutter :                  │ alignment: FractionalOffset(0.5, 0.5)
android: I/flutter :                  │
android: I/flutter :                  └─child: RenderPadding relayoutSubtreeRoot=up1
android: I/flutter :                    │ owner: Padding ← Container ← FlatButton ← Center ← ⋯
android: I/flutter :                    │ parentData: offset=Offset(153.7, 315.7)
android: I/flutter :                    │ constraints: BoxConstraints(0.0<=w<=411.4, 0.0<=h<=683.4)
android: I/flutter :                    │ size: Size(104.0, 52.0)
android: I/flutter :                    │ padding: EdgeDims(8.0, 8.0, 8.0, 8.0)
android: I/flutter :                    │
android: I/flutter :                    └─child: RenderConstrainedBox relayoutSubtreeRoot=up2
android: I/flutter :                      │ owner: ConstrainedBox ← Padding ← Container ← FlatButton ← ⋯
android: I/flutter :                      │ parentData: offset=Offset(8.0, 8.0)
android: I/flutter :                      │ constraints: BoxConstraints(0.0<=w<=395.4, 0.0<=h<=667.4)
android: I/flutter :                      │ size: Size(88.0, 36.0)
android: I/flutter :                      │ additionalConstraints: BoxConstraints(88.0<=w<=Infinity, h=36.0)
android: I/flutter :                      │
android: I/flutter :                      └─child: RenderPointerListener relayoutSubtreeRoot=up3
android: I/flutter :                        │ owner: Listener ← GestureDetector ← InkWell ← DefaultTextStyle ← ⋯
android: I/flutter :                        │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :                        │ constraints: BoxConstraints(88.0<=w<=395.4, h=36.0)
android: I/flutter :                        │ size: Size(88.0, 36.0)
android: I/flutter :                        │ listeners: down
android: I/flutter :                        │ behavior: opaque
android: I/flutter :                        │
android: I/flutter :                        └─child: RenderPadding relayoutSubtreeRoot=up4
android: I/flutter :                          │ owner: Padding ← Container ← Listener ← GestureDetector ← ⋯
android: I/flutter :                          │ parentData: offset=Offset(0.0, 0.0)
android: I/flutter :                          │ constraints: BoxConstraints(88.0<=w<=395.4, h=36.0)
android: I/flutter :                          │ size: Size(88.0, 36.0)
android: I/flutter :                          │ padding: EdgeDims(0.0, 8.0, 0.0, 8.0)
android: I/flutter :                          │
android: I/flutter :                          └─child: RenderPositionedBox relayoutSubtreeRoot=up5
android: I/flutter :                            │ owner: Center ← Padding ← Container ← Listener ← ⋯
android: I/flutter :                            │ parentData: offset=Offset(8.0, 0.0)
android: I/flutter :                            │ constraints: BoxConstraints(72.0<=w<=379.4, h=36.0)
android: I/flutter :                            │ size: Size(72.0, 36.0)
android: I/flutter :                            │ alignment: FractionalOffset(0.5, 0.5)
android: I/flutter :                            │
android: I/flutter :                            └─child: RenderParagraph relayoutSubtreeRoot=up6
android: I/flutter :                              │ owner: RawText ← Text ← Center ← Padding ← ⋯
android: I/flutter :                              │ parentData: offset=Offset(3.0, 10.0)
android: I/flutter :                              │ constraints: BoxConstraints(0.0<=w<=379.4, 0.0<=h<=36.0)
android: I/flutter :                              │ size: Size(66.0, 16.0)
android: I/flutter :                              ╘═╦══ text ═══
android: I/flutter :                                ║ StyledTextSpan:
android: I/flutter :                                ║   inherit: false
android: I/flutter :                                ║   color: Color(0xdd000000)
android: I/flutter :                                ║   size: 14.0
android: I/flutter :                                ║   weight: 500
android: I/flutter :                                ║   baseline: alphabetic
android: I/flutter :                                ║   PlainTextSpan: "Dump App"
android: I/flutter :                                ╚═══════════
android: I/flutter :
```

When debugging layout issues, the key fields to look at are the `size`
and `constraints` fields. The constraints flow down the tree, and the
sizes flow back up.

For example, in the dump above you can see that the window size,
`Size(411.4, 683.4)`, is used to force all the boxes down to the
[`RenderPositionedBox`](http://docs.flutter.io/flutter/rendering/RenderPositionedBox-class.html)
to be the size of the screen, with constraints of
`BoxConstraints(w=411.4, h=683.4)`. The `RenderPositionedBox`, which
the dump says was created by a
[`Center`](http://docs.flutter.io/flutter/widgets/Center-class.html)
widget (as described by the `owner` field), sets its childs
constraints to a loose version of this: `BoxConstraints(0.0<=w<=411.4,
0.0<=h<=683.4)`. The child, a
[`RenderPadding`](http://docs.flutter.io/flutter/rendering/RenderPadding-class.html),
further inserts these constraints to ensure there is room for the
padding, and thus the
[`RenderConstrainedBox`](http://docs.flutter.io/flutter/rendering/RenderConstrainedBox-class.html)
has a loose constraint of `BoxConstraints(0.0<=w<=395.4,
0.0<=h<=667.4)`. This object, which the `owner` field tells us is
probably part of the
[`FlatButton`](http://docs.flutter.io/flutter/material/FlatButton-class.html)'s
definition, sets a minimum width of 88 pixels on its contents and a
specific height of 36.0. (This is the `FlatButton` class implementing
the Material Design rules regarding button dimensions.)

The inner-most `RenderPositionedBox` loosens the constraints again,
this time to center the text within the button. The
[`RenderParagraph`](http://docs.flutter.io/flutter/rendering/RenderParagraph-class.html)
picks its size based on its contents. If you now follow the sizes back
up the chain, you'll see how the text's size is what influences the
width of all the boxes that form the button, as they all take their
child's dimensions to size themselves.

Another way to notice this is by looking at the "relayoutSubtreeRoot"
part of the descriptions of each box, which essentially tells you how
many ancestors depend on this element's size in some way. Thus the
`RenderParagraph` has a `relayoutSubtreeRoot=up6`, meaning that when
the `RenderParagraph` is dirtied, six ancestors also have to be
dirtied because they might be affected by the new dimensions.

If you write your own render objects, you can add information to the
dump by overriding
[`debugDescribeSettings()`](http://docs.flutter.io/flutter/rendering/RenderObject/debugDescribeSettings.html).
Add strings to the method's argument, and call the superclass method.

### Layers

If you are trying to debug a compositing issue, you can use
[`debugDumpLayerTree()`](http://docs.flutter.io/flutter/rendering/debugDumpLayerTree.html).
For the example above, it would output:

```
android: I/flutter : TransformLayer
android: I/flutter :  │ owner: [root]
android: I/flutter :  │ offset: Offset(0.0, 0.0)
android: I/flutter :  │ transform:
android: I/flutter :  │   [0] 3.5,0.0,0.0,0.0
android: I/flutter :  │   [1] 0.0,3.5,0.0,0.0
android: I/flutter :  │   [2] 0.0,0.0,1.0,0.0
android: I/flutter :  │   [3] 0.0,0.0,0.0,1.0
android: I/flutter :  │
android: I/flutter :  └─child 1: ContainerLayer
android: I/flutter :    │ owner: RepaintBoundary ← _ModalScope-[GlobalKey 943445263] ← _OverlayEntry-[GlobalKey 792667939] ← Stack ← ⋯
android: I/flutter :    │ offset: Offset(0.0, 0.0)
android: I/flutter :    │
android: I/flutter :    └─child 1: PictureLayer
android: I/flutter :        offset: Offset(0.0, 0.0)
android: I/flutter :        paintBounds: Rect.fromLTRB(0.0, 0.0, 411.4, 683.4)
```

## Visual debugging

You can also debug a layout problem visually, by setting
[`debugPaintSizeEnabled`](http://docs.flutter.io/flutter/rendering/debugPaintSizeEnabled.html)
to `true`. This is a boolean from the `rendering` library. It can be
enabled at any time and affects all painting while it is true. The
easiest way to set it is at the top of your `void main()` entry point.

When it is enabled, all boxes get a bright teal border, padding (from
widgets like `Padding`) is shown in faded blue with a darker blue box
around the child, alignment (from widgets like `Center` and `Align`)
is shown with yellow arrows, and spacers (from widgets like
`Container` when they have no child) are shown in gray.

The
[`debugPaintBaselinesEnabled`](http://docs.flutter.io/flutter/rendering/debugPaintBaselinesEnabled.html)
does something similar but for objects with baselines. The alphabetic
baseline is shown in bright green and the ideographic baseline in
orange.

The
[`debugPaintPointersEnabled`](http://docs.flutter.io/flutter/rendering/debugPaintPointersEnabled.html)
flag turns on a special mode whereby any objects that are being tapped
get highlighted in teal. This can help you determine whether an object
is somehow failing to correctly hit test (which might happen if, for
instance, it is actually outside the bounds of its parent and thus not
being considered for hit testing in the first place).

If you're trying to debug compositor layers, for example to determine
whether and where to add `RepaintBoundary` widgets, you can use the
[`debugPaintLayerBordersEnabled`](http://docs.flutter.io/flutter/rendering/debugPaintLayerBordersEnabled.html)
flag, which outlines each layer's bounds in orange, or the
[`debugEnableRepaintRainbox`](http://docs.flutter.io/flutter/rendering/debugEnableRepaintRainbox.html)
flag, which causes layers to be overlayed with a rotating set of
colors whenever they are repainted.

All of these flags only work in checked mode. In general, anything in
the Flutter framework that starts with "`debug...`" will only work in
checked mode.

## Debugging animations

The easiest way to debug animations is to slow them way down. To do
that, set the
[`timeDilation`](http://docs.flutter.io/flutter/scheduler/timeDilation.html)
variable (from the `scheduler` library) to a number greater than 1.0,
for instance, 50.0. It's best to only set this once on app startup. If
you change it on the fly, especially if you reduce it while animations
are running, it's possible that the framework will observe time going
backwards, which will probably result in asserts and generally will
interfere with your efforts.

## Debugging performance problems

To see why your application is causing relayouts or repaints, you can
set the
[`debugPrintMarkNeedsLayoutStacks`](http://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsLayoutStacks.html)
and
[`debugPrintMarkNeedsPaintStacks`](http://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsPaintStacks.html)
flags respectively. These will log a stack trace to the console any
time a render box is asked to relayout and repaint. You can use the
`debugPrintStack()` method from the `services` library to print your
own stack traces on demand, if this kind of approach is useful to you.

## PerformanceOverlay

To get a graphical view of the performance of your application, set
the `showPerformanceOverlay` argument of the [`MaterialApp`
constructor](http://docs.flutter.io/flutter/material/MaterialApp/MaterialApp.html)
to true. (If you're not using `MaterialApp`, you can get the same
effect by wrapping your application in a stack and putting a widget on
your stack that was created by calling [`new
PerformanceOverlay.allEnabled()`](http://docs.flutter.io/flutter/widgets/PerformanceOverlay/PerformanceOverlay.allEnabled.html).)

This will show two graphs. The top one is the time spent by the GPU
thread, the bottom one is the time spent by the CPU thread. The white
lines across the graphs show 16ms increments along the vertical axis;
if the graph ever goes over one of these lines then you are running at
less than 60Hz. The horizontal axis represents frames. The graph is
only updated when your application paints, so if it is idle the graph
will stop moving.

This should always be done in release mode, since in checked mode
performance is intentionally sacrificed in exchange for expensive
asserts that are intended to aid development, and thus the results
will be misleading.

## Material grid

When developing applications that implement [Material
design](https://www.google.com/design/spec/material-design/introduction.html),
it can be helpful to overlay a [Material design baseline
grid](https://www.google.com/design/spec/layout/metrics-keylines.html)
over the application to help verify alignments. To that end, the
[`MaterialApp`
constructor](http://docs.flutter.io/flutter/material/MaterialApp/MaterialApp.html)
has a `debugShowGrid` argument which, when set to `true` in checked
mode, will overlay such a grid.

You can also overlay such a grid on non-Material applications by using
the
[`GridPaper`](http://docs.flutter.io/flutter/widgets/GridPaper-class.html)
widget directly.
