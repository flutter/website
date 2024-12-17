---
title: Flutter for UIKit developers
description: Learn how to apply iOS and UIKit developer knowledge when building Flutter apps.
---

<?code-excerpt path-base="get-started/flutter-for/ios_devs"?>

iOS developers with experience using UIKit
who want to write mobile apps using Flutter
should review this guide.
It explains how to apply existing UIKit knowledge to Flutter.

:::note
If you have experience building apps with SwiftUI,
check out [Flutter for SwiftUI developers][] instead.
:::

Flutter is a framework for building cross-platform applications
that uses the Dart programming language.
To understand some differences between programming with Dart
and programming with Swift,
check out [Learning Dart as a Swift Developer][]
and [Flutter concurrency for Swift developers][].

Your iOS and UIKit knowledge and experience
are highly valuable when building with Flutter.
{% comment %}
  TODO: Add talk about plugin system for interacting with OS and hardware
  when [iOS and Apple hardware interactions with Flutter][] is released.
{% endcomment -%}

Flutter also makes a number of adaptations
to app behavior when running on iOS.
To learn how, see [Platform adaptations][].

:::tip
To integrate Flutter code into an **existing** iOS app,
check out [Add Flutter to existing app][].
:::

Use this guide as a cookbook.
Jump around and find questions that address your most relevant needs.

## Overview

As an introduction, watch the following video.
It outlines how Flutter works on iOS and how to use Flutter to build iOS apps.

{% ytEmbed 'ceMsPBbcEGg', 'Flutter for iOS developers', false, true %}

### Views vs. Widgets

:::secondary
How is react-style, or _declarative_,
programming different from the
traditional imperative style?
For a comparison, see [Introduction to declarative UI][].
:::

In UIKit, most of what you create in the UI is done using view objects,
which are instances of the `UIView` class.
These can act as containers for other `UIView` classes,
which form your layout.

In Flutter, the rough equivalent to a `UIView` is a `Widget`.
Widgets don't map exactly to iOS views,
but while you're getting acquainted with how Flutter works
you can think of them as "the way you declare and construct UI".

However, these have a few differences to a `UIView`.
To start, widgets have a different lifespan: they are immutable
and only exist until they need to be changed.
Whenever widgets or their state change,
Flutter's framework creates a new tree of widget instances.
In comparison, a UIKit view is not recreated when it changes,
but rather it's a mutable entity that is drawn once
and doesn't redraw until it is invalidated using `setNeedsDisplay()`.

Furthermore, unlike `UIView`, Flutter's widgets are lightweight,
in part due to their immutability.
Because they aren't views themselves,
and aren't directly drawing anything,
but rather are a description of the UI and its semantics
that get "inflated" into actual view objects under the hood.

Flutter includes the [Material Components][] library.
These are widgets that implement the
[Material Design guidelines][].
Material Design is a flexible design system
[optimized for all platforms][], including iOS.

