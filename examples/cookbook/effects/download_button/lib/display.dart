import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

// #docregion Display
@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.status,
    this.transitionDuration = const Duration(
      milliseconds: 500,
    ),
  });

  final DownloadStatus status;
  final Duration transitionDuration;

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  @override
  Widget build(BuildContext context) {
    return ButtonShapeWidget(
      transitionDuration: transitionDuration,
      isDownloaded: _isDownloaded,
      isDownloading: _isDownloading,
      isFetching: _isFetching,
    );
  }
}

@immutable
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget({
    super.key,
    required this.isDownloading,
    required this.isDownloaded,
    required this.isFetching,
    required this.transitionDuration,
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    final ShapeDecoration shape;
    if (isDownloading || isFetching) {
      shape = const ShapeDecoration(
        shape: CircleBorder(),
        color: Colors.transparent,
      );
    } else {
      shape = const ShapeDecoration(
        shape: StadiumBorder(),
        color: CupertinoColors.lightBackgroundGray,
      );
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: const SizedBox(),
    );
  }
}
// #enddocregion Display
