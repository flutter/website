// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';
import 'package:youtube_transcript_api/youtube_transcript_api.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln(
      'Usage: dart run tool/get_video_transcript.dart <youtube_url>',
    );
    exit(1);
  }

  final url = args[0];
  final videoId = _youtubeVideoIdFromUrl(url);

  if (videoId == null) {
    stderr.writeln('Error: Could not extract video ID from URL: $url');
    exit(1);
  }

  final api = YouTubeTranscriptApi();
  try {
    final transcriptList = await api.list(videoId);

    Transcript? transcript;

    try {
      transcript = transcriptList.findManuallyCreatedTranscript(['en']);
    } catch (e) {
      try {
        transcript = transcriptList.findGeneratedTranscript(['en']);
      } catch (e) {
        // If there's no English transcript available,
        // take the first available one.
        transcript = transcriptList.firstOrNull;
      }
    }

    if (transcript == null) {
      stderr.writeln('Error: No transcripts found.');
      exit(1);
    }

    final fetchedTranscript = await transcript.fetch();

    for (final entry in fetchedTranscript) {
      print('${_formatTimestamp(entry.start.toInt())} ${entry.text}');
    }
  } catch (e) {
    stderr.writeln('Error fetching transcript: $e');
    exit(1);
  } finally {
    api.dispose();
  }
}

/// Extracts the video ID from the specified YouTube [url].
///
/// Returns `null` if the URL is invalid or doesn't contain a video ID.
String? _youtubeVideoIdFromUrl(String url) {
  if (Uri.tryParse(url) case final uri?) {
    if (uri.host == 'youtu.be') {
      return uri.path.substring(1);
    }
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.path == '/watch') {
        return uri.queryParameters['v'];
      }
      if (uri.path.startsWith('/embed/')) {
        return uri.pathSegments[1];
      }
      if (uri.path.startsWith('/v/')) {
        return uri.pathSegments[1];
      }
    }
  }

  return null;
}

/// Formats the given number of [seconds] as a timestamp in
/// `[MM:SS]` or `[HH:MM:SS]` format.
String _formatTimestamp(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final secs = (seconds % 60).toInt();

  String pad(int n) => n.toString().padLeft(2, '0');

  if (hours > 0) {
    return '[${pad(hours)}:${pad(minutes)}:${pad(secs)}]';
  } else {
    return '[${pad(minutes)}:${pad(secs)}]';
  }
}
