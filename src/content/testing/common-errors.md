---
title: Common Flutter errors
description: How to recognize and resolve common Flutter framework errors.
---

<?code-excerpt path-base="testing/common_errors"?>

## Introduction

This page explains several frequently-encountered Flutter
framework errors (including layout errors) and gives suggestions
on how to resolve them.
This is a living document with more errors to be added in
future revisions, and your contributions are welcomed.
Feel free to [open an issue][] or [submit a pull request][] to
make this page more useful to you and the Flutter community.

[open an issue]: {{site.repo.this}}/issues/new/choose
[submit a pull request]: {{site.repo.this}}/pulls

## A solid red or grey screen when running your app

Typically called a "red (or grey) screen of death",
this is sometimes how Flutter lets
you know that there's an error.

The red screen can appear when the app runs in
debug or profile mode. The grey screen can appear
when the app runs in release mode.

Generally, these errors occur when there's an
uncaught exception (and you might need another
try-catch block), or when there is some rendering error,
such as an overflow error.

The following articles provide some useful insights
on debugging this sort of error:

* [Flutter errors demystified][] by Abishek
* [Understanding and addressing the grey screen in Flutter][] by Christopher Nwosu-Madueke
* [Flutter stuck on white screen][] by Kesar Bhimani

[Flutter errors demystified]: {{site.medium}}/@hpatilabhi10/flutter-errors-demystified-red-screen-errors-vs-debug-console-errors-acb3b8ed2625
[Flutter stuck on white screen]: https://www.dhiwise.com/post/flutter-stuck-on-white-screen-understanding-and-fixing
[Understanding and addressing the grey screen in Flutter]: {{site.medium}}/@LordChris/understanding-and-addressing-the-grey-screen-in-flutter-5e72c31f408f

## 'A RenderFlex overflowed…'

RenderFlex overflow is one of the most frequently
encountered Flutter framework errors,
and you've probably run into it already.

**What does the error look like?**

When it happens, yellow and black stripes appear,
indicating the area of overflow in the app UI.
In addition, an error message displays in the debug console:

```plaintext
The following assertion was thrown during layout:
A RenderFlex overflowed by 1146 pixels on the right.

The relevant error-causing widget was

    Row      lib/errors/renderflex_overflow_column.dart:23

The overflowing RenderFlex has an orientation of Axis.horizontal.
The edge of the RenderFlex that is overflowing has been marked in the rendering 
with a yellow and black striped pattern. This is usually caused by the contents 
being too big for the RenderFlex.
(Additional lines of this message omitted)
```

**How might you run into this error?**

The error often occurs when a `Column` or `Row` has a
child widget that isn't constrained in its size.
For example,
the code snippet below demonstrates a common scenario:

<?code-excerpt "lib/renderflex_overflow.dart (problem)"?>
```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      const Icon(Icons.message),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title', style: Theme.of(context).textTheme.headlineMedium),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
            'do eiusmod tempor incididunt ut labore et dolore magna '
            'aliqua. Ut enim ad minim veniam, quis nostrud '
            'exercitation ullamco laboris nisi ut aliquip ex ea '
            'commodo consequat.',
          ),
        ],
      ),
    ],
  );
}
```

In the above example,
the `Column` tries to be wider than the space the `Row`
(its parent) can allocate to it, causing an overflow error.
Why does the `Column` try to do that?
To understand this layout behavior, you need to know
how Flutter framework performs layout:

"_To perform layout, Flutter walks the render tree in a depth-first traversal
and **passes down size constraints** from parent to child… Children respond by
**passing up a size** to their parent object within the constraints the parent
established._" – [Flutter architectural overview][]

In this case, the `Row` widget doesn't constrain the
size of its children, nor does the `Column` widget.
Lacking constraints from its parent widget, the second
`Text` widget tries to be as wide as all the characters
it needs to display. The self-determined width of the
`Text` widget then gets adopted by the `Column`, which
clashes with the maximum amount of horizontal space its parent,
the `Row` widget, can provide.

[Flutter architectural overview]: /resources/architectural-overview#layout-and-rendering

**How to fix it?**

Well, you need to make sure the `Column` won't attempt
to be wider than it can be. To achieve this,
you need to constrain its width. One way to do it is to
wrap the `Column` in an `Expanded` widget:

<?code-excerpt "lib/renderflex_overflow.dart (solution)"?>
```dart
return const Row(
  children: [
    Icon(Icons.message),
    Expanded(
      child: Column(
        // code omitted
      ),
    ),
  ],
);
```

Another way is to wrap the `Column` in a `Flexible` widget
and specify a `flex` factor. In fact,
the `Expanded` widget is equivalent to the `Flexible` widget
with a `flex` factor of 1.0, as [its source code][] shows.
To further understand how to use the `Flex` widget in Flutter layouts,
check out [this 90-second Widget of the Week video][flexible-video]
on the `Flexible` widget.

**Further information:**

The resources linked below provide further information about this error.

* [Flexible (Flutter Widget of the Week)][flexible-video]
* [How to debug layout issues with the Flutter Inspector][medium-article]
* [Understanding constraints][]

[its source code]: {{site.repo.flutter}}/blob/c8e42b47f5ea8b5ff7bf2f2b0a2a8e765f1aa51d/packages/flutter/lib/src/widgets/basic.dart#L5166-L5174
[flexible-video]: {{site.yt.watch}}?v=CI7x0mAZiY0
[medium-article]: {{site.flutter-medium}}/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db#738b
[Understanding constraints]: /ui/layout/constraints

## 'RenderBox was not laid out'

While this error is pretty common,
it's often a side effect of a primary error
occurring earlier in the rendering pipeline.

**What does the error look like?**

The message shown by the error looks like this:

```plaintext
RenderBox was not laid out: 
RenderViewport#5a477 NEEDS-LAYOUT NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
```

**How might you run into this error?**

Usually, the issue is related to violation of box constraints,
and it needs to be solved by providing more information
to Flutter about how you'd like to constrain the widgets in question.
You can learn more about how constraints work
in Flutter on the [Understanding constraints][] page.

The `RenderBox was not laid out` error is often
caused by one of two other errors:

* 'Vertical viewport was given unbounded height'
* 'An InputDecorator...cannot have an unbounded width'

<a id="unbounded"></a>

## 'Vertical viewport was given unbounded height'

This is another common layout error you could run into
while creating a UI in your Flutter app.

**What does the error look like?**

The message shown by the error looks like this:

```plaintext
The following assertion was thrown during performResize():
Vertical viewport was given unbounded height.

Viewports expand in the scrolling direction to fill their container. 
In this case, a vertical viewport was given an unlimited amount of 
vertical space in which to expand. This situation typically happens when a 
scrollable widget is nested inside another scrollable widget.
(Additional lines of this message omitted)
```

**How might you run into this error?**

The error is often caused when a `ListView`
(or other kinds of scrollable widgets such as `GridView`)
is placed inside a `Column`. A `ListView` takes all
the vertical space available to it,
unless it's constrained by its parent widget.
However, a `Column` doesn't impose any constraint
on its children's height by default.
The combination of the two behaviors leads to the failure of
determining the size of the `ListView`.

<?code-excerpt "lib/unbounded_height.dart (problem)"?>
```dart
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        const Text('Header'),
        ListView(
          children: const <Widget>[
            ListTile(leading: Icon(Icons.map), title: Text('Map')),
            ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
          ],
        ),
      ],
    ),
  );
}
```

**How to fix it?**

To fix this error, specify how tall the `ListView` should be.
To make it as tall as the remaining space in the `Column`,
wrap it using an `Expanded` widget (as shown in the following example).
Otherwise, specify an absolute height using a `SizedBox`
widget or a relative height using a `Flexible` widget.

<?code-excerpt "lib/unbounded_height.dart (solution)"?>
```dart
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        const Text('Header'),
        Expanded(
          child: ListView(
            children: const <Widget>[
              ListTile(leading: Icon(Icons.map), title: Text('Map')),
              ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
            ],
          ),
        ),
      ],
    ),
  );
}
```

**Further information:**

The resources linked below provide
further information about this error.

* [How to debug layout issues with the Flutter Inspector][medium-article]
* [Understanding constraints][]

## 'An InputDecorator...cannot have an unbounded width'

The error message suggests that it's also related
to box constraints, which are important to understand
to avoid many of the most common Flutter framework errors.

**What does the error look like?**

The message shown by the error looks like this:

```plaintext
The following assertion was thrown during performLayout():
An InputDecorator, which is typically created by a TextField, cannot have an 
unbounded width.
This happens when the parent widget does not provide a finite width constraint. 
For example, if the InputDecorator is contained by a `Row`, then its width must 
be constrained. An `Expanded` widget or a SizedBox can be used to constrain the 
width of the InputDecorator or the TextField that contains it.
(Additional lines of this message omitted)
```

**How might you run into the error?**

This error occurs, for example, when a `Row` contains a
`TextFormField` or a `TextField` but the latter has
no width constraint.

