---
title: Understanding Flutter's keyboard focus system
description: How to use the focus system in your Flutter app.
---

This article explains how to direct keyboard input.
If your app uses a physical keyboard, like desktop and web apps,
keep reading. If your app won't use a physical keyboard,
you can skip this guide.

## Overview

Flutter includes a focus system that directs keyboard input
to a particular part of an app.
To "focus" the input to part of an app, app users can take action
depending on their input method.

* To change focus on touch interfaces,
  app users tap or click on the desired UI element.

* To change focus on traditional interfaces,
  app users can use the mouse to click on the desired UI element
  or press a keyboard shortcut to move focus.

Once in focus, text entered with the keyboard flows to that element.
Text input could control objects or display text in a text field.
This continues until the focus moves to another element in the app.

:::secondary What you'll learn

* How the focus system works
* When to use the focus system
* How to give focus to, and remove focus from, a control
* How to find which widget has focus
* How to set focus scope
* How to set focus order
:::

Some developers have expressed confusion about how to define and
use [`FocusNode`][] objects.
If that describes your experience, skip to
[Follow focus best practices](#follow-focus-best-practices).

## Glossary

The following terms describe elements of the Flutter focus system.
The various classes that implement some of these concepts
are listed after this section.

**Focus tree**
  : A sparse mirror of the widget tree that represents all the widgets
    that can receive focus. The nodes in this tree are called _focus nodes_.

**Focus node**
  : A single node in a focus tree.
  This type of node can receive focus when it's part of the _focus chain_.
  When it has focus, it participates in handling key events.

**Primary focus**
  : A focus node that has focus where key events start propagating to
  the primary focus node and its ancestors.
  This focus node exists at the farthest point from the root of the focus tree.

**Focus chain**
  : A list of focus nodes ordered from the primary focus node to the root
  of the focus tree.
  Starting at the primary focus node, it follows the focus tree branches
  to its root. All of the nodes in the _focus chain_ are assumed to have focus.
  Key events start at the first node in the chain, called the _primary focus_,
  and propagate along the chain until a node handles the event.

**Focus scope**
  : A special focus node that contains a group of other focus nodes.
  It limits focus traversal to those nodes.
  It maintains data about which nodes have received focus
  in its subtree in the past.

**Focus traversal**
  : The process of moving focus from one focusable node to another
  in a predictable, controllable, order.
  In common app UX, when a user presses <kbd>Tab</kbd>, focus moves
  to the next focusable control or field.
  This is why this method is also known as _tab traversal_

## Focus use cases

Some situations where you might use the focus system include:

* [Receiving/handling key events](#listen-for-key-events)
* [Implementing a custom component that needs to be focusable](#control-what-gets-focus)
* [Receiving notifications when the focus changes](#get-notifications-of-focus-changes)
* [Changing or defining the "tab order" of focus traversal in an app](#set-a-focus-traversal-policy)
* [Defining groups of controls that should be traversed together](#limit-focus-traversal-to-a-group)
* [Preventing some controls in an app from being focusable](#control-what-gets-focus)

## Implement the focus system in your app

The `FocusNode` and [`FocusScopeNode`][] objects implement the mechanics
of the focus system.
Like render objects, these objects live longer than widgets and
hold the focus state and attributes.
This allows focus nodes to persist between builds of the widget tree.
Together, these objects form the focus tree data structure.

The original intent was for these widgets to control some focus system aspects.
They would've been developer-facing objects.
Over time, they evolved to implement details of the focus system.
To prevent breaking existing apps,
they still contain public interfaces for their attributes.

These widgets act as a somewhat opaque handle.
To focus a descendant widget,
an ancestor widget can use this handle to call the `requestFocus()` method.
The ancestor widget can also request that Flutter give focus
to a descendant widget.
If setting other attributes like `onKey` or `skipTraversal`,
use the [`Focus.withExternalFocusNode`][] or
[`FocusScope.withExternalFocusNode`][] constructors
This avoids an accidental reset of the attributes.

### Follow focus best practices

Some dos and don'ts around using these objects include:

**Do create `FocusNode` and `FocusScopeNode` objects in a stateful widget.**
: When you finish using `FocusNode` and `FocusScopeNode`,
  you need to dispose of them.
  For this reason, only create them inside of a stateful widget's `State` object.
  You can override the stateful widget's `dispose` method to dispose of the
  focus objects.

**Do set the `debugLabel` of a focus node widget.**
: This helps with diagnosing focus issues.

**Do call the `requestFocus()` method on a node to request the primary focus.**
: Call this method from an ancestor that has passed a node
  it owns to a descendant where you want to the focus.

**Do use `focusNode.requestFocus()`.**
: You don't need to call FocusScope.of(context).requestFocus(focusNode)`.
  The `focusNode.requestFocus()` method works the same with better performance.

**Don't allocate a new `FocusNode` object for each build.**
: This can cause memory leaks.
  It might also cause a loss of focus when the widget rebuilds while
  the node has focus.

**Don't use the same `FocusNode` for multiple widgets.**
: If you do, the widgets fight over managing the attributes of the node.
  That might result in an unexpected outcome.

**Don't set the `onKeyEvent` callback on a `FocusNode` that `Focus` manages.**
: To set focus to respond to a key event, use an `onKeyEvent` handler.
  Surround the desired widget subtree with a new `Focus` widget
  with its `onKeyEvent` attribute set to your handler.
  If you don't want the widget to be able to take primary focus,
  set `canRequestFocus: false` on it.
  Do this because the `onKeyEvent` attribute on the `Focus` widget
  can be set to something else in a later build. If that happens,
  the attribute overwrites the `onKeyEvent` handler you set on the node.
  This applies to a `FocusScopeNode` that a `FocusScope` widget manages.

### Tell a node to give up focus

The `FocusNode.unfocus()` API tells a node to "give up the focus".
While it does remove focus from the node,
note that you can't "unfocus" all nodes.
If you remove focus from a node, it must pass the focus somewhere else,
since there is _always_ a primary focus. When a node calls `unfocus()`,
focus can pass to one of two nodes.
It can pass to either the nearest `FocusScopeNode`
or a node in the same scope that had focus earlier.
Which one depends upon the `disposition` argument you give to `unfocus()`.
To better control where the focus passes when you remove it from a node,
you have two options.
You can choose to set focus to another node or use the focus traversal mechanism.
To find another node, this mechanism can use the `focusInDirection`,
`nextFocus`, or `previousFocus` methods on `FocusNode`.

When calling `unfocus()`, you can set the `disposition` argument. 
It allows two modes for passing focus:

- [`UnfocusDisposition.scope`][]:
  The argument defaults to this option.
  It gives the focus to the nearest parent focus scope.
  If the something moves the focus to the next node with `FocusNode.nextFocus`,
  the app starts with the "first" focusable item in the scope.

- `UnfocusDisposition.previouslyFocusedChild`:
  The `previouslyFocusedChild` disposition searches the scope to find the
  last focused child and request focus on it.
  If no child had focus before, this disposition works like `scope`.

:::important
Without another scope, focus moves to the root scope node of the focus system,
`FocusManager.rootScope`.
This wouldn't be a desired result,
because it stops focus traversal from working.
The root scope doesn't have a `context` for the framework to determine which
node should be focused next.
If you find that your app can't navigate using focus traversal,
this change in focus is the probable reason.
To fix it, add a `FocusScope` as an ancestor to the focus node
requesting the unfocus.
The `WidgetsApp` has its own `FocusScope`.
As `MaterialApp` and `CupertinoApp` derive from `WidgetsApp`,
this would cause an issue in apps in very limited edge cases.
These cases would be limited to apps that don't start with
any of these specific widgets and don't have their own `FocusScope`.
:::

## Allow a control to receive focus

The `Focus` widget owns and manages a focus node.
It performs the following functions as the workhorse of the focus system:

- Attaches and detaches the focus node it owns from the focus tree
- Manages the attributes and callbacks of the focus node
- Enables discovery of focus nodes attached to the widget
  tree through its static functions

To allow a widget subtree to obtain focus, wrap the `Focus` widget around it.
This works during the focus traversal process or when a passed
`FocusNode` calls `requestFocus`.
Combined with a gesture detector calling `requestFocus`,
it can receive focus when tapped or clicked.

If you don't create a `FocusNode` object for the `Focus` widget to manage,
it creates its own.
To allow focus control from a parent widget, create your own`FocusNode`.
To control its focus, this object can then call `requestFocus()` on the node.
To access the functionality of a `FocusNode`,
change the attributes of the `Focus` widget itself.

To implement Flutter's own focus functionality,
its controls use the `Focus` widget.

Consider the following example.
It shows how to use the `Focus` widget to make a custom control focusable.
It creates a container with text that reacts to receiving the focus.

<?code-excerpt "ui/advanced/focus/lib/custom_control_example.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Focus Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[MyCustomWidget(), MyCustomWidget()],
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  Color _color = Colors.white;
  String _label = 'Unfocused';

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _color = focused ? Colors.black26 : Colors.white;
          _label = focused ? 'Focused' : 'Unfocused';
        });
      },
      child: Center(
        child: Container(
          width: 300,
          height: 50,
          alignment: Alignment.center,
          color: _color,
          child: Text(_label),
        ),
      ),
    );
  }
}
```

### Listen for key events

To listen for key events in a subtree, set `Focus.onKeyEvent` to a handler.
This handler should either listen to the key, or handle the key
and stop its propagation to other widgets.

Key events start at the focus node that has primary focus.
If that node doesn't return `KeyEventResult.handled` from
its `onKeyEvent` handler, then its parent focus node is given the event.
If the parent doesn't handle it, it goes to its parent,
and so on, until it reaches the root of the focus tree.
If the event reaches the root of the focus tree without being handled, then
it is returned to the platform to give to
the next native control in the app
(in case the Flutter UI is part of a larger native app UI).
Events that are handled are not propagated to other Flutter widgets,
and they are also not propagated to native widgets.

Here's an example of a `Focus` widget that absorbs every key that
its subtree doesn't handle, without being able to be the primary focus:

<?code-excerpt "ui/advanced/focus/lib/samples.dart (absorb-keys)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    onKeyEvent: (node, event) => KeyEventResult.handled,
    canRequestFocus: false,
    child: child,
  );
}
```

Flutter processes focus key events before text entry events.
This prevents that key from being entered into the text field.

Consider the following example.
A widget won't allow the letter "a" to be typed into the text field:

<?code-excerpt "ui/advanced/focus/lib/samples.dart (no-letter-a)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    onKeyEvent: (node, event) {
      return (event.logicalKey == LogicalKeyboardKey.keyA)
          ? KeyEventResult.handled
          : KeyEventResult.ignored;
    },
    child: const TextField(),
  );
}
```

If the intent is input validation, this example's functionality would probably
be better implemented using a `TextInputFormatter`, but the technique can still
be useful: the `Shortcuts` widget uses this method to handle shortcuts before
they become text input, for instance.

### Control what gets focus

One of the main aspects of focus is controlling what can receive focus and how.
The attributes `canRequestFocus`, `skipTraversal,` and `descendantsAreFocusable`
control how this node and its descendants participate in the focus process.

If the `skipTraversal` attribute true, then this focus node doesn't participate
in focus traversal. It is still focusable if `requestFocus` is called on its
focus node, but is otherwise skipped when the focus traversal system is looking
for the next thing to focus on.

The `canRequestFocus` attribute, unsurprisingly, controls whether or not the
focus node that this `Focus` widget manages can be used to request focus. If
this attribute is false, then calling `requestFocus` on the node has no effect.
It also implies that this node is skipped for focus traversal, since it can't
request focus.

The `descendantsAreFocusable` attribute controls whether the descendants of this
node can receive focus, but still allows this node to receive focus. This
attribute can be used to turn off focusability for an entire widget subtree.
This is how the `ExcludeFocus` widget works: it's just a `Focus` widget with
this attribute set.

### Set autofocus

Setting the `autofocus` attribute of a `Focus` widget tells the widget to
request the focus the first time the focus scope it belongs to is focused. If
more than one widget has `autofocus` set, then it is arbitrary which one
receives the focus, so try to only set it on one widget per focus scope.

The `autofocus` attribute only takes effect if there isn't already a focus in
the scope that the node belongs to.

Setting the `autofocus` attribute on two nodes that belong to different focus
scopes is well defined: each one becomes the focused widget when their
corresponding scopes are focused.

### Get notifications of focus changes

The `Focus.onFocusChanged` callback can be used to get notifications that the
focus state for a particular node has changed. It notifies if the node is added
to or removed from the focus chain, which means it gets notifications even if it
isn't the primary focus. If you only want to know if you have received the
primary focus, check and see if `hasPrimaryFocus` is true on the focus node.

### Obtain which node has focus

To interrogate the attributes of a FocusNode,
you need to first obtain the focus node of a `Focus` widget.

To access the focus node from an ancestor of the `Focus` widget,
create and pass in a `FocusNode` as the `Focus` widget's `focusNode` attribute.
As you dispose of this `FocusNode` afterward,
a stateful widget must own the focus node you pass.

To access the focus node from the descendant of a `Focus` widget,
call `Focus.of(context)`. This obtains the focus node of the nearest
`Focus` widget to the given context.
To obtain the `FocusNode` of a `Focus` widget within the same build function,
use a [`Builder`][] to verify you have the correct context.
The following example shows how this would work.

<?code-excerpt "ui/advanced/focus/lib/samples.dart (builder)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    child: Builder(
      builder: (context) {
        final bool hasPrimary = Focus.of(context).hasPrimaryFocus;
        print('Building with primary focus: $hasPrimary');
        return const SizedBox(width: 100, height: 100);
      },
    ),
  );
}
```

