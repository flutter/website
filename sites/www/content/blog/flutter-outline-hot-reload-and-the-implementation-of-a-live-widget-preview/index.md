---
title: "Flutter Outline, Hot Reload, and the implementation of a live widget preview"
description: "In M22 of the Flutter plugin for IntelliJ we added a new tool window — the Flutter Outline view. It shows you the structure of your Dart…"
publishDate: 2018-04-04
author: scheglov
image: images/0TUzb7DjU9HweZAAI.webp
category: engineering
layout: blog
---

In M22 of the Flutter plugin for IntelliJ we added a new tool window — the Flutter Outline view. It shows you the structure of your Dart files — the classes, fields, and methods — just like the standard IntelliJ Structure tool window. But when the selected file contains Flutter UI code, it also shows the widget hierarchy — the association between parent and child widgets:

<DashImage figure src="images/0TUzb7DjU9HweZAAI.webp" />

## What’s new?

Now with M23, we’ve introduced a new experimental feature — a live, in-IntelliJ rendering of the widget under development. This can be enabled from the Flutter preferences page in IntelliJ:

<DashImage figure src="images/0NeOjBxMN6kT43xJ7.webp" />

In order for this to work for a widget, the widget class must define a forDesignTime() constructor. The reason for this is that widgets are usually created with context specific constructor parameters. When rendering the preview of the widget, we don’t necessarily know the right values for these parameters. So, we let the user provide them for us via this specially named constructor.

We’ve had several comments that Flutter UI code can be quite long and it can be difficult to construct a mental model and navigate while coding. We realized that a visual presentation and two-way synchronization between the code and its visual presentation could help to solve both problems.

The code for a previewable widget might then look like this:

```dart
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String firstText;

  MyWidget(this.firstText);

  factory MyWidget.forDesignTime() {
    return new MyWidget('AA');
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        buildText(firstText),
        buildText('BBBB'),
        buildText('CCCCCC'),
        buildText('DDDDDDDD'),
      ],
    );
  }

  Text buildText(String text) {
    return new Text(text, style: const TextStyle(fontSize: 24.0));
  }
}
```

and its preview would look something like this:

<DashImage figure src="images/1Zut6fVhPFiAPFp2Uq24H6Q.webp" />

When trying this out, you’ll note that the preview area will show you the layout of any number of different kinds of widgets (constructible using a forDesignTime() constructor), and will update automatically as you type.

## How does it work?

The live preview view ties together technology from hot reload, Flutter’s headless testing binary, and Dart’s analysis server, with an implementation in IntelliJ.

### On file edits

When you open a Dart file in IntelliJ, the Flutter plugin subscribes to Flutter Outline events from the Dart Analysis Server. Every time a file changes, a new ‘Flutter Outline’ event is sent to IntelliJ with structured information about the contents of a file. This information includes classes, methods, fields, as well as information about the Flutter widgets created in the file. Flutter items are created for every instantiation of a Widget subclass and any reference to a Widget typed variable or a method invocation.

In order to map runtime widget instances back to the locations in source where they were created, we re-write the user’s source code to assign a unique ID to each created widget. You can see the instrumented code here:

```dart
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String firstText;

  MyWidget(this.firstText);

  factory MyWidget.forDesignTime() {
    return _registerWidgetInstance(0, new MyWidget('AA'));
  }

  @override
  Widget build(BuildContext context) {
    return _registerWidgetInstance(1, new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _registerWidgetInstance(2, buildText(firstText)),
        _registerWidgetInstance(3, buildText('BBBB')),
        _registerWidgetInstance(4, buildText('CCCCCC')),
        _registerWidgetInstance(5, buildText('DDDDDDDD')),
      ],
    ));
  }

  Text buildText(String text) {
    return _registerWidgetInstance(6, new Text(text, style: const TextStyle(fontSize: 24.0)));
  }
}
final flutterDesignerWidgets = <int, Widget>{};

T _registerWidgetInstance<T extends Widget>(int id, T widget) {
  flutterDesignerWidgets[id] = widget;
  return widget;
}
```

This instrumented code also comes back as part of the analysis server’s response.

### Populating the outline view

This information is used to populate the tree portion of the outline view. As the user changes selection in the file, we request a re-rendering of the widget preview using the currently selected widget.

### Starting the rendering server

We use a standard Flutter tool, which allows headless execution of Flutter code — the flutter_tester binary. You can think about it as part of Dart VM with the dart:ui library and [Skia](https://skia.org/) bindings, just like on a mobile device, but on your desktop. We write two files into a temporary directory — the instrumented code itself, and the [rendering server](https://github.com/flutter/flutter-intellij/blob/master/src/io/flutter/preview/render_server_template.txt). The rendering server listens on stdin for the render command, instantiates the widget to render, puts it into a MaterialApp, grabs positioning information for each widget, and returns JSON information back to the client, with the bounds information mapped to corresponding widget identifiers.

### Hot reloading the instrumented code

But running a new flutter_tester instance for each cycle would be too slow — it takes about 1000 ms for the Dart VM to start and the JIT to run. So, instead of running a new process each time, we use yet another amazing feature of Flutter and Dart — hot reload. We update the rendering server file to use the new preview area size, the new widget class name to instantiate, and of course write newly instrumented code into the file to render. Then we ask the Dart VM to hot reload the entry point (the rendering server in our case), and it picks up all changes. The whole process takes only about 100 ms, which is 10 times faster than the initial, cold, rendering.

This works well when you switch between files of the same package, because the set of packages stays the same (and we run flutter_tester with this set). But when you switch to a file in another package, we restart the process. We also terminate the process if rendering does not happen fast enough — currently a cutoff of 2000 ms. So, if there is a compilation or a runtime error, once you fix it, eventually the rendering server process will succeed and you will see rendering.

### Painting in IntelliJ

Once the Flutter plugin for IntelliJ gets the outline and corresponding set of bounds for each widget, it paints the widget layout in the preview area using standard Swing components. This preview lets you select a widget outline and see the corresponding entry in the tree view and in the source code.

## Kicking the tires

So, go to the preferences panel, turn on live preview, and let us know what you think! We hope it helps you edit and understand your Flutter code and UIs.
