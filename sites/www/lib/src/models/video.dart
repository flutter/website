// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/// A video that can be displayed in a video carousel or card.
abstract class Video {
  const Video({required this.title, required this.description});

  /// Title shown above the video card.
  final String title;

  /// Short description shown below the title.
  final String description;

  /// URL where the video can be watched.
  String get watchUrl;

  /// URL of the thumbnail image to display.
  String get thumbnailUrl;
}

/// A [Video] hosted on YouTube, identified by its video [id].
class YouTubeVideo extends Video {
  const YouTubeVideo({
    required this.id,
    required super.title,
    required super.description,
    String? thumbnailUrl,
    // Keep the public parameter aligned with the `thumbnailUrl` getter.
    // ignore: prefer_initializing_formals
  }) : _thumbnailUrl = thumbnailUrl;

  /// The YouTube video ID (the value after `watch?v=`).
  final String id;

  final String? _thumbnailUrl;

  @override
  String get watchUrl => 'https://www.youtube.com/watch?v=$id';

  @override
  String get thumbnailUrl =>
      _thumbnailUrl ?? 'https://i.ytimg.com/vi/$id/hqdefault.jpg';
}
