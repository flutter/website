// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:meta/meta.dart';

import '../../models/flutter_release_model.dart';

@client
class ArchiveTable extends StatefulComponent {
  const ArchiveTable({required this.os, required this.channel, super.key});

  /// Creates an [ArchiveTable] from a set of attributes parsed from markdown.
  factory ArchiveTable.fromAttributes(Map<String, String> attributes) {
    final os =
        attributes['os'] ??
        (throw Exception('ArchiveTable component requires an "os" attribute.'));
    final channel =
        attributes['channel'] ??
        (throw Exception(
          'ArchiveTable component requires a "channel" attribute.',
        ));
    return ArchiveTable(os: os.toLowerCase(), channel: channel.toLowerCase());
  }

  final String os;
  final String channel;

  @override
  State<ArchiveTable> createState() => _ArchiveTableState();
}

class _ArchiveTableState extends State<ArchiveTable> {
  String get os => component.os;
  String get channel => component.channel;

  bool isLoading = true;
  String? error;
  List<FlutterRelease> releases = [];

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
      final releasesData = await FlutterRelease.fetchFlutterReleases(
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
                th(classes: 'date', [text('Release date')]),
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

  Component buildProvenanceLink(FlutterRelease release) {
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
          '${FlutterRelease.baseReleasesUrl}$channel/$os/'
          'flutter_${os}_${release.version}-$channel.'
          '$archiveExtension.intoto.jsonl',
      target: Target.blank,
      [text('Attestation bundle')],
    );
  }
}
