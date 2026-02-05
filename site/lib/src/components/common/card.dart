// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../util.dart';

class Card extends StatelessComponent {
  /// Creates a card that can have a [header], [content], and [actions].
  ///
  /// If the card should be collapsible, use [Card.expandable] instead.
  const Card({
    super.key,
    this.header = const [],
    this.content = const [],
    this.actions,
    this.outlined = false,
    this.filled = false,
    this.id,
    this.attributes = const {},
    this.additionalClasses,
    this.link,
  }) : collapsedContent = null,
       expandable = false,
       initiallyExpanded = true;

  /// Creates an expandable card, such as used on the glossary page.
  const Card.expandable({
    super.key,
    this.header = const [],
    required List<Component> expandedContent,
    required this.collapsedContent,
    this.actions,
    this.outlined = false,
    this.filled = false,
    required String this.id,
    this.attributes = const {},
    this.additionalClasses,
    this.initiallyExpanded = true,
  }) : content = expandedContent,
       link = null,
       expandable = true;

  /// Creates a [Card] from a set of attributes parsed from markdown.
  factory Card.fromAttributes(
    Map<String, String> attributes,
    Component? child,
  ) {
    final link = attributes['link'];
    final title =
        attributes['title'] ??
        (throw Exception('Card component requires a "title" attribute.'));
    final outlined = attributes['outlined'] == 'true';
    final additionalClasses = attributes['additional-classes'];
    return Card(
      header: [
        Component.element(
          tag: 'header',
          classes: 'card-title',
          children: [.text(title)],
        ),
      ],
      content: [?child],
      link: link,
      filled: link != null && attributes['filled'] != 'false',
      outlined: outlined,
      additionalClasses: additionalClasses,
    );
  }

  final List<Component> header;
  final List<Component> content;
  final List<Component>? collapsedContent;
  final CardActions? actions;

  final bool outlined;
  final bool filled;
  final bool expandable;
  final String? id;
  final String? link;
  final Map<String, String> attributes;
  final String? additionalClasses;
  final bool initiallyExpanded;

  @override
  Component build(BuildContext context) {
    final classes = [
      'card',
      if (outlined) 'outlined-card',
      if (filled) 'filled-card',
      if (expandable) 'expandable-card',
      if (expandable && !initiallyExpanded) 'collapsed',
      ?additionalClasses,
    ].toClasses;

    final children = [
      if (header.isNotEmpty) div(classes: 'card-header', header),
      if (collapsedContent case final collapsedContent?)
        div(classes: 'initial-content', collapsedContent),
      div(
        id: id != null ? '$id-content' : null,
        classes: [
          'card-content',
          if (expandable) 'expandable-content',
        ].toClasses,
        content,
      ),
      ?actions,
    ];

    if (link case final link?) {
      return a(
        classes: classes,
        id: id,
        href: link,
        attributes: attributes,
        children,
      );
    } else {
      return div(
        classes: classes,
        id: id,
        attributes: attributes,
        children,
      );
    }
  }
}

class CardActions extends StatelessComponent {
  const CardActions({this.leading = const [], this.trailing = const []});

  final List<Component> leading;
  final List<Component> trailing;

  @override
  Component build(BuildContext context) {
    return div(classes: 'card-actions', [
      div(classes: 'leading', leading),
      div(classes: 'trailing', trailing),
    ]);
  }
}
