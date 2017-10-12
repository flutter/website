// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

// A "radial transformation" as defined here:
// https://material.io/guidelines/motion/transforming-material.html#transforming-material-radial-transformation

// In this example, the destination route (which completely obscures
// the source route once the page transition has finished),
// displays the Hero image in a Card containing a column of two
// widgets: the image, and some descriptive text.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Photo extends StatelessWidget {
  Photo({ Key key, this.photo, this.color, this.onTap }) : super(key: key);

  final String photo;
  final Color color;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return new Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: new InkWell(
        onTap: onTap,
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return new Image.asset(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  RadialExpansion({
    Key key,
    this.maxRadius,
    this.child,
  }) : clipRectSize = 2.0 * (maxRadius / math.SQRT2),
       super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new ClipOval(
      child: new Center(
        child: new SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: new ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return new Container(
      color: Theme.of(context).canvasColor,
      child: new Center(
        child: new Card(
          elevation: 8.0,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              new SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: new Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: new RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: new Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              new Text(
                description,
                style: new TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, String imageName, String description) {
    return new Container(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: new Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: new RadialExpansion(
          maxRadius: kMaxRadius,
          child: new Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                new PageRouteBuilder<Null>(
                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                    return new AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget child) {
                        return new Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, imageName, description),
                        );
                      }
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/chair-alpha.png', 'Chair'),
            _buildHero(context, 'images/binoculars-alpha.png', 'Binoculars'),
            _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new RadialExpansionDemo()));
}
