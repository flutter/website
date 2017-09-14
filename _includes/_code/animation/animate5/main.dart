// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate an AnimatedComponent with multiple Tweens

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LogoApp extends AnimatedWidget {
  // We can make the Tweens static because we don't change them.
  static final _opacityTween = new Tween<double>(begin: 1.0, end: 0.3);
  static final _dimensionTween = new Tween<double>(begin: 0.0, end: 300.0);

  LogoApp({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    return new Center(
        child: new Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: new Container(
                margin: new EdgeInsets.symmetric(vertical: 10.0),
                height: _dimensionTween.evaluate(animation),
                width: _dimensionTween.evaluate(animation),
                child: new FlutterLogo(),
),
),);
  }
}

void main() {
  final AnimationController controller = new AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this);
  final Animation<double> animation =
      new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed)
      controller.reverse();
    else if (status == AnimationStatus.dismissed) controller.forward();
  });

  runApp(new LogoApp(animation: animation));
  controller.forward();
}