But Flutter is flexible and expressive enough
to implement any design language.
On iOS, you can use the [Cupertino widgets][]
library to produce an interface that looks like
[Apple's iOS design language][].

### Updating widgets

To update your views in UIKit, you directly mutate them.
In Flutter, widgets are immutable and not updated directly.
Instead, you have to manipulate the widget's state.

This is where the concept of Stateful vs Stateless widgets
comes in. A `StatelessWidget` is just what it sounds
like&mdash;a widget with no state attached.

`StatelessWidgets` are useful when the part of the user interface you are
describing does not depend on anything other than the initial configuration
information in the widget.

For example, with UIKit, this is similar to placing a `UIImageView`
with your logo as the `image`. If the logo is not changing during runtime,
use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received
after making an HTTP call, use a `StatefulWidget`.
After the HTTP call has completed, tell the Flutter framework
that the widget's `State` is updated, so it can update the UI.

The important difference between stateless and
stateful widgets is that `StatefulWidget`s have a `State` object
that stores state data and carries it over across tree rebuilds,
so it's not lost.

If you are in doubt, remember this rule:
if a widget changes outside of the `build` method
(because of runtime user interactions, for example),
it's stateful.
If the widget never changes, once built, it's stateless.
However, even if a widget is stateful, the containing parent widget
can still be stateless if it isn't itself reacting to those changes
(or other inputs).

The following example shows how to use a `StatelessWidget`.
A common`StatelessWidget` is the `Text` widget.
If you look at the implementation of the `Text` widget,
you'll find it subclasses `StatelessWidget`.

<?code-excerpt "lib/text_widget.dart (text-widget)" replace="/return const //g"?>
```dart
Text(
  'I like Flutter!',
  style: TextStyle(fontWeight: FontWeight.bold),
);
```

If you look at the code above, you might notice that the `Text` widget
carries no explicit state with it. It renders what is passed in its
constructors and nothing more.

But, what if you want to make "I Like Flutter" change dynamically,
for example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and
update it when the user clicks the button.

For example:

<?code-excerpt "lib/text_widget.dart (stateful-widget)"?>
```dart

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  String textToShow = 'I Like Flutter';

  void _updateText() {
    setState(() {
      // Update the text
      textToShow = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

### Widget layout

In UIKit, you might use a Storyboard file
to organize your views and set constraints,
or you might set your constraints programmatically in your view controllers.
In Flutter, declare your layout in code by composing a widget tree.

The following example shows how to display a simple widget with padding:

<?code-excerpt "lib/layout.dart (simple-widget)"?>
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sample App')),
    body: Center(
      child: CupertinoButton(
        onPressed: () {},
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: const Text('Hello'),
      ),
    ),
  );
}
```

You can add padding to any widget,
which mimics the functionality of constraints in iOS.

You can view the layouts that Flutter has to offer
in the [widget catalog][].

### Removing Widgets

In UIKit, you call `addSubview()` on the parent,
or `removeFromSuperview()` on a child view
to dynamically add or remove child views.
In Flutter, because widgets are immutable,
there is no direct equivalent to `addSubview()`.
Instead, you can pass a function to the parent
that returns a widget, and control that child's creation
with a boolean flag.

The following example shows how to toggle between two widgets
when the user clicks the `FloatingActionButton`:

<?code-excerpt "lib/layout.dart (toggle-widget)"?>
```dart
class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default value for toggle.
  bool toggle = true;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    }

    return CupertinoButton(
      onPressed: () {},
      child: const Text('Toggle Two'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

### Animations

In UIKit, you create an animation by calling the
`animate(withDuration:animations:)` method on a view.
In Flutter, use the animation library
to wrap widgets inside an animated widget.

In Flutter, use an `AnimationController`, which is an `Animation<double>`
that can pause, seek, stop, and reverse the animation.
It requires a `Ticker` that signals when vsync happens
and produces a linear interpolation
between 0 and 1 on each frame while it's running.
You then create one or more
`Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation`
to implement an animation along an interpolated curve.
In this sense, the controller is the "master" source
of the animation progress
and the `CurvedAnimation` computes the curve
that replaces the controller's default linear motion.
Like widgets, animations in Flutter work with composition.

When building the widget tree you assign the `Animation` to an animated
property of a widget, such as the opacity of a `FadeTransition`,
and tell the controller to start the animation.

The following example shows how to write a `FadeTransition` that
fades the widget into a logo when you press the `FloatingActionButton`:

<?code-excerpt "lib/animation.dart"?>
```dart
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fade Demo',
      home: MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  const MyFadeTest({super.key, required this.title});

  final String title;

  @override
  State<MyFadeTest> createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(size: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
      ),
    );
  }
}
```

For more information, see [Animation & Motion widgets][],
the [Animations tutorial][], and the [Animations overview][].

### Drawing on the screen

In UIKit, you use `CoreGraphics` to draw lines and shapes to the
screen. Flutter has a different API based on the `Canvas` class,
with two other classes that help you draw: `CustomPaint` and `CustomPainter`,
the latter of which implements your algorithm to draw to the canvas.

To learn how to implement a signature painter in Flutter,
see Collin's answer on [StackOverflow][].

[StackOverflow]: {{site.so}}/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter

<?code-excerpt "lib/canvas.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  State<Signature> createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox? referenceBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (details) => _points.add(null),
      child: CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
```

### Widget opacity

In UIKit, everything has `.opacity` or `.alpha`.
In Flutter, most of the time you need to
wrap a widget in an `Opacity` widget to accomplish this.

### Custom Widgets

In UIKit, you typically subclass `UIView`, or use a pre-existing view,
to override and implement methods that achieve the desired behavior.
In Flutter, build a custom widget by [composing][] smaller widgets
(instead of extending them).

