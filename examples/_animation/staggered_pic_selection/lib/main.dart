// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/*
This app arranges its photos (allPhotos) in a list of blocks,
where each block contains an arrangement of a handful of photos
defined by photoBlockFrames.
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Photo {
  const Photo(this.asset, this.id);

  final String asset;
  final int id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

final List<Photo> allPhotos = List<Photo>.generate(30, (index) {
  return Photo('images/pic${index + 1}.jpg', index);
});

class PhotoFrame {
  const PhotoFrame(this.width, this.height);

  final double width;
  final double height;
}

// Defines the app's repeating photo layout "block" in terms of
// photoBlockFrames.length rows of photos.
//
// Each photoBlockFrames[i] item defines the layout of one row of photos
// in terms  of their relative widgets and heights. In a row: widths must
// sum to 1.0, heights must be the same.
const List<List<PhotoFrame>> photoBlockFrames = [
  [PhotoFrame(1.0, 0.4)],
  [PhotoFrame(0.25, 0.3), PhotoFrame(0.75, 0.3)],
  [PhotoFrame(0.75, 0.3), PhotoFrame(0.25, 0.3)],
];

class PhotoCheck extends StatelessWidget {
  const PhotoCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: const Icon(Icons.check, size: 32, color: Colors.white),
    );
  }
}

class PhotoItem extends StatefulWidget {
  const PhotoItem({
    super.key,
    required this.photo,
    this.color,
    this.onTap,
    required this.selected,
  });

  final Photo photo;
  final Color? color;
  final VoidCallback? onTap;
  final bool selected;

  @override
  State<PhotoItem> createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> with TickerProviderStateMixin {
  late final AnimationController _selectController;
  late final Animation<double> _stackScaleAnimation;
  late final Animation<RelativeRect> _imagePositionAnimation;
  late final Animation<double> _checkScaleAnimation;
  late final Animation<double> _checkSelectedOpacityAnimation;

  late final AnimationController _replaceController;
  late final Animation<Offset> _replaceNewPhotoAnimation;
  late final Animation<Offset> _replaceOldPhotoAnimation;
  late final Animation<double> _removeCheckAnimation;

  late Photo _oldPhoto;
  Photo? _newPhoto; // non-null during a remove animation

  @override
  void initState() {
    super.initState();

    _oldPhoto = widget.photo;

    _selectController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    final Animation<double> easeSelection = CurvedAnimation(
      parent: _selectController,
      curve: Curves.easeIn,
    );
    _stackScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(easeSelection);
    _checkScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.25,
    ).animate(easeSelection);
    _checkSelectedOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(easeSelection);
    _imagePositionAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(12.0, 12.0, 12.0, 12.0),
    ).animate(easeSelection);

    _replaceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    final Animation<double> easeInsert = CurvedAnimation(
      parent: _replaceController,
      curve: Curves.easeIn,
    );

    _replaceNewPhotoAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(easeInsert);

    _replaceOldPhotoAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(easeInsert);

    _removeCheckAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _replaceController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _selectController.dispose();
    _replaceController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PhotoItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.photo != oldWidget.photo) {
      _replace(oldWidget.photo, widget.photo);
    }

    if (widget.selected != oldWidget.selected) _select();
  }

  Future<void> _replace(Photo oldPhoto, Photo newPhoto) async {
    try {
      setState(() {
        _oldPhoto = oldPhoto;
        _newPhoto = newPhoto;
      });
      await _replaceController.forward().orCancel;
      setState(() {
        _oldPhoto = newPhoto;
        _newPhoto = null;
        _replaceController.value = 0.0;
        _selectController.value = 0.0;
      });
    } on TickerCanceled {
      // This is never reached...
    }
  }

  void _select() {
    if (widget.selected) {
      _selectController.forward();
    } else {
      _selectController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ClipRect(
            child: SlideTransition(
              position: _replaceOldPhotoAnimation,
              child: Material(
                color: widget.color,
                child: InkWell(
                  onTap: widget.onTap,
                  child: ScaleTransition(
                    scale: _stackScaleAnimation,
                    child: Stack(
                      children: <Widget>[
                        PositionedTransition(
                          rect: _imagePositionAnimation,
                          child: Image.asset(
                            _oldPhoto.asset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: FadeTransition(
                            opacity: _checkSelectedOpacityAnimation,
                            child: FadeTransition(
                              opacity: _removeCheckAnimation,
                              child: ScaleTransition(
                                alignment: Alignment.topLeft,
                                scale: _checkScaleAnimation,
                                child: const PhotoCheck(),
                              ),
                            ),
                          ),
                        ),
                        PositionedTransition(
                          rect: _imagePositionAnimation,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            alignment: Alignment.topRight,
                            child: Text(
                              widget.photo.id.toString(),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRect(
            child: SlideTransition(
              position: _replaceNewPhotoAnimation,
              child:
                  _newPhoto == null
                      ? null
                      : Image.asset(_newPhoto!.asset, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagesDemo extends StatefulWidget {
  const ImagesDemo({super.key});

  @override
  State<ImagesDemo> createState() => _ImagesDemoState();
}

class _ImagesDemoState extends State<ImagesDemo>
    with SingleTickerProviderStateMixin {
  static const double _photoBlockHeight = 576.0;

  int? _selectedPhotoIndex;

  void _selectPhoto(int photoIndex) {
    setState(() {
      _selectedPhotoIndex =
          photoIndex == _selectedPhotoIndex ? null : photoIndex;
    });
  }

  void _removeSelectedPhoto() {
    if (_selectedPhotoIndex == null) return;
    setState(() {
      allPhotos.removeAt(_selectedPhotoIndex!);
      _selectedPhotoIndex = null;
    });
  }

  Widget _buildPhotoBlock(
    BuildContext context,
    int blockIndex,
    int blockFrameCount,
  ) {
    final List<Widget> rows = [];

    var startPhotoIndex = blockIndex * blockFrameCount;
    final photoColor = Colors.grey[500]!;
    for (int rowIndex = 0; rowIndex < photoBlockFrames.length; rowIndex += 1) {
      final List<Widget> rowChildren = [];
      final int rowLength = photoBlockFrames[rowIndex].length;
      for (var frameIndex = 0; frameIndex < rowLength; frameIndex += 1) {
        final frame = photoBlockFrames[rowIndex][frameIndex];
        final photoIndex = startPhotoIndex + frameIndex;
        rowChildren.add(
          Expanded(
            flex: (frame.width * 100).toInt(),
            child: Container(
              padding: const EdgeInsets.all(4),
              height: frame.height * _photoBlockHeight,
              child: PhotoItem(
                photo: allPhotos[photoIndex],
                color: photoColor,
                selected: photoIndex == _selectedPhotoIndex,
                onTap: () {
                  _selectPhoto(photoIndex);
                },
              ),
            ),
          ),
        );
      }
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowChildren,
        ),
      );
      startPhotoIndex += rowLength;
    }

    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 20.0; // 1.0 is normal animation speed.

    // Number of PhotoBlockFrames in each _photoBlockHeight block
    final int photoBlockFrameCount = photoBlockFrames
        .map((l) => l.length)
        .reduce((s, n) => s + n);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _removeSelectedPhoto,
          ),
        ],
      ),
      body: SizedBox.expand(
        child: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemExtent: _photoBlockHeight,
          itemCount: (allPhotos.length / photoBlockFrameCount).floor(),
          itemBuilder: (context, blockIndex) {
            return _buildPhotoBlock(context, blockIndex, photoBlockFrameCount);
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ImagesDemo()));
}
