// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'material_icon.dart';

/// A search bar component, such as used on the glossary page.
class SearchBar extends StatelessComponent {
  const SearchBar({
    required this.placeholder,
    required this.label,
    this.value,
    this.onInput,
  });

  final String placeholder;
  final String label;
  final String? value;
  final void Function(String)? onInput;

  @override
  Component build(BuildContext context) => div(classes: 'search-row', [
    div(classes: 'search-wrapper', [
      const MaterialIcon('search', classes: ['leading-icon']),
      input(
        type: InputType.search,
        value: value,
        attributes: {
          'placeholder': placeholder,
          'aria-label': label,
        },
        onInput: onInput != null ? (value) => onInput!(value as String) : null,
      ),
    ]),
  ]);
}