### Changes to focus happen after current build phase

One of the details of the focus system is that when focus is requested,
it only takes effect after the current build phase completes.
This means that focus changes are always delayed by one frame,
because changing focus can cause arbitrary parts of the widget tree to rebuild,
including ancestors of the widget currently requesting focus.
Because descendants cannot dirty their ancestors,
it has to happen between frames,
so that any needed changes can happen on the next frame.

## Group focus nodes

A special version of the `Focus` widget,
the `FocusScope` widget manages a `FocusScopeNode` instead of a `FocusNode`.
The `FocusScopeNode` groups the focus nodes into a subtree.
Unless a node outside of the scope receives focus,
focus traversal stays within a focus scope.

The focus scope also keeps track of the current focus and history of the nodes
focused within its subtree. That way, if a node releases focus or is removed
when it had focus, the focus can be returned to the node that had focus
previously.

Focus scopes also serve as a place to return focus to if none of the descendants
have focus. This allows the focus traversal code to have a starting context for
finding the next (or first) focusable control to move to.

If you focus a focus scope node, it first attempts to focus the current, or most
recently focused node in its subtree, or the node in its subtree that requested
autofocus (if any). If there is no such node, it receives the focus itself.

## Detect focusable actions

The [`FocusableActionDetector`][] widget combines the functionality of
[`Actions`][], [`Shortcuts`][], and [`MouseRegion`][] with a `Focus` widget.
This widgets creates a detector that defines actions and key bindings,
and provides callbacks that handle focus and hover highlights.
Flutter controls use this to implement all of these aspects of the controls.
Flutter implements this widget using the constituent widgets.
If you don't need all of its functionality, use only the widgets you need.
This widget provides a convenient way to build these behaviors into
your custom controls.

