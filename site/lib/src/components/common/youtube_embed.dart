// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

class YoutubeEmbed with CustomComponentBase {
  const YoutubeEmbed();

  @override
  Pattern get pattern => RegExp('YouTubeEmbed', caseSensitive: false);

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    final rawVideoId =
        attributes['id'] ??
        (throw Exception('YouTubeEmbed component requires an "id" attribute.'));
    final videoTitle =
        attributes['title'] ??
        (throw Exception(
          'YouTubeEmbed component requires a "title" attribute.',
        ));
    final playlistId = attributes['playlist'];

    final String videoId;
    final int startTime;
    if (rawVideoId.contains('?')) {
      final idAndStartTime = rawVideoId.split('?');
      videoId = idAndStartTime[0];

      final rawStartTime = idAndStartTime[1].split('start=')[1];
      startTime = int.tryParse(rawStartTime) ?? 0;
    } else {
      startTime = 0;
      videoId = rawVideoId;
    }

    // Instead of directly including a YouTube embed iframe,
    // we use https://github.com/justinribeiro/lite-youtube which
    // lazily loads the video, significantly reduces page load times,
    // and enables configurability through element attributes.
    return raw('''
<lite-youtube videoid="$videoId" videotitle="$videoTitle" videoStartAt="$startTime" ${playlistId != null ? 'playlistid="$playlistId"' : ''}>
  <a class="lite-youtube-fallback" href="https://www.youtube.com/watch/$videoId" target="_blank" rel="noopener">Watch on YouTube in a new tab: "$videoTitle"</a>
</lite-youtube>
''');
  }
}
