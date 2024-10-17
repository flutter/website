import 'package:flutter/material.dart';

// #docregion FilterSelector
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
// #enddocregion FilterSelector

@immutable
class ExampleInstagramFilterSelection extends StatefulWidget {
  const ExampleInstagramFilterSelection({super.key});

  @override
  State<ExampleInstagramFilterSelection> createState() =>
      _ExampleInstagramFilterSelectionState();
}

class _ExampleInstagramFilterSelectionState
    extends State<ExampleInstagramFilterSelection> {
  final _filterColor = ValueNotifier<Color>(Colors.white);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      // #docregion Stack
      child: Stack(
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
      // #enddocregion Stack
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