For example, how do you build a `CustomButton`
that takes a label in the constructor?
Create a CustomButton that composes a `ElevatedButton` with a label,
rather than by extending `ElevatedButton`:

<?code-excerpt "lib/custom.dart (custom-button)"?>
```dart
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
```

Then use `CustomButton`,
just as you'd use any other Flutter widget:

<?code-excerpt "lib/custom.dart (use-custom-button)"?>
```dart
@override
Widget build(BuildContext context) {
  return const Center(
    child: CustomButton('Hello'),
  );
}
```

### Managing dependencies

In iOS, you add dependencies with CocoaPods by adding to your `Podfile`.
Flutter uses Dart's build system and the Pub package manager
to handle dependencies. The tools delegate the building of the
native Android and iOS wrapper apps to the
respective build systems.

While there is a Podfile in the iOS folder in your
Flutter project, only use this if you are adding native
dependencies needed for per-platform integration.
In general, use `pubspec.yaml` to declare external dependencies in Flutter.
A good place to find great packages for Flutter is on [pub.dev][].

## Navigation

This section of the document discusses navigation
between pages of an app, the push and pop mechanism, and more.

### Navigating between pages

In UIKit, to travel between view controllers, you can use a
`UINavigationController` that manages the stack of view controllers
to display.

Flutter has a similar implementation,
using a `Navigator` and `Routes`.
A `Route` is an abstraction for a "screen" or "page" of an app,
and a `Navigator` is a [widget][]
that manages routes. A route roughly maps to a
`UIViewController`. The navigator works in a similar way to the iOS
`UINavigationController`, in that it can `push()` and `pop()`
routes depending on whether you want to navigate to, or back from, a view.

To navigate between pages, you have a couple options:

* Specify a `Map` of route names.
* Directly navigate to a route.

The following example builds a `Map.`

<?code-excerpt "lib/intent.dart (map)"?>
```dart
void main() {
  runApp(
    CupertinoApp(
      home: const MyAppHome(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}
```

Navigate to a route by `push`ing its name to the `Navigator`.

<?code-excerpt "lib/intent.dart (push)"?>
```dart
Navigator.of(context).pushNamed('/b');
```

The `Navigator` class handles routing in Flutter and is used to get
a result back from a route that you have pushed on the stack.
This is done by `await`ing on the `Future` returned by `push()`.

For example, to start a `location` route that lets the user select their
location, you might do the following:

<?code-excerpt "lib/intent.dart (push-await)"?>
```dart
Object? coordinates = await Navigator.of(context).pushNamed('/location');
```

And then, inside your `location` route, once the user has selected their
location, `pop()` the stack with the result:

<?code-excerpt "lib/intent.dart (pop)"?>
```dart
Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
```

### Navigating to another app

In UIKit, to send the user to another application,
you use a specific URL scheme.
For the system level apps, the scheme depends on the app.
To implement this functionality in Flutter,
create a native platform integration, or use an
[existing plugin][], such as [`url_launcher`][].

### Manually pop back

Calling `SystemNavigator.pop()` from your Dart code
invokes the following iOS code:

```objc
UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
if ([viewController isKindOfClass:[UINavigationController class]]) {
  [((UINavigationController*)viewController) popViewControllerAnimated:NO];
}
```

If that doesn't do what you want, you can create your own
[platform channel][] to invoke arbitrary iOS code.

### Handling localization

Unlike iOS, which has the `Localizable.strings` file,
Flutter doesn't currently have a dedicated system for handling strings.
At the moment, the best practice is to declare your copy text
in a class as static fields and access them from there. For example:

<?code-excerpt "lib/string_examples.dart (strings)"?>
```dart
class Strings {
  static const String welcomeMessage = 'Welcome To Flutter';
}
```

You can access your strings as such:

<?code-excerpt "lib/string_examples.dart (access-string)" replace="/const //g; /return //g;"?>
```dart
Text(Strings.welcomeMessage);
```

By default, Flutter only supports US English for its strings.
If you need to add support for other languages,
include the `flutter_localizations` package.
You might also need to add Dart's [`intl`][]
package to use i10n machinery, such as date/time formatting.

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any # Use version of intl from flutter_localizations.
```

To use the `flutter_localizations` package,
specify the `localizationsDelegates` and
`supportedLocales` on the app widget:

<?code-excerpt "lib/localizations_example.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        // Add app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale('en', 'US'), // English
        Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
    );
  }
}
```

