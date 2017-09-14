// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Extends shared_element_transition example to show:
// - Puts a rounded border on the image.
// - Sets the time dilation to 20, which greatly slows the animation.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

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
            child: new FittedBox(
              fit: BoxFit.contain,
              child: new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(8.0),
                  border: new Border.all(
                    color: Colors.blue,
                    width: 8.0,
                  ),
                ),
                child: new Image.asset(
                  photo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SampleTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 1.0; //20.0; // 1.0 means normal animation speed.

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Main Page'),
      ),
      body: new Center(
        child: new PhotoHero(
          photo: 'images/curly.jpg',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: const Text('Detail Page'),
                ),
                body: new Container(
                  // Use background color to emphasize that it's a new page.
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  alignment: FractionalOffset.topLeft,
                  child: new PhotoHero(
                    photo: 'images/curly.jpg',
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new SampleTwo()));
}
