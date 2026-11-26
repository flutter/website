// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';

import 'package:flutter_website/main.server.options.dart';
import 'package:flutter_website/src/layouts/blog_layout.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/blog.dart';
import 'package:site_shared/components/blog/blog_index.dart';
import 'package:site_shared/components/utils/define_component.dart';
import 'package:test/test.dart';

void main() {
  late final ContentApp app;
  setUpAll(() {
    Jaspr.initializeApp(options: defaultServerOptions);
    app = ContentApp.custom(
      loaders: [
        FilesystemLoader('content', filterExtensions: {'.md'}),
      ],
      eagerlyLoadAllPages: true,
      configResolver: PageConfig.all(
        dataLoaders: [
          FilesystemDataLoader('content'),
          AssetManager(directory: 'content').dataLoader,
        ],
        parsers: const [MarkdownParser()],
        components: [defineComponent('BlogIndex', const BlogIndex())],
        // Posts are listed first to verify they don't claim the index.
        layouts: [BlogPostLayout(), BlogIndexLayout()],
        secondaryOutputs: const [BlogAtomFeedOutput()],
      ),
    );
  });

  Future<String> render(String path) async {
    final response = await renderComponent(
      app,
      request: Request('GET', Uri.parse('https://flutter.dev$path')),
    );
    return utf8.decode(response.body);
  }

  test('the blog index lists posts in its own layout', () async {
    final page = await render('/blog');

    expect(page, contains('<title>The Flutter Blog</title>'));
    expect(page, contains('class="blog-card'));
    expect(page, isNot(contains('post-content')));
  });

  test('the blog index serves Atom XML at the feed URL', () async {
    final feed = await render(blogAtomFeedPath);

    expect(feed, startsWith('<?xml'));
    expect(feed, contains('<feed xmlns="http://www.w3.org/2005/Atom">'));
    expect(feed, contains('<entry>'));
  });
}