The delegates contain the actual localized values,
while the `supportedLocales` defines which locales the app supports.
The above example uses a `MaterialApp`,
so it has both a `GlobalWidgetsLocalizations`
for the base widgets localized values,
and a `MaterialWidgetsLocalizations` for the Material widgets localizations.
If you use `WidgetsApp` for your app, you don't need the latter.
Note that these two delegates contain "default" values,
but you'll need to provide one or more delegates
for your own app's localizable copy,
if you want those to be localized too.

When initialized, the `WidgetsApp` (or `MaterialApp`)
creates a [`Localizations`][] widget for you,
with the delegates you specify.
The current locale for the device is always accessible
from the `Localizations` widget from the current context
(in the form of a `Locale` object), or using the [`Window.locale`][].

To access localized resources, use the `Localizations.of()` method
to access a specific localizations class that is provided by a given delegate.
Use the [`intl_translation`][] package to extract translatable copy
to [arb][] files for translating, and importing them back into the app
for using them with `intl`.

For further details on internationalization and localization in Flutter,
see the [internationalization guide][], which has sample code
with and without the `intl` package.

## ViewControllers

This section of the document discusses the equivalent
of ViewController in Flutter and how to listen to
lifecycle events.

### Equivalent of ViewController in Flutter

In UIKit, a `ViewController` represents a portion of user interface,
most commonly used for a screen or section.
These are composed together to build complex user interfaces,
and help scale your application's UI.
In Flutter, this job falls to Widgets.
As mentioned in the Navigation section,
screens in Flutter are represented by Widgets since
"everything is a widget!"
Use a `Navigator` to move between different `Route`s
that represent different screens or pages,
or maybe different states or renderings of the same data.

### Listening to lifecycle events

In UIKit, you can override methods to the `ViewController`
to capture lifecycle methods for the view itself,
or register lifecycle callbacks in the `AppDelegate`.
In Flutter, you have neither concept, but you can instead
listen to lifecycle events by hooking into
the `WidgetsBinding` observer and listening to
the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

**`inactive`**
: The application is in an inactive state and is not receiving
user input. This event only works on iOS,
as there is no equivalent event on Android.

**`paused`**
: The application is not currently visible to the user,
is not responding to user input, but is running in the background.

**`resumed`**
: The application is visible and responding to user input.

**`suspending`**
: The application is suspended momentarily.
The iOS platform has no equivalent event.

For more details on the meaning of these states, see
[`AppLifecycleState` documentation][].

## Layouts

This section discusses different layouts in Flutter
and how they compare with UIKit.

### Displaying a list view

In UIKit, you might show a list in
either a `UITableView` or a `UICollectionView`.
In Flutter, you have a similar implementation using a `ListView`.
In UIKit, these views have delegate methods
for deciding the number of rows,
the cell for each index path, and the size of the cells.

Due to Flutter's immutable widget pattern,
you pass a list of widgets to your `ListView`,
and Flutter takes care of making sure that
scrolling is fast and smooth.

<?code-excerpt "lib/listview.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    final List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $i'),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: _getListData()),
    );
  }
}
```

### Detecting what was clicked

In UIKit, you implement the delegate method,
`tableView:didSelectRowAtIndexPath:`.
In Flutter, use the touch handling provided by the passed-in widgets.

<?code-excerpt "lib/list_item_tapped.dart"?>
```dart
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(
        GestureDetector(
          onTap: () {
            developer.log('row tapped');
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Row $i'),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: _getListData()),
    );
  }
}
```

### Dynamically updating ListView

In UIKit, you update the data for the list view,
and notify the table or collection view using the
`reloadData` method.

In Flutter, if you update the list of widgets inside a `setState()`,
you quickly see that your data doesn't change visually.
This is because when `setState()` is called,
the Flutter rendering engine looks at the widget tree
to see if anything has changed.
When it gets to your `ListView`, it performs an `==` check,
and determines that the two `ListView`s are the same.
Nothing has changed, so no update is required.

For a simple way to update your `ListView`,
create a new `List` inside of `setState()`,
and copy the data from the old list to the new list.
While this approach is simple,
it is not recommended for large data sets,
as shown in the next example.

<?code-excerpt "lib/listview_dynamic.dart"?>
```dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets = List.from(widgets);
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $i'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: widgets),
    );
  }
}
```

The recommended, efficient,
and effective way to build a list uses a `ListView.Builder`.
This method is great when you have a dynamic
list or a list with very large amounts of data.

<?code-excerpt "lib/listview_builder.dart"?>
```dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $i'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }
}
```

Instead of creating a `ListView`, create a `ListView.builder`
that takes two key parameters: the initial length of the list,
and an `ItemBuilder` function.

The `ItemBuilder` function is similar to the `cellForItemAt`
delegate method in an iOS table or collection view,
as it takes a position, and returns the
cell you want rendered at that position.

Finally, but most importantly, notice that the `onTap()` function
doesn't recreate the list anymore, but instead `.add`s to it.

### Creating a scroll view

In UIKit, you wrap your views in a `ScrollView` that
allows a user to scroll your content if needed.

In Flutter the easiest way to do this is using the `ListView` widget.
This acts as both a `ScrollView` and an iOS `TableView`,
as you can lay out widgets in a vertical format.

<?code-excerpt "lib/layout.dart (list-view)"?>
```dart
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

