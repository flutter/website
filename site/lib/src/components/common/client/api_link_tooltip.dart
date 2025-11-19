// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:jaspr/jaspr.dart';
import 'package:meta/meta.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../tooltip.dart';

@client
class ApiLinkTooltip extends StatefulComponent {
  const ApiLinkTooltip({required this.url, required this.text, super.key});

  final String url;
  final String text;

  @override
  State<ApiLinkTooltip> createState() => _ApiLinkTooltipState();
}

class _ApiLinkTooltipState extends State<ApiLinkTooltip> {
  Component? tooltipContent;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      setupTooltip();
    }
  }

  @awaitNotRequired
  Future<void> setupTooltip() async {
    final (extractedHeader, extractedDescription) = await scrapeApiDocs(
      component.url,
    );

    if (extractedHeader == null && extractedDescription == null) {
      return;
    }

    if (!mounted) return;
    setState(() {
      tooltipContent = fragment([
        if (extractedHeader != null)
          span(classes: 'tooltip-header', [raw(extractedHeader)]),
        if (extractedDescription != null)
          span(classes: 'tooltip-content', [raw(extractedDescription)]),
      ]);
    });
  }

  @override
  Component build(BuildContext context) {
    return Tooltip(
      target: a(href: component.url, [
        code([text(component.text)]),
      ]),
      content: tooltipContent,
    );
  }
}

const contentId = 'dartdoc-main-content';
// This seems to be a good limit to avoid overly small or large tooltips.
const maxDescriptionLength = 400;
const minTrailingParagraphLength = 20;

@awaitNotRequired
Future<(String?, String?)> scrapeApiDocs(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    var content = response.body;

    final startIndex = content.indexOf(RegExp('<div\\s+id="$contentId"'));
    if (startIndex == -1) {
      print(
        'Error fetching API docs for $url: content id "$contentId" not found.',
      );
      return (null, null);
    }
    content = content.substring(startIndex);

    final element =
        web.document.createElement('template') as web.HTMLTemplateElement;
    element.innerHTML = content.toJS;
    final fragment = element.content;

    final header = fragment.querySelector('#$contentId div h1');
    final description = fragment.querySelector(
      '#$contentId section.desc',
    );

    // Remove any feature badge from the header (like "abstract" or "final").
    final featureBadges = header?.querySelectorAll('.feature');
    if (featureBadges != null) {
      for (var i = 0; i < featureBadges.length; i++) {
        final featureBadge = featureBadges.item(i);
        featureBadge?.parentNode?.removeChild(featureBadge);
      }
    }
    // Limit description to not exceed <maxDescriptionLength> characters.
    // This only removes full paragraphs and does not truncate individual ones.
    var charCount = 0;
    if (description != null) {
      final children = description.childNodes;
      var removeFrom = -1;
      for (var i = 0; i < children.length; i++) {
        final child = children.item(i)!;

        if (child.instanceOfString('HTMLHeadingElement')) {
          // Stop at any headings.
          removeFrom = i;
          break;
        }

        if (child.textContent?.startsWith('See also') == true) {
          // Stop at "See also" sections.
          removeFrom = i;
          break;
        }

        if (!child.instanceOfString('HTMLParagraphElement')) {
          // Skip non-paragraph elements (such as video embeds, code snippets).
          description.removeChild(child);
          i--;
          continue;
        }

        charCount += child.textContent?.length ?? 0;

        if (charCount > maxDescriptionLength) {
          removeFrom = i;
          break;
        }
      }

      // Remove any extra paragraphs beyond the max characters.
      if (removeFrom > 0) {
        while (children.length > removeFrom) {
          description.removeChild(children.item(children.length - 1)!);
        }

        // If the last paragraph is very short, remove it as well.
        // This avoids having trailing "See also" or similar.
        while (children.length > 1 &&
            (children.item(children.length - 1)!.textContent?.length ?? 0) <
                minTrailingParagraphLength) {
          description.removeChild(children.item(children.length - 1)!);
        }
      }

      // Append a "Read more" link to the full docs.
      description.appendChild(
        web.document.createElement('a')
          ..setAttribute('href', url)
          ..textContent = 'Read more.',
      );
    }

    return (
      (header?.innerHTML as JSString?)?.toDart,
      (description?.innerHTML as JSString?)?.toDart,
    );
  } catch (e) {
    print('Error fetching API docs for $url: $e');
    return (null, null);
  }
}
