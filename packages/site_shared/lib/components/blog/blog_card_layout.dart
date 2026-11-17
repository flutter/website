// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/// The layout of a card in the blog index,
/// determined by its position among the visible cards.
enum BlogCardLayout {
  /// A full-width card with a large image and title,
  /// used to highlight the most prominent post.
  featured,

  /// A bordered tile that's arranged in a grid with other cards.
  grid,

  /// A full-width row with a small image beside the post details.
  list,
  ;

  /// The CSS class applied to a `.blog-card` element to
  /// style it with this layout.
  String get className => switch (this) {
    .featured => 'layout-featured',
    .grid => 'layout-grid',
    .list => 'layout-list',
  };

  /// Returns the layout for the card at the specified [index]
  /// among the visible cards.
  ///
  /// The first card is [featured], the next four are [grid],
  /// and all remaining cards are [list].
  static BlogCardLayout forIndex(int index) => switch (index) {
    0 => featured,
    < 5 => grid,
    _ => list,
  };
}
