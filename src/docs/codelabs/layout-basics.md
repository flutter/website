---
title: "Basic Flutter layout concepts"
description: "A codelab that teaches basic Flutter layout concepts through DartPad examples and exercises."
toc: true
js:
- defer: true
  url: https://dartpad.dev/inject_embed.dart.js
---
Welcome to the Flutter layout codelab,
where you learn how to build a Flutter UI without
downloading and installing Flutter or Dart!

{{site.alert.important}}
  This codelab covers basic Flutter layout concepts using an
  experimental code editor called DartPad.
  DartPad hasn't been fully tested on all browsers.
  If you experience any difficulties while using DartPad
  on a specific browser, please create a [DartPad issue][]
  and specify which browser you're using in the issue title.
{{site.alert.end}}

Flutter is different from other frameworks because its UI
is built in code, not (for example) in an XML file or similar.
Widgets are the basic building blocks of a Flutter UI.
As you progress through this codelab,
you'll learn that almost everything in Flutter is a widget.
A widget is an immutable object that describes a specific part of a UI.
You'll also learn that Flutter widgets are composable, meaning
that you can combine existing widgets to make more sophisticated widgets.
At the end of this codelab,
you'll get to apply what you've learned
into building a Flutter UI that displays a business card.

**Estimated time to complete this codelab: 45-60 minutes.**

## Row and Column classes
`Row` and `Column` are classes that contain and lay out widgets.
Widgets inside of a `Row` or `Column` are called *children*,
and `Row` and `Column` are referred to as *parents*.
`Row` lays out its widgets horizontally,
and `Column` lays out its widgets vertically.

#### Example: Creating a Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  The following example displays the differences between
  a `Row` and `Column`.

  **1.** Click the **Run** button.

  **2.** In the code, change the `Row` to a `Column`, and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;
  
  runApp(MyApp());

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final columns = controller.widgetList(find.byType(Column));

  if (columns.length == 0) {
    _result(false, ['The Row contains three BlueBox widgets and lays them out horizontally.']);
    return;
  }

  if (columns.length > 1) {
    _result(false, ['Found ${columns.length} Rows, rather than just one.']);
    return;
  }

  final column = columns.first as Column;

  if (column.children.length != 3 || column.children.any((w) => w is! BlueBox)) {
    _result(false, ['Row/Column should contain three children, all BlueBox widgets.']);
    return;
  }

  _result(true, ['The Column contains three BlueBox widgets and lays them out vertically.']);
}
{$ end test.dart $}
```

## Axis size and alignment

So far, the `BlueBox` widgets have been squished together
(either to the left or at the top of the UI Output).
You can change how the `BlueBox` widgets are spaced
out using the axis size and alignment properties.

### mainAxisSize property

`Row` and `Column` occupy different main axes.
A `Row`'s main axis is horizontal,
and a `Column`'s main axis is vertical.
The `mainAxisSize` property determines how much
space a `Row` and `Column` can occupy on their main axes.
The `mainAxisSize` property has two possible values:

`MainAxisSize.max`
: `Row` and `Column` occupy all of the space on their main axes.
  If the combined width of their children is
  less than the total space on their main axes,
  their children are laid out with extra space.

`MainAxisSize.min`
: `Row` and `Column` only occupy enough space on their main axes
  for their children. Their children are laid out without extra space
  and at the middle of their main axes.

{{site.alert.tip}}
  `MainAxisSize.max` is the `mainAxisSize` property's default value.
  If you don't specify another value,
  the default value is used,
  as shown in the previous example.
{{site.alert.end}}

#### Example: Modifying axis size
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}

  The following example explicitly sets `mainAxisSize`
  to its default value, `MainAxisSize.max`.

  **1.** Click the **Run** button.

  **2.** Change `MainAxisSize.max` to `MainAxisSize.min`,
         and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();

  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });

  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.min) {
    _result(false, ['Row lays out the BlueBox widgets with extra space. Change MainAxisSize.max to MainAxisSize.min']);
    return;
  }

  if (row.children.length != 3 || row.children.any((w) => w is! BlueBox)) {
    _result(false, ['There should only be three children, all BlueBox widgets.']);
    return;
  }

  _result(true, ['Row lays out the BlueBox widgets without extra space, and the BlueBox widgets are positioned at the middle of Row\'s main axis.']);
}
{$ end test.dart $}
```

### mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`,
`Row` and `Column` might lay out their children with extra space.
The `mainAxisAlignment` property determines how `Row` and `Column`
can position their children in that extra space.
`mainAxisAlignment` has six possible values:

`MainAxisAlignment.start`
: Positions children near the beginning of the main axis.
  (Left for `Row`, top for `Column`)

`MainAxisAlignment.end`
: Positions children near the end of the main axis.
  (Right for `Row`, bottom for `Column`)

`MainAxisAlignment.center`
: Positions children at the middle of the main axis.

`MainAxisAlignment.spaceBetween`
: Divides the extra space evenly between children.

`MainAxisAlignment.spaceEvenly`
: Divides the extra space evenly between children
  and before and after the children.

`MainAxisAlignment.spaceAround`
: Similar to `MainAxisAlignment.spaceEvenly`,
  but reduces half of the space before the first
  child and after the last child
  to half of the width between the children.

