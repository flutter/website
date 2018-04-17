// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Tap on the source route’s photo to push a new route,
// containing the same photo at a different location and scale.
// Return to the previous route by tapping the image, or by using the
// device’s back-to-the-previous-screen gesture.
// You can slow the transition using the timeDilation property.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      child: new Hero(
        tag: photo,
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            onTap: onTap,
            child: new Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 means normal animation speed.

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: new Center(
        child: new PhotoHero(
          photo: 'images/flippers-alpha.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: new Container(
                    // Set background to blue to emphasize that it's a new route.
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: new PhotoHero(
                      photo: 'images/flippers-alpha.png',
                      width: 100.0,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              }
            ));
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new HeroAnimation()));
}
