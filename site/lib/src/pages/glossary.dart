// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/common/button.dart';
import '../components/common/card.dart';
import '../components/pages/glossary_search_section.dart';
import '../markdown/markdown_parser.dart';
import '../util.dart';

/// Different types of resources that glossary terms might link to.
enum ResourceType {
  term,
  article,
  tutorial,
  apiDoc,
  video,
  code,
  diagnostic,
  external;

  /// The ID of the material symbol icon associated with each resource type.
  String get icon => switch (this) {
    term => 'dictionary',
    tutorial => 'school',
    apiDoc => 'description',
    video => 'play_arrow',
    code => 'code_blocks',
    diagnostic => 'lightbulb',
    external => 'open_in_new',
    _ => 'article',
  };

  /// Retrieve the most relevant [ResourceType] that
  /// corresponds to the [type] string.
  static ResourceType fromString(String? type) => switch (type?.toLowerCase()) {
    'term' || 'glossary' => ResourceType.term,
    'article' || 'doc' => ResourceType.article,
    'tutorial' => ResourceType.tutorial,
    'api' => ResourceType.apiDoc,
    'video' => ResourceType.video,
    'code' || 'sample' => ResourceType.code,
    'diagnostic' || 'lint' => ResourceType.diagnostic,
    'external' => ResourceType.external,
    _ => ResourceType.article,
  };
}

/// Represents a single glossary entry with all its metadata.
@immutable
final class GlossaryEntry {
  const GlossaryEntry({
    required this.term,
    required this.shortDescription,
    required this.id,
    this.longDescription,
    this.relatedLinks = const [],
    this.labels = const [],
    this.alternate = const [],
  });

  final String term;
  final String shortDescription;
  final String id;
  final String? longDescription;
  final List<RelatedLink> relatedLinks;
  final List<String> labels;
  final List<String> alternate;
}

/// Represents a related link for a glossary entry.
@immutable
final class RelatedLink {
  const RelatedLink({
    required this.text,
    required this.link,
    this.type = ResourceType.article,
  });

  final String text;
  final String link;
  final ResourceType type;
}

/// Represents a complete glossary with multiple entries.
@immutable
final class Glossary {
  const Glossary({required this.entries});

  /// The entries to include in the glossary. One for each term.
  final List<GlossaryEntry> entries;

  /// Create a [Glossary] from parsed data.
  ///
  /// Expects the format used by `src/data/glossary.yml`.
  factory Glossary.fromList(List<Object?> rawData) {
    final entries = <GlossaryEntry>[];

    for (final item in rawData) {
      if (item is Map<String, Object?>) {
        final term = item['term'] as String?;
        final shortDescription = item['short_description'] as String?;

        if (term != null && shortDescription != null) {
          final relatedLinks = <RelatedLink>[];
          final rawLinks = item['related_links'] as List<Object?>?;

          if (rawLinks != null) {
            for (final link in rawLinks) {
              if (link is Map<String, Object?>) {
                relatedLinks.add(
                  RelatedLink(
                    text: link['text'] as String,
                    link: link['link'] as String,
                    type: ResourceType.fromString(link['type'] as String?),
                  ),
                );
              }
            }
          }

          entries.add(
            GlossaryEntry(
              term: term,
              shortDescription: shortDescription,
              id: item['id'] as String? ?? slugify(term),
              longDescription: item['long_description'] as String?,
              relatedLinks: relatedLinks,
              labels:
                  (item['labels'] as List<Object?>?)?.cast<String>() ??
                  const [],
              alternate:
                  (item['alternate'] as List<Object?>?)?.cast<String>() ??
                  const [],
            ),
          );
        }
      }
    }

    // Sort entries alphabetically by term.
    entries.sort(
      (a, b) => a.term.toLowerCase().compareTo(b.term.toLowerCase()),
    );

    return Glossary(entries: entries);
  }
}

/// A glossary component that displays a
/// searchable list of terms and definitions.
final class GlossaryIndex extends StatelessComponent {
  const GlossaryIndex([this.glossaryData]);

  /// The raw glossary data to display. If `null`, the data will be
  /// loaded from the 'glossary.yml' file.
  final List<Object?>? glossaryData;

  @override
  Component build(BuildContext context) {
    final glossary = Glossary.fromList(
      glossaryData ?? context.page.data['glossary'] as List<Object?>,
    );
    return Component.fragment(
      [
        p([
          text(
            'The following are definitions of terms used '
            'across the Flutter documentation.',
          ),
        ]),
        const GlossarySearchSection(),
        section(id: 'content-search-results', [
          div(classes: 'card-list', [
            for (final entry in glossary.entries) GlossaryCard(entry: entry),
          ]),
        ]),
      ],
    );
  }
}

final class GlossaryCard extends StatelessComponent {
  const GlossaryCard({
    super.key,
    required this.entry,
  });

  final GlossaryEntry entry;

  @override
  Component build(BuildContext context) {
    final cardId = entry.id;
    final contentId = '$cardId-content';

    final partialMatches = [
      entry.term.toLowerCase(),
      ...entry.labels,
    ].join(' ');
    final fullMatches = entry.alternate.map((e) => e.toLowerCase()).join(',');

    return Card.expandable(
      id: cardId,
      outlined: true,
      filled: true,
      additionalClasses: 'glossary-card',
      attributes: {
        'data-partial-matches': partialMatches,
        'data-full-matches': fullMatches,
      },
      header: [
        h2(classes: 'card-title', [text(entry.term)]),
        div(classes: 'card-header-buttons', [
          Button(
            href: '#$cardId',
            icon: 'tag',
            style: ButtonStyle.text,
            classes: const ['share-button'],
            title: 'Link to card',
            attributes: {
              'aria-label': 'Link to ${entry.term} card',
            },
          ),
          Button(
            icon: 'keyboard_arrow_up',
            style: ButtonStyle.text,
            classes: const ['expand-button'],
            title: 'Expand or collapse card',
            attributes: {
              'aria-expanded': 'true',
              'aria-controls': contentId,
              'aria-label': 'Expand or collapse ${entry.term} card',
            },
          ),
        ]),
      ],
      collapsedContent: [
        if (entry.shortDescription.isNotEmpty)
          DashMarkdown(content: entry.shortDescription, inline: true),
      ],
      expandedContent: [
        if (entry.longDescription case final longDescription?)
          DashMarkdown(content: longDescription),

        if (entry.relatedLinks.isNotEmpty)
          div([
            h3(classes: 'no_toc details-header', [
              text('Related docs and resources'),
            ]),
            ul(classes: 'resources-list', [
              for (final resource in entry.relatedLinks)
                li([
                  Button(
                    href: resource.link,
                    content: parseMarkdownToHtml(resource.text, inline: true),
                    icon: resource.type.icon,
                    style: ButtonStyle.filled,
                    asRaw: true,
                  ),
                ]),
            ]),
          ]),
      ],
    );
  }
}
