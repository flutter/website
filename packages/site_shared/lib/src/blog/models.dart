// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../components/blog/client/blog_categories.dart';

extension type Post(Map<String, Object?> data) {
  static Post parse(
    Map<String, Object?> data, {
    required Iterable<BlogCategory> categories,
    String? source,
  }) {
    final post = tryParse(data);
    final sourceDescription = source == null ? '' : ' at "$source"';
    if (post == null) {
      throw ArgumentError(
        'Missing or invalid required blog post metadata$sourceDescription.',
      );
    }

    final supportedCategories = categories.map((category) => category.slug);
    if (!supportedCategories.contains(post.category)) {
      throw ArgumentError(
        'Unsupported blog post category "${post.category}"'
        '$sourceDescription. Supported categories: '
        '${supportedCategories.join(', ')}.',
      );
    }

    return post;
  }

  static Post? tryParse(Map<String, Object?> data) {
    if (data['title'] is! String ||
        data['description'] is! String ||
        data['publishDate'] is! String ||
        data['category'] is! String ||
        !_isValidAuthorProperty(data['author'])) {
      return null;
    }
    return Post(data);
  }

  String get title => data['title'] as String;
  String get description => data['description'] as String;
  String? get image => data['image'] as String?;
  String get publishDate => data['publishDate'] as String;

  DateTime get dateObject => DateTime.parse(publishDate);
  String get formattedDate => DateFormat.yMMMd().format(dateObject);

  List<String> get authorIds => switch (data['author']) {
    final String authorId => [authorId],
    final List<Object?> authorIds => authorIds.cast<String>(),
    _ => throw ArgumentError(
      'Post author is neither a string nor a list of strings for "$title".',
    ),
  };

  String get readingTime => data['readingTime'] as String? ?? '5 min read';
  String get category => data['category'] as String;
}

extension type Author(Map<String, Object?> data) {
  String get name => data['name'] as String;
  String? get image => data['image'] as String?;
  String? get imageUrl => data['imageUrl'] as String?;
  String? get link => data['link'] as String?;

  String? resolveImageUrl(BuildContext context) {
    if (image case final localImage? when localImage.isNotEmpty) {
      return context.resolveAsset('/blog/authors/$localImage');
    }
    if (imageUrl case final url? when url.isNotEmpty) {
      return url;
    }
    return null;
  }
}

extension BlogData on Page {
  Map<String, Object?> get blogData {
    if (data['blog'] case {'data': final Map<String, Object?> data}) {
      return data;
    } else {
      throw ArgumentError('Missing or invalid blog data.');
    }
  }

  List<BlogCategory> get blogCategories {
    final categories = blogData['categories'];
    if (categories is! List<Object?>) {
      throw ArgumentError('Missing or invalid blog categories');
    }
    return categories
        .map((c) => BlogCategory.fromMap(c as Map<String, Object?>))
        .toList();
  }

  String get blogAtomSubscribeTitle {
    if (blogData case {'atom': {'subscribeTitle': final String title}}) {
      return title;
    } else {
      throw Exception('Missing or invalid blog atom subscribe title.');
    }
  }

  /// Returns the author with the specified [id].
  Author authorById(String id) {
    final authors = (data['blog'] as Map<String, Object?>)['authors'];
    if (authors is! Map<String, Object?>) {
      throw Exception('Authors data not found or invalid.');
    }

    final author = authors[id];
    if (author == null) {
      throw Exception('Author not found: $id');
    }
    if (author is! Map<String, Object?>) {
      throw Exception('Author data not found or invalid: $id');
    }
    return Author(author);
  }

  /// Returns the authors with the specified [ids].
  List<Author> authorsByIds(List<String> ids) => [
    for (final id in ids) authorById(id),
  ];
}

/// Whether [author] is a valid author configuration:
/// either a single author ID or a non-empty list of author IDs.
bool _isValidAuthorProperty(Object? author) {
  return switch (author) {
    final String authorId => authorId.isNotEmpty,
    final List<Object?> authorIds =>
      authorIds.isNotEmpty &&
          authorIds.every(
            (authorId) => authorId is String && authorId.isNotEmpty,
          ),
    _ => false,
  };
}