For more detailed docs on how to lay out widgets in Flutter,
see the [layout tutorial][].

## Gesture detection and touch event handling

This section discusses how to detect gestures
and handle different events in Flutter,
and how they compare with UIKit.

### Adding a click listener

In UIKit, you attach a `GestureRecognizer` to a view to
handle click events.
In Flutter, there are two ways of adding touch listeners:

1. If the widget supports event detection, pass a function to it,
   and handle the event in the function. For example, the
   `ElevatedButton` widget has an `onPressed` parameter:

  <?code-excerpt "lib/events.dart (on-pressed)"?>
   ```dart
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        developer.log('click');
      },
      child: const Text('Button'),
    );
  }
   ```

2. If the Widget doesn't support event detection,
   wrap the widget in a GestureDetector and pass a function
   to the `onTap` parameter.

  <?code-excerpt "lib/events.dart (on-tap)"?>
   ```dart
  class SampleTapApp extends StatelessWidget {
    const SampleTapApp({super.key});
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              developer.log('tap');
            },
            child: const FlutterLogo(
              size: 200,
            ),
          ),
        ),
      );
    }
  }
   ```

### Handling other gestures

Using `GestureDetector` you can listen
to a wide range of gestures such as:

* **Tapping**

  **`onTapDown`**
  : A pointer that might cause a tap has contacted the
  screen at a particular location.

  **`onTapUp`**
  : A pointer that triggers a tap has stopped contacting the
  screen at a particular location.

  **`onTap`**
  : A tap has occurred.

  **`onTapCancel`**
  : The pointer that previously triggered the `onTapDown`
  won't cause a tap.

* **Double tapping**

  **`onDoubleTap`**
  : The user tapped the screen at the same location twice in
  quick succession.

* **Long pressing**

  **`onLongPress`**
  : A pointer has remained in contact with the screen
  at the same location for a long period of time.

* **Vertical dragging**

  **`onVerticalDragStart`**
  : A pointer has contacted the screen and might begin to
  move vertically.

  **`onVerticalDragUpdate`**
  : A pointer in contact with the screen
  has moved further in the vertical direction.

  **`onVerticalDragEnd`**
  : A pointer that was previously in contact with the
  screen and moving vertically is no longer in contact
  with the screen and was moving at a specific velocity
  when it stopped contacting the screen.

* **Horizontal dragging**

  **`onHorizontalDragStart`**
  : A pointer has contacted the screen and might begin
  to move horizontally.

  **`onHorizontalDragUpdate`**
  : A pointer in contact with the screen
  has moved further in the horizontal direction.

  **`onHorizontalDragEnd`**
  : A pointer that was previously in contact with the
  screen and moving horizontally is no longer in
  contact with the screen.

The following example shows a `GestureDetector`
that rotates the Flutter logo on a double tap:

<?code-excerpt "lib/events.dart (sample-app)"?>
```dart
class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: RotationTransition(
            turns: curve,
            child: const FlutterLogo(
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}
```

## Themes, styles, and media

Flutter applications are easy to style; you can switch
between light and dark themes,
change the style of your text and UI components,
and more. This section covers aspects of styling your Flutter apps
and compares how you might do the same in UIKit.

### Using a theme

Out of the box, Flutter comes with a beautiful implementation
of Material Design, which takes care of a lot of styling and
theming needs that you would typically do.

