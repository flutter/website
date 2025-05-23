// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class GridListDemo extends StatelessWidget {
  const GridListDemo({super.key, required this.type});

  final GridListDemoType type;

  static const List<_Photo> _photos = [
    _Photo(
      assetName: 'places/india_chennai_flower_market.png',
      title: 'Chennai',
      subtitle: 'Flower Market',
    ),
    _Photo(
      assetName: 'places/india_tanjore_bronze_works.png',
      title: 'Tanjore',
      subtitle: 'Bronze Works',
    ),
    _Photo(
      assetName: 'places/india_tanjore_market_merchant.png',
      title: 'Tanjore',
      subtitle: 'Market',
    ),
    _Photo(
      assetName: 'places/india_tanjore_thanjavur_temple.png',
      title: 'Tanjore',
      subtitle: 'Thanjavur Temple',
    ),
    _Photo(
      assetName: 'places/india_tanjore_thanjavur_temple_carvings.png',
      title: 'Tanjore',
      subtitle: 'Thanjavur Temple',
    ),
    _Photo(
      assetName: 'places/india_pondicherry_salt_farm.png',
      title: 'Pondicherry',
      subtitle: 'Salt Farm',
    ),
    _Photo(
      assetName: 'places/india_chennai_highway.png',
      title: 'Chennai',
      subtitle: 'Scooters',
    ),
    _Photo(
      assetName: 'places/india_chettinad_silk_maker.png',
      title: 'Chettinad',
      subtitle: 'Silk Maker',
    ),
    _Photo(
      assetName: 'places/india_chettinad_produce.png',
      title: 'Chettinad',
      subtitle: 'Lunch Prep',
    ),
    _Photo(
      assetName: 'places/india_tanjore_market_technology.png',
      title: 'Tanjore',
      subtitle: 'Market',
    ),
    _Photo(
      assetName: 'places/india_pondicherry_beach.png',
      title: 'Pondicherry',
      subtitle: 'Beach',
    ),
    _Photo(
      assetName: 'places/india_pondicherry_fisherman.png',
      title: 'Pondicherry',
      subtitle: 'Fisherman',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Grid view'),
        ),
        body: GridView.count(
          restorationId: 'grid_view_demo_grid_offset',
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
          childAspectRatio: 1,
          children: _photos.map<Widget>((photo) {
            return _GridDemoPhotoItem(photo: photo, tileStyle: type);
          }).toList(),
        ),
      ),
    );
  }
}

class _Photo {
  const _Photo({
    required this.assetName,
    required this.title,
    required this.subtitle,
  });

  final String assetName;
  final String title;
  final String subtitle;
}

/// Allow the text size to shrink to fit in the space.
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  const _GridDemoPhotoItem({required this.photo, required this.tileStyle});

  final _Photo photo;
  final GridListDemoType tileStyle;

  @override
  Widget build(BuildContext context) {
    final Widget image = Semantics(
      label: '${photo.title} ${photo.subtitle}',
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(photo.assetName, fit: BoxFit.cover),
      ),
    );

    return switch (tileStyle) {
      GridListDemoType.imageOnly => image,
      GridListDemoType.header => GridTile(
        header: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            title: _GridTitleText(photo.title),
            backgroundColor: Colors.black45,
          ),
        ),
        child: image,
      ),
      GridListDemoType.footer => GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: _GridTitleText(photo.title),
            subtitle: _GridTitleText(photo.subtitle),
          ),
        ),
        child: image,
      ),
    };
  }
}

enum GridListDemoType { imageOnly, header, footer }

void main() {
  runApp(const GridListDemo(type: GridListDemoType.footer));
}