:::note
To learn more, check out this short Widget of the Week video on
the `FocusableActionDetector` widget:

<iframe class="full-width" src="{{site.yt.embed}}/R84AGg0lKs8" title="Learn about the FocusableActionDetector Flutter Widget" {{site.yt.set}}></iframe>
:::

## Control focus traversal

Once an app can set focus, you might want to allow the app user to control
the focus using the keyboard or another input device.
The most common example of focus control would be "tab traversal".
To go to the "next" control, the user presses <kbd>Tab</kbd>.
This section explains how to define what "next" means.
By default, Flutter provides tab traversal.

A simple grid layout simplifies deciding the next control.
If you're not at the end of the row,
"next" would be to the right of the current control
(or left for right-to-left directionality).
When you reach the end of a row,
"next" would be the first control in the next row.
Apps don't often use a grid layout, so focus traversal requires more guidance.

Flutter's default algorithm for focus traversal
([`ReadingOrderTraversalPolicy`][]) often provides the right answer for most apps.
Exceptions exist: cases where the context or design requires a different order
than what the default ordering algorithm calculates.
For those cases, you can use other methods to achieve your desired order.

### Limit focus traversal to a group

Your app might need to confine traversal to one group of widgets
before moving on to another widget or group of widgets.
To set this constrant, place the [`FocusTraversalGroup`][] widget
around the necessary widget subtrees in the focus tree.
To resolve many tab traversal ordering problems,
you might only need to arrange widgets into related groups.
If grouping alone doesn't resolve your problem,
add a [`FocusTraversalPolicy`][] to the widget group
to set the ordering within the group.

