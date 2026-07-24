---
title: "Decomposing Widgets: Backdrop"
description: >-
  Understand Flutter widget composition by
  examining how the Material Backdrop widget is built.
publishDate: 2018-06-26
author: mjohnsullivan
image: images/1in7MRIAKfRn-qDgJKc9XVw.jpeg
category: tutorial
layout: blog
---

While it’s easy to create custom widgets in Flutter, it’s often useful to examine existing widgets to better understand how to compose widgets to create more complex ones.

[Hans Muller](https://github.com/HansMuller) and [Mary Xia](https://github.com/maryx) created Backdrop, a widget that implements the [Material Backdrop component](https://material.io/design/components/backdrop.html), and used in the Flutter Gallery, [Flutter’s Udacity course](https://www.udacity.com/course/build-native-mobile-apps-with-flutter--ud905) and the [Flutter Material Design talk](https://www.youtube.com/watch?v=hA0hrpR-o8U) at I/O 2018. Backdrop manages a front layer widget that overlays a back layer and can be opened and closed.

<DashImage figure src="images/0RLNPIlZaftyTRlhw.webp" alt="Unit Converter app from Flutter’s Udacity course" caption="Unit Converter app from Flutter’s Udacity course" />

Backdrop uses a number of Flutter widgets to accomplish this: Stack, Expanded, LayoutBuilder, Animation, Tween, and PositionedTransition. It serves as a good example of how to compose standard Flutter widgets together to create something more complex.

I extracted Backdrop’s source code and wrote a couple of examples to demonstrate how it works. The revised code is [available on Github](https://github.com/mjohnsullivan/flutter-by-example/tree/master/16_panels), and I’d recommend you spend a couple of minutes playing with and examining the code before diving into the deconstruction below.

I’ve also worked in both ValueNotifier and ScopedModel to demonstrate a couple of different techniques for handling state in Flutter apps.

Let’s dig in and explore how this widget works.

## Backdrop

Backdrop is a StatefulWidget whose state manages the position and animation of the front layer. Let’s start by focusing on Backdrop’s build() function.

```dart
AnimationController _controller;

Widget build(BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    final panelSize = constraints.biggest;
    final closedPercentage = widget.frontHeaderVisibleClosed
        ? (panelSize.height - widget.frontHeaderHeight) / panelSize.height
        : 1.0;
    final openPercentage = widget.frontPanelOpenHeight / panelSize.height;

final panelDetailsPosition = Tween<Offset>(
      begin: Offset(0.0, closedPercentage),
      end: Offset(0.0, openPercentage),
    ).animate(_controller.view);

return Container(
      child: Stack(
        children: <Widget>[
          widget.backLayer,
          SlideTransition(
            position: panelDetailsPosition,
            child: _BackdropPanel(
              child: widget.frontLayer,
              // panel configs
            ),
          ),
        ],
      ),
    );
  });
}
```

The widget consists of a moveable front layer, stacked on top of an immovable back layer. The backLayer widget is placed first in the Stack widget so it appears underneath, followed by _BackdropPanel containing the frontLayer, wrapped in a SlideTransition. The [original version of Backdrop](https://github.com/flutter/flutter/blob/09276bea258737e11b109e227f70eac94a4e1691/examples/flutter_gallery/lib/gallery/backdrop.dart) used PositionTransition, but this was changed to avoid overflow issues when completely hiding the front layer.

LayoutBuilder determines how much vertical space is available at run time, which can vary by screen size and density. This is then used to work out how much of the back layer is covered by the front layer when open. The Tween defines the open and closed positions of the front layer and uses the AnimationController to manage motion.

The BackdropPanel widget implements the front layer with a Column containing the header, divider, and child. The child widget is wrapped in an Expanded to ensure that it fills the available space.

The Material widget decorates the panel with a drop shadow and beveled edges using BorderRadius.

```dart
Widget build(BuildContext context) {
  return Material(
    elevation: 12.0,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        GestureDetector(
          // ...
          child: Container(
            // ...
            height: titleHeight,
            child: title,
          ),
        ),
        Divider(height: 1.0,),
        Expanded(child: child,),
      ],
    ),
  );
}
```

The remaining code in Backdrop primarily implements dragging and animations. BackdropState has an AnimationController where a value of 1 opens the front layer, and 0 closes it.

```dart
_controller = AnimationController(
      duration: Duration(milliseconds: 300),
      // 0 hides the panel; 1 shows the panel
      value: (widget.panelVisible?.value ?? true) ? 1.0 : 0.0,
      vsync: this,
    );
```

The status of the controller can be queried to determine the state of the layer:

```dart
bool get _backdropPanelVisible =>
      _controller.status == AnimationStatus.completed ||
      _controller.status == AnimationStatus.forward;
```

fling() can be called to open or close the layer:

```dart
void _toggleBackdropPanelVisibility() => _controller.fling(
    velocity: _backdropPanelVisible 
        ? -_kFlingVelocity
        : _kFlingVelocity
    );
```

Dragging the layer is supported by _handleDragUpdate(). _handleDragEnd() determines whether the layer should animate open or closed, depending on drag direction, velocity, and position. These functions are used by the GestureDetector widget in BackdropPanel.

```dart
void _handleDragUpdate(DragUpdateDetails details) {
  if (!_controller.isAnimating)
    _controller.value -= details.primaryDelta / _backdropHeight;
}

void _handleDragEnd(DragEndDetails details) {
  if (_controller.isAnimating ||
      _controller.status == AnimationStatus.completed) return;

final double flingVelocity =
      details.velocity.pixelsPerSecond.dy / _backdropHeight;
  if (flingVelocity < 0.0)
    _controller.fling(velocity: math.max(_kFlingVelocity,
      -flingVelocity));
  else if (flingVelocity > 0.0)
    _controller.fling(velocity: math.min(-_kFlingVelocity,
      -flingVelocity));
  else
    _controller.fling(
        velocity:
            _controller.value < 0.5
              ? -_kFlingVelocity
              : _kFlingVelocity);
}
```

## ValueNotifier

I extended the original implementation of Backdrop to take a ValueNotifier, which the widget uses to track the open or closed state of the panel. ValueNotifiers provide a mechanism by which objects can listen for changes to a value.

ValueNotifier is being used here as a demonstration; a callback or other form of state management would be equally valid.

A boolean value, representing the layer’s open/closed state, is held by ValueNotifier. Those widgets interested in the panel state can subscribe to the notifier and know when the panel is opened or closed.

Firstly we ensure that the value is updated when the layer is opened or closed, by listening to the AnimationController’s status in Backdrop:

```dart
if (widget.panelVisible != null) {
  _controller.addStatusListener((status) {
    if (status == AnimationStatus.completed)
      widget.panelVisible.value = true;
    else if (status == AnimationStatus.dismissed)
      widget.panelVisible.value = false;
  });
```

Backdrop also listens for changes in the value, so that other widgets can trigger a change in the front layer’s state:

```dart
void _subscribeToValueNotifier() {
  if (widget.panelVisible.value != _backdropPanelVisible)
    _toggleBackdropPanelVisibility();
}
```

One subtle, but important, side effect of using and subscribing to ValueNotifiers is that when the app is hot reloaded, the widgets may get rebuilt and, if you’ve subscribed to the notifier in initState(), the subscription is no longer valid. To fix this, implement the StatefulWidget’s didWidgetUpdate() method and add a new listener:

```dart
void didUpdateWidget(Backdrop oldWidget) {
  super.didUpdateWidget(oldWidget);
  oldWidget.panelVisible?.removeListener(_subscribeToValueNotifier);
  widget.panelVisible?.addListener(_subscribeToValueNotifier);
}
```

## SimpleExample

The SimpleExample widget shows how to use Backdrop in the simplest of cases. Clicking the button changes the value in ValueNotifier and triggers the front layer to open or close. The notifier is also used to change the Text widget in the back layer.

<DashImage figure src="images/0EhUXhOHx6i4KCuUj.webp" alt="Simple example" caption="Simple example" />

## ComplexExample

ComplexExample demonstrates how to use Backdrop to show different content in the front layer and uses ScopedModel to track the content state. A Model is first defined to manage the front layer state.

```dart
enum FrontPanels { tealPanel, limePanel }

class FrontPanelModel extends Model {
  FrontPanelModel(this._activePanel);
  FrontPanels _activePanel;

FrontPanels get activePanelType => _activePanel;

Widget get panelTitle => _activePanel == FrontPanels.tealPanel
      ? Text('Teal Panel')
      : Text('Lime Panel');

Widget get activePanel =>
      _activePanel == FrontPanels.tealPanel ? TealPanel() : LimePanel();

void activate(FrontPanels panel) {
    _activePanel = panel;
    notifyListeners();
  }
}
```

The model is placed in the widget tree, using a ScopedModel widget, and the ScopedModelDescendant widgets provide access to the model. They rebuild whenever the model changes, unless the rebuildOnChange flag is set to false.

```dart
Widget build(BuildContext context) => ScopedModel(
    model: FrontPanelModel(FrontPanels.firstPanel),
    child: Scaffold(body: SafeArea(child: Panels())));
...
Widget build(BuildContext context) {
  return ScopedModelDescendant<FrontPanelModel>(
    builder: (context, _, model) => Backdrop(
          frontPanel: model.activePanel,
          frontHeader: model.panelTitle,
          ...
        ),
  );
}
...
Center(
    child: ScopedModelDescendant<FrontPanelModel>(
        rebuildOnChange: false,
        builder: (context, _, model) => RaisedButton(
            child: Text('show first panel'),
            onPressed: () {
              model.activate(FrontPanels.firstPanel);
              widget.frontPanelOpen.value = true;
            },
        ))),
```

The buttons in the back layer control which widget is displayed in the front layer.

<DashImage figure src="images/0RLdUfeFhMFa502tl.webp" alt="Complex example" caption="Complex example" />

## Final Thoughts

What looks initially like a complicated widget is, in fact, a collection of standard Flutter widgets composed together to lend their individual functionality to the whole. This is one of Flutter’s most powerful features, the ability to rapidly build out custom, complex UIs from the toolbox of widgets provided by the platform.

Check out the full source code [on GitHub](https://github.com/mjohnsullivan/flutter-by-example/tree/master/16_panels), and thanks again to Hans and Mary, the original creators of Backdrop.

<DashImage figure src="images/1in7MRIAKfRn-qDgJKc9XVw.jpeg" />
