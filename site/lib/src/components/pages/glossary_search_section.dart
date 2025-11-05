// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../common/search.dart';

@client
class GlossarySearchSection extends StatefulComponent {
  const GlossarySearchSection({super.key});

  @override
  State<GlossarySearchSection> createState() => _GlossarySearchSectionState();
}

class _GlossarySearchSectionState extends State<GlossarySearchSection> {
  String searchQuery = '';

  final glossaryCards = <web.HTMLElement>[];

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // Waiting until after the frame is only needed for tests, since there
      // the cards are not pre-rendered. Does not affect the real app.
      context.binding.addPostFrameCallback(() {
        final cards = web.document
            .getElementById('content-search-results')
            ?.querySelectorAll('.card');
        if (cards == null) return;

        for (var i = 0; i < cards.length; i++) {
          final card = cards.item(i) as web.HTMLElement;
          glossaryCards.add(card);
        }
      });
    }
  }

  void filterCards() {
    final searchTerm = searchQuery.trim().toLowerCase();

    List<String> getMatches(web.HTMLElement elem, String name) =>
        elem.attributes.getNamedItem('data-$name')?.value.split(',') ?? [];

    for (final card in glossaryCards) {
      final matchPartially = getMatches(card, 'partial-matches');
      final matchExactly = getMatches(card, 'full-matches');

      if (matchPartially.any((m) => m.contains(searchTerm))) {
        card.classList.remove('hidden');
        continue;
      }

      if (matchExactly.any((m) => m == searchTerm)) {
        card.classList.remove('hidden');
        continue;
      }

      card.classList.add('hidden');
    }
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'filter-and-search', [
      SearchBar(
        placeholder: 'Search terms...',
        label: 'Search terms by name...',
        value: searchQuery,
        onInput: (value) {
          setState(() {
            searchQuery = value;
          });
          filterCards();
        },
      ),
    ]);
  }
}