While the default [`ReadingOrderTraversalPolicy`][] works in most cases,
use an [`OrderedTraversalPolicy`][] for greater control of focus order.
When wrapped around the focusable components, the `order` argument of the
[`FocusTraversalOrder` widget constructor][FocusTraversalOrder-constructor]
 determines the order. The order can be any subclass of [`FocusOrder`][], but
[`NumericFocusOrder`][] and [`LexicalFocusOrder`][] are provided.

If none of the provided focus traversal policies work for your app,
write your own policy. You can then use that policy to determine any
custom ordering.

Consider this example of how to to traverse a row of buttons in the
order TWO, ONE, THREE.
This example uses the `FocusTraversalOrder` widget with the `order`
set to `NumericFocusOrder`.

<?code-excerpt "ui/advanced/focus/lib/samples.dart (ordered-button-row)"?>
```dart
class OrderedButtonRow extends StatelessWidget {
  const OrderedButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Row(
        children: <Widget>[
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(2),
            child: TextButton(
              child: const Text('ONE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(1),
            child: TextButton(
              child: const Text('TWO'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(3),
            child: TextButton(
              child: const Text('THREE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
```

### Set a focus traversal policy

When given a request and the current focus node,
the `FocusTraversalPolicy` object determines the next widget.
The requests (member functions) can include `findFirstFocus`,
`findLastFocus`, `next`, `previous`, and `inDirection`.

