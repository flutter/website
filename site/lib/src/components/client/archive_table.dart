// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr/jaspr.dart';
import 'package:meta/meta.dart';
import 'package:universal_web/js_interop.dart';

class Release {
  Release({
    required this.url,
    required this.version,
    required this.channel,
    required this.dartSdkVersion,
    required this.architecture,
    required this.hash,
    required this.releaseDate,
  });

  factory Release.fromJson(Map<String, Object?> json, String baseUrl) {
    return Release(
      url: '$baseUrl/${json['archive'] as String}',
      version: json['version'] as String,
      channel: json['channel'] as String,
      dartSdkVersion:
          (json['dart_sdk_version'] as String?)?.split(' ')[0] ?? '-',
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
}

const _baseReleasesUrl =
    'https://storage.googleapis.com/flutter_infra_release/releases/';

@client
class ArchiveTable extends StatefulComponent {
  const ArchiveTable({required this.os, required this.channel, super.key});

  final String os;
  final String channel;

  @override
  State<ArchiveTable> createState() => _ArchiveTableState();

  static final Map<String, Future<List<Release>>> _flutterReleasesFutures = {};

  /// Fetches Flutter release JSON for the given OS and caches the result.
  static Future<List<Release>> fetchFlutterReleases(String os) {
    return _flutterReleasesFutures[os] ??= http
        .get(Uri.parse('${_baseReleasesUrl}releases_$os.json'))
        .then((response) {
          if (response.statusCode == 200) {
            final releases = jsonDecode(response.body) as Map<String, Object?>;
            final baseUrl = releases['base_url'] as String;
            final releasesList = releases['releases'] as List<Object?>;
            return releasesList.map((release) {
              return Release.fromJson(release as Map<String, Object?>, baseUrl);
            }).toList();
          } else {
            throw Exception('Failed to load Flutter releases');
          }
        });
  }
}

class _ArchiveTableState extends State<ArchiveTable> {
  String get os => component.os;
  String get channel => component.channel;

  bool isLoading = true;
  String? error;
  List<Release> releases = [];

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      loadReleases();
    }
  }

  @awaitNotRequired
  Future<void> loadReleases() async {
    try {
      final releasesData = await ArchiveTable.fetchFlutterReleases(
        component.os,
      );
      final filteredReleases = releasesData
          .where((release) => release.channel == channel)
          .toList();

      setState(() {
        releases = filteredReleases;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      p([
        text('Select from the following scrollable list:'),
      ]),
      div(classes: 'scrollable-table table-wrapper', [
        table(
          id: 'downloads-$os-$channel',
          classes: 'table table-striped',
          [
            thead([
              tr([
                th([text('Flutter version')]),
                th([text('Architecture')]),
                th([text('Ref')]),
                th(classes: 'date', [text('Release Date')]),
                th([text('Dart version')]),
                th([text('Provenance')]),
              ]),
            ]),
            tbody([
              if (isLoading)
                tr(classes: 'loading', [
                  td(attributes: {'colspan': '6'}, [text('Loading...')]),
                ])
              else if (error != null)
                tr(classes: 'error', [
                  td(
                    attributes: {'colspan': '6'},
                    [
                      text(
                        'Failed to load releases. Refresh page to try again.',
                      ),
                    ],
                  ),
                ])
              else
                for (final release in releases)
                  tr([
                    td([
                      a(href: release.url, [
                        text(release.version),
                      ]),
                    ]),
                    td([
                      span([text(release.architecture)]),
                    ]),
                    td([
                      span(classes: 'git-hash', [text(release.hash)]),
                    ]),
                    td(classes: 'date', [
                      text(
                        release.releaseDate.toLocaleDateString(),
                      ),
                    ]),
                    td([
                      span([text(release.dartSdkVersion)]),
                    ]),
                    td([
                      buildProvenanceLink(release),
                    ]),
                  ]),
            ]),
          ],
        ),
      ]),
    ]);
  }

  static final windowsCutoff = Date.parse('4/3/2023');
  static final otherOsCutoff = Date.parse('12/15/2022');

  Component buildProvenanceLink(Release release) {
    final dateValue = release.releaseDate.valueOf();

    if (os == 'windows' && dateValue < windowsCutoff) {
      // Provenance not available before 4/3/2023 for Windows
      return span([text('-')]);
    } else if (dateValue < otherOsCutoff) {
      // Provenance not available before 12/15/2022 for macOS and Linux
      return span([text('-')]);
    }

    final archiveExtension = os == 'linux' ? 'tar.xz' : 'zip';
    return a(
      href:
          '$_baseReleasesUrl$channel/$os/flutter_${os}_${release.version}-$channel.$archiveExtension.intoto.jsonl',
      target: Target.blank,
      [text('Attestation bundle')],
    );
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
