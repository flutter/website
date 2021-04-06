---
title: Create a scrolling parallax effect
description: How to implement a scrolling parallax effect.
prev:
  title: Create a photo filter carousel
  path: /docs/cookbook/effects/photo-filter-carousel
next:
  title: Create a shimmer loading effect
  path:  /docs/cookbook/effects/shimmer-loading
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

When you scroll a list of cards (containing images,
for example) in an app, you might notice that those
images appear to scroll more slowly than the rest of the 
screen. It almost looks as if the cards in the list
are in the foreground, but the images themselves sit
far off in the distant background. This effect is 
known as parallax.

In this recipe, you create the parallax effect by building
a list of cards (with rounded corners containing some text).
Each card also contains an image.
As the cards slide up the screen,
the images within each card slide down.

The following animation shows the app's behavior: 

![Parallax scrolling]({% asset cookbook/effects/ParallaxScrolling.gif @path %}){:.site-mobile-screenshot}

## Create a list to hold the parallax items

To display a list of parallax scrolling images,
you must first display a list.

Create a new stateless widget called `ParallaxRecipe`.
Within `ParallaxRecipe`, build a widget tree with a
`SingleChildScrollView` and a `Column`, which forms 
a list.

<!--skip-->
```dart
class ParallaxRecipe extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     child: Column(
       children: [],
     ),
   );
 }
}
```

## Display items with text and a static image

Each list item displays a rounded-rectangle background
image, exemplifying one of seven locations in the world.
Stacked on top of that background image is the 
name of the location and its country,
positioned in the lower left. Between the 
background image and the text is a dark gradient,
which improves the legibility 
of the text against the background.

Implement a stateless widget called `LocationListItem`
that consists of the previously mentioned visuals.
For now, use a static `Image` widget for the background.
Later, you’ll replace that widget with a parallax version.

<!--skip-->
```dart
@immutable
class LocationListItem extends StatelessWidget {
 const LocationListItem({
   Key? key,
   required this.imageUrl,
   required this.name,
   required this.country,
 }) : super(key: key);

 final String imageUrl;
 final String name;
 final String country;

 @override
 Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
     child: AspectRatio(
       aspectRatio: 16 / 9,
       child: ClipRRect(
         borderRadius: BorderRadius.circular(16),
         child: Stack(
           children: [
             _buildParallaxBackground(context),
             _buildGradient(),
             _buildTitleAndSubtitle(),
           ],
         ),
       ),
     ),
   );
 }

 Widget _buildParallaxBackground(BuildContext context) {
   return Image.network(
     imageUrl,
     fit: BoxFit.cover,
   );
 }

 Widget _buildGradient() {
   return Positioned.fill(
     child: DecoratedBox(
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
           stops: [0.6, 0.95],
         ),
       ),
     ),
   );
 }

 Widget _buildTitleAndSubtitle() {
   return Positioned(
     left: 20,
     bottom: 20,
     child: Column(
       mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           name,
           style: const TextStyle(
             color: Colors.white,
             fontSize: 20,
             fontWeight: FontWeight.bold,
           ),
         ),
         Text(
           country,
           style: const TextStyle(
             color: Colors.white,
             fontSize: 14,
           ),
         ),
       ],
     ),
   );
 }
}
```

Next, add the list items to your `ParallaxRecipe` widget.

<!--skip-->
```dart
class ParallaxRecipe extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     child: Column(
       children: [
         for (final location in locations)
           LocationListItem(
             imageUrl: location.imageUrl,
             name: location.name,
             location: location.place,
           ),
       ],
     ),
   );
 }
}
```

You now have a typical, scrollable list of cards
that displays seven unique locations in the world.
In the next step, you add a parallax effect to the 
background image.

## Implement the parallax effect

A parallax scrolling effect is achieved by slightly
pushing the background image in the opposite direction
of the rest of the list. As the list items slide up 
the screen, each background image slides slightly downward.
Conversely, as the list items slide down the screen,
each background image slides slightly upward. 
Visually, this results in parallax.

The parallax effect depends on the list item’s
current position within its ancestor `Scrollable`.
As the list item’s scroll position changes, the position
of the list item’s background image must also change.
This is an interesting problem to solve. The position
of a list item within the `Scrollable` isn’t 
available until Flutter’s layout phase is complete.
This means that the position of the background image
must be determined in the paint phase, which comes after 
the layout phase. Fortunately, Flutter provides a widget
called `Flow`, which is specifically designed to give you
control over the transform of a child widget immediately
before the widget is painted. In other words,
you can intercept the painting phase and take control
to reposition your child widgets however you want.

{{site.alert.note}}
  In cases where you need control over what a child paints,
  rather than where a child is painted,
  consider using a [`CustomPaint`][] widget.

  In cases where you need control over the layout,
  painting, and hit testing, consider defining a
  custom [`RenderBox`][].
{{site.alert.end}}

Wrap your background `Image` widget with a
[`Flow`][] widget.

<!--skip-->
```dart
Widget _buildParallaxBackground(BuildContext context) {
 return Flow(
   children: [
     Image.network(
       imageUrl,
       fit: BoxFit.cover,
     ),
   ],
 );
}
```

Introduce a new `FlowDelegate` called `ParallaxFlowDelegate`.

<!--skip-->
```dart
Widget _buildParallaxBackground(BuildContext context) {
 return Flow(
   delegate: ParallaxFlowDelegate(),
   children: [
     Image.network(
       imageUrl,
       fit: BoxFit.cover,
     ),
   ],
 );
}

// …

class ParallaxFlowDelegate extends FlowDelegate {
 ParallaxFlowDelegate();

 @override
 BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
   // TODO:
 }

 @override
 void paintChildren(FlowPaintingContext context) {
   // TODO:
 }

 @override
 bool shouldRepaint(covariant FlowDelegate oldDelegate) {
   // TODO:
   return true;
 }
}
```

A `FlowDelegate` controls how its children are sized
and where those children are painted. In this case,
your `Flow` widget has only one child: the background 
image. That image must be exactly as wide as the `Flow` widget.

Return tight width constraints for your background image child.

<!--skip-->
```dart
 @override
 BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
   return BoxConstraints.tightFor(
    width: constraints.maxWidth,
   );
 }
```

Your background images are now sized appropriately.
But, you still need to calculate the vertical position
of each background image based on its scroll 
position, and then paint it.

There are three critical pieces of information that
you need to compute the desired position of a
background image: 

 * The bounds of the ancestor `Scrollable`
 * The bounds of the individual list item
 * The size of the image after it’s scaled down
   to fit in the list item

To look up the bounds of the `Scrollable`,
you pass a `ScrollableState` into your `FlowDelegate`.

To look up the bounds of your individual list item,
you pass your list item’s `BuildContext` into your `FlowDelegate`.

To look up the final size of your background image,
you assign a `GlobalKey` to your `Image` widget,
and then you pass that `GlobalKey` into your 
`FlowDelegate`.

Make this information available to `ParallaxFlowDelegate`.

<!--skip-->
```dart
class LocationListItem extends StatelessWidget {

 final GlobalKey _backgroundImageKey = GlobalKey();

 Widget _buildParallaxBackground(BuildContext context) {
   return Flow(
     delegate: ParallaxFlowDelegate(
       scrollable: Scrollable.of(context)!,
       listItemContext: context,
       backgroundImageKey: _backgroundImageKey,
     ),
     children: [
       Image.network(
         imageUrl,
         key: _backgroundImageKey,
         fit: BoxFit.cover,
       ),
     ],
   );
 }
}

// …

class ParallaxFlowDelegate extends FlowDelegate {
 ParallaxFlowDelegate({
   required this.scrollable,
   required this.listItemContext,
   required this.backgroundImageKey,
 });

 final ScrollableState scrollable;
 final BuildContext listItemContext;
 final GlobalKey backgroundImageKey;
}
```

Having all the information needed to implement
parallax scrolling, implement the `shouldRepaint()` method.

<!--skip-->
```dart
@override
bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
 return scrollable != oldDelegate.scrollable ||
     listItemContext != oldDelegate.listItemContext ||
     backgroundImageKey != oldDelegate.backgroundImageKey;
}
```

Now, implement the layout calculations for the parallax effect.

First, calculate the pixel position of a list
item within its ancestor `Scrollable`.

<!--skip-->
```dart
@override
void paintChildren(FlowPaintingContext context) {
 // Calculate the position of this list item within the viewport.
 final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
 final listItemBox = listItemContext.findRenderObject() as RenderBox;
 final listItemOffset = listItemBox.localToGlobal(
     listItemBox.size.centerLeft(Offset.zero),
     ancestor: scrollableBox);
}
```

Use the pixel position of the list item to calculate its
percentage from the top of the `Scrollable`.
A list item at the top of the scrollable area should 
produce 0%, and a list item at the bottom of the
scrollable area should produce 100%.

<!--skip-->
```dart
@override
void paintChildren(FlowPaintingContext context) {
 // Calculate the position of this list item within the viewport.
 final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
 final listItemBox = listItemContext.findRenderObject() as RenderBox;
 final listItemOffset = listItemBox.localToGlobal(
     listItemBox.size.centerLeft(Offset.zero),
     ancestor: scrollableBox);

 // Determine the percent position of this list item within the
 // scrollable area.
 final viewportDimension = scrollable.position.viewportDimension;
 final scrollFraction =
   (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);
}
```

Use the scroll percentage to calculate an `Alignment`.
At 0%, you want `Alignment(0.0, -1.0)`,
and at 100%, you want `Alignment(0.0, 1.0)`.
These coordinates correspond to top and bottom
alignment, respectively.

<!--skip-->
```dart
@override
void paintChildren(FlowPaintingContext context) {
 // Calculate the position of this list item within the viewport.
 final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
 final listItemBox = listItemContext.findRenderObject() as RenderBox;
 final listItemOffset = listItemBox.localToGlobal(
     listItemBox.size.centerLeft(Offset.zero),
     ancestor: scrollableBox);

 // Determine the percent position of this list item within the
 // scrollable area.
 final viewportDimension = scrollable.position.viewportDimension;
 final scrollFraction =
   (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

 // Calculate the vertical alignment of the background
 // based on the scroll percentage.
 final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
}
```

Use `verticalAlignment`, along with the size of the
list item and the size of the background image,
to produce a `Rect` that determines where the 
background image should be positioned.

<!--skip-->
```dart
@override
void paintChildren(FlowPaintingContext context) {
 // Calculate the position of this list item within the viewport.
 final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
 final listItemBox = listItemContext.findRenderObject() as RenderBox;
 final listItemOffset = listItemBox.localToGlobal(
     listItemBox.size.centerLeft(Offset.zero),
     ancestor: scrollableBox);

 // Determine the percent position of this list item within the
 // scrollable area.
 final viewportDimension = scrollable.position.viewportDimension;
 final scrollFraction =
   (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

 // Calculate the vertical alignment of the background
 // based on the scroll percentage.
 final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

 // Convert the background alignment into a pixel offset for
 // painting purposes.
 final backgroundSize =
   (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
       .size;
   final listItemSize = context.size;
   final childRect =
     verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);
}
```

Using `childRect`, paint the background image with
the desired translation transformation.
It’s this transformation over time that gives you the 
parallax effect.

<!--skip-->
```dart
@override
void paintChildren(FlowPaintingContext context) {
 // Calculate the position of this list item within the viewport.
 final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
 final listItemBox = listItemContext.findRenderObject() as RenderBox;
 final listItemOffset = listItemBox.localToGlobal(
     listItemBox.size.centerLeft(Offset.zero),
     ancestor: scrollableBox);

 // Determine the percent position of this list item within the
 // scrollable area.
 final viewportDimension = scrollable.position.viewportDimension;
 final scrollFraction =
   (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

 // Calculate the vertical alignment of the background
 // based on the scroll percentage.
 final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

 // Convert the background alignment into a pixel offset for
 // painting purposes.
 final backgroundSize =
   (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
       .size;
   final listItemSize = context.size;
   final childRect =
     verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

 // Paint the background.
 context.paintChild(
   0,
   transform: Transform.translate(
     offset: Offset(0.0, childRect.top),
   ).transform,
 );
}
```

You need one final detail to achieve the parallax effect.
The `ParallaxFlowDelegate` repaints when the inputs change,
but the `ParallaxFlowDelegate` doesn’t repaint every time
the scroll position changes.

Pass the `ScrollableState`’s `ScrollPosition` to
the `FlowDelegate` superclass so that the `FlowDelegate`
repaints every time the `ScrollPosition` changes.

<!--skip-->
```dart
class ParallaxFlowDelegate extends FlowDelegate {
 ParallaxFlowDelegate({
   required this.scrollable,
   required this.listItemContext,
   required this.backgroundImageKey,
 }) : super(repaint: scrollable.position);
}
```

Congratulations!
You now have a list of cards with parallax,
scrolling background images.

## Interactive example

Run the app:

* Scroll up and down to observe the parallax effect.

<!--skip-->
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ExampleParallax(),
        ),
      ),
    );
  }
}

class ExampleParallax extends StatelessWidget {
  const ExampleParallax({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final location in locations)
            LocationListItem(
              imageUrl: location.imageUrl,
              name: location.name,
              country: location.place,
            ),
        ],
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.country,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            country,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  Parallax({
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context)!);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context)!;
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}

class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
  });

  final String name;
  final String place;
  final String imageUrl;
}

const urlPrefix =
    'https://flutter.dev/docs/cookbook/img-files/effects/parallax';
const locations = [
  Location(
    name: 'Mount Rushmore',
    place: 'U.S.A',
    imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
  ),
  Location(
    name: 'Singapore',
    place: 'China',
    imageUrl: '$urlPrefix/02-singapore.jpg',
  ),
  Location(
    name: 'Machu Picchu',
    place: 'Peru',
    imageUrl: '$urlPrefix/03-machu-picchu.jpg',
  ),
  Location(
    name: 'Vitznau',
    place: 'Switzerland',
    imageUrl: '$urlPrefix/04-vitznau.jpg',
  ),
  Location(
    name: 'Bali',
    place: 'Indonesia',
    imageUrl: '$urlPrefix/05-bali.jpg',
  ),
  Location(
    name: 'Mexico City',
    place: 'Mexico',
    imageUrl: '$urlPrefix/06-mexico-city.jpg',
  ),
  Location(
    name: 'Cairo',
    place: 'Egypt',
    imageUrl: '$urlPrefix/07-cairo.jpg',
  ),
];
```


[`CustomPaint`]: {{site.api}}/flutter/widgets/CustomPaint-class.html
[`Flow`]: {{site.api}}/flutter/widgets/Flow-class.html
[`RenderBox`]: {{site.api}}/flutter/rendering/RenderBox-class.html
