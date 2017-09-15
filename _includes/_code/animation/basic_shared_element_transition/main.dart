// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrates a basic hero animation.

import 'package:flutter/material.dart';

class BasicElementTransition extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Main Page'),
      ),
      body: new Center(
        child: new InkWell(
          onTap: () {
            Navigator.of(context).push(
              new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return new Scaffold(
                    appBar: new AppBar(
                      title: const Text('Detail Page'),
                    ),
                    body: new Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: FractionalOffset.topLeft,
                      // Use background color to emphasize that it's a new page.
                      color: Colors.lightBlueAccent,
                      child: new Hero(
                        tag: 'curly',
                        child: new SizedBox(
                          width: 100.0,
                          child: new Image.asset(
                            'images/curly.jpg',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main page
          child: new Hero(
            tag: 'curly',
            child: new Image.asset(
              'images/curly.jpg',
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new BasicElementTransition()));
}
