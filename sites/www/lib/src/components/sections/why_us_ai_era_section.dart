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
class WhyUsAiEraSection extends StatefulComponent {
  const WhyUsAiEraSection({required this.geminiSprite, super.key});

  /// Resolved URL of the Dash and Gemini sprite sheet.
  ///
  /// Resolved by the page rather than here, so that this component — which
  /// hydrates on the client — never imports the server-only asset helpers.
  final String geminiSprite;

  @override
  State<WhyUsAiEraSection> createState() => _WhyUsAiEraSectionState();
}

class _WhyUsAiEraSectionState extends State<WhyUsAiEraSection> {
  static const _capabilities = ['MCP Server', 'GenUI', 'LLM-fluent'];

  bool _isSpriteRunning = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-us-gemini', () {
      setState(() => _isSpriteRunning = true);
    });
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'ai-era', classes: 'module why-us-ai', [
      div(classes: 'why-us-row container', [
        div(classes: 'why-us-ai-copy', [
          const h2([.text('Built for the AI era')]),
          const p(classes: 'why-us-body', [
            .text(
              'Flutter provides a scalable foundation for AI-powered '
              'experiences, making it easy to integrate agentic features and '
              'evolve your product.',
            ),
          ]),
          div(classes: 'why-us-chips', [
            for (final capability in _capabilities)
              _CapabilityChip(label: capability),
          ]),
        ]),
        div(classes: 'why-us-ai-media', [
          div(
            id: 'why-us-gemini',
            classes: [
              'why-us-gemini-sprite',
              if (_isSpriteRunning) 'is-running',
            ].join(' '),
            styles: Styles(
              raw: {
                '--why-us-sprite': 'url(${component.geminiSprite})',
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
    return div(classes: 'why-us-chip', [
      const div(classes: 'why-us-chip-check', [Icon(symbol: 'check')]),
      span([.text(label)]),
    ]);
  }
}
