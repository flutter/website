// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum CardType {
  standard,
  tappable,
  selectable,
}

class TravelDestination {
  const TravelDestination({
    required this.assetName,
    required this.title,
    required this.description,
    required this.city,
    required this.location,
    this.cardType = CardType.standard,
  });

  final String assetName;
  final String title;
  final String description;
  final String city;
  final String location;
  final CardType cardType;
}

const List<TravelDestination> _destinations = [
  TravelDestination(
    assetName: 'places/india_thanjavur_market.png',
    title: 'Top 10 Cities to Visit in Tamil Nadu',
    description: 'Number 10',
    city: 'Thanjavur',
    location: 'Thanjavur, Tamil Nadu',
  ),
  TravelDestination(
    assetName: 'places/india_chettinad_silk_maker.png',
    title: 'Artisans of Southern India',
    description: 'Silk Spinners',
    city: 'Chettinad',
    location: 'Sivaganga, Tamil Nadu',
    cardType: CardType.tappable,
  ),
  TravelDestination(
    assetName: 'places/india_tanjore_thanjavur_temple.png',
    title: 'Brihadisvara Temple',
    description: 'Temples',
    city: 'Thanjavur',
    location: 'Thanjavur, Tamil Nadu',
    cardType: CardType.selectable,
  ),
];

class TravelDestinationItem extends StatelessWidget {
  const TravelDestinationItem({
    super.key,
    required this.destination,
    this.shape,
  });

  // Height that allows for all the Card's contents
  // to fit comfortably within the card.
  static const double height = 360;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SectionTitle(title: 'Normal'),
            SizedBox(
              height: height,
              child: Card(
                // Ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: Semantics(
                  label: destination.title,
                  child: TravelDestinationContent(destination: destination),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappableTravelDestinationItem extends StatelessWidget {
  const TappableTravelDestinationItem({
    super.key,
    required this.destination,
    this.shape,
  });

  // Height that allows for all the Card's contents
  // to fit comfortably within the card.
  static const double height = 298;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SectionTitle(title: 'Tappable'),
            SizedBox(
              height: height,
              child: Card(
                // Ensures that the Card's children (including the ink splash)
                // are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {},
                  splashColor: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.12),
                  highlightColor: Colors.transparent,
                  child: Semantics(
                    label: destination.title,
                    child: TravelDestinationContent(destination: destination),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onSelected,
    this.shape,
  });

  final TravelDestination destination;
  final ShapeBorder? shape;
  final bool isSelected;
  final VoidCallback onSelected;

  // Height that allows for all the Card's contents
  // to fit comfortably within the card.
  static const double height = 298;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String selectedStatus = isSelected ? 'Selected' : 'Not selected';

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SectionTitle(title: 'Selectable (long press)'),
            SizedBox(
              height: height,
              child: Card(
                // Ensures that the Card's children (including the ink splash)
                // are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onLongPress: () {
                    onSelected();
                  },
                  splashColor: colorScheme.onSurface.withValues(alpha: 0.12),
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.08)
                            : Colors.transparent,
                      ),
                      Semantics(
                        label: '${destination.title}, $selectedStatus',
                        onLongPressHint: isSelected ? 'Deselect' : 'Select',
                        child:
                            TravelDestinationContent(destination: destination),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle,
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({super.key, required this.destination});

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineSmall!.copyWith(
      color: Colors.white,
    );
    final descriptionStyle = theme.textTheme.titleMedium!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as
                // part of the Material and display ink effects above it.
                // Using a standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(
                    destination.assetName,
                  ),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Semantics(
                    container: true,
                    header: true,
                    child: Text(
                      destination.title,
                      style: titleStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Semantics(
          container: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: DefaultTextStyle(
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: descriptionStyle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The three line description on each card demo.
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      destination.description,
                      style: descriptionStyle.copyWith(color: Colors.black54),
                    ),
                  ),
                  Text(destination.city),
                  Text(destination.location),
                ],
              ),
            ),
          ),
        ),
        if (destination.cardType == CardType.standard)
          // share, explore buttons
          Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              alignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Share',
                    semanticsLabel: 'Share ${destination.title}',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Explore',
                    semanticsLabel: 'Explore ${destination.title}',
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class CardsDemo extends StatefulWidget {
  const CardsDemo({super.key});

  @override
  State<CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }

  @override
  void dispose() {
    _isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cards'),
        ),
        body: Scrollbar(
          child: ListView(
            restorationId: 'cards_demo_list_view',
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            children: [
              for (final destination in _destinations)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: switch (destination.cardType) {
                    CardType.standard =>
                      TravelDestinationItem(destination: destination),
                    CardType.tappable =>
                      TappableTravelDestinationItem(destination: destination),
                    CardType.selectable => SelectableTravelDestinationItem(
                        destination: destination,
                        isSelected: _isSelected.value,
                        onSelected: () {
                          setState(() {
                            _isSelected.value = !_isSelected.value;
                          });
                        },
                      ),
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const CardsDemo());
}