`FocusTraversalPolicy` abstracts concrete policies like
`ReadingOrderTraversalPolicy`, `OrderedTraversalPolicy` and the
[`DirectionalFocusTraversalPolicyMixin`][] classes.

To use a `FocusTraversalPolicy`, give one to a `FocusTraversalGroup`,
It determines the widget subtree in which the policy will be effective.
Avoid calling the member functions of the class directly.
The focus system should use these functions.

## Manage focus

The [`FocusManager`][] maintains the current primary focus for the system.
Users of the focus system might only use three properties of this API.

**`FocusManager.instance.primaryFocus` property**
: This contains the current focus node with focus.
  It can be accessed from the global `primaryFocus` field.

**`FocusManager.instance.highlightStrategy` property**
: Widgets that change between touch and mouse and keyboard input
  need this property. This property tells `FocusManager` how to
  interpret changes to app user device input.
  The `highlightStrategy` property allows one of three values:

  - `automatic` (default):
    Switch focus highlighting based on the most recent input events
  - `alwaysTouch`:
    Lock to touch focus highlighting
  - `alwaysTraditional`:
    Lock to traditional focus highlighting

**`FocusManager.instance.highlightMode` property**
: The `highlightStrategy` value determines the `highlightMode` value.

  - When an app user navigates with touch, Flutter hides the focus highlight.
  - When the app user switches to a mouse or keyboard,
    Flutter shows the focus highlight.

The provided focus widgets in Flutter know how to use these properties.
You only need this API if you're writing your own controls.

To listen for changes in the highlight mode,
use `addHighlightModeListener` callback.

[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`Builder`]: {{site.api}}/flutter/widgets/Builder-class.html
[`DirectionalFocusTraversalPolicyMixin`]: {{site.api}}/flutter/widgets/DirectionalFocusTraversalPolicyMixin-mixin.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`FocusableActionDetector`]: {{site.api}}/flutter/widgets/FocusableActionDetector-class.html
[`FocusManager`]: {{site.api}}/flutter/widgets/FocusManager-class.html
[`FocusNode`]: {{site.api}}/flutter/widgets/FocusNode-class.html
[`FocusOrder`]: {{site.api}}/flutter/widgets/FocusOrder-class.html
[`FocusScope`]: {{site.api}}/flutter/widgets/FocusScope-class.html
[`FocusScopeNode`]: {{site.api}}/flutter/widgets/FocusScopeNode-class.html
[`FocusTraversalGroup`]: {{site.api}}/flutter/widgets/FocusTraversalGroup-class.html
[`FocusTraversalOrder`]: {{site.api}}/flutter/widgets/FocusTraversalOrder-class.html
[FocusTraversalOrder-constructor]: {{site.api}}/flutter/widgets/FocusTraversalOrder/FocusTraversalOrder.html
[`FocusTraversalPolicy`]: {{site.api}}/flutter/widgets/FocusTraversalPolicy-class.html
[`LexicalFocusOrder`]: {{site.api}}/flutter/widgets/LexicalFocusOrder-class.html
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`NumericFocusOrder`]: {{site.api}}/flutter/widgets/NumericFocusOrder-class.html
[`OrderedTraversalPolicy`]: {{site.api}}/flutter/widgets/OrderedTraversalPolicy-class.html
[`ReadingOrderTraversalPolicy`]: {{site.api}}/flutter/widgets/ReadingOrderTraversalPolicy-class.html
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html
[`UnfocusDisposition.scope`]: {{site.api}}/flutter/widgets/UnfocusDisposition.html