#### Example: Modifying main axis alignment
{:.no_toc}
{{site.alert.secondary}}
  The following example explicitly sets
  `mainAxisAlignment` to its default value,
  `MainAxisAlignment.start`.

  **1.** Click the **Run** button.

  **2.** Change `MainAxisAlignment.start` to
         `MainAxisAlignment.end`, and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();

  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });

  await completer.future;
  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }

  if (row.children.length != 3 || row.children.any((w) => w is! BlueBox)) {
    _result(false, ['The Row should have three children, all BlueBox widgets.']);
    return;
  }

  if (row.mainAxisAlignment == MainAxisAlignment.start) {
    _result(false, ['MainAxisAlignment.start positions the BlueBox widgets on the left of the main axis. Change the value to MainAxisAlignment.end.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.end) {
    _result(true, ['MainAxisAlignment.end positions the BlueBox widgets on the right of the main axis.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.center) {
    _result(true, ['MainAxisAlignment.center positions the BlueBox widgets at the middle of the main axis.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceBetween) {
    _result(true, ['The extra space is divided between the BlueBox widgets.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
    _result(true, ['The extra space is divided evenly between the BlueBox widgets and before and after them.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceAround) {
    _result(true, ['Similar to MainAxisAlignment.spaceEvenly, but reduces half of the space before the first BlueBox widget and after the last BlueBox widget to half of the width between the BlueBox widgets.']);
  }
}
{$ end test.dart $}
```
{{site.alert.tip}}
  Before moving to the next section,
  change `MainAxisAlignment.end` to another value.
{{site.alert.end}}

### crossAxisAlignment property

The `crossAxisAlignment` property determines
how `Row` and `Column` can position their children
on their cross axes.
A `Row`'s cross axis is vertical,
and a `Column`'s cross axis is horizontal.
The `crossAxisAlignment` property has five possible values:

`CrossAxisAlignment.start`
: Positions children near the start of the cross axis. (Top for `Row`, Left for `Column`)

`CrossAxisAlignment.end`
: Positions children near the end of the cross axis. (Bottom for `Row`, Right for `Column`)

`CrossAxisAlignment.center`
: Positions children at the middle of the cross axis. (Middle for `Row`, Center for `Column`)

`CrossAxisAlignment.stretch`
: Stretches children across the cross axis.
  (Top-to-bottom for `Row`, left-to-right for `Column`)

`CrossAxisAlignment.baseline`
: Aligns children by their character baselines.
  (`Text` class only, and requires that the
  `textBaseline` property is set to
  `TextBaseline.alphabetic`.  See the
  [Text widget](#text-widget) section for an example.)

#### Example: Modifying cross axis alignment
{:.no_toc}
{{site.alert.secondary}}
  The following example explicitly sets `crossAxisAlignment`
  to its default value, `CrossAxisAlignment.center`.

  To demonstrate cross axis alignment,
  `mainAxisAlignment` is set to
 `MainAxisAlignment.spaceAround`,
  and `Row` now contains a `BiggerBlueBox` widget
  that is taller than the `BlueBox` widgets.

  **1.** Click the **Run** button.

  **2.** Change `CrossAxisAlignment.center` to
         `CrossAxisAlignment.start`, and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlueBox(),
        BiggerBlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.children.length != 3 || row.children.any((w) => w is! BlueBox && w is! BiggerBlueBox)) {
    _result(false, ['The Row should have three children, all BlueBox or BiggerBlueBox widgets.']);
    return;
  }

  if (row.crossAxisAlignment == CrossAxisAlignment.start) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are positioned at the top of the cross axis.']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.end) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are positioned at the bottom of the cross axis']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.center) {
    _result(false, ['The widgets are positioned at the middle of the cross axis. Change CrossAxisAlignment.center to CrossAxisAlignment.start.']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.stretch) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are stretched across the cross axis. Change the Row to a Column, and run again.']);
  } else if(row.crossAxisAlignment == CrossAxisAlignment.baseline) {
    _result(false, ['Couldn\t find a text class.']);
  }
}
{$ end test.dart $}
```
{{site.alert.tip}}
  Before moving to the next section,
  change `CrossAxisAlignment.start` to another value.
{{site.alert.end}}

## Flexible widget

As you've seen, the `mainAxisAlignment` and
`crossAxisAlignment` properties determine
how `Row` and `Column` position widgets along both axes.
`Row` and `Column` first lay out widgets of a fixed size.
Fixed size widgets are considered *inflexible* because
they can't resize themselves after they've been laid out.

The `Flexible` widget wraps a widget,
so the widget becomes resizable.
When the `Flexible` widget wraps a widget,
the widget becomes the `Flexible` widget's child
and is considered *flexible*.
After inflexible widgets are laid out,
the widgets are resized according to their
`flex` and `fit` properties.:

`flex`
: Compares itself against other `flex`
  properties before determining what fraction of the
  total remaining space each `Flexible` widget receives.

`fit`
: Determines whether a `Flexible` widget
  fills all of its extra space.

#### Example: Changing fit properties
{:.no_toc}
{{site.alert.secondary}}
  The following example demonstrates the `fit` property,
  which can have one of two values:

  `FlexFit.loose`
  : The widget's preferred size is used. (Default)

  `FlexFit.tight`
  : Forces the widget to fill all of its extra space.

  In this example, change the `fit` properties to
  make the `Flexible` widgets fill the extra space.

  **1.** Click the **Run** button.

  **2.** Change both `fit` values to `FlexFit.tight`,
         and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: BlueBox(),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: BlueBox(),
        ),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  if (row.children.length != 3) {
    _result(false, ['The Row should have three children, all BlueBox or Flexible widgets.']);
    return;
  }

  if (row.children[0] is! BlueBox) {
    _result(false, ['Row\'s first child should be a BlueBox.']);
    return;
  }

  if (row.children[1] is! Flexible) {
    _result(false, ['Row\'s second child should be a Flexible class.']);
    return;
  }

  if (row.children[2] is! Flexible) {
    _result(false, ['Row\'s third child should be a Flexible class.']);
    return;
  }

  final flexibleWidget = row.children[2] as Flexible;
  
  if (flexibleWidget.child is! BlueBox) {
    _result(false, ['The Flexible classes should have BlueBox widgets as their children.']);
    return;
  }

  if (flexibleWidget.fit != FlexFit.tight) {
    _result(false, ['The fit properties set the Flexible widgets to their preferred size. Change both fit values to FlexFit.tight.']);
    return;
  }

  _result(true, ['The Flexible widgets now occupy the space determined by their flex values.']);
}
{$ end test.dart $}
```

#### Example: Testing flex values
{:.no_toc}
{{site.alert.secondary}}
  In the following example,
  `Row` contains one `BlueBox` widget
  and two `Flexible` widgets that wrap two
  `BlueBox` widgets.  The `Flexible` widgets
  contain `flex` properties with `flex`
  values set to 1 (the default value).

  When `flex` properties are compared against one another,
  the ratio between their `flex` values determines
  what fraction of the total remaining space each
  `Flexible` widget receives.

  <!-- skip -->
  ```dart
  remainingSpace * (flex / totalOfAllFlexValues)
  ```

  In this example, the sum of the `flex` values (2),
  determines that both `Flexible` widgets receive
  half of the total remaining space.
  The `BlueBox` widget (or fixed-size widget)
  remains the same size.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: BlueBox(),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: BlueBox(),
        ),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.children.length != 3) {
    _result(false, ['The Row should have three children, all BlueBlox or Flexible widgets.']);
    return;
  }

  if (row.children[0] is! BlueBox) {
    _result(false, ['The Row\'s first child should be a BlueBox widget.']);
    return;
  }

  if (row.children[1] is! Flexible) {
    _result(false, ['The Row\'s second child should be a Flexible widget.']);
    return;
  }

  if (row.children[2] is! Flexible) {
    _result(false, ['The Row\'s third child should be a Flexible widget.']);
    return;
  }

  final flexibleWidget = row.children[1] as Flexible;
  
  if (flexibleWidget.child is! BlueBox) {
    _result(false, ['The Flexible should have a BlueBox widget as its child.']);
    return;
  }

  if (flexibleWidget.flex != 1) {
    _result(false, ['Notice how the flex properties divide the extra space between the two Flexible widgets.']);
    return;
  }

  _result(true, ['Both Flexible widgets receive half of the total remaining space.']);
}
{$ end test.dart $}
```
{{site.alert.tip}}
  Before moving to the next example,
  try changing the `flex` properties to other values,
  such as 2 and 1.
{{site.alert.end}}

## Expanded widget

Similar to `Flexible`, the `Expanded` widget can
wrap a widget and force the widget to fill extra space.

{{site.alert.tip}}
  **What's the difference between Flexible and Expanded?**
  Use `Flexible` to resize widgets in a `Row` or `Column`.
  That way, you can adjust a child widget's spacing
  while keeping its size in relation to its parent widget.
  `Expanded` changes the constraints of a child widget,
  so it fills any empty space.
{{site.alert.end}}

#### Example: Filling extra space
{:.no_toc}
{{site.alert.secondary}}
  The following example demonstrates how the
  `Expanded` widget forces its child widget to
  fill extra space.

  **1.** Click the **Run** button.

  **2.** Wrap the second `BlueBox` widget in an `Expanded` widget.

  For example:

  <!-- skip -->
  ```dart
  Expanded(child: BlueBox(),),
  ```
  **3.** Select the **Format** button to properly format the code,
         and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;
  
  if (row.children.length != 3) {
    _result(false, ['The Row should have three children, all BlueBox widgets.']);
    return;
  }

   if (row.children[0] is! BlueBox) {
    _result(false, ['The Row\'s first child should be a BlueBox widget.']);
    return;
  }

  if (row.children[1] is! Expanded) {
    _result(false, ['Notice how Row contains extra space on its main axis. Wrap the second BlueBox widget in an Expanded widget.']);
    return;
  }

  if (row.children[2] is! BlueBox) {
    _result(false, ['The Row\'s third child should be a Flexible widget.']);
    return;
  }
  
  _result(true, ['Expanded forces second BlueBox widget to fill the extra space.']);
}
{$ end test.dart $}
```

## SizedBox widget

The `SizedBox` widget can be used in one of two ways when
creating exact dimensions.
When `SizedBox` wraps a widget, it resizes the widget
using the `height` and `width` properties.
When it doesn't wrap a widget,
it uses the `height` and `width` properties to
create empty space.

#### Example: Resizing a widget
{:.no_toc}
{{site.alert.secondary}}
  The following example wraps the middle `BlueBox` widget inside of a
  `SizedBox` widget and sets the `BlueBox`'s width to 100 logical pixels.

  **1.** Click the **Run** button.

  **2.** Add a `height` property equal to 100 logical pixels
         inside the `SizedBox` widget, and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        BlueBox(),
        SizedBox(
          width: 100,
          child: BlueBox(),
        ),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  
  if (row.children.length != 3) {
    _result(false, ['The Row should end up with three children.']);
    return;
  }

  if (row.children[0] is! BlueBox) {
    _result(false, ['The Row\'s first child should be a BlueBox widget.']);
    return;
  }

  if (row.children[1] is! SizedBox) {
    _result(false, ['The Row\'s second child should be a SizedBox widget.']);
    return;
  }

  if (row.children[2] is! BlueBox) {
    _result(false, ['The Row\'s third child should be a BlueBox widget.']);
    return;
  }

  final sizedBox = row.children[1] as SizedBox;
  
  if (sizedBox.width != 100) {
    _result(false, ['The SizedBox should have a width of 100.']);
    return;
  }
  
  if (sizedBox.height != 100) {
    _result(false, ['The SizedBox widget resizes the BlueBox widget to 100 logical pixels wide. Add a height property inside SizedBox equal to 100 logical pixels.']);
    return;
  }
  
  _result(true, ['The SizedBox widget resizes the BlueBox widget to 100 logical pixels wide and tall.']);
}
{$ end test.dart $}
```

#### Example: Creating space
{:.no_toc}
{{site.alert.secondary}}
  The following example contains three `BlueBox` widgets
  and one `SizedBox` widget that separates the first
  and second `BlueBox` widgets. The `SizedBox` widget
  contains a `width` property equal to 50 logical pixels.

  **1.** Click the **Run** button.

  **2.** Create more space by adding another
         `SizedBox` widget (25 logical pixels wide)
         between the second and third `BlueBox` widgets,
         and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        SizedBox(width: 50),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  if (row.mainAxisAlignment == MainAxisAlignment.spaceAround 
      || row.mainAxisAlignment == MainAxisAlignment.spaceBetween 
      || row.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
    _result(false, ['It\'s best to use MainAxisAlignment.start, MainAxisAlignment.end, or MainAxisAlignment.center to see how the SizedBox widgets work in a Row.']);
    return;
  }
  
  if (row.children.length != 5) {
    _result(false, ['The SizedBox widget creates space at 50 logical pixels wide. Add another SizedBox class between the second and third BlueBox widgets with a width property equal to 25 logical pixels.']);
    return;
  }

  if (row.children[0] is! BlueBox) {
    _result(false, ['The Row\'s first child should be a BlueBox widget.']);
    return;
  }

  if (row.children[1] is! SizedBox) {
    _result(false, ['The Row\'s second child should be a SizedBox widget.']);
    return;
  }

  if (row.children[2] is! BlueBox) {
    _result(false, ['The Row\'s third child should be a BlueBox widget.']);
    return;
  }

  if (row.children[3] is! SizedBox) {
    _result(false, ['The Row\'s fourth child should be a SizedBox widget.']);
    return;  
  }
  
   if (row.children[4] is! BlueBox) {
    _result(false, ['The Row\'s fifth child should be a BlueBox widget.']);
    return;
  }
  
  final sizedBox = row.children[1] as SizedBox;
  
  if (sizedBox.width != 50) {
    _result(false, ['The SizedBox should have a width of 50.']);
    return;
  }
  
  final sizedBox2 = row.children[3] as SizedBox;
  
  if (sizedBox2.width != 25) {
    _result(false, ['SizedBox should have a width of 25.']);
    return;
  }
  
  _result(true, ['The SizedBox widgets create space between the BlueBox widgets, one space at 50 logical pixels and one at 25 logical pixels.']);
}
{$ end test.dart $}
```

## Spacer widget

Similar to `SizedBox`, the `Spacer` widget also
can create space between widgets.

{{site.alert.tip}}
  **What's the difference between SizedBox and Spacer?**
  Use `Spacer` when you want to create space using a `flex` property.
  Use `SizedBox` when you want to create space
  using a specific number of logical pixels.
{{site.alert.end}}

#### Example: Creating more space
{:.no_toc}
{{site.alert.secondary}}
  The following example separates the first two
  `BlueBox` widgets using a `Spacer` widget with
  a `flex` value of 1.

  **1.** Click the **Run** button.

  **2.** Add another `Spacer` widget (also with a `flex` value of 1)
         between the second and third `BlueBox` widgets.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        Spacer(flex: 1),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  if (row.mainAxisAlignment == MainAxisAlignment.spaceAround 
      || row.mainAxisAlignment == MainAxisAlignment.spaceBetween 
      || row.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
    _result(false, ['It\'s best to use MainAxisAlignment.start, MainAxisAlignment.end, or MainAxisAlignment.center to see how the SizedBox widgets work in a Row.']);
    return;
  }
  
  if (row.children.length != 5) {
    _result(false, ['What do you think would happen if you added another Spacer widget with a flex value of 1 between the second and third BlueBox widgets?']);
    return;
  }

  if (row.children[0] is! BlueBox ||
     row.children[1] is! Spacer ||
     row.children[2] is! BlueBox ||
     row.children[3] is! Spacer ||
     row.children[4] is! BlueBox) {
    _result(false, ['Not quite. Row should contain five children in this order: BlueBox, Spacer, BlueBox, Spacer, BlueBox.']);
    return;
  }
  
    final spacer = row.children[3] as Spacer;
  
    if (spacer.flex != 1) {
    _result(false, ['The Spacer class should have a flex equal to 1.']);
    return;
  }
  
  _result(true, ['Both Spacer widgets create equal amounts of space between all three BlueBox widgets.']);
}
{$ end test.dart $}
```

## Text widget

The `Text` widget displays text and can be configured
for different fonts, sizes, and colors.

#### Example: Aligning text
{:.no_toc}
{{site.alert.secondary}}
  The following example displays "Hey!" three times,
  but at different font sizes and in different colors.
  `Row` specifies the `crossAxisAlignment`
  and `textBaseline` properties.

  **1.** Click the **Run** button.

  **2.** Change `CrossAxisAlignment.center` to
         `CrossAxisAlignment.baseline`, and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Hey!',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Futura',
            color: Colors.blue,
          ),
        ),
        Text(
          'Hey!',
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'Futura',
            color: Colors.green,
          ),
        ),
        Text(
          'Hey!',
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Futura',
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  if (row.children.length != 3 || row.children.any((w) => w is! Text)) {
    _result(false, ['The Row should have three children, all Text widgets.']);
    return;
  }

  if (row.textBaseline == null) {
    _result(false, ['To use CrossAxisAlignment.baseline, you need to set the Row\'s textBaseline property.']);
    return;
  } 
  
  if (row.crossAxisAlignment != CrossAxisAlignment.baseline) {
    _result(false, ['The Text widgets are positioned at the middle of the cross axis. Change CrossAxisAlignment.center to CrossAxisAlignment.baseline.']);
		return;
  }  

  _result(true, ['The Text widgets are now aligned by their character baselines.']);
  
}
{$ end test.dart $}
```

## Icon widget

The `Icon` widget displays a graphical symbol
that represents an aspect of the UI.
Flutter is preloaded with icon packages for
[Material][] and [Cupertino][] applications.

#### Example: Creating an Icon
{:.no_toc}
{{site.alert.secondary}}
  The following example displays the widget `Icons.widget`
  from the [Material Icon library][] in red and blue.

  **1.** Click the **Run** button.

  **2.** Add another `Icon` from the
         [Material Icon library][]
         with a size of 50.

  **3.** Give the `Icon` a color of `Colors.amber` from the
         [Material Color palette][], and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(
          Icons.widgets,
          size: 50,
          color: Colors.blue,
        ),
        Icon(
          Icons.widgets,
          size: 50,
          color: Colors.red,
        ),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to       take effect.']);
    return;
  }
  
    if (row.children.length != 3 || row.children.any((w) => w is! Icon)) {
    _result(false, ['Row should have three children, all Icon widgets.']);
    return;
  }

    final icon = row.children[2] as Icon;
  
  if (icon.color != Colors.amber) {
    _result(false, ['Add a third Icon. Give the Icon a size of 50 and a color of Colors.amber.']);
    return;
  }
  
  _result(true, ['The code displays three Icons in blue, red, and amber.']);
  
}
{$ end test.dart $}
```

## Image widget

The `Image` widget displays an image.
You either can reference images using a URL,
or you can include images inside your app package.
Since DartPad can't package an image,
the following example uses an image from the network.

#### Example: Displaying an image
{:.no_toc}
{{site.alert.secondary}}
  The following example displays an image that's
  stored remotely on [GitHub][].
  The `Image.network` method takes a string
  parameter that contains an image's URL.

  In this example, `Image.network` contains a non-working URL.

  **1.** Click the **Run** button.

  **2.** Change the non-working URL to the actual URL:

  `https://raw.githubusercontent.com/flutter/website/master/examples/layout/sizing/images/pic1.jpg`

  **3.** Then change `pic1.jpg` to `pic2.jpg` or `pic3.jpg`,
         and run again.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network('[Place an image link here!]'),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
 
}
{$ end test.dart $}
```

## Putting it all together

You're almost at the end of this codelab.
If you'd like to test your knowledge of the
techniques that you've learned, why not apply
those skills into building a Flutter UI that
displays a business card!

 ![Completed business card]({% asset codelab/layout/businesscarddisplay1.png
 @path%}){:width="400px"}{:.text-center}

You'll break down Flutter's layout into parts,
which is how you'd create a Flutter UI in the real world.

In [Part 1](#part-1),
you'll implement a `Column` that contains the name and title.
Then you'll wrap the `Column` in a `Row` that contains the icon,
which is positioned to the left of the name and title.

 ![Completed business card]({% asset codelab/layout/businesscarddisplay2.png
 @path%}){:width="400px"}{:.text-center}

In [Part 2](#part-2), you'll wrap the `Row` in a `Column`,
so the code contains a `Column` within a `Row` within a `Column`.
Then you'll tweak the outermost `Column`'s layout,
so it looks nice.
Finally, you'll add the contact information
to the outermost `Column`'s list of children,
so it's displayed below the name, title, and icon.

 ![Completed business card]({% asset codelab/layout/businesscarddisplay3.png
 @path%}){:width="400px"}{:.text-center}

In [Part 3](#part-3), you'll finish building
the business card display by adding four more icons,
which are positioned below the contact information.

 ![Completed business card]({% asset codelab/layout/businesscarddisplay4.png
 @path %}){:width="400px"}{:.text-center}

### Part 1
{:.no_toc}

#### Exercise: Create the name and title
{:.no_toc}
{{site.alert.secondary}}

  Implement a `Column` that contains two text widgets:

<ul markdown="1">
  <li markdown="1">
  The first `Text` widget has the name `Flutter McFlutter` and
  the `style` property set to `Theme.of(context).textTheme.headline5`.
  </li>
  <li markdown="1">
  The second `Text` widget contains the title `Experienced App Developer`.
  </li>
</ul>

  For the `Column`,
  set `mainAxisSize` to `MainAxisSize.min`
  and `crossAxisAlignment` to `CrossAxisAlignment.start`.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TODO('Begin implementing the Column here.');
  }
}
{$ end main.dart $}
{$ begin solution.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter McFlutter', 
          style: Theme.of(context).textTheme.headline5,
        ),
        Text('Experienced App Developer'),
      ],
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffeeeeee),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x80000000),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  // Check MyWidget starts with one Column

  final myWidgetElement = controller.element(find.byType(MyWidget));

  final myWidgetChildElements = <Element>[];
  myWidgetElement.visitChildElements((e) => myWidgetChildElements.add(e));

  if (myWidgetChildElements.length != 1 ||
      myWidgetChildElements[0].widget is! Column) {
    _result(false, ['The root widget in MyWidget\'s build method should be a Column.']);
    return;
  }

  // Check Column has correct properties

  final innerColumnElement = myWidgetChildElements[0];
  final innerColumnWidget = innerColumnElement.widget as Column;

  if (innerColumnWidget.crossAxisAlignment != CrossAxisAlignment.start) {
    _result(false, ['The Column that contains the name and title should use CrossAxisAlignment.start as its CrossAxisAlignment value.']);
    return;
  }

  if (innerColumnWidget.mainAxisSize != MainAxisSize.min) {
    _result(false, ['The Column that contains the name and title should use MainAxisSize.min as its MainAxisSize value.']);
    return;
  }

  // Check inner Column has two Text children

  if (innerColumnWidget.children.any((w) => w is! Text)) {
    _result(false, ['The Column that contains the name and title should have two children, both Text widgets.']);
    return;
  }

  // Check first Text has headline style

  final nameText = innerColumnWidget.children[0] as Text;

  if (nameText.style?.fontSize != 24) {
    _result(false, ['The Text widget for the name should use the "headline5" textStyle.']);
    return;
  }

  _result(true);
}
{$ end test.dart $}
```

#### Exercise: Wrap the Column in a Row
{:.no_toc}
{{site.alert.secondary}}

  Wrap the `Column` you implemented in a
  `Row` that contains the following widgets:

<ul markdown="1">
  <li markdown="1">
  An `Icon` widget set to `Icons.account_circle`
  and with a size of 50 pixels.

  </li>
  <li markdown="1">
  A `Padding` widget that creates a space of 8
  pixels around the `Icon` widget.

  To do this, you can specify `const EdgeInsets.all(8.0)`
  for the `padding` property.

  The `Row` should look like this:
  </li>
</ul>

  <!-- skip -->
  ```dart
     Row(
       children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.account_circle, size: 50),
        ),
        Column( ... ), // <--- The Column you first implemented
      ],
     );
  ```

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter McFlutter',
          style: Theme.of(context).textTheme.headline5,
        ),
        Text('Experienced App Developer'),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin solution.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.account_circle, size: 50),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter McFlutter',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text('Experienced App Developer'),
          ],
        ),
      ],
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffeeeeee),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x80000000),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  // Check MyWidget starts with one Column

  final myWidgetElement = controller.element(find.byType(MyWidget));

  final myWidgetChildElements = <Element>[];
  myWidgetElement.visitChildElements((e) => myWidgetChildElements.add(e));

  if (myWidgetChildElements.length != 1 ||
      myWidgetChildElements[0].widget is! Row) {
    _result(false, ['The root widget in MyWidget\'s build method should be a Column.']);
    return;
  }

  // Check first Row has two children: Padding and Column

  final firstRowElement = myWidgetChildElements[0];

  final firstRowChildElements = <Element>[];
  firstRowElement.visitChildElements((e) => firstRowChildElements.add(e));

  if (firstRowChildElements.length != 2 ||
      firstRowChildElements[0].widget is! Padding ||
      firstRowChildElements[1].widget is! Column) {
    _result(false, ['The first Row should have two children: first a Padding, and then a Column.']);
    return;
  }

  // Check Padding has correct padding

  final paddingElement = firstRowChildElements[0];

  if ((paddingElement.widget as Padding).padding != const EdgeInsets.all(8)) {
    _result(false, ['The Padding widget in the first Row should have a padding of 8.']);
    return;
  }

  // Check Padding has an Icon as its child

  final paddingChildren = <Element>[];
  paddingElement.visitChildElements((e) => paddingChildren.add(e));

  if (paddingChildren.length != 1 || paddingChildren[0].widget is! Icon) {
    _result(false, ['The Padding widget in the first Row should have an Icon as its child.']);
    return;
  }

  // Check icon has a size of 50

  if ((paddingChildren[0].widget as Icon).size != 50) {
    _result(false, ['The Icon in the top-left corner should have a size of 50.']);
    return;
  }

  // Check inner Column has correct properties

  final innerColumnElement = firstRowChildElements[1];
  final innerColumnWidget = innerColumnElement.widget as Column;

  if (innerColumnWidget.crossAxisAlignment != CrossAxisAlignment.start) {
    _result(false, ['The Column for the name and title should use CrossAxisAlignment.start as its crosAxisAlignment.']);
    return;
  }

  if (innerColumnWidget.mainAxisSize != MainAxisSize.min) {
    _result(false, ['The Column for the name and title should use MainAxisSize.min as its mainAxisSize.']);
    return;
  }

  // Check inner Column has two Text children

  if (innerColumnWidget.children.any((w) => w is! Text)) {
    _result(false, ['The Column for the name and title should have two children, both Text widgets.']);
    return;
  }

  // Check first Text has headline style

  final nameText = innerColumnWidget.children[0] as Text;

  if (nameText.style?.fontSize != 24) {
    _result(false, ['The Text widget for the name should use the "headline" textStyle.']);
    return;
  }

  _result(true);
}
{$ end test.dart $}
```

### Part 2
{:.no_toc}

#### Exercise: Tweak the layout
{:.no_toc}
{{site.alert.secondary}}

  Wrap the `Row` in a `Column` that has a `mainAxisSize`
  property set to `MainAxisSize.min` and a
  `crossAxisAlignment` property set to `CrossAxisAlignment.stretch`.
  The `Column` contains the following widgets:

  * A `SizedBox` widget with a height of 8.

  * An empty `Row` where you'll add the contact information in
    a later step.

  * A second `SizedBox` widget with a height of 16.

  * A second empty `Row` where you'll add
    four icons (Part 3).

  The `Column`'s list of widgets should be formatted as follows,
  so the contact information and icons are displayed below the
  name and title:

  <!-- skip -->
  ```dart

     ],
    ), // <--- Closing parenthesis for the Row
    SizedBox(),
    Row(), // First empty Row
    SizedBox(),
    Row(), // Second empty Row
   ],
  ); // <--- Closing parenthesis for the Column that wraps the Row

  ```

{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.account_circle, size: 50),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter McFlutter',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text('Experienced App Developer'),
          ],
        ),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin solution.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(),
        SizedBox(height: 16),
        Row(),
      ],
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffeeeeee),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x80000000),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  // Check MyWidget starts with one Column

  final myWidgetElement = controller.element(find.byType(MyWidget));

  final myWidgetChildElements = <Element>[];
  myWidgetElement.visitChildElements((e) => myWidgetChildElements.add(e));

  if (myWidgetChildElements.length != 1 ||
      myWidgetChildElements[0].widget is! Column) {
    _result(false, ['The root widget in MyWidget\'s build method should be a Column.']);
    return;
  }

  // Check outermost Column has 5 correct children.

  final outerColumnElement = myWidgetChildElements[0];
  final outerColumnChildWidgets =
      (outerColumnElement.widget as Column).children;
  final outerColumnChildElements = <Element>[];
  outerColumnElement.visitChildElements((e) => outerColumnChildElements.add(e));

  if (outerColumnChildWidgets.length != 5 ||
      outerColumnChildWidgets[0] is! Row ||
      outerColumnChildWidgets[1] is! SizedBox ||
      outerColumnChildWidgets[2] is! Row ||
      outerColumnChildWidgets[3] is! SizedBox ||
      outerColumnChildWidgets[4] is! Row) {
    _result(false, ['The children of the outermost Column should be [Row, SizedBox, Row, SizedBox, Row] in that order.']);
    return;
  }

  // Check outermost Column's properties

  if ((outerColumnElement.widget as Column).mainAxisSize != MainAxisSize.min) {
    _result(false, ['The outermost Column should use MainAxisSize.min for its mainAxisSize.']);
    return;
  }

  if ((outerColumnElement.widget as Column).crossAxisAlignment !=
      CrossAxisAlignment.stretch) {
    _result(false, ['The outermost Column should use CrossAxisAlignment.stretch for its crossAxisAlignment.']);
    return;
  }

  // Check first Row has two children: Padding and Column

  final firstRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[0]);

  final firstRowChildElements = <Element>[];
  firstRowElement.visitChildElements((e) => firstRowChildElements.add(e));

  if (firstRowChildElements.length != 2 ||
      firstRowChildElements[0].widget is! Padding ||
      firstRowChildElements[1].widget is! Column) {
    _result(false, ['The first Row should have two children: first a Padding, and then a Column.']);
    return;
  }

  // Check Padding has correct padding

  final paddingElement = firstRowChildElements[0];

  if ((paddingElement.widget as Padding).padding != const EdgeInsets.all(8)) {
    _result(false, ['The Padding widget in the first Row should have a padding of 8.']);
    return;
  }

  // Check Padding has an Icon as its child

  final paddingChildren = <Element>[];
  paddingElement.visitChildElements((e) => paddingChildren.add(e));

  if (paddingChildren.length != 1 || paddingChildren[0].widget is! Icon) {
    _result(false, ['The Padding widget in the first Row should have an Icon as its child.']);
    return;
  }

  // Check icon has a size of 50

  if ((paddingChildren[0].widget as Icon).size != 50) {
    _result(false, ['The Icon in the top-left corner should have a size of 50.']);
    return;
  }

  // Check inner Column has correct properties

  final innerColumnElement = firstRowChildElements[1];
  final innerColumnWidget = innerColumnElement.widget as Column;

  if (innerColumnWidget.crossAxisAlignment != CrossAxisAlignment.start) {
    _result(false, ['The Column for the name and title should use CrossAxisAlignment.start as its crosAxisAlignment.']);
    return;
  }

  if (innerColumnWidget.mainAxisSize != MainAxisSize.min) {
    _result(false, ['The Column for the name and title should use MainAxisSize.min as its mainAxisSize.']);
    return;
  }

  // Check inner Column has two Text children

  if (innerColumnWidget.children.any((w) => w is! Text)) {
    _result(false, ['The Column for the name and title should have two children, both Text widgets.']);
    return;
  }

  // Check first Text has headline style

  final nameText = innerColumnWidget.children[0] as Text;

  if (nameText.style?.fontSize != 24) {
    _result(false, ['The Text widget for the name should use the "headline" textStyle.']);
    return;
  }

  // Check first SizedBox has correct properties

  final firstSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[1]);

  if ((firstSizedBoxElement.widget as SizedBox).height != 8) {
    _result(false, ['The SizedBox before the first empty Row should have a height of 8.']);
    return;
  }

  // Check second SizedBox has correct properties

  final secondSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[3]);

  if ((secondSizedBoxElement.widget as SizedBox).height != 16) {
    _result(false, ['The SizedBox between the first and second empty Rows should have a height of 16.']);
    return;
  }

  _result(true);
}
{$ end test.dart $}
```

