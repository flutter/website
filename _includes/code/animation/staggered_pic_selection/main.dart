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
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final Photo typedOther = other;
    return id == typedOther.id;
  }

  @override
  int get hashCode => id.hashCode;
}

final List<Photo> allPhotos = new List<Photo>.generate(30, (int index) {
  return new Photo('images/pic${index+1}.jpg', index);
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
final List<List<PhotoFrame>> photoBlockFrames = [
  [const PhotoFrame(1.0, 0.4)],
  [const PhotoFrame(0.25, 0.3), const PhotoFrame(0.75, 0.3)],
  [const PhotoFrame(0.75, 0.3), const PhotoFrame(0.25, 0.3)],
];

class PhotoCheck extends StatelessWidget {
  const PhotoCheck({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: new BorderRadius.all(const Radius.circular(16.0)),
      ),
      child: const Icon(
        Icons.check,
        size: 32.0,
        color: Colors.white,
      ),
    );
  }
}

class PhotoItem extends StatefulWidget {
  PhotoItem({
    Key key,
    this.photo,
    this.color,
    this.onTap,
    this.selected,
  }) : super(key: key);

  final Photo photo;
  final Color color;
  final VoidCallback onTap;
  final bool selected;

  @override
  _PhotoItemState createState() => new _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> with TickerProviderStateMixin {

  AnimationController _selectController;
  Animation<double> _stackScaleAnimation;
  Animation<RelativeRect> _imagePositionAnimation;
  Animation<double> _checkScaleAnimation;
  Animation<double> _checkSelectedOpacityAnimation;

  AnimationController _replaceController;
  Animation<Offset> _replaceNewPhotoAnimation;
  Animation<Offset> _replaceOldPhotoAnimation;
  Animation<double> _removeCheckAnimation;

  Photo _oldPhoto;
  Photo _newPhoto; // non-null during a remove animation

  @override
  void initState() {
    super.initState();

    _oldPhoto = widget.photo;

    _selectController = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );
    final Animation<double> easeSelection = new CurvedAnimation(
      parent: _selectController,
      curve: Curves.easeIn,
    );
    _stackScaleAnimation = new Tween<double>(begin: 1.0, end: 0.85).animate(easeSelection);
    _checkScaleAnimation = new Tween<double>(begin: 0.0, end: 1.25).animate(easeSelection);
    _checkSelectedOpacityAnimation = new Tween<double>(begin: 0.0, end: 1.0).animate(easeSelection);
    _imagePositionAnimation = new RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(12.0, 12.0, 12.0, 12.0),
    ).animate(easeSelection);

    _replaceController = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );

    final Animation<double> easeInsert = new CurvedAnimation(
      parent: _replaceController,
      curve: Curves.easeIn,
    );

    _replaceNewPhotoAnimation = new Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(easeInsert);

    _replaceOldPhotoAnimation = new Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(easeInsert);

    _removeCheckAnimation = new Tween<double>(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: _replaceController,
        curve: new Interval(0.0, 0.25, curve: Curves.easeIn),
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

    if (widget.photo != oldWidget.photo)
      _replace(oldWidget.photo, widget.photo);
    if (widget.selected != oldWidget.selected)
      _select();
  }

  Future<Null> _replace(Photo oldPhoto, Photo newPhoto) async {
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
      print('canceled!'); //never reached...
    }
  }

  void _select() {
    if (widget.selected)
      _selectController.forward();
    else
      _selectController.reverse();
  }

  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Positioned.fill(
          child: new ClipRect(
            child: new SlideTransition(
              position: _replaceOldPhotoAnimation,
              child: new Material(
                color: widget.color,
                child: new InkWell(
                  onTap: widget.onTap,
                  child: new ScaleTransition(
                    scale: _stackScaleAnimation,
                    child: new Stack(
                      children: <Widget>[
                        new PositionedTransition(
                          rect: _imagePositionAnimation,
                          child: new Image.asset(
                            _oldPhoto.asset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: new FadeTransition(
                            opacity: _checkSelectedOpacityAnimation,
                            child: new FadeTransition(
                              opacity: _removeCheckAnimation,
                              child: new ScaleTransition(
                                alignment: Alignment.topLeft,
                                scale: _checkScaleAnimation,
                                child: const PhotoCheck(),
                              ),
                            ),
                          ),
                        ),
                        new PositionedTransition(
                          rect: _imagePositionAnimation,
                          child: new Container(
                            margin: const EdgeInsets.all(8.0),
                            alignment: Alignment.topRight,
                            child: new Text(
                              widget.photo.id.toString(),
                              style: new TextStyle(color: Colors.green),
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
        new Positioned.fill(
          child: new ClipRect(
            child: new SlideTransition(
              position: _replaceNewPhotoAnimation,
              child: _newPhoto == null ? null : new Image.asset(
                _newPhoto.asset,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagesDemo extends StatefulWidget {
  @override
  _ImagesDemoState createState() => new _ImagesDemoState();
}

class _ImagesDemoState extends State<ImagesDemo> with SingleTickerProviderStateMixin {
  static const double _photoBlockHeight = 576.0;

  int _selectedPhotoIndex;

  void _selectPhoto(int photoIndex) {
    setState(() {
      _selectedPhotoIndex = photoIndex == _selectedPhotoIndex ? null : photoIndex;
    });
  }

  void _removeSelectedPhoto() {
    if (_selectedPhotoIndex == null)
      return;
    setState(() {
      allPhotos.removeAt(_selectedPhotoIndex);
      _selectedPhotoIndex = null;
    });
  }

  Widget _buildPhotoBlock(BuildContext context, int blockIndex, int blockFrameCount) {
    final List<Widget> rows = [];

    int startPhotoIndex = blockIndex * blockFrameCount;
    final Color photoColor = Colors.grey[500];
    for (int rowIndex = 0; rowIndex < photoBlockFrames.length; rowIndex += 1) {
      final List<Widget> rowChildren = [];
      final int rowLength = photoBlockFrames[rowIndex].length;
      for (int frameIndex = 0; frameIndex < rowLength; frameIndex += 1) {
        final PhotoFrame frame = photoBlockFrames[rowIndex][frameIndex];
        final int photoIndex = startPhotoIndex + frameIndex;
        rowChildren.add(
          new Expanded(
            flex: (frame.width * 100.0).toInt(),
            child: new Container(
              padding: const EdgeInsets.all(4.0),
              height: frame.height * _photoBlockHeight,
              child: new PhotoItem(
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
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowChildren,
        )
      );
      startPhotoIndex += rowLength;
    }

    return new Column(
      children: rows
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 20.0; // 1.0 is normal animation speed.

    // Number of PhotoBlockFrames in each _photoBlockHeight block
    final int photoBlockFrameCount = photoBlockFrames.map((List<PhotoFrame> l) => l.length).reduce((s, n) => s + n);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Images Demo'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.delete),
            onPressed: _removeSelectedPhoto,
          ),
        ],
      ),
      body: new SizedBox.expand(
        child: new ListView.builder(
          padding: new EdgeInsets.all(4.0),
          itemExtent: _photoBlockHeight,
          itemCount: (allPhotos.length / photoBlockFrameCount).floor(),
          itemBuilder: (BuildContext context, int blockIndex) {
            return _buildPhotoBlock(context, blockIndex, photoBlockFrameCount);
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new ImagesDemo()));
}
