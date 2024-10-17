// ignore_for_file: unused_element

import 'package:flutter/material.dart';

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
            child: FilterSelector(
              onFilterChanged: _onFilterChanged,
              filters: _filters,
            ),
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

  // #docregion FilterTapped
  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }
  // #enddocregion FilterTapped

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  // #docregion final-build-carousel
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
                    // #docregion OnFilterTapped
                    child: FilterItem(
                      color: itemColor(index),
                      onFilterSelected: () => () {},
                    ),
                    // #enddocregion OnFilterTapped
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  // #enddocregion final-build-carousel

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

// #docregion filter-item
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
// #enddocregion filter-item
