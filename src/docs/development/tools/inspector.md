---
title: Widget inspector
description: A brief overview of Flutter's widget inspector.
---

The Flutter widget inspector is powerful tool for visualizing and exploring
Flutter widget trees.

The Flutter framework uses widgets as [the core building
block](/docs/development/ui/widgets-intro) for anything from controls (text,
buttons, toggles, etc.) to layout (centering, padding, rows, columns, etc.).
The inspector is powerful tool for visualizing and exploring Flutter
these widget trees. It can be helpful when:

* Understanding existing layouts
* Diagnosing layout issues

![IntelliJ Flutter inspector window]({% asset tools/android-studio/visual-debugging.png @path %})

## Getting started with the inspector

The inspector is currently available in [the Flutter
plugin](/docs/get-started/editor) for Android Studio, or IntelliJ IDEA.

To start click "Select widget" on the Flutter inspector toolbar, and then click
on the device to select a widget. The selected widget is then highlighted
on the device and in the widget tree.

![Select Demo]({% asset tools/android-studio/inspector_select_example.gif @path %})

You can then browse around the interactive widget tree in the IDE to view
nearby widgets and see their field values. If you are trying to debug a layout
issue, then the Widget layer’s tree may be insufficiently detailed. In that
case, click the Render Tree tab to view the render tree corresponding to the
same location in the tree. When debugging layout issues, the key fields to look
at are the `size` and `constraints` fields. The constraints flow down the tree,
and the sizes flow back up.

![Switch Trees]({% asset tools/android-studio/switch_inspector_tree.gif @path %})

For a more complete demonstration of the inspector, see the
[DartConf 2018 talk](https://www.youtube.com/watch?v=JIcmJNT9DNI).

## Feedback

If you have suggestions, or encounter issues, please
[file an issue in our tracker](https://github.com/flutter/flutter-intellij/issues/new?labels=inspector)!
