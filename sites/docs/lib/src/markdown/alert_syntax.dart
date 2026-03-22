// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:markdown/markdown.dart' as md;

/// A custom Markdown block syntax for alerts that are
/// opened and closed with `:::`.
///
/// Example:
///
/// ```md
/// :::important The title of my alert
/// The content of my alert.
/// :::
/// ```
///
/// This renders as HTML similar to:
/// ```html
/// <aside class="alert alert-important">
///   <div class="alert-header">
///     <span class="material-symbols" aria-hidden="true">important_icon</span>
///     <span>The title of my alert</span>
///   </div>
///   <div class="alert-content">
///     <p>The content of my alert.</p>
///   </div>
/// </aside>
/// ```
final class AlertBlockSyntax extends md.BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^:::([a-zA-Z-]+)(?:\s+(.*))?$');

  const AlertBlockSyntax();

  @override
  bool canParse(md.BlockParser parser) {
    return pattern.hasMatch(parser.current.content);
  }

  @override
  md.Node? parse(md.BlockParser parser) {
    final match = pattern.firstMatch(parser.current.content);
    if (match == null) return null;

    final alertType = _AlertType.fromTypeId(match.group(1)!.toLowerCase());
    var title = match.group(2)?.trim();

    if (title == null || title.isEmpty) {
      title = alertType.defaultTitle;
    }

    // Advance past the opening line.
    parser.advance();

    // Collect content lines until we find the closing :::.
    final contentLines = <String>[];
    while (!parser.isDone) {
      final line = parser.current.content;
      if (line.trim() == ':::') {
        // Consume the closing line.
        parser.advance();
        break;
      }
      contentLines.add(line);
      parser.advance();
    }

    // Create a new BlockParser with the same document context.
    // This preserves link references and other document-level state.
    final contentNodes = md.BlockParser(
      contentLines.map(md.Line.new).toList(growable: false),
      parser.document,
    ).parseLines(parentSyntax: this);

    final alertChildren = <md.Node>[];

    // If title is provided, create and add a header.
    if (title != null && title.isNotEmpty) {
      final headerChildren = <md.Node>[];

      // If the type has a corresponding icon, add it to the header.
      if (alertType.iconId case final iconId?) {
        final iconElement = md.Element('span', [md.Text(iconId)])
          ..attributes['class'] = 'material-symbols'
          ..attributes['translate'] = 'no'
          ..attributes['aria-hidden'] = 'true';
        headerChildren.add(iconElement);
      }

      // Parse the title as inline Markdown to support links, emphasis, etc.
      final titleNodes = parser.document.parseInline(title);
      headerChildren.add(md.Element('span', titleNodes));

      alertChildren.add(
        md.Element('div', headerChildren)..attributes['class'] = 'alert-header',
      );
    }

    final contentElement = md.Element('div', contentNodes)
      ..attributes['class'] = 'alert-content';
    alertChildren.add(contentElement);

    final alertElement = md.Element('aside', alertChildren)
      ..attributes['class'] = 'alert ${alertType.cssClass}';

    return alertElement;
  }
}

/// The supported types of alerts, otherwise known as asides or callouts.
enum _AlertType {
  experimental(
    cssClass: 'alert-warning',
    iconId: 'construction',
    defaultTitle: 'Experimental',
  ),
  note(
    cssClass: 'alert-info',
    iconId: 'info',
    defaultTitle: 'Note',
  ),
  flutterNote(
    cssClass: 'alert-info',
    iconId: 'flutter',
    defaultTitle: 'Flutter note',
  ),
  versionNote(
    cssClass: 'alert-info',
    iconId: 'merge_type',
    defaultTitle: 'Version note',
  ),
  tip(
    cssClass: 'alert-success',
    iconId: 'lightbulb',
    defaultTitle: 'Tip',
  ),
  recommend(
    cssClass: 'alert-success',
    iconId: 'bolt',
    defaultTitle: 'Recommended',
  ),
  important(
    cssClass: 'alert-important',
    iconId: 'feedback',
    defaultTitle: 'Important',
  ),
  warning(
    cssClass: 'alert-warning',
    iconId: 'warning',
    defaultTitle: 'Warning',
  ),
  caution(
    cssClass: 'alert-error',
    iconId: 'error',
    defaultTitle: 'Caution',
  ),
  secondary(
    cssClass: 'alert-secondary',
  );

  /// The CSS class to add to `aside` element
  final String cssClass;

  /// The Material Symbols icon ID to display in the alert header.
  ///
  /// If `null`, no icon is displayed.
  final String? iconId;

  /// The default title to display in the alert header if
  /// no title is explicitly provided in the Markdown.
  ///
  /// If `null`, no title will be displayed if one wasn't explicitly provided.
  final String? defaultTitle;

  const _AlertType({
    required this.cssClass,
    this.iconId,
    this.defaultTitle,
  });

  /// Returns the [_AlertType] corresponding to the given [typeId].
  ///
  /// If the [typeId] does not match any known type,
  /// an [ArgumentError] is thrown.
  static _AlertType fromTypeId(String typeId) => switch (typeId) {
    'experimental' => _AlertType.experimental,
    'note' => _AlertType.note,
    'flutter-note' => _AlertType.flutterNote,
    'version-note' => _AlertType.versionNote,
    'tip' => _AlertType.tip,
    'recommend' => _AlertType.recommend,
    'important' => _AlertType.important,
    'warning' => _AlertType.warning,
    'caution' => _AlertType.caution,
    'secondary' => _AlertType.secondary,
    _ => throw ArgumentError('Unknown alert type: $typeId'),
  };
}
