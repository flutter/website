// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/visibility_observer.dart';
import '../common/icon.dart';

/// The "Built for the AI era" section.
///
/// The Dash and Gemini sprite starts looping once it scrolls into view, so the
/// section hydrates on the client.
@client
class WhyFlutterAiEraSection extends StatefulComponent {
  const WhyFlutterAiEraSection({required this.geminiSprite, super.key});

  /// Resolved URL of the Dash and Gemini sprite sheet.
  ///
  /// Resolved by the page rather than here, so that this component — which
  /// hydrates on the client — never imports the server-only asset helpers.
  final String geminiSprite;

  @override
  State<WhyFlutterAiEraSection> createState() => _WhyFlutterAiEraSectionState();
}

class _WhyFlutterAiEraSectionState extends State<WhyFlutterAiEraSection> {
  static const _capabilities = ['MCP Server', 'GenUI', 'LLM-fluent'];

  bool _isSpriteRunning = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-flutter-gemini', () {
      setState(() => _isSpriteRunning = true);
    });
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'ai-era', classes: 'module why-flutter-ai', [
      div(classes: 'why-flutter-row container', [
        div(classes: 'why-flutter-ai-copy', [
          const h2([.text('Built for the AI era')]),
          const p(classes: 'why-flutter-body', [
            .text(
              'Flutter provides a scalable foundation for AI-powered '
              'experiences, making it easy to integrate agentic features and '
              'evolve your product.',
            ),
          ]),
          div(classes: 'why-flutter-chips', [
            for (final capability in _capabilities)
              _CapabilityChip(label: capability),
          ]),
        ]),
        div(classes: 'why-flutter-ai-media', [
          div(
            id: 'why-flutter-gemini',
            classes: [
              'why-flutter-gemini-sprite',
              if (_isSpriteRunning) 'is-running',
            ].join(' '),
            styles: Styles(
              raw: {
                '--why-flutter-sprite': 'url(${component.geminiSprite})',
              },
            ),
            const [],
          ),
        ]),
      ]),
    ]);
  }
}

/// A single capability chip with a teal check mark.
class _CapabilityChip extends StatelessComponent {
  const _CapabilityChip({required this.label});

  final String label;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-flutter-chip', [
      const div(classes: 'why-flutter-chip-check', [Icon(symbol: 'check')]),
      span([.text(label)]),
    ]);
  }
}
