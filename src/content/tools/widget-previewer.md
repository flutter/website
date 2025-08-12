---
title: Flutter Widget Previewer
description: >-
  Learn how to use the Flutter Widget Previewer to see your
  widgets render in real-time, separate from your full app.
---

In this guide, you will learn how to use the
Flutter Widget Previewer.

## Overview

With the Flutter Widget Previewer, you can see your widgets
render in real-time, separate from a full app, in the
Chrome browser. To start the previewer, show a widget
in it, and customize a preview, see the following sections.

:::version-note
The Flutter Widget Preview requires Flutter version 3.35 or
higher.

Please be aware that this is an **experimental feature**
available in the Flutter stable channel. The APIs are not
stable and *will change*. This guide is for the current
early access version, and you should expect future updates
to introduce breaking changes.
:::

## Start the previewer

To start the Flutter Widget Previewer, navigate to your
Flutter project's root directory and run the following
command in your terminal. This will launch a local server
and open a Widget Preview environment in Chrome that
automatically updates based on changes to your project.

```shell
flutter widget-preview start
```

## Preview a widget

After you've started the previewer, to look at a widget,
you must use the [`@Preview`][] annotation defined in
`package:flutter/widget_previews.dart`. This annotation
can be applied to:

*   **Top-level functions** that return a `Widget` or
    `WidgetBuilder`.  
*   **Static methods** within a class that return a `Widget` or
    `WidgetBuilder`.  
*   **Public Widget constructors and factories** with no
    required arguments.

Here is a basic example of how to use the
`@Preview` annotation to preview a `Text` widget:

```dart
import 'package:flutter/widget_previews.dart';
import 'package:flutter/material.dart'; // For Material widgets

@Preview(name: 'My Sample Text')
Widget mySampleText() {
  return const Text('Hello, World!');
}
```

![Sample widget in Flutter Widget Previewer](/assets/images/docs/tools/widget-previewer/widget-previewer.png "Example widget"){:width="50%"}

Each preview instance provides various controls for
interacting with the previewed widget. From left to right:

*   **Zoom in:** Magnifies the widget in the preview.

*   **Zoom out:** Reduces the magnification of the widget in
    the preview.

*   **Reset zoom:** Returns the widget preview to its
    default zoom level.

*   **Toggle between light and dark mode:** Switches the
    preview's theme between a light and dark color scheme.

*   **Perform a hot restart for the individual preview:**
    Restarts only the specific widget preview,
    allowing changes to be applied quickly without
    restarting the entire application.

For the case where global state has been modified
(for example, a static initializer has been changed), the
entire widget previewer can be told to hot restart using the
button at the top right of the environment.

## Customize a preview

The [`@Preview`][] annotation has several parameters you can
use to customize the preview:

*   **`name`**: A descriptive name for the preview.

*   **`size`**: Artificial size constraints using a
    `Size` object.
  
*   **`textScaleFactor`**: A custom font scale.

*   **`wrapper`**: A function that wraps your previewed
    widget in a specific widget tree (for example, to inject
    application state into the widget tree with a
    `InheritedWidget`).
  
*   **`theme`**: A function to provide Material and
    Cupertino theming data.
  
*   **`brightness`**: The initial theme brightness.

*   **`localizations`**: A function to apply a localization
    configuration.

[`@Preview`]: {{site.api}}/flutter/widgets/Preview-class.html

## Restrictions and limitations

The Flutter Widget Previewer has certain restrictions you
should be aware of:

*   **Public constants**: All arguments provided to the
    `@Preview` annotation must be public and constant.
    This is required for the previewer's code generation
    implementation to work correctly. The requirement for
    public variable names will be relaxed in future
    releases, but function arguments must always have
    public names.  

*   **Unsupported APIs**: Native plugins and any APIs from
    the `dart:io` library are not supported. This is because
    the widget previewer is built with
    Flutter Web, which doesn't have access to the underlying
    native platform APIs. While web plugins may work when
    using Chrome, there is no guarantee that they will work
    within other environments, such as when embedded in
    IDEs.  

*   **Asset paths**: When using `fromAsset` APIs from
    `dart:ui` to load resources, you must use
    **package-based paths** instead of direct local paths.
    This ensures that the assets can be correctly located
    and loaded within the previewer's web environment. For
    example, use `'packages/my_package_name/assets/my_image.png'`
    instead of `'assets/my_image.png'`.  

*   **Browser support**: At this time, the previewer is only
    supported on Chrome as it requires hot reload
    support. Web server and IDE support for this feature is
    planned for a future release.  

*   **Unconstrained widgets**: Unconstrained widgets are
    automatically constrained to approximately half the
    height and width of the widget previewer. This behavior
    is likely to change in the future, so constraints should
    be applied using the `size` parameter when possible.
