---
title: "Handling Web Gestures in Flutter"
description: "Flutter has released web support that allows you to create dynamic websites. With Flutter web, MacOS, Linux, and Windows operating systems…"
publishDate: 2020-09-21
author: JoseAlba
image: images/1BzcKF4qdbLIFFB6XL8x-9A.png
category: announcements
layout: blog
---

## Handling web gestures in Flutter

<DashImage figure src="images/1BzcKF4qdbLIFFB6XL8x-9A.png" />


Flutter has released web support that allows you to create dynamic websites. With Flutter web, MacOS, Linux, and Windows operating systems (even on mobile devices connected to a mouse, keyboard, or other peripherals), you now have access to platform-specific behaviors including focus support, keyboard input, custom mouse cursors, and hover input. But, how do you make use of these platform behaviors in Flutter?

This article explains how to use the `FocusableActionDetector` widget, which handles keyboard input, focus input, hover input, and custom mouse cursors.

## How to use the Focusable Action Detector widget

The Focusable Action Detector widget allows you to handles several web-specific actions, including:

1. Keyboard input

1. Focus input

1. Hover input

1. Custom mouse cursors

See the `FocusableActionDetector` in action in the [DartPad #1](https://dartpad.dev/d16345202d0e26d40fe14904657dc24a) example.
> **Note**: This article uses two DartPad examples, though there are multiple links to each. [DartPad #1](https://dartpad.dev/d16345202d0e26d40fe14904657dc24a) shows the `FocusableActionDetector` sample, and [DartPad #2](https://dartpad.dev/5544c57e20454fe212e3ec5cf10b1f0a) demonstrates hover and focus support for `FocusableActionDetector`.

## Keyboard input

Flutter lets you define custom actions to handle keyboard input. Let’s say you want to have a hidden menu or your application has to handle a lot of custom keyboard input. This is easy to achieve with the `FocusableActionDetector` widget.

First, add the following import:

`import ‘package:flutter/services.dart’;`

Next, from the class where the `FocusableActionDetector` is called, initialize two private variables. These variables map the keyboard input to the desired action:

```
Map<LogicalKeySet, Intent> _shortcutMap;

Map<Type, Action<Intent>> _actionMap;
```


Define a `FocusableActionDetector` widget. Note that the custom keyboard input activates only when the child widget is in focus:

```
FocusableActionDetector(

  actions: _actionMap,

  shortcuts: _shortcutMap,

  child:

)
```


This class maps the enums and keyboard input type to the `Intent` class. The following setup is necessary because the actions and shortcuts parameter requires a class that extends `Intent`:

```
class _ShowSecretMessageIntent extends Intent {

  const _ShowSecretMessageIntent({@required this.type});

  const _ShowSecretMessageIntent.P() : type = _SecretMessageType.P;

  const _ShowSecretMessageIntent.L() : type = _SecretMessageType.L;

  const _ShowSecretMessageIntent.A() : type = _SecretMessageType.A;

  const _ShowSecretMessageIntent.T() : type = _SecretMessageType.T;

  const _ShowSecretMessageIntent.F() : type = _SecretMessageType.F;

  const _ShowSecretMessageIntent.O() : type = _SecretMessageType.O;

  const _ShowSecretMessageIntent.R() : type = _SecretMessageType.R;

  const _ShowSecretMessageIntent.M() : type = _SecretMessageType.M;

  final _SecretMessageType type;

}

enum _SecretMessageType {

  P,

  L,

  A,

  T,

  F,

  O,

  R,

  M,

}
```


Within the `initState` method, initialize the mapping previously defined:

```
void initState() {

  _shortcutMap = <LogicalKeySet, Intent>{

    LogicalKeySet(LogicalKeyboardKey.keyP):

      const _ShowSecretMessageIntent.P(),

    LogicalKeySet(LogicalKeyboardKey.keyL):

      const _ShowSecretMessageIntent.L(),

    LogicalKeySet(LogicalKeyboardKey.keyA):

      const _ShowSecretMessageIntent.A(),

    LogicalKeySet(LogicalKeyboardKey.keyT):

      const _ShowSecretMessageIntent.T(),

    LogicalKeySet(LogicalKeyboardKey.keyF):

      const _ShowSecretMessageIntent.F(),

    LogicalKeySet(LogicalKeyboardKey.keyO):

      const _ShowSecretMessageIntent.O(),

    LogicalKeySet(LogicalKeyboardKey.keyR):

      const _ShowSecretMessageIntent.R(),

    LogicalKeySet(LogicalKeyboardKey.keyM):

      const _ShowSecretMessageIntent.M(),

    };

  _actionMap = <Type, Action<Intent>>{

    _ShowSecretMessageIntent: CallbackAction<_ShowSecretMessageIntent>(

      onInvoke: _actionHandler,

    ),

  };

}
```


The action handler links the keyboard input to a certain function within the application. Any time a character is pressed, an expanded container is added to the main part of the application. But in your application, you can use it for more creative purposes:

```
void _actionHandler(_ShowSecretMessageIntent intent) {

  switch (intent.type) {

    case _SecretMessageType.P:

      setState(() {

        children.add(

          Expanded(

            child: Container(

              color: Colors.orange,

              child: Text(‘Press L’),

            ),

          ),

        );

      });

    break;

    …

  }

}
```


## Focus input

The `FocusableActionDetector` widget lets you perform action calls any time the specified widget is in focus.

The focus tree allows you to navigate through your application using the tab key. This allows people with visual impairment to navigate through your website.

The `FocusableActionDetector` child widget is selected as the initial focus when no other node in its scope is currently focused. It’s important to set the `autofocus` parameter variable to `true` if you want your custom keyboard input to work regardless of whether your child widget has focus or not. This is because, by default, this `FocusableActionDetector` widget won’t be in focus, hence you won’t be able to use custom keyboard inputs:

```
FocusableActionDetector(

  autofocus: true,

  child : …

),
```


Let’s say you want your child widget to have a different color when focused to identify that this widget is currently in focus. If you need to set custom actions whenever your widget has focus, use the `onShowFocusHighlight` property.

The [DartPad #2](https://dartpad.dev/5544c57e20454fe212e3ec5cf10b1f0a) example shows how to use the `onShowFocusHighlight` property.

Focus is an advanced topic. Learn more about focus by reading the API docs for the [`Focus`](https://api.flutter.dev/flutter/widgets/Focus-class.html) class

## Hover input

The `FocusableActionDetector` widget lets you handle hover input. That way, anytime a cursor hovers over a certain widget, custom actions can happen. Similar to the `onShowFocusHighlight` property, the `onShowHoverHighlight` property lets you create custom actions anytime the mouse cursor hovers over a certain widget.

Check out the [DartPad #2](https://dartpad.dev/5544c57e20454fe212e3ec5cf10b1f0a) example, which demonstrates how to implement custom hover and focus action.

In the [DartPad #2](https://dartpad.dev/5544c57e20454fe212e3ec5cf10b1f0a) example, anytime the mouse hovers over the widget it changes the color of the widget. If you are navigating the application using tab, then you’ll notice that the widget in focus applies a different shade to the widget compared to the widget that is currently being hovered over.

This means you can have different custom actions anytime the widget is in focus or a mouse cursor hovers over that widget. You can tell this if you hover and focus over on the same widget. That widget is applying two shades at the same time to that widget. For more information, see the API docs for the [`FocusableActionDetector`](https://api.flutter.dev/flutter/widgets/FocusableActionDetector-class.html) class.

## Custom mouse cursors

The `FocusableActionDetector` widget lets you implement custom mouse cursors. For example, if you want your users to know that a widget is draggable, changing the mouse cursor is a good indicator that you can do this. The `FocusableActionDetector` widget has a `mouseCursor` parameter.

`mouseCursor: SystemMouseCursors.grabbing`

The [DartPad #1](https://dartpad.dev/d16345202d0e26d40fe14904657dc24a) example demonstrates the different types of mouse cursors within Flutter. Click any of the icons in the app bar to try. There are nine different system default mouse cursors:

1. `SystemMouseCursors.basic`

1. `SystemMouseCursors.text`

1. `SystemMouseCursors.click`

1. `SystemMouseCursors.forbidden`

1. `SystemMouseCursors.grab`

1. `SystemMouseCursors.grabbing`

1. `SystemMouseCursors.horizontalDoubleArrow` (not in stable)

1. `SystemMouseCursors.verticalDoubleArrow` (not in stable)

1. `SystemMouseCursors.none`

## Closing remarks

In Flutter you have access to web-specific APIs. The `FocusableActionDetector` widget lets you handle web-specific functions in Flutter. To learn more about Flutter web, see the Medium post, [Handling 404: Page not found error in Flutter](https://medium.com/flutter/handling-404-page-not-found-error-in-flutter-731f5a9fba29).

*About the author: Jose recently graduated from university and now works on [Material](https://material.io/), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html). To learn more, visit his Jose’s pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*