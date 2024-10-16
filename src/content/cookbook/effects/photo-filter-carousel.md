---
title: Create a photo filter carousel
description: How to implement a photo filter carousel in Flutter.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/effects/photo_filter_carousel"?>

{% include docs/deprecated.md %}

Everybody knows that a photo looks better with a filter.
In this recipe, you build a scrollable,
filter selection carousel.

The following animation shows the app's behavior:

![Photo Filter Carousel](/assets/images/docs/cookbook/effects/PhotoFilterCarousel.gif){:.site-mobile-screenshot}

This recipe begins with the photo and filters
already in place. Filters are applied with the
`color` and `colorBlendMode` properties of the
[`Image`][] widget.

## Add a selector ring and dark gradient

The selected filter circle is displayed within a
selector ring. Additionally, a dark gradient is
behind the available filters, which helps the contrast 
between the filters and any photo that you choose.

Create a new stateful widget called
`FilterSelector` that you'll use to 
implement the selector.

<?code-excerpt "lib/excerpt1.dart (FilterSelector)"?>
```dart
@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
  });

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
```

Add the `FilterSelector` widget to the existing
widget tree. Position the `FilterSelector` widget
on top of the photo, at the bottom and centered.

<?code-excerpt "lib/excerpt1.dart (Stack)" replace="/^child: //g"?>
```dart
Stack(
  children: [
    Positioned.fill(
      child: _buildPhotoWithFilter(),
    ),
    const Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: FilterSelector(),
    ),
  ],
),
```

Within the `FilterSelector` widget,
display a selector ring on top of a 
dark gradient by using a `Stack` widget.

<?code-excerpt "lib/excerpt2.dart (FilterSelectorState2)"?>
```dart
class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemSize = constraints.maxWidth * _viewportFractionPerItem;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildShadowGradient(itemSize),
            _buildSelectionRing(itemSize),
          ],
        );
      },
    );
  }

  Widget _buildShadowGradient(double itemSize) {
    return SizedBox(
      height: itemSize * 2 + widget.padding.vertical,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

The size of the selector circle and the background gradient
depends on the size of an individual filter in the carousel
called `itemSize`. The `itemSize` depends on the available width.
Therefore, a `LayoutBuilder` widget is used to determine the
available space, and then you calculate the size of an 
individual filter's `itemSize`.

The selector ring includes an `IgnorePointer` widget
because when carousel interactivity is added,
the selector ring shouldn't interfere with 
tap and drag events.

## Create a filter carousel item

Each filter item in the carousel displays a
circular image with a color applied to the image
that corresponds to the associated filter color.

Define a new stateless widget called `FilterItem`
that displays a single list item.

<?code-excerpt "lib/original_example.dart (filter-item)"?>
```dart
@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
  });

  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.network(
              'https://docs.flutter.dev/cookbook/img-files'
              '/effects/instagram-buttons/millennial-texture.jpg',
              color: color.withValues(alpha: 0.5),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
      ),
    );
  }
}
```

## Implement the filter carousel

Filter items scroll to the left and right as the user drags. Scrolling requires 
some kind of `Scrollable` widget. 

You might consider using a horizontal `ListView` widget,
but a `ListView` widget positions the first element at the
beginning of the available space, not at 
the center, where your selector ring sits.

A `PageView` widget is better suited for a carousel.
A `PageView` widget lays out its children from the
center of the available space and provides snapping physics.
Snapping physics is what causes an item to snap to the center, 
no matter where the user releases a drag.

:::note
In cases where you need to customize the
position of child widgets within a scrollable area,
consider using a [`Scrollable`][] widget with a 
[`viewportBuilder`][], and place a
[`Flow`][] widget inside the `viewportBuilder`. 
The `Flow` widget has a [delegate property][]
that allows you to position child widgets wherever
you want, based on the current `viewportOffset`.
:::

Configure your widget tree to make space for the `PageView`.

<?code-excerpt "lib/excerpt3.dart (page-view)"?>
```dart
@override
Widget build(BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    final itemSize = constraints.maxWidth * _viewportFractionPerItem;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildShadowGradient(itemSize),
        _buildCarousel(itemSize),
        _buildSelectionRing(itemSize),
      ],
    );
  });
}

Widget _buildCarousel(double itemSize) {
  return Container(
    height: itemSize,
    margin: widget.padding,
    child: PageView.builder(
      itemCount: widget.filters.length,
      itemBuilder: (context, index) {
        return const SizedBox();
      },
    ),
  );
}
```

Build each `FilterItem` widget within the
`PageView` widget based on the given `index`.

<?code-excerpt "lib/excerpt4.dart (BuildFilterItem)"?>
```dart
Color itemColor(int index) => widget.filters[index % widget.filters.length];

Widget _buildCarousel(double itemSize) {
  return Container(
    height: itemSize,
    margin: widget.padding,
    child: PageView.builder(
      itemCount: widget.filters.length,
      itemBuilder: (context, index) {
        return Center(
          child: FilterItem(
            color: itemColor(index),
            onFilterSelected: () {},
          ),
        );
      },
    ),
  );
}
```

The `PageView` widget displays all of the `FilterItem`
widgets, and you can drag to the left and right.
However, right now each `FilterItem` widget takes 
up the entire width of the screen,
and each `FilterItem` widget is displayed 
at the same size and opacity. There should be
five `FilterItem` widgets on the screen,
and the `FilterItem` widgets need to shrink and
fade as they move farther from the center of the screen.

The solution to both of these issues is to introduce
a `PageViewController`. The `PageViewController`'s
`viewportFraction` property is used to display 
multiple `FilterItem` widgets on the screen at
the same time. Rebuilding each `FilterItem` widget
as the `PageViewController` changes allows you to 
change each `FilterItem` widget's size and opacity
as the user scrolls.

Create a `PageViewController` and connect it to the
`PageView` widget.

<?code-excerpt "lib/excerpt5.dart (page-view-controller)" plaster="none"?>
```dart
class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;

  Color itemColor(int index) => widget.filters[index % widget.filters.length];

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    widget.onFilterChanged(widget.filters[page]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCarousel(double itemSize) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          return Center(
            child: FilterItem(
              color: itemColor(index),
              onFilterSelected: () {},
            ),
          );
        },
      ),
    );
  }
}
```

With the `PageViewController` added, five `FilterItem`
widgets are visible on the screen at the same time,
and the photo filter changes as you scroll, but 
the `FilterItem` widgets are still the same size. 

Wrap each `FilterItem` widget with an `AnimatedBuilder`
to change the visual properties of each `FilterItem`
widget as the scroll position changes.

<?code-excerpt "lib/excerpt6.dart (BuildCarousel)"?>
```dart
Widget _buildCarousel(double itemSize) {
  return Container(
    height: itemSize,
    margin: widget.padding,
    child: PageView.builder(
      controller: _controller,
      itemCount: widget.filters.length,
      itemBuilder: (context, index) {
        return Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FilterItem(
                color: itemColor(index),
                onFilterSelected: () => {},
              );
            },
          ),
        );
      },
    ),
  );
}
```

The `AnimatedBuilder` widget rebuilds every time the
`_controller` changes its scroll position.
These rebuilds allow you to change the `FilterItem`
size and opacity as the user drags.

Calculate an appropriate scale and opacity for each
`FilterItem` widget within the `AnimatedBuilder` and
apply those values.

<?code-excerpt "lib/original_example.dart (final-build-carousel)"?>
```dart
Widget _buildCarousel(double itemSize) {
  return Container(
    height: itemSize,
    margin: widget.padding,
    child: PageView.builder(
      controller: _controller,
      itemCount: widget.filters.length,
      itemBuilder: (context, index) {
        return Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (!_controller.hasClients ||
                  !_controller.position.hasContentDimensions) {
                // The PageViewController isn't connected to the
                // PageView widget yet. Return an empty box.
                return const SizedBox();
              }

              // The integer index of the current page,
              // 0, 1, 2, 3, and so on
              final selectedIndex = _controller.page!.roundToDouble();

              // The fractional amount that the current filter
              // is dragged to the left or right, for example, 0.25 when
              // the current filter is dragged 25% to the left.
              final pageScrollAmount = _controller.page! - selectedIndex;

              // The page-distance of a filter just before it
              // moves off-screen.
              const maxScrollDistance = _filtersPerScreen / 2;

              // The page-distance of this filter item from the
              // currently selected filter item.
              final pageDistanceFromSelected =
                  (selectedIndex - index + pageScrollAmount).abs();

              // The distance of this filter item from the
              // center of the carousel as a percentage, that is, where the selector
              // ring sits.
              final percentFromCenter =
                  1.0 - pageDistanceFromSelected / maxScrollDistance;

              final itemScale = 0.5 + (percentFromCenter * 0.5);
              final opacity = 0.25 + (percentFromCenter * 0.75);

              return Transform.scale(
                scale: itemScale,
                child: Opacity(
                  opacity: opacity,
                  child: FilterItem(
                    color: itemColor(index),
                    onFilterSelected: () => () {},
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
```

Each `FilterItem` widget now shrinks and fades
away as it moves farther from the center of the screen.

Add a method to change the selected filter when a
`FilterItem` widget is tapped.

<?code-excerpt "lib/original_example.dart (FilterTapped)"?>
```dart
void _onFilterTapped(int index) {
  _controller.animateToPage(
    index,
    duration: const Duration(milliseconds: 450),
    curve: Curves.ease,
  );
}
```

Configure each `FilterItem` widget to invoke
`_onFilterTapped` when tapped.

```dart
FilterItem(
  color: itemColor(index),
  onFilterSelected: () => _onFilterTapped,
),
```

Congratulations!
You now have a draggable, tappable photo filter carousel.

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter photo filter carousel hands-on example in DartPad" run="true"
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;

void main() {
  runApp(
    const MaterialApp(
      home: ExampleInstagramFilterSelection(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class ExampleInstagramFilterSelection extends StatefulWidget {
  const ExampleInstagramFilterSelection({super.key});

  @override
  State<ExampleInstagramFilterSelection> createState() =>
      _ExampleInstagramFilterSelectionState();
}

class _ExampleInstagramFilterSelectionState
    extends State<ExampleInstagramFilterSelection> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        return Image.network(
          'https://docs.flutter.dev/cookbook/img-files'
          '/effects/instagram-buttons/millennial-dude.jpg',
          color: color.withValues(alpha: 0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<Color> filters;
  final void Function(Color selectedColor) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;

  Color itemColor(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      initialPage: _page,
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(widget.filters[page]);
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildShadowGradient(itemSize),
                _buildCarousel(
                  viewportOffset: viewportOffset,
                  itemSize: itemSize,
                ),
                _buildSelectionRing(itemSize),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildShadowGradient(double itemSize) {
    return SizedBox(
      height: itemSize * 2 + widget.padding.vertical,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: viewportOffset,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: [
          for (int i = 0; i < filterCount; i++)
            FilterItem(
              onFilterSelected: () => _onFilterTapped(i),
              color: itemColor(i),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselFlowDelegate extends FlowDelegate {
  CarouselFlowDelegate({
    required this.viewportOffset,
    required this.filtersPerScreen,
  }) : super(repaint: viewportOffset);

  final ViewportOffset viewportOffset;
  final int filtersPerScreen;

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;

    // All available painting width
    final size = context.size.width;

    // The distance that a single item "page" takes up from the perspective
    // of the scroll paging system. We also use this size for the width and
    // height of a single item.
    final itemExtent = size / filtersPerScreen;

    // The current scroll position expressed as an item fraction, e.g., 0.0,
    // or 1.0, or 1.3, or 2.9, etc. A value of 1.3 indicates that item at
    // index 1 is active, and the user has scrolled 30% towards the item at
    // index 2.
    final active = viewportOffset.pixels / itemExtent;

    // Index of the first item we need to paint at this moment.
    // At most, we paint 3 items to the left of the active item.
    final min = math.max(0, active.floor() - 3).toInt();

    // Index of the last item we need to paint at this moment.
    // At most, we paint 3 items to the right of the active item.
    final max = math.min(count - 1, active.ceil() + 3).toInt();

    // Generate transforms for the visible items and sort by distance.
    for (var index = min; index <= max; index++) {
      final itemXFromCenter = itemExtent * index - viewportOffset.pixels;
      final percentFromCenter = 1.0 - (itemXFromCenter / (size / 2)).abs();
      final itemScale = 0.5 + (percentFromCenter * 0.5);
      final opacity = 0.25 + (percentFromCenter * 0.75);

      final itemTransform = Matrix4.identity()
        ..translate((size - itemExtent) / 2)
        ..translate(itemXFromCenter)
        ..translate(itemExtent / 2, itemExtent / 2)
        ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
        ..translate(-itemExtent / 2, -itemExtent / 2);

      context.paintChild(
        index,
        transform: itemTransform,
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CarouselFlowDelegate oldDelegate) {
    return oldDelegate.viewportOffset != viewportOffset;
  }
}

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
  });

  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.network(
              'https://docs.flutter.dev/cookbook/img-files'
              '/effects/instagram-buttons/millennial-texture.jpg',
              color: color.withValues(alpha: 0.5),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
      ),
    );
  }
}
```

[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[`Scrollable`]: {{site.api}}/flutter/widgets/Scrollable-class.html
[`viewportBuilder`]: {{site.api}}/flutter/widgets/Scrollable/viewportBuilder.html
[`Flow`]: {{site.api}}/flutter/widgets/Flow-class.html
[delegate property]: {{site.api}}/flutter/widgets/Flow/delegate.html
