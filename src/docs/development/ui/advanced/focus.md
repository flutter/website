---
title: Understanding Flutter's focus system
description: How to use the focus system in your Flutter app.
---


This article explains how to control where keyboard input is directed. If you
are implementing an application that uses a physical keyboard, such as most
desktop and web applications, this page is for you. If your app won't be used
with a physical keyboard, you can skip this.

## Overview

Flutter comes with a focus system that directs the keyboard input to a
particular part of an application. In order to do this, users "focus" the input
onto that part of an application by tapping or clicking the desired UI element.
Once that happens, text entered with the keyboard flows to that part of the
application until the focus moves to another part of the application.  Focus can
also be moved by pressing a particular keyboard shortcut, which is typically
bound to the **Tab** key, so it is sometimes called "tab traversal".

This page explores the APIs used to perform these operations on a Flutter
application, and how the focus system works. We have noticed that there is some
confusion among developers about how to define and use [`FocusNode`][] objects.
If that describes your experience, skip ahead to the [best practices for
creating `FocusNode` objects](#best-practices-for-creating-focusnode-objects).

### Focus use cases

Some examples of situations where you might need to know how to use the focus
system:

 - [Receiving/handling key events](#key-events)
 - [Implementing a custom component that needs to be focusable](#focus-widget)
 - [Receiving notifications when the focus changes](#change-notifications)
 - [Changing or defining the "tab order" of focus traversal in an application ](#focustraversalpolicy)
 - [Defining groups of controls that should be traversed together](#focustraversalgroup-widget)
 - [Preventing some controls in an application from being focusable](#controlling-what-gets-focus)

## Glossary

Below are terms, as Flutter uses them, for elements of the focus system. The
various classes that implement some of these concepts are introduced below.

 - **Focus tree** - A tree of focus nodes that typically sparsely mirrors the
   widget tree, representing all the widgets that can receive focus.
 - **Focus node** - A single node in a focus tree. This node can receive the
   focus, and is said to "have focus" when it is part of the focus chain. It
   participates in handling key events only when it has focus.
 - **Primary focus** - The farthest focus node from the root of the focus tree
   that has focus. This is the focus node where key events start propagating to
   the primary focus node and its ancestors.
 - **Focus chain** - An ordered list of focus nodes that starts at the primary
   focus node and follows the branches of the focus tree to the root of the
   focus tree.
 - **Focus scope** - A special focus node whose job is to contain a group of
   other focus nodes, and allow only those nodes to receive focus. It contains
   information about which nodes were previously focused in its subtree.
 - **Focus traversal** - The process of moving from one focusable node to
   another in a predictable order. This is typically seen in applications when
   the user presses the **Tab** key to move to the next focusable control or
   field.

## FocusNode and FocusScopeNode

The `FocusNode` and [`FocusScopeNode`][] objects implement the
mechanics of the focus system. They are long-lived objects (longer than widgets,
similar to render objects) that hold the focus state and attributes so that they
are persistent between builds of the widget tree. Together, they form
the focus tree data structure.

They were originally intended to be developer-facing objects used to control
some aspects of the focus system, but over time they have evolved to mostly
implement details of the focus system. In order to prevent breaking existing
applications, they still contain public interfaces for their attributes. But, in
general, the thing for which they are most useful is to act as a relatively
opaque handle, passed to a descendant widget in order to call `requestFocus()`
on an ancestor widget, which requests that a descendant widget obtain focus.
Setting of the other attributes is best managed by a [`Focus`][] or
[`FocusScope`][] widget, unless you are not using them, or implementing your own
version of them.

### Best practices for creating FocusNode objects

Some dos and don'ts around using these objects include:

 -  Don't allocate a new `FocusNode` for each build.  This can cause
    memory leaks, and occasionally causes a loss of focus when the widget
    rebuilds while the node has focus.
 -  Do create `FocusNode` and `FocusScopeNode` objects in a stateful widget.
    `FocusNode` and `FocusScopeNode` need to be disposed of when you're done
    using them, so they should only be created inside of a stateful widget's
    state object, where you can override `dispose` to dispose of them.
 -  Don't use the same `FocusNode` for multiple widgets. If you do, the
    widgets will fight over managing the attributes of the node, and you
    probably won't get what you expect.
 -  Do set the `debugLabel` of a focus node widget to help with diagnosing
    focus issues.
 -  Don't set the `onKey` callback on a `FocusNode` or `FocusScopeNode` if
    they are being managed by a `Focus` or `FocusScope` widget. If you want an
    `onKey` handler, then add a new `Focus` widget around the widget subtree you
    would like to listen to, and set the `onKey` attribute of the widget to your
    handler. Set `canRequestFocus: false` on the widget if you also don't want
    it to be able to take primary focus. This is because the `onKey` attribute
    on the `Focus` widget can be set to something else in a subsequent build,
    and if that happens, it overwrites the `onKey` handler you set on the node.
 -  Do call `requestFocus()` on a node to request that it receives the
    primary focus, especially from an ancestor that has passed a node it owns to
    a descendant where you want to focus.
 -  Do use `focusNode.requestFocus()`. It is not necessary to call
    `FocusScope.of(context).requestFocus(focusNode)`. The
    `focusNode.requestFocus()` method is  equivalent and more performant.

### Unfocusing

There is an API for telling a node to "give up the focus", named
`FocusNode.unfocus()`. While it does remove focus from the node, it is important
to realize that there really is no such thing as "unfocusing" all nodes. If a
node is unfocused, then it must pass the focus somewhere else, since there is
_always_ a primary focus. The node that receives the focus when a node calls
`unfocus()` is either the nearest `FocusScopeNode`, or a previously focused node
in that scope, depending upon the `disposition` argument given to `unfocus()`.
If you would like more control over where the focus goes when you remove it from
a node, explicitly focus another node instead of calling `unfocus()`, or use the
focus traversal mechanism to find another node with the `focusInDirection`,
`nextFocus`, or `previousFocus` methods on `FocusNode`.

When calling `unfocus()`, the `disposition` argument allows two modes for
unfocusing: [`UnfocusDisposition.scope`][] and
`UnfocusDisposition.previouslyFocusedChild`. The default is `scope`, which gives
the focus to the nearest parent focus scope. This means that if the focus is
thereafter moved to the next node with `FocusNode.nextFocus`, it starts with the
"first" focusable item in the scope.

The `previouslyFocusedChild` disposition will search the scope to find the
previously focused child and request focus on it. If there is no previously
focused child, it is equivalent to `scope`.

{{site.alert.secondary}}
  **Beware**: If there is no other scope, then focus moves to the root scope node of
  the focus system, `FocusManager.rootScope`. This is generally not desirable, as
  the root scope doesn't have a `context` for the framework to determine which
  node should be focused next. If you find that your application suddenly loses
  the ability to navigate by using focus traversal, this is probably what has
  happened.  To fix it, add a `FocusScope` as an ancestor to the focus node that
  is requesting the unfocus. The `WidgetsApp` (from which `MaterialApp` and
  `CupertinoApp` are derived) has its own `FocusScope`, so this should not be an
  issue if you are using those.
{{site.alert.end}}

## Focus widget

The `Focus` widget owns and manages a focus node, and is the workhorse of the
focus system.  It manages the attaching and detaching of the focus node it owns
from the focus tree, manages the attributes and callbacks of the focus node, and
has static functions to enable discovery of focus nodes attached to the widget
tree.

In its simplest form, wrapping the `Focus` widget around a widget subtree allows
that widget subtree to obtain focus as part of the focus traversal process, or
whenever `requestFocus` is called on the `FocusNode` passed to it. When combined
with a gesture detector that calls `requestFocus`, it can receive focus when
tapped or clicked.

You might pass a `FocusNode` object to the `Focus` widget to manage, but if you
don't, it creates its own. The main reason you would want to create your own
`FocusNode` to pass to a `Focus` widget is to be able to call `requestFocus()`
on the node to control the focus from a parent widget. Most of the other
functionality of a `FocusNode` is best accessed by changing the attributes of
the `Focus` widget itself.

The `Focus` widget is used in most of Flutter's own controls to implement their
focus functionality.

Here is an example showing how to use the `Focus` widget to make a custom
control focusable. It creates a container with text that reacts to receiving the
focus.

<?code-excerpt "ui/advanced/focus/lib/custom_control_example.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Focus Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[MyCustomWidget(), MyCustomWidget()],
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({Key? key}) : super(key: key);

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  Color _color = Colors.white;
  String _label = 'Unfocused';

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (bool focused) {
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
### Key events

If you wish to listen for key events in a subtree, set the `onKey` attribute of
the `Focus` widget to be a handler that either just listens to the key, or
handles the key and stops its propagation to other widgets.

Key events start at the focus node with primary focus. If that node doesn't
return `KeyEventResult.handled` from its `onKey` handler, then its parent focus
node is given the event. If the parent doesn't handle it, it goes to its parent,
and so on, until it reaches the root of the focus tree. If the event reaches the
root of the focus tree without being handled, then it is returned to the
platform to give to the next native control in the application (in case the
Flutter UI is part of a larger native application UI). Events that are handled
are not propagated to other Flutter widgets, and they are also not propagated to
native widgets.

Here's an example of a `Focus` widget that absorbs every key that its subtree
doesn't handle, without being able to be the primary focus:

<?code-excerpt "ui/advanced/focus/lib/samples.dart (AbsorbKeysExample)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    onKey: (FocusNode node, RawKeyEvent event) => KeyEventResult.handled,
    canRequestFocus: false,
    child: child,
  );
}
```

Focus key events are processed before text entry is, so handling a key event
when the focus widget surrounds a text field will prevent that key from being
entered into the text field.

Here's an example of a widget that won't allow the letter "a" to be typed into
the text field:

<?code-excerpt "ui/advanced/focus/lib/samples.dart (NoAExample)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    onKey: (FocusNode node, RawKeyEvent event) {
      return (event.logicalKey == LogicalKeyboardKey.keyA)
          ? KeyEventResult.handled
          : KeyEventResult.ignored;
    },
    child: TextField(),
  );
}
```

If the intent is input validation, this example's functionality would probably
be better implemented using a `TextInputFormatter`, but the technique can still
be useful: the `Shortcuts` widget uses this method to handle shortcuts before
they become text input, for instance.

### Controlling what gets focus

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
node can receive focus, but still allows this node to receive focus.  This
attribute can be used to turn off focusability for an entire widget subtree.
This is how the `ExcludeFocus` widget works: it's just a `Focus` widget with
this attribute set.

### Autofocus

Setting the `autofocus` attribute of a `Focus` widget tells the widget to
request the focus the first time the focus scope it belongs to is focused.  If
more than one widget has `autofocus` set, then it is arbitrary which one
receives the focus, so try to only set it on one widget per focus scope.

The `autofocus` attribute only takes effect if there isn't already a focus in
the scope that the node belongs to.

Setting the `autofocus` attribute on two nodes that belong to different focus
scopes is well defined: each one becomes the focused widget when their
corresponding scopes are focused.

### Change notifications

The `Focus.onFocusChanged` callback can be used to get notifications that the
focus state for a particular node has changed. It notifies if the node is added
to or removed from the focus chain, which means it gets notifications even if it
isn't the primary focus. If you only want to know if you have received the
primary focus, check and see if `hasPrimaryFocus` is true on the focus node.

### Obtaining the FocusNode

Sometimes, it is useful to obtain the focus node of a `Focus` widget to
interrogate its attributes.

To access the focus node from an ancestor of the `Focus` widget, create and pass
in a `FocusNode` as the `Focus` widget's `focusNode` attribute. Because it needs
to be disposed of, the focus node you pass needs to be owned by a stateful
widget, so don't just create one each time it is built.

If you need access to the focus node from the descendant of a `Focus` widget,
you can call `Focus.of(context)` to obtain the focus node of the nearest `Focus
`widget to the given context. If you need to obtain the `FocusNode` of a `Focus`
widget within the same build function, use a [`Builder`][] to make sure you have
the correct context. As shown in the following example:

<?code-excerpt "ui/advanced/focus/lib/samples.dart (BuilderExample)"?>
```dart
@override
Widget build(BuildContext context) {
  return Focus(
    child: Builder(
      builder: (BuildContext context) {
        final bool hasPrimary = Focus.of(context).hasPrimaryFocus;
        print('Building with primary focus: $hasPrimary');
        return const SizedBox(width: 100, height: 100);
      },
    ),
  );
}
```

### Timing

One of the details of the focus system is that when focus is requested, it only
takes effect after the current build phase completes.  This means that focus
changes are always delayed by one frame. This is because changing focus can
cause arbitrary parts of the widget tree to rebuild, including ancestors of the
widget currently requesting focus. Because descendants cannot dirty their
ancestors, it has to happen between frames, so that any needed changes can
happen on the next frame.

## FocusScope widget

The `FocusScope` widget is a special version of the `Focus` widget that manages
a `FocusScopeNode` instead of a `FocusNode`.  The `FocusScopeNode` is a special
node in the focus tree that serves as a grouping mechanism for the focus nodes
in a subtree. Focus traversal stays within a focus scope unless a node outside
of the scope is explicitly focused.

The focus scope also keeps track of the current focus and history of the nodes
focused within its subtree.  That way, if a node releases focus or is removed
when it had focus, the focus can be returned to the node that had focus
previously.

Focus scopes also serve as a place to return focus to if none of the descendants
have focus.  This allows the focus traversal code to have a starting context for
finding the next (or first) focusable control to move to.

If you focus a focus scope node, it first attempts to focus the current, or most
recently focused node in its subtree, or the node in its subtree that requested
autofocus (if any).  If there is no such node, it receives the focus itself.

## FocusableActionDetector widget

The [`FocusableActionDetector`][] is a widget that combines the functionality of
[`Actions`][], [`Shortcuts`][], [`MouseRegion`][] and a `Focus` widget to create
a detector that defines actions and key bindings, and provides callbacks for
handling focus and hover highlights. It is what Flutter controls use to
implement all of these aspects of the controls. It is just implemented using the
constituent widgets, so if you don't need all of its functionality, you can just
use the ones you need, but it is a convenient way to build these behaviors into
your custom controls.

## Controlling focus traversal

Once an application has the ability to focus, the next thing many apps want to
do is to allow the user to control the focus using the keyboard or another input
device. The most common example of this is "tab traversal" where the user
presses the **Tab** key to go to the "next" control. Controlling what "next"
means is the subject of this section. This kind of traversal is provided by
Flutter by default.

In a simple grid layout, it's fairly easy to decide which control is next. If
you're not at the end of the row, then it's the one to the right (or left for
right-to-left locales). If you are at the end of a row, it's the first control
in the next row. Unfortunately, applications are rarely laid out in grids, so
more guidance is often needed.

The default algorithm in Flutter ([`ReadingOrderTraversalPolicy`][]) for focus
traversal is pretty good: It gives the right answer for most applications.
However, there are always pathological cases, or cases where the context or
design requires a different order than the one the default ordering algorithm
arrives at. For those cases, there are other mechanisms for achieving the
desired order.

### FocusTraversalGroup widget

The [`FocusTraversalGroup`][] widget should be placed in the tree around widget
subtrees that should be fully traversed before moving on to another widget or
group of widgets. Just grouping widgets into related groups is often enough to
resolve many tab traversal ordering problems. If not, the group can also be
given a [`FocusTraversalPolicy`][] to determine the ordering within the group.

The default [`ReadingOrderTraversalPolicy`][] is usually sufficient, but in
cases where more control over ordering is needed, an
[`OrderedTraversalPolicy`][] can be used. The `order` argument of the
[`FocusTraversalOrder`][] widget wrapped around the focusable components
determines the order. The order can be any subclass of [`FocusOrder`][], but
[`NumericFocusOrder`][] and [`LexicalFocusOrder`][] are provided.

If none of the provided focus traversal policies are sufficient for your
application, you could also write your own policy and use it to determine any
custom ordering you want.

Here's an example of how to use the `FocusTraversalOrder` widget to traverse a
row of buttons in the order TWO, ONE, THREE using `NumericFocusOrder`.

<?code-excerpt "ui/advanced/focus/lib/samples.dart (OrderedButtonRowExample)"?>
```dart
class OrderedButtonRow extends StatelessWidget {
  const OrderedButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Row(
        children: <Widget>[
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(2.0),
            child: TextButton(
              child: const Text('ONE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(1.0),
            child: TextButton(
              child: const Text('TWO'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(3.0),
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

### FocusTraversalPolicy

The `FocusTraversalPolicy` is the object that determines which widget is next,
given a request and the current focus node. The requests (member functions) are
things like `findFirstFocus`, `findLastFocus`, `next`, `previous`, and
`inDirection`.

`FocusTraversalPolicy` is the abstract base class for concrete policies, like
`ReadingOrderTraversalPolicy`,  `OrderedTraversalPolicy` and the
[`DirectionalFocusTraversalPolicyMixin`][] classes.

In order to use a `FocusTraversalPolicy`, you give one to a
`FocusTraversalGroup`, which determines the widget subtree in which the policy
will be effective. The member functions of the class are rarely called directly:
they are meant to be used by the focus system.

## The focus manager

The [`FocusManager`][] maintains the current primary focus for the system. It
only has a few pieces of API that are useful to users of the focus system. One
is the `FocusManager.instance.primaryFocus` property, which contains the
currently focused focus node and is also accessible from the global
`primaryFocus` field.

Other useful properties are `FocusManager.instance.highlightMode` and
`FocusManager.instance.highlightStrategy`. These are used by widgets that need
to switch between a "touch" mode and a "traditional" (mouse and keyboard) mode
for their focus highlights. When a user is using touch to navigate, the focus
highlight is usually hidden, and when they switch to a mouse or keyboard, the
focus highlight needs to be shown again so they know what is focused. The
`hightlightStrategy` tells the focus manager how to interpret changes in the
usage mode of the device: it can either automatically switch between the two
based on the most recent input events, or it can be locked in touch or
traditional modes. The provided widgets in Flutter already know how to use this
information, so you only need it if you're writing your own controls from
scratch. You can use `addHighlightModeListener` callback to listen for changes
in the highlight mode.


[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`Builder`]: {{site.api}}/flutter/widgets/Builder-class.html
[`DirectionalFocusTraversalPolicyMixin`]: {{site.api}}/flutter/widgets/DirectionalFocusTraversalPolicyMixin-class.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`FocusableActionDetector`]: {{site.api}}/flutter/widgets/FocusableActionDetector-class.html
[`FocusManager`]: {{site.api}}/flutter/widgets/FocusManager-class.html
[`FocusNode`]: {{site.api}}/flutter/widgets/FocusNode-class.html
[`FocusOrder`]: {{site.api}}/flutter/widgets/FocusOrder-class.html
[`FocusScope`]: {{site.api}}/flutter/widgets/FocusScope-class.html
[`FocusScopeNode`]: {{site.api}}/flutter/widgets/FocusScopeNode-class.html
[`FocusTraversalGroup`]: {{site.api}}/flutter/widgets/FocusTraversalGroup-class.html
[`FocusTraversalOrder`]: {{site.api}}/flutter/widgets/FocusTraversalOrder-class.html
[`FocusTraversalPolicy`]: {{site.api}}/flutter/widgets/FocusTraversalPolicy-class.html
[`LexicalFocusOrder`]: {{site.api}}/flutter/widgets/LexicalFocusOrder-class.html
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`NumericalFocusOrder`]: {{site.api}}/flutter/widgets/NumericalFocusOrder-class.html
[`ReadingOrderTraversalPolicy`]: {{site.api}}/flutter/widgets/ReadingOrderTraversalPolicy-class.html
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html
[`UnfocusDisposition.scope`]: {{site.api}}/flutter/widgets/UnfocusDisposition-class.html
