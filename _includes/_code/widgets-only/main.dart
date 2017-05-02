// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This app doesn't use any material widgets, such as Scaffold.
// Normally, an app that doesn't use Scaffold has a black background
// and the default text color is black. This app changes its background
// to white and its text color to dark grey to mimic a material app.
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: new Center(
        child: new Text('Hello World',
            style: new TextStyle(fontSize: 40.0, color: Colors.black87)),
      ),
    );
  }
}
