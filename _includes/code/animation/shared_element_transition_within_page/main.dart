// Expands basic_hero_transition_within_page to create a row of thumbnails.
// Clicking any flies that image to an emulated dialog within the page.
// Defines a curved trajectory for the animation.

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

class HeroTransitionWithinPage extends StatelessWidget {
  Widget makeHero(BuildContext context, String imageName, String desc) {
    return new PhotoHero(
      photo: imageName,
      width: 85.0,
      onTap: () {
        Navigator.of(context).push(new PageRouteBuilder<Null>(
          opaque: false,
          barrierDismissible: true,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return new SizedBox.expand(
              child: new Container(
                padding: const EdgeInsets.all(32.0),
                alignment: FractionalOffset.center,
                child: new SizedBox(
                  width: 350.0,
                  height: 400.0,
                  child: new AnimatedBuilder(
                    animation: new CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn,
                    ),
                    builder: (BuildContext context, Widget child) {
                      return new Opacity(
                        opacity: animation.value,
                        child: new Card(
                          elevation: 8.0,
                          child: new Center(
                            child: new Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                new PhotoHero(
                                  photo: imageName,
                                  width: 225.0,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new Text(
                                  desc,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold),
                                  textScaleFactor: 3.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));
      },
    );
  }

  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 is normal animation speed.

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Hero Transition Within Page'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        color: Colors.blue[50], // Main page has blue background
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                makeHero(context, 'images/backpack-alpha.png', 'Backpack'),
                makeHero(context, 'images/flippers-alpha.png', 'Flippers'),
                makeHero(context, 'images/surfboard-alpha.png', 'Surfboard'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new HeroTransitionWithinPage()));
}
