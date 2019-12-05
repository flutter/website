---
title: ExpansionTile
description: An example that uses ExpansionTiles.
deprecated: true
---

ExpansionTiles can be used to produce two-level or multi-level lists.

<p>
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-4">
        <div class="panel">
          <div class="panel-body">
            <img style="border:1px solid #000000" src="https://storage.googleapis.com/flutter-catalog/cb4a54db8fb3726bf4293b9cc5cb12ce16883803/expansion_tile_sample_small.png" alt="Android screenshot" class="img-fluid">
          </div>
          <!-- <div class="panel-footer">
            Android screenshot
          </div> -->
        </div>
      </div>
    </div>
  </div>
</p>

This app displays hierarchical data with ExpansionTiles. Tapping a tile
expands or collapses the view of its children. When a tile is collapsed
its children are disposed so that the widget footprint of the list only
reflects what's visible.

When displayed within a scrollable that creates its list items lazily,
like a scrollable list created with `ListView.builder()`, ExpansionTiles
can be quite efficient, particularly for Material Design "expand/collapse"
lists.

Try this app out by creating a new project with `flutter create` and
replacing the contents of `lib/main.dart` with the following code.

```dart
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}
```

## See also

* The Material [Lists]({{site.material}}/design/components/lists.html) component page.
* The source code in
  [examples/catalog/lib/expansion_tile_sample.dart]({{site.repo.flutter}}/tree/{{site.branch}}/examples/catalog/lib/expansion_tile_sample.dart).