To take full advantage of Material Components in your app,
declare a top-level widget, `MaterialApp`,
as the entry point to your application.
`MaterialApp` is a convenience widget that wraps a number
of widgets that are commonly required for applications
implementing Material Design.
It builds upon a `WidgetsApp` by adding Material specific functionality.

But Flutter is flexible and expressive enough to implement
any design language. On iOS, you can use the
[Cupertino library][] to produce an interface that adheres to the
[Human Interface Guidelines][].
For the full set of these widgets,
see the [Cupertino widgets][] gallery.

You can also use a `WidgetsApp` as your app widget,
which provides some of the same functionality,
but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components,
pass a `ThemeData` object to the `MaterialApp` widget.
For example, in the code below,
the color scheme from seed is set to deepPurple and divider color is grey.

<?code-excerpt "lib/theme.dart (theme)"?>
```dart
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        dividerColor: Colors.grey,
      ),
      home: const SampleAppPage(),
    );
  }
}
```

### Using custom fonts

In UIKit, you import any `ttf` font files into your project
and create a reference in the `info.plist` file.
In Flutter, place the font file in a folder
and reference it in the `pubspec.yaml` file,
similar to how you import images.

```yaml
fonts:
  - family: MyCustomFont
    fonts:
      - asset: fonts/MyCustomFont.ttf
      - style: italic
```

Then assign the font to your `Text` widget:

<?code-excerpt "lib/text.dart (custom-font)"?>
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Sample App'),
    ),
    body: const Center(
      child: Text(
        'This is a custom font text',
        style: TextStyle(fontFamily: 'MyCustomFont'),
      ),
    ),
  );
}
```

### Styling text

Along with fonts, you can customize other styling elements on a `Text` widget.
The style parameter of a `Text` widget takes a `TextStyle` object,
where you can customize many parameters, such as:

* `color`
* `decoration`
* `decorationColor`
* `decorationStyle`
* `fontFamily`
* `fontSize`
* `fontStyle`
* `fontWeight`
* `hashCode`
* `height`
* `inherit`
* `letterSpacing`
* `textBaseline`
* `wordSpacing`

### Bundling images in apps

While iOS treats images and assets as distinct items,
Flutter apps have only assets. Resources that are
placed in the `Images.xcasset` folder on iOS,
are placed in an assets' folder for Flutter.
As with iOS, assets are any type of file, not just images.
For example, you might have a JSON file located in the `my-assets` folder:

```plaintext
my-assets/data.json
```

Declare the asset in the `pubspec.yaml` file:

```yaml
assets:
 - my-assets/data.json
```

And then access it from code using an [`AssetBundle`][]:

<?code-excerpt "lib/asset_bundle.dart"?>
```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('my-assets/data.json');
}
```

For images, Flutter follows a simple density-based format like iOS.
Image assets might be `1.0x`, `2.0x`, `3.0x`, or any other multiplier.
Flutter's [`devicePixelRatio`][] expresses the ratio
of physical pixels in a single logical pixel.

Assets are located in any arbitrary folder&mdash;
Flutter has no predefined folder structure.
You declare the assets (with location) in
the `pubspec.yaml` file, and Flutter picks them up.

For example, to add an image called `my_icon.png` to your Flutter
project, you might decide to store it in a folder arbitrarily called `images`.
Place the base image (1.0x) in the `images` folder, and the
other variants in sub-folders named after the appropriate ratio multiplier:

```plaintext
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, declare these images in the `pubspec.yaml` file:

```yaml
assets:
 - images/my_icon.png
```

You can now access your images using `AssetImage`:

<?code-excerpt "lib/images.dart (asset-image)"?>
```dart
image: AssetImage('images/a_dot_burr.jpeg'),
```

or directly in an `Image` widget:

<?code-excerpt "lib/images.dart (image-asset)"?>
```dart
@override
Widget build(BuildContext context) {
  return Image.asset('images/my_image.png');
}
```

For more details, see
[Adding Assets and Images in Flutter][].

## Form input

This section discusses how to use forms in Flutter
and how they compare with UIKit.

### Retrieving user input

Given how Flutter uses immutable widgets with a separate state,
you might be wondering how user input fits into the picture.
In UIKit, you usually query the widgets for their current values
when it's time to submit the user input, or action on it.
How does that work in Flutter?

