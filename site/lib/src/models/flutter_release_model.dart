// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_web/js_interop.dart';

/// Represents a Flutter release loaded from the Flutter releases endpoint.
class FlutterRelease {
  static final RegExp _dartSdkBuildPattern = RegExp(r'\(build\s(.*?)\)');

  FlutterRelease({
    required this.url,
    required this.version,
    required this.channel,
    required this.dartSdkVersion,
    required this.architecture,
    required this.hash,
    required this.releaseDate,
  });

  factory FlutterRelease.fromJson(Map<String, Object?> json, String baseUrl) {
    final dartSdkVersion = switch (json['dart_sdk_version']) {
      final String rawDartSdkVersion when rawDartSdkVersion.isNotEmpty =>
        _dartSdkBuildPattern.firstMatch(rawDartSdkVersion)?.group(1) ??
            rawDartSdkVersion.trim(),
      _ => '-',
    };

    return FlutterRelease(
      url: '$baseUrl/${json['archive'] as String}',
      version: json['version'] as String,
      channel: json['channel'] as String,
      dartSdkVersion: dartSdkVersion,
      architecture: (json['dart_sdk_arch'] as String?) ?? 'x64',
      hash: (json['hash'] as String).substring(0, 7),
      releaseDate: Date(Date.parse(json['release_date'] as String)),
    );
  }

  final String url;
  final String version;
  final String channel;
  final String dartSdkVersion;
  final String architecture;
  final String hash;
  final Date releaseDate;

  static const baseReleasesUrl =
      'https://storage.googleapis.com/flutter_infra_release/releases/';

  static final Map<String, Future<List<FlutterRelease>>>
  _flutterReleasesFutures = {};

  /// Fetches Flutter release JSON for the given OS and caches the result.
  static Future<List<FlutterRelease>> fetchFlutterReleases(String os) {
    return _flutterReleasesFutures[os] ??= http
        .get(Uri.parse('${baseReleasesUrl}releases_$os.json'))
        .then((response) {
          if (response.statusCode == 200) {
            final releases = jsonDecode(response.body) as Map<String, Object?>;
            final baseUrl = releases['base_url'] as String;
            final releasesList = releases['releases'] as List<Object?>;
            return releasesList.map((release) {
              return FlutterRelease.fromJson(
                release as Map<String, Object?>,
                baseUrl,
              );
            }).toList();
          } else {
            throw Exception('Failed to load Flutter releases');
          }
        });
  }
}

/// The JavaScript Date object.
///
/// Used for formatting dates on the client side, as a
/// lightweight alternative to depending on the 'intl' package.
extension type Date._(JSObject date) implements JSObject {
  external Date(int date);

  external static int parse(String dateString);

  external String toLocaleDateString();
  external int valueOf();
}
