// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a factored animation with AnimatedBuilder.

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new FlutterLogo());
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(curve);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new GrowTransition(child: new LogoWidget(), animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(new LogoApp());
}
