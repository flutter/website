// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Converts the specified [text] into a standardized URL slug
/// that can be used as the ID for headers and other anchors in HTML.
String slugify(String text) => text
    .toLowerCase()
    .trim()
    .replaceAll(_slugifyPunctuationToReplace, '-')
    .replaceAll(_slugifyUnsupportedToRemove, '')
    .replaceAll(_slugifyCharsToCombine, '-')
    .replaceAll(_slugifyHyphenTrim, '');

final RegExp _slugifyPunctuationToReplace = RegExp(r'[:._]');
final RegExp _slugifyUnsupportedToRemove = RegExp(
  r'[^\p{L}\p{N}\s:.-]',
  unicode: true,
);
final RegExp _slugifyCharsToCombine = RegExp(r'[\s-]+');
final RegExp _slugifyHyphenTrim = RegExp(r'^-+|-+$');
