---
title: "Getting to the Bottom of Navigation in Flutter"
description: "Bottom navigation in mobile apps is popular because our phones keep getting bigger but our thumbs do not. Here’s how to do it in Flutter."
publishDate: 2019-06-27
author: hansmuller
image: images/1pzfLG6bpSs8KGe48AXZR_g.webp
category: tutorial
layout: blog
---

Bottom navigation in mobile apps is popular because our phones keep getting bigger but our thumbs do not. The Material Design specification describes a [*bottom navigation bar*](https://material.io/design/components/bottom-navigation.html#) as a row of three to five buttons at the bottom of the screen that are used to select among as many *destinations*.

<DashImage figure src="images/1pzfLG6bpSs8KGe48AXZR_g.webp" alt="A typical bottom navigation bar; Flutter’s BottomNavigationBar widget." caption="A typical bottom navigation bar; Flutter’s BottomNavigationBar widget." />


Flutter provides a [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) widget that’s essentially just a row of destination buttons and a single callback that’s passed the index of the button that was tapped. All the app has to do is to rebuild with a “destination view” widget that corresponds to the button the user tapped. Easy. There’s even a short example that demonstrates as much in the API docs. We’re done right?

If only it were that simple.

## Stateful Destination Views

Destination views are likely to be stateful. They may contain text fields, selection controls, scrollables, or other widgets that depend on state which should not be discarded when the user selects a different destination. In other words, when the user returns to a destination, the destination view should be just as they left it.

A trivial implementation of the bottom navigation, where only the selected destination view is part of the widget tree, will not retain the state of the other destination views. The simplest way to ensure that the state for all views is retained, is to keep all of the views in the widget tree, while only showing the selected view. Fortunately, there’s a widget for that.

An [*IndexedStack*](https://api.flutter.dev/flutter/widgets/IndexedStack-class.html) displays only one of its children. All of its children are always part of the widget tree so their state is never discarded.

To demonstrate using an IndexedStack for displaying the selected destination, I’ve created a few small support classes and variables.

The *Destination* class contains a few visual properties that identify one destination. There’s also a list of the app’s four destinations, *allDestinations*.

```dart
class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.teal),
  Destination('Business', Icons.business, Colors.cyan),
  Destination('School', Icons.school, Colors.orange),
  Destination('Flight', Icons.flight, Colors.blue)
];

```

Each stateful *DestinationView* contains a *TextField* to demonstrate that the keyboard focus and the text field’s value persist upon switching destinations.
Each DestinationView has its own scaffold. Not to put too fine a point on it: we’re nesting scaffolds here. That’s OK.

```dart
class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination }) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title} Text'),
        backgroundColor: widget.destination.color,
      ),
      backgroundColor: widget.destination.color[100],
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(controller: _textController),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

```

Finally the point of this whole exercise is revealed: the app’s *HomePage,* featuring a scaffold with a *BottomNavigationBar* for the destinations, and an *IndexedStack* for the destination views. As you can see, tapping on a destination (on a *BottomNavigationBarItem*) causes the home page to rebuild with a new value for *_currentIndex*. The indexed stack displays the destination view selected by the current index.

```dart
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map<Widget>((Destination destination) {
            return DestinationView(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            backgroundColor: destination.color,
            title: Text(destination.title)
          );
        }).toList(),
      ),
    );
  }
}

```

And that’s that, you now have bottom navigation with stateful destination views. Everyone is happy.

<DashImage figure src="images/1VLSvnXBbA3ohu3YgpGVIhA.webp" />


Actually, everyone is not happy. The Material Design spec makes it clear that destination views should cross-fade into view. The indexed stack demo unceremoniously snaps the selected destination into view within a single frame. The spec also suggests that if a destination view is scrollable, the bottom navigation bar should optionally slide off screen when the user scrolls up, and only reappear when the user scrolls down. And finally there’s navigation: many apps require each destination view to be hosted by its own [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html), so that the view can display a stack of routes rather than a single interactive page.

The following sections will make everyone happy. Happier.

## Navigator per Destination View

A Flutter Navigator manages a stack of Route objects and a stack of overlays that are displayed on top. Routes aren’t widgets, they’re objects that have-a widget. A route’s widget can be a fully opaque page or a smaller user interface part like a dialog or a menu.

A complete discussion of navigators and routes is beyond the scope of this article. To help you understand the version of the demo where each destination view includes a navigator, here are a few facts to keep in mind:

* Navigators have push and pop methods for managing the stack of routes.

* Navigators support lazily creating routes. Lazily created routes are identified by a path name.

* By default the navigator displays the route called ‘/’.

* Any widget can push or pop routes on its navigator ancestor with the static [Navigator.push](https://api.flutter.dev/flutter/widgets/Navigator/push.html) and [Navigator.pop](https://api.flutter.dev/flutter/widgets/Navigator/pop.html) methods.

The code that follows is a version of the destination view’s state which builds a navigator instead of just building a text field. Routes are lazily constructed by the navigator’s *onGenerateRoute* callback and each route’s widget is constructed by a *MaterialPageRoute builder* callback.

```dart
class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return RootPage(destination: widget.destination);
              case '/list':
                return ListPage(destination: widget.destination);
              case '/text':
                return TextPage(destination: widget.destination);
            }
          },
        );
      },
    );
  }
}

```

The *RootPage* widget handles taps by pushing the route called ‘/list’ that contains a ListPage widget:

```dart
onTap: () {
  Navigator.pushNamed(context, "/list");
},

```

The *ListPage* widget is similar. Tapping any list item causes it to push a ‘/text’ route which will contain a *TextPage* widget. The TextPage widget is essentially the same as the original DestinationView (it contains a single TextField).

<DashImage figure src="images/1SWOS-PvXgnH9-0SWcPt2mA.webp" />


## Cross Fading Destination Views

The basic idea here is pretty simple: stack the destination views, fade in the selected view, and fade out the unselected views. Once a destination has faded out we’ll move it [*Offstage*](https://api.flutter.dev/flutter/widgets/Offstage-class.html) so that it’s no longer rendered or hit tested. To ensure that moving views offstage preserves their state, give them a Global Key.

A brief word about global keys and preserving a widget’s state.

Each time the widget tree is rebuilt, Flutter preserves the state of widgets that occupy the same place in the tree, and have the same key as they did in the previous frame. Most widgets are created without a key, so this test simplifies to: same runtime type and same tree location. A widget with a global key is treated differently. Its state and its subtree are *moved* if the keyed widget has moved to a new location when the tree rebuilds.

This version of the demo requires some additional HomePage state for each destination view: a fader animation and a global key.

```dart
List<AnimationController> _faders;
List<Key> _destinationKeys;
int _currentIndex = 0;

@override
void initState() {
  super.initState();

  _faders = allDestinations.map<AnimationController>((Destination destination) {
    return AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }).toList();
  _faders[_currentIndex].value = 1.0;
  _destinationKeys = List<Key>.generate(allDestinations.length, (int index) => GlobalKey()).toList();
}

@override
void dispose() {
  for (AnimationController controller in _faders)
    controller.dispose();
  super.dispose();
}

```

In the cross fading version of the demo, the original indexed stack has been replaced by an ordinary [*Stack*](https://api.flutter.dev/flutter/widgets/Stack-class.html) where each destination view has been wrapped with a [*FadeTransition*](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html) and been assigned a global key with a *[KeyedSubtree](https://api.flutter.dev/flutter/widgets/KeyedSubtree-class.html).* Each fade transition is driven by one of the animation controllers in the list of _faders shown above.

The fader for the currently selected destination view is driven forwards, which causes it to fade in. The faders for the other views are driven in reverse, and those which have completely faded out are moved offstage. While a view is fading out it’s wrapped with *[IgnorePointer](https://api.flutter.dev/flutter/widgets/IgnorePointer-class.html),* so that it doesn’t respond to user gestures.

```dart
Stack(
  fit: StackFit.expand,
  children: allDestinations.map((Destination destination) {
    final Widget view = FadeTransition(
      opacity: _faders[destination.index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
      child: KeyedSubtree(
        key: _destinationKeys[destination.index],
        child: DestinationView(
          destination: destination,
        ),
      ),
    );
    if (destination.index == _currentIndex) {
      _faders[destination.index].forward();
      return view;
    } else {
      _faders[destination.index].reverse();
      if (_faders[destination.index].isAnimating) {
        return IgnorePointer(child: view);
      }
      return Offstage(child: view);
    }
  }).toList(),
)

```

That’s it for cross fading. Hopefully it’s obvious that it would be easy to substitute a different transition for the fade.

<DashImage figure src="images/12_97cfLZr3d3sp2Sgv71Lg.webp" />


## Hiding the Bottom Navigation Bar on Scroll

In this version of the demo, any destination view with scrollable content causes the bottom navigation bar to slide off screen when the content is scrolled downwards, and back on screen when the content scrolls upwards. We’ll use a [*NotificationListener&lt;ScrollNotification&gt;*](https://api.flutter.dev/flutter/widgets/NotificationListener-class.html) at the root of each destination view to detect changes in the scroll direction. Wrapping the bottom navigation bar with a [*SizeTransition*](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html) makes it possible to animate the bar on and off screen.

This version of the demo requires adding one more animation controller for showing and hiding the bottom navigation bar the destination view’s state:

```dart
// ...
AnimationController _hide;

@override
void initState() {
  super.initState();
  // ...
  _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
}

@override
void dispose() {
  // ...
  _hide.dispose();
  super.dispose();
}

```

When the scroll direction changes, the scroll notification’s callback runs the _hide animation controller forward to hide the bottom navigation bar, and in reverse to show it. We use the notification’s *depth* to distinguish the topmost scrollable from nested ones.

The size transition keeps the child of the navigation bar top-aligned as it grows and shrinks, by specifying axisAlignment as -1.

```dart
bool _handleScrollNotification(ScrollNotification notification) {
  if (notification.depth == 0) {
    if (notification is UserScrollNotification) {
      final UserScrollNotification userScroll = notification;
      switch (userScroll.direction) {
        case ScrollDirection.forward:
          _hide.forward();
          break;
        case ScrollDirection.reverse:
          _hide.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    }
  }
  return false;
}

Widget build(BuildContext context) {
  return NotificationListener<ScrollNotification>(
    onNotification: _handleScrollNotification,
    child: Scaffold(
      // ...
      bottomNavigationBar: SizeTransition(
        sizeFactor: _hide,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          // ...
        ),
      ),
    ),
  );
}

```

That’s just about that for adding support for changing the visibility of the bottom navigation bar when the current destination is scrolled. If you read the source for the [complete demo](https://gist.github.com/HansMuller/b189642d10fd236a41044fdf7626f7b0) you’ll see one additional tweak. Each time a destination view’s navigator pushes or pops a new route, the bottom navigation bar is shown. This is done by giving each destination view navigator a *[NavigatorObserver](https://api.flutter.dev/flutter/widgets/Navigator/observers.html),* which ensures that the bottom navigation bar is visible.

<DashImage figure src="images/1TIqGBqqOQsvHpUC5kx8P2w.webp" />


## Summary

This article explains how to create a bottom navigation bar app using Flutter. The effect is similar to tabbed web browsing with the tabs on the bottom: each tab (or “destination”) selects a view that provides a navigation stack.

In addition to the BottomNavigationBar widget, the [demo implementation](https://gist.github.com/HansMuller/b189642d10fd236a41044fdf7626f7b0) uses the Stack, Navigator, IgnorePointer, and Offstage widgets to manage the destination views, the SizeTransition and FadeTransition widgets for animation, and the NotificationListener and NavigatorObserver widgets to track state changes.

This article is based on a talk I gave at the [NYC Flutter Meetup on 5/22/2019](https://www.meetup.com/flutter-nyc/events/257815270/).

Many of the examples depend on Flutter 1.7.1 or a newer version.
