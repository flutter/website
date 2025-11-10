// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:meta/meta.dart';

import '../../../models/flutter_release_model.dart';

@client
class DownloadLatestButton extends StatefulComponent {
  const DownloadLatestButton({required this.os, this.arch, super.key});

  /// Creates a [DownloadLatestButton] from a set of attributes parsed
  /// from markdown.
  factory DownloadLatestButton.fromAttributes(Map<String, String> attributes) {
    final os =
        attributes['os'] ??
        (throw Exception(
          'DownloadLatestButton component requires an "os" attribute.',
        ));
    final arch = attributes['arch'];
    return DownloadLatestButton(
      os: os.toLowerCase(),
      arch: arch?.toLowerCase(),
    );
  }

  final String os;
  final String? arch;

  @override
  State<DownloadLatestButton> createState() => _DownloadLatestButtonState();
}

class _DownloadLatestButtonState extends State<DownloadLatestButton> {
  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      loadLatestRelease();
    }
  }

  bool isLoading = true;
  String? error;
  FlutterRelease? latestRelease;

  @awaitNotRequired
  Future<void> loadLatestRelease() async {
    try {
      final releasesData = await FlutterRelease.fetchFlutterReleases(
        component.os,
      );
      final filteredReleases = releasesData.where(
        (release) {
          return release.channel == 'stable' &&
              (component.arch == null ||
                  release.architecture == component.arch);
        },
      );

      setState(() {
        latestRelease = filteredReleases.firstOrNull;
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
    if (!isLoading && error == null && latestRelease == null) {
      return const Component.empty();
    }
    return a(
      href: latestRelease?.url ?? '#',
      classes: 'filled-button',
      [
        if (isLoading)
          text('(loading...)')
        else if (error != null)
          text('(failed)')
        else if (latestRelease case final latestRelease?)
          text(latestRelease.url.split('/').last),
      ],
    );
  }
}
