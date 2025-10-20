// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:meta/meta.dart';

import '../../util.dart';
import 'archive_table.dart';

@client
class DownloadLatestButton extends StatefulComponent {
  const DownloadLatestButton({required this.os, this.arch, super.key});

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
  Release? latestRelease;

  @awaitNotRequired
  Future<void> loadLatestRelease() async {
    try {
      final releasesData = await ArchiveTable.fetchFlutterReleases(
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