In practice forms are handled, like everything in Flutter,
by specialized widgets. If you have a `TextField` or a
`TextFormField`, you can supply a [`TextEditingController`][]
to retrieve user input:

<?code-excerpt "lib/form.dart (my-form-state)"?>
```dart
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
```

You can find more information and the full code listing in
[Retrieve the value of a text field][],
from the [Flutter cookbook][].

### Placeholder in a text field

In Flutter, you can easily show a "hint" or a placeholder text
for your field by adding an `InputDecoration` object
to the decoration constructor parameter for the `Text` widget:

<?code-excerpt "lib/form.dart (input-hint)" replace="/return const //g;/;//g"?>
```dart
Center(
  child: TextField(
    decoration: InputDecoration(hintText: 'This is a hint'),
  ),
)
```

### Showing validation errors

Just as you would with a "hint", pass an `InputDecoration` object
to the decoration constructor for the `Text` widget.

However, you don't want to start off by showing an error.
Instead, when the user has entered invalid data,
update the state, and pass a new `InputDecoration` object.

<?code-excerpt "lib/validation_errors.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  String? _errorText;

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: TextField(
          onSubmitted: (text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'This is a hint',
            errorText: _errorText,
          ),
        ),
      ),
    );
  }
}
```

## Threading & asynchronicity

This section discusses concurrency in Flutter and
how it compares with UIKit.

### Writing asynchronous code

Dart has a single-threaded execution model,
with support for `Isolate`s
(a way to run Dart code on another thread),
an event loop, and asynchronous programming.
Unless you spawn an `Isolate`,
your Dart code runs in the main UI thread and is
driven by an event loop. Flutter's event loop is
equivalent to the iOS main loop&mdash;that is,
the `Looper` that is attached to the main thread.

Dart's single-threaded model doesn't mean you are
required to run everything as a blocking operation
that causes the UI to freeze. Instead,
use the asynchronous facilities that the Dart language provides,
such as `async`/`await`, to perform asynchronous work.

For example, you can run network code without causing the
UI to hang by using `async`/`await` and letting Dart do
the heavy lifting:

<?code-excerpt "lib/async.dart (load-data)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

Once the `await`ed network call is done,
update the UI by calling `setState()`,
which triggers a rebuild of the widget subtree
and updates the data.

The following example loads data asynchronously and
displays it in a `ListView`:

<?code-excerpt "lib/async.dart"?>
```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
```

Refer to the next section for more information on doing work
in the background, and how Flutter differs from iOS.

### Moving to the background thread

Since Flutter is single threaded and runs an event loop
(like Node.js), you don't have to worry about
thread management or spawning background threads.
If you're doing I/O-bound work,
such as disk access or a network call,
then you can safely use `async`/`await` and you're done.
If, on the other hand, you need to do computationally intensive
work that keeps the CPU busy, you want to move it to an
`Isolate` to avoid blocking the event loop.

For I/O-bound work, declare the function as an `async` function,
and `await` on long-running tasks inside the function:

<?code-excerpt "lib/async.dart (load-data)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

This is how you typically do network or database calls,
which are both I/O operations.

However, there are times when you might be processing
a large amount of data and your UI hangs.
In Flutter, use `Isolate`s to take advantage of
multiple CPU cores to do long-running or
computationally intensive tasks.

Isolates are separate execution threads that do not share
any memory with the main execution memory heap.
This means you can't access variables from the main thread,
or update your UI by calling `setState()`.
Isolates are true to their name, and cannot share memory
(in the form of static fields, for example).

The following example shows, in a simple isolate,
how to share data back to the main thread to update the UI.

<?code-excerpt "lib/isolates.dart (load-data)"?>
```dart
Future<void> loadData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message.
  final SendPort sendPort = await receivePort.first as SendPort;

  final List<Map<String, dynamic>> msg = await sendReceive(
    sendPort,
    'https://jsonplaceholder.typicode.com/posts',
  );

  setState(() {
    data = msg;
  });
}

