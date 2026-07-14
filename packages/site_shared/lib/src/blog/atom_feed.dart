// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:xml/xml.dart';

import 'models.dart';

/// The site-relative path the [BlogAtomFeedOutput] publishes the blog feed at.
const String blogAtomFeedPath = '/blog/feed.xml';

/// The MIME type of the published Atom feed.
const String blogAtomMimeType = 'application/atom+xml';

const String _atomNamespace = 'http://www.w3.org/2005/Atom';

final DateFormat _atomDateFormat = DateFormat('yyyy-MM-dd');
final RegExp _blogIndexPattern = RegExp(r'^blog/index\.(md|html)$');

/// A secondary output that generates an Atom feed for the blog.
///
/// Blog posts are pages beneath `/blog/` with a
/// `publishDate` in their frontmatter.
/// Posts that set `atom: false` are excluded.
final class BlogAtomFeedOutput implements SecondaryOutput {
  const BlogAtomFeedOutput();

  @override
  Pattern get pattern => _blogIndexPattern;

  @override
  String createRoute(String _) => blogAtomFeedPath;

  @override
  Component build(Page page) => Builder(
    builder: (context) {
      context.setHeader(
        'Content-Type',
        '$blogAtomMimeType; charset=utf-8',
      );
      context.setStatusCode(
        200,
        responseBody: renderAtomFeed(page, context.pages),
      );
      return const Component.empty();
    },
  );

  /// The Atom feed XML rendered from [blogIndex] and
  /// the candidate [pages] to include as entries.
  @visibleForTesting
  String renderAtomFeed(Page blogIndex, List<Page> pages) {
    final pageData = blogIndex.data;
    final siteUrl = pageData.site['url'];
    if (siteUrl is! String) {
      throw Exception('Site URL not configured in site data.');
    }

    final siteBaseUrl = Uri.parse(siteUrl);
    final feedUrl = siteBaseUrl.resolve(blogAtomFeedPath).toString();
    final blogUrl = siteBaseUrl.resolve('/blog').toString();
    final feedTitle = pageData.page['title'];
    if (feedTitle is! String) {
      throw Exception('Blog index title not configured in page data.');
    }
    final feedDescription = pageData.page['description'];
    if (feedDescription is! String) {
      throw Exception('Blog index description not configured in page data.');
    }

    final String feedAuthor;
    if (blogIndex.blogData case {
      'atom': {'feedAuthor': final String author},
    }) {
      feedAuthor = author;
    } else {
      throw Exception('Blog atom feed author not configured in page data.');
    }

    final (:entries, :feedUpdated) = _entriesFor(siteBaseUrl, pages);

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="utf-8"');
    builder.element(
      'feed',
      namespaces: const {_atomNamespace: ''},
      nest: () {
        builder
          ..writeTextElement('title', feedTitle)
          ..writeTextElement('subtitle', feedDescription)
          ..element('id', nest: feedUrl)
          ..writeLink(
            rel: 'self',
            type: blogAtomMimeType,
            href: feedUrl,
          )
          ..writeLink(rel: 'alternate', type: 'text/html', href: blogUrl)
          ..element('updated', nest: feedUpdated.toIso8601String())
          ..writeAuthor(feedAuthor);

        for (final entry in entries) {
          entry.writeTo(builder);
        }
      },
    );

    return builder.buildDocument().toXmlString(pretty: true, indent: '  ');
  }

  /// The entries to write to the feed alongside the
  /// latest `updated` timestamp across them.
  ({List<_AtomEntry> entries, DateTime feedUpdated}) _entriesFor(
    Uri siteBaseUrl,
    List<Page> pages,
  ) {
    final entries = <_AtomEntry>[];
    DateTime? feedUpdated;

    for (final page in pages) {
      if (!page.url.startsWith('/blog/')) continue;
      final pageData = page.data.page;
      if (pageData['atom'] == false) continue;
      final post = Post.tryParse(pageData);
      if (post == null) continue;

      final published = _atomDateFormat.parseStrict(post.publishDate, true);
      final updated = switch (pageData['updatedDate']) {
        final String updatedDate => _latest(
          _atomDateFormat.parseStrict(updatedDate, true),
          published,
        ),
        _ => published,
      };

      entries.add(
        _AtomEntry(
          url: siteBaseUrl.resolve(page.url).toString(),
          title: post.title,
          summary: post.description,
          authors: [
            for (final author in page.authorsByIds(post.authorIds)) author.name,
          ],
          category: post.category,
          published: published,
          updated: updated,
        ),
      );
      feedUpdated = _latest(feedUpdated, updated);
    }

    if (feedUpdated == null) {
      print(
        'Warning: No blog posts qualified for the Atom feed. '
        'Generated an empty feed.',
      );
    }

    return (
      entries: entries.sorted(),
      feedUpdated: feedUpdated ?? DateTime.utc(1970),
    );
  }
}

/// The rendered representation of a single blog post in the Atom feed.
///
/// Entries sort by [published] descending,
/// with [url] as a tiebreaker so same-day posts have a stable order.
final class _AtomEntry implements Comparable<_AtomEntry> {
  const _AtomEntry({
    required this.url,
    required this.title,
    required this.summary,
    required this.authors,
    required this.published,
    required this.updated,
    this.category,
  });

  /// The absolute URL of the blog post.
  final String url;

  /// The post's title, written to `<title>`.
  final String title;

  /// The post's description, written to `<summary>`.
  final String summary;

  /// The display names of the post's authors.
  final List<String> authors;

  /// The time the post was first published.
  final DateTime published;

  /// The time the post was last updated, or [published] if never updated.
  final DateTime updated;

  /// The post's category slug,
  /// written as the `term` of a `<category>` element,
  /// or `null` if the post has no category.
  final String? category;

  @override
  int compareTo(_AtomEntry other) {
    final byPublished = other.published.compareTo(published);
    if (byPublished != 0) return byPublished;
    return url.compareTo(other.url);
  }

  /// Writes this entry as a complete Atom `<entry>` element to [builder].
  void writeTo(XmlBuilder builder) {
    builder.element(
      'entry',
      nest: () {
        builder
          ..writeTextElement('title', title)
          ..writeLink(rel: 'alternate', type: 'text/html', href: url)
          ..element('id', nest: url)
          ..element('updated', nest: updated.toIso8601String())
          ..element('published', nest: published.toIso8601String());
        for (final author in authors) {
          builder.writeAuthor(author);
        }
        builder.writeTextElement('summary', summary);
        if (category case final category?) {
          builder.element('category', attributes: {'term': category});
        }
      },
    );
  }
}

extension on XmlBuilder {
  /// Writes an Atom text construct (such as `<title>` or `<summary>`) named
  /// [name] with [value] as its text content.
  void writeTextElement(String name, String value) {
    element(name, attributes: const {'type': 'text'}, nest: value);
  }

  /// Writes an Atom `<link>` element with the given [rel], [type], and [href].
  void writeLink({
    required String rel,
    required String type,
    required String href,
  }) {
    element(
      'link',
      attributes: {'rel': rel, 'type': type, 'href': href},
    );
  }

  /// Writes an Atom `<author>` element wrapping a
  /// single `<name>` set to [name].
  void writeAuthor(String name) {
    element('author', nest: () => element('name', nest: name));
  }
}

/// The later of [previous] and [candidate],
/// or [candidate] if [previous] is `null`.
DateTime _latest(DateTime? previous, DateTime candidate) {
  if (previous == null || candidate.isAfter(previous)) {
    return candidate;
  }
  return previous;
}
