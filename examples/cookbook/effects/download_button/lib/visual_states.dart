import 'package:flutter/material.dart';

// #docregion VisualStates
enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.status,
    this.transitionDuration = const Duration(
      milliseconds: 500,
    ),
  }) : super(key: key);

  final DownloadStatus status;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    // TODO: We'll add more to this later.
    return const SizedBox();
  }
}
// #enddocregion VisualStates