// The entry point for the isolate.
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  final ReceivePort port = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (final dynamic msg in port) {
    final String url = msg[0] as String;
    final SendPort replyTo = msg[1] as SendPort;

    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
  }
}

Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
  final ReceivePort response = ReceivePort();
  port.send(<dynamic>[msg, response.sendPort]);
  return response.first as Future<List<Map<String, dynamic>>>;
}
```

Here, `dataLoader()` is the `Isolate` that runs in
its own separate execution thread.
In the isolate, you can perform more CPU intensive
processing (parsing a big JSON, for example),
or perform computationally intensive math,
such as encryption or signal processing.

You can run the full example below:

<?code-excerpt "lib/isolates.dart"?>
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    final SendPort sendPort = await receivePort.first as SendPort;

    final List<Map<String, dynamic>> msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      data = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (final dynamic msg in port) {
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;

      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
    }
  }

  Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
    final ReceivePort response = ReceivePort();
    port.send(<dynamic>[msg, response.sendPort]);
    return response.first as Future<List<Map<String, dynamic>>>;
  }

  Widget getBody() {
    bool showLoadingDialog = data.isEmpty;

    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }
}
```

### Making network requests

Making a network call in Flutter is easy when you
use the popular [`http` package][]. This abstracts
away a lot of the networking that you might normally
implement yourself, making it simple to make network calls.

To add the `http` package as a dependency, run `flutter pub add`:

```console
flutter pub add http
```

To make a network call,
call `await` on the `async` function `http.get()`:

<?code-excerpt "lib/progress.dart (load-data)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

### Showing the progress on long-running tasks

In UIKit, you typically use a `UIProgressView`
while executing a long-running task in the background.

In Flutter, use a `ProgressIndicator` widget.
Show the progress programmatically by controlling
when it's rendered through a boolean flag.
Tell Flutter to update its state before your long-running task starts,
and hide it after it ends.

In the example below, the build function is separated into three different
functions. If `showLoadingDialog` is `true`
(when `widgets.length == 0`), then render the `ProgressIndicator`.
Otherwise, render the `ListView` with the data returned from a network call.

<?code-excerpt "lib/progress.dart"?>
```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }

    return getListView();
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }
}
```

[Flutter for SwiftUI developers]: /get-started/flutter-for/swiftui-devs
[Add Flutter to existing app]: /add-to-app
[Adding Assets and Images in Flutter]: /ui/assets/assets-and-images
[Animation & Motion widgets]: /ui/widgets/animation
[Animations overview]: /ui/animations
[Animations tutorial]: /ui/animations/tutorial
[Apple's iOS design language]: {{site.apple-dev}}/design/resources
[`AppLifecycleState` documentation]: {{site.api}}/flutter/dart-ui/AppLifecycleState.html
[arb]: {{site.github}}/googlei18n/app-resource-bundle
[`AssetBundle`]: {{site.api}}/flutter/services/AssetBundle-class.html
[composing]: /resources/architectural-overview#composition
[Cupertino library]: {{site.api}}/flutter/cupertino/cupertino-library.html
[Cupertino widgets]: /ui/widgets/cupertino
[`devicePixelRatio`]: {{site.api}}/flutter/dart-ui/FlutterView/devicePixelRatio.html
[existing plugin]: {{site.pub}}/flutter
[Flutter concurrency for Swift developers]: /get-started/flutter-for/dart-swift-concurrency
[Flutter cookbook]: /cookbook
[`http` package]: {{site.pub-pkg}}/http
[Human Interface Guidelines]: {{site.apple-dev}}/ios/human-interface-guidelines/overview/themes/
[internationalization guide]: /ui/accessibility-and-internationalization/internationalization
[`intl`]: {{site.pub-pkg}}/intl
[`intl_translation`]: {{site.pub-pkg}}/intl_translation
[Introduction to declarative UI]: /get-started/flutter-for/declarative
[layout tutorial]: /ui/widgets/layout
[`Localizations`]: {{site.api}}/flutter/widgets/Localizations-class.html
[Material Components]: {{site.material}}/develop/flutter/
[Material Design guidelines]: {{site.material}}/styles/
[optimized for all platforms]: {{site.material2}}/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines
[Platform adaptations]: /platform-integration/platform-adaptations
[platform channel]: /platform-integration/platform-channels
[pub.dev]: {{site.pub}}/flutter/packages
[Retrieve the value of a text field]: /cookbook/forms/retrieve-input
[`TextEditingController`]: {{site.api}}/flutter/widgets/TextEditingController-class.html
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[widget]: /resources/architectural-overview#widgets
[widget catalog]: /ui/widgets/layout
[`Window.locale`]: {{site.api}}/flutter/dart-ui/Window/locale.html
[Learning Dart as a Swift Developer]: {{site.dart-site}}/guides/language/coming-from/swift-to-dart