<?code-excerpt "lib/unbounded_width.dart (problem)"?>
```dart
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Unbounded Width of the TextField')),
      body: const Row(children: [TextField()]),
    ),
  );
}
```

**How to fix it?**

As suggested by the error message,
fix this error by constraining the text field
using either an `Expanded` or `SizedBox` widget.
The following example demonstrates using an `Expanded` widget:

<?code-excerpt "lib/unbounded_width.dart (solution)"?>
```dart
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Unbounded Width of the TextField')),
      body: Row(children: [Expanded(child: TextFormField())]),
    ),
  );
}
```

## 'Incorrect use of ParentData widget'

This error is about missing an expected parent widget.

**What does the error look like?**

The message shown by the error looks like this:

```plaintext
The following assertion was thrown while looking for parent data:
Incorrect use of ParentDataWidget.
(Some lines of this message omitted)
Usually, this indicates that at least one of the offending ParentDataWidgets 
listed above is not placed directly inside a compatible ancestor widget.
```

**How might you run into the error?**

While Flutter's widgets are generally flexible
in how they can be composed together in a UI,
a small subset of those widgets expect specific parent widgets.
When this expectation can't be satisfied in your widget tree,
you're likely to encounter this error.

Here is an _incomplete_ list of widgets that expect
specific parent widgets within the Flutter framework.
Feel free to submit a PR (using the doc icon in
the top right corner of the page) to expand this list.

| Widget                                |  Expected parent widget(s) |
|:--------------------------------------|---------------------------:|
| `Flexible`                            | `Row`, `Column`, or `Flex` |
| `Expanded` (a specialized `Flexible`) | `Row`, `Column`, or `Flex` |
| `Positioned`                          |                    `Stack` |
| `TableCell`                           |                    `Table` |

**How to fix it?**

The fix should be obvious once you know
which parent widget is missing.

## 'setState called during build'

The `build` method in your Flutter code isn't
a good place to call `setState`,
either directly or indirectly.

**What does the error look like?**

When the error occurs,
the following message is displayed in the console:

```plaintext
The following assertion was thrown building DialogPage(dirty, dependencies: 
[_InheritedTheme, _LocalizationsScope-[GlobalKey#59a8e]], 
state: _DialogPageState#f121e):
setState() or markNeedsBuild() called during build.

This Overlay widget cannot be marked as needing to build because the framework 
is already in the process of building widgets.
(Additional lines of this message omitted)
```

**How might you run into the error?**

In general, this error occurs when the `setState`
method is called within the `build` method.

A common scenario where this error occurs is when
attempting to trigger a `Dialog` from within the
`build` method. This is often motivated by the need to
immediately show information to the user,
but `setState` should never be called from a `build` method.

The following snippet seems to be a common culprit of this error:

<?code-excerpt "lib/set_state_build.dart (problem)"?>
```dart
Widget build(BuildContext context) {
  // Don't do this.
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(title: Text('Alert Dialog'));
    },
  );

  return const Center(
    child: Column(children: <Widget>[Text('Show Material Dialog')]),
  );
}
```

This code doesn't make an explicit call to `setState`,
but it's called by `showDialog`.
The `build` method isn't the right place to call
`showDialog` because `build` can be called by the
framework for every frame, for example, during an animation.

**How to fix it?**

One way to avoid this error is to use the `Navigator` API
to trigger the dialog as a route. In the following example,
there are two pages. The second page has a
dialog to be displayed upon entry.
When the user requests the second page by
clicking a button on the first page,
the `Navigator` pushes two routes–one
for the second page and another for the dialog.

<?code-excerpt "lib/set_state_build.dart (solution)"?>
```dart
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
            // Immediately show a dialog upon loading the second screen.
            Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) => const MyDialog(),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## `The ScrollController is attached to multiple scroll views`

This error can occur when multiple scrolling
widgets (such as `ListView`) appear on the
screen at the same time. It's more likely for
this error to occur on a web or desktop app,
than a mobile app since it's rare to encounter
this scenario on mobile.

For more information and to learn how to fix,
check out the following video on
[`PrimaryScrollController`][controller-video]:

{% ytEmbed '33_0ABjFJUU', 'PrimaryScrollController | Decoding Flutter' %}

[controller-video]: {{site.api}}/flutter/widgets/PrimaryScrollController-class.html

## References

To learn more about how to debug errors,
especially layout errors in Flutter,
check out the following resources:

* [How to debug layout issues with the Flutter Inspector][medium-article]
* [Understanding constraints][]
* [Flutter architectural overview][]

[Flutter architectural overview]: /resources/architectural-overview#layout-and-rendering
