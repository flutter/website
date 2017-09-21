// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a shared element transition that emulates flying the Hero to a
// dialog, rather than a new page.
//
// The Hero flies from a small tile on the bottom of the page to a popup that
// obscures the middle of the page, and then back.

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

class BasicHeroTransitionWithinPage extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 means normal animation speed.

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Basic Shared Element Transition Within Page'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        color: Colors.blue[50], // Main page has blue background
        child: new PhotoHero(
          photo: 'images/backpack-alpha.png',
          width: 85.0,
          onTap: () {
            Navigator.of(context).push(new PageRouteBuilder<Null>(
                opaque: false,
                barrierDismissible: true,
                pageBuilder: (BuildContext context, Animation<double> _,
                    Animation<double> __) {
                  return new SizedBox.expand(
                    child: new Container(
                      padding: const EdgeInsets.all(32.0),
                      alignment: FractionalOffset.center,
                      child: new SizedBox(
                        width: 350.0,
                        height: 400.0,
                        child: new Card(
                          elevation: 8.0,
                          child: new Center(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                new PhotoHero(
                                  photo: 'images/backpack-alpha.png',
                                  width: 225.0,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new Text(
                                  'Backpack',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 3.0,
                                ),
                              ],
                            ),
                          ),
                        ),
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
  runApp(new MaterialApp(home: new BasicHeroTransitionWithinPage()));
}