#### Exercise: Enter contact information
{:.no_toc}
{{site.alert.secondary}}
  Enter two `Text` widgets inside the first empty `Row` :

<ul markdown="1">
  <li markdown="1">
  The first `Text` widget contains the address `123 Main Street`.
  </li>
  <li markdown="1">
  The second `Text` widget contains the phone number `(415) 555-0198`.
  </li>
</ul>

  For the first empty `Row`,
  set the `mainAxisAlignment` property to
  `MainAxisAlignment.spaceBetween`.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [],
        ),
        SizedBox(height: 16),
        Row(
          children: [],
        ),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin solution.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '123 Main Street',
            ),
            Text(
              '(415) 555-0198',
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [],
        ),
      ],
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffeeeeee),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x80000000),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  // Check MyWidget starts with one Column

  final myWidgetElement = controller.element(find.byType(MyWidget));

  final myWidgetChildElements = <Element>[];
  myWidgetElement.visitChildElements((e) => myWidgetChildElements.add(e));

  if (myWidgetChildElements.length != 1 ||
      myWidgetChildElements[0].widget is! Column) {
    _result(false, ['The root widget in MyWidget\'s build method should be a Column.']);
    return;
  }

  // Check outermost Column has 5 correct children.

  final outerColumnElement = myWidgetChildElements[0];
  final outerColumnChildWidgets =
      (outerColumnElement.widget as Column).children;
  final outerColumnChildElements = <Element>[];
  outerColumnElement.visitChildElements((e) => outerColumnChildElements.add(e));

  if (outerColumnChildWidgets.length != 5 ||
      outerColumnChildWidgets[0] is! Row ||
      outerColumnChildWidgets[1] is! SizedBox ||
      outerColumnChildWidgets[2] is! Row ||
      outerColumnChildWidgets[3] is! SizedBox ||
      outerColumnChildWidgets[4] is! Row) {
    _result(false, ['The children of the outermost Column should be [Row, SizedBox, Row, SizedBox, Row] in that order.']);
    return;
  }

  // Check outermost Column's properties

  if ((outerColumnElement.widget as Column).mainAxisSize != MainAxisSize.min) {
    _result(false, ['The outermost Column should use MainAxisSize.min for its mainAxisSize.']);
    return;
  }

  if ((outerColumnElement.widget as Column).crossAxisAlignment !=
      CrossAxisAlignment.stretch) {
    _result(false, ['The outermost Column should use CrossAxisAlignment.stretch for its crossAxisAlignment.']);
    return;
  }

  // Check first Row has two children: Padding and Column

  final firstRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[0]);

  final firstRowChildElements = <Element>[];
  firstRowElement.visitChildElements((e) => firstRowChildElements.add(e));

  if (firstRowChildElements.length != 2 ||
      firstRowChildElements[0].widget is! Padding ||
      firstRowChildElements[1].widget is! Column) {
    _result(false, ['The first Row should have two children: first a Padding, and then a Column.']);
    return;
  }

  // Check Padding has correct padding

  final paddingElement = firstRowChildElements[0];

  if ((paddingElement.widget as Padding).padding != const EdgeInsets.all(8)) {
    _result(false, ['The Padding widget in the first Row should have a padding of 8.']);
    return;
  }

  // Check Padding has an Icon as its child

  final paddingChildren = <Element>[];
  paddingElement.visitChildElements((e) => paddingChildren.add(e));

  if (paddingChildren.length != 1 || paddingChildren[0].widget is! Icon) {
    _result(false, ['The Padding widget in the first Row should have an Icon as its child.']);
    return;
  }

  // Check icon has a size of 50

  if ((paddingChildren[0].widget as Icon).size != 50) {
    _result(false, ['The Icon in the top-left corner should have a size of 50.']);
    return;
  }

  // Check inner Column has correct properties

  final innerColumnElement = firstRowChildElements[1];
  final innerColumnWidget = innerColumnElement.widget as Column;

  if (innerColumnWidget.crossAxisAlignment != CrossAxisAlignment.start) {
    _result(false, ['The Column for the name and title should use CrossAxisAlignment.start as its crosAxisAlignment.']);
    return;
  }

  if (innerColumnWidget.mainAxisSize != MainAxisSize.min) {
    _result(false, ['The Column for the name and title should use MainAxisSize.min as its mainAxisSize.']);
    return;
  }

  // Check inner Column has two Text children

  if (innerColumnWidget.children.any((w) => w is! Text)) {
    _result(false, ['The Column for the name and title should have two children, both Text widgets.']);
    return;
  }

  // Check first Text has headline style

  final nameText = innerColumnWidget.children[0] as Text;

  if (nameText.style?.fontSize != 24) {
    _result(false, ['The Text widget for the name should use the "headline" textStyle.']);
    return;
  }

  // Check first SizedBox has correct properties

  final firstSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[1]);

  if ((firstSizedBoxElement.widget as SizedBox).height != 8) {
    _result(false, ['The SizedBox before the first empty Row widget should have a height of 8.']);
    return;
  }

  // Check second Row has two Text children

  final secondRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[2]);

  final secondRowChildElements = <Element>[];
  secondRowElement.visitChildElements((e) => secondRowChildElements.add(e));

  if (secondRowChildElements.length != 2 ||
      secondRowChildElements.any((e) => e.widget is! Text)) {
    _result(false, ['The first empty Row widget should have two children, both Text widgets.']);
    return;
  }

  // Check second Row has correct properties

  if ((secondRowElement.widget as Row).mainAxisAlignment !=
      MainAxisAlignment.spaceBetween) {
    _result(false, ['The first empty Row widget should use MainAxisAlignment.spaceBetween as its MainAxisAlignment value.']);
    return;
  }

  // Check second SizedBox has correct properties

  final secondSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[3]);

  if ((secondSizedBoxElement.widget as SizedBox).height != 16) {
    _result(false, ['The SizedBox between the first and second empty Row widgets should have a height of 16.']);
    return;
  }

  _result(true);
}
{$ end test.dart $}
```

### Part 3
{:.no_toc}
#### Exercise: Add four icons
{:.no_toc}
{{site.alert.secondary}}
  Enter the following `Icon` widgets inside the second empty `Row`:

  * `Icons.accessibility`
  * `Icons.timer`
  * `Icons.phone_android`
  * `Icons.phone_iphone`

  For the second empty `Row`,
  set the `mainAxisAlignment` property to
  `MainAxisAlignment.spaceAround`.
{{site.alert.end}}

<!-- skip -->
```run-dartpad:theme-dark:mode-flutter:width-100%:height-400px:split-60:null_safety-true
{$ begin main.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('123 Main Street'),
            Text('415-555-0198'),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [],
        ),
      ],
    );
  }
}
{$ end main.dart $}
{$ begin solution.dart $}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '123 Main Street',
            ),
            Text(
              '(415) 555-0198',
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.accessibility),
            Icon(Icons.timer),
            Icon(Icons.phone_android),
            Icon(Icons.phone_iphone),
          ],
        ),
      ],
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffeeeeee),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x80000000),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized()
      .addPostFrameCallback((timestamp) async {
    completer.complete();
  });
  
  await completer.future;

  final controller = LiveWidgetController(WidgetsBinding.instance!);

  // Check MyWidget starts with one Column

  final myWidgetElement = controller.element(find.byType(MyWidget));

  final myWidgetChildElements = <Element>[];
  myWidgetElement.visitChildElements((e) => myWidgetChildElements.add(e));

  if (myWidgetChildElements.length != 1 ||
      myWidgetChildElements[0].widget is! Column) {
    _result(false, ['The root widget in MyWidget\'s build method should be a Column.']);
    return;
  }

  // Check outermost Column has 5 correct children.

  final outerColumnElement = myWidgetChildElements[0];
  final outerColumnChildWidgets =
      (outerColumnElement.widget as Column).children;
  final outerColumnChildElements = <Element>[];
  outerColumnElement.visitChildElements((e) => outerColumnChildElements.add(e));

  if (outerColumnChildWidgets.length != 5 ||
      outerColumnChildWidgets[0] is! Row ||
      outerColumnChildWidgets[1] is! SizedBox ||
      outerColumnChildWidgets[2] is! Row ||
      outerColumnChildWidgets[3] is! SizedBox ||
      outerColumnChildWidgets[4] is! Row) {
    _result(false, ['The children of the outermost Column should be [Row, SizedBox, Row, SizedBox, Row] in that order.']);
    return;
  }

  // Check outermost Column's properties

  if ((outerColumnElement.widget as Column).mainAxisSize != MainAxisSize.min) {
    _result(false, ['The outermost Column should use MainAxisSize.min for its mainAxisSize.']);
    return;
  }

  if ((outerColumnElement.widget as Column).crossAxisAlignment !=
      CrossAxisAlignment.stretch) {
    _result(false, ['The outermost Column should use CrossAxisAlignment.stretch for its crossAxisAlignment.']);
    return;
  }

  // Check first Row has two children: Padding and Column

  final firstRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[0]);

  final firstRowChildElements = <Element>[];
  firstRowElement.visitChildElements((e) => firstRowChildElements.add(e));

  if (firstRowChildElements.length != 2 ||
      firstRowChildElements[0].widget is! Padding ||
      firstRowChildElements[1].widget is! Column) {
    _result(false, ['The first Row should have two children: first a Padding, and then a Column.']);
    return;
  }

  // Check Padding has correct padding

  final paddingElement = firstRowChildElements[0];

  if ((paddingElement.widget as Padding).padding != const EdgeInsets.all(8)) {
    _result(false, ['The Padding widget in the first Row should have a padding of 8.']);
    return;
  }

  // Check Padding has an Icon as its child

  final paddingChildren = <Element>[];
  paddingElement.visitChildElements((e) => paddingChildren.add(e));

  if (paddingChildren.length != 1 || paddingChildren[0].widget is! Icon) {
    _result(false, ['The Padding widget in the first Row should have an Icon as its child.']);
    return;
  }

  // Check icon has a size of 50

  if ((paddingChildren[0].widget as Icon).size != 50) {
    _result(false, ['The Icon in the top-left corner should have a size of 50.']);
    return;
  }

  // Check inner Column has correct properties

  final innerColumnElement = firstRowChildElements[1];
  final innerColumnWidget = innerColumnElement.widget as Column;

  if (innerColumnWidget.crossAxisAlignment != CrossAxisAlignment.start) {
    _result(false, ['The Column for the name and title should use CrossAxisAlignment.start as its crosAxisAlignment.']);
    return;
  }

  // Check inner Column has two Text children

  if (innerColumnWidget.children.any((w) => w is! Text)) {
    _result(false, ['The Column for the name and title should have two children, both Text widgets.']);
    return;
  }

  if (innerColumnWidget.mainAxisSize != MainAxisSize.min) {
    _result(false, ['The Column for the name and title should use MainAxisSize.min as its mainAxisSize.']);
    return;
  }

  // Check first Text has headline style

  final nameText = innerColumnWidget.children[0] as Text;

  if (nameText.style?.fontSize != 24) {
    _result(false, ['The Text widget for the name should use the "headline" textStyle.']);
    return;
  }

  // Check first SizedBox has correct properties

  final firstSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[1]);

  if ((firstSizedBoxElement.widget as SizedBox).height != 8) {
    _result(false, ['The SizedBox before the first empty Row widget should have a height of 8.']);
    return;
  }

  // Check second Row has two Text children

  final secondRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[2]);

  final secondRowChildElements = <Element>[];
  secondRowElement.visitChildElements((e) => secondRowChildElements.add(e));

  if (secondRowChildElements.length != 2 ||
      secondRowChildElements.any((e) => e.widget is! Text)) {
    _result(false, ['The first Row widget should have two children, both Text widgets.']);
    return;
  }

  // Check second Row has correct properties

  if ((secondRowElement.widget as Row).mainAxisAlignment !=
      MainAxisAlignment.spaceBetween) {
    _result(false, ['The first Row widget should use MainAxisAlignment.spaceBetween as its mainAxisAlignment.']);
    return;
  }

  // Check second SizedBox has correct properties

  final secondSizedBoxElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[3]);

  if ((secondSizedBoxElement.widget as SizedBox).height != 16) {
    _result(false, ['The SizedBox between the first and second Row widgets should have a height of 16.']);
    return;
  }

  // Check second empty Row has four Icon children

  final thirdRowElement = outerColumnChildElements
      .firstWhere((e) => e.widget == outerColumnChildWidgets[4]);

  final thirdRowChildElements = <Element>[];
  thirdRowElement.visitChildElements((e) => thirdRowChildElements.add(e));

  if (thirdRowChildElements.length != 4 ||
      thirdRowChildElements.any((e) => e.widget is! Icon)) {
    _result(false, ['The second empty Row widget should have four children, all Icon widgets.']);
    return;
  }

  // Check second empty Row has correct properties

  if ((thirdRowElement.widget as Row).mainAxisAlignment !=
      MainAxisAlignment.spaceAround) {
    _result(false, ['The second empty Row widget should use MainAxisAlignment.spaceAround as its MainAxisAligment value.']);
    return;
  }

  _result(true);
}
{$ end test.dart $}
```

## What's next?

Congratulations, you've finished this codelab!
If you'd like to know more about Flutter,
here are a few suggestions for resources worth exploring:

* Learn more about layouts in Flutter by
  visiting the [Building layouts][] page.
* Check out the [sample apps][].
* Visit [Flutter's YouTube channel][],
  where you can watch a variety videos from
  videos that focus on individual widgets
  to videos of developers building apps.

You can download Flutter from the [install][] page.




[Building layouts]: /docs/development/ui/layout
[Cupertino]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[DartPad issue]: {{site.github}}/dart-lang/dart-pad/issues/new
[Flutter's YouTube channel]: https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw
[GitHub]: {{site.github}}/flutter/website/tree/master/examples/layout/sizing/images
[install]: /docs/get-started/install
[Material]: {{site.api}}/flutter/material/MaterialApp-class.html
[Material Color palette]: {{site.api}}/flutter/material/Colors-class.html
[Material Icon library]: {{site.api}}/flutter/material/Icons-class.html
[sample apps]: {{site.github}}/flutter/samples
