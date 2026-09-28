// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:mermaid_core/mermaid_core.dart';

/// Renders a Mermaid diagram as server-generated SVG.
///
/// Both light and dark variants are rendered at build time and included in
/// the page, so CSS can show the variant matching the site's current theme
/// without shipping a Mermaid renderer to the client.
final class MermaidDiagram extends StatelessComponent {
  const MermaidDiagram({required this.diagram, super.key});

  /// The Mermaid diagram definition to render.
  final String diagram;

  @override
  Component build(BuildContext context) {
    final lightSvg = _renderDiagram(theme: MermaidTheme.defaultTheme);
    final darkSvg = _renderDiagram(theme: MermaidTheme.darkTheme);

    return div(
      classes: 'mermaid-container',
      [
        if (lightSvg != null && darkSvg != null) ...[
          div(classes: 'mermaid-theme mermaid-theme-light', [
            RawText(lightSvg),
          ]),
          div(classes: 'mermaid-theme mermaid-theme-dark', [
            RawText(darkSvg),
          ]),
        ] else
          // If rendering fails, preserve the source in a fallback element.
          pre(
            classes: 'mermaid',
            attributes: {'data-source': diagram},
            [.text(diagram)],
          ),
      ],
    );
  }

  /// Renders [diagram] as SVG using the specified [theme].
  String? _renderDiagram({required MermaidTheme theme}) {
    try {
      // Server rendering doesn't have browser text metrics available, so use
      // the library's deterministic approximation when laying out labels.
      final mermaid = Mermaid(
        measurer: const ApproximateTextMeasurer(),
        theme: theme,
      );
      final scene = mermaid.render(diagram);
      return renderSceneToSvg(scene);
    } catch (error) {
      if (kDebugMode) {
        print('Failed to render Mermaid diagram: $error');
      }
      return null;
    }
  }
}
