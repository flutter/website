---
title: "Test Flutter apps on Travis"
description: >-
  Learn how to run Flutter widget tests on
  Travis CI and catch regressions automatically.
publishDate: 2017-05-24
author: yegorj
category: tutorial
layout: blog
---

One of my favorite features of Flutter is the widget testing framework. It’s fast and reliable. It feels much more like unit testing rather than user interface testing even though it exercises most of what your UI does: build widgets, perform layout, paint, respond to user actions, animate.

Animation is a particularly interesting topic. Advanced animation in modern UI is a norm. There are transitions, hero effects, scrolling, sliding, zooming, and much more. Check out [https://material.io](https://material.io/) for a comprehensive list of what comprises a modern user interface. Flutter implements some of the most demanding UI designs (see [https://github.com/flutter/posse_gallery](https://github.com/flutter/posse_gallery), and [Flutter Gallery](https://play.google.com/store/apps/details?id=io.flutter.gallery&hl=en)). One might assume that this would make reliable testing in Flutter nearly impossible. Surprisingly, the reverse is true. Flutter’s [testing framework](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html) gives you a great level of control over what exactly happens during a frame, animation, transition, or a user action. We run more than 1300 tests on every commit of Flutter, and we rarely see flaky or otherwise unreliable test results.

To start testing, jump over to [https://flutter.io/testing](https://flutter.io/testing/) and create your first test.

However, you would also want to run your tests every time a change is made to your application. This is what continuous integration (CI) systems are for. Some CI systems are hosted: Travis, Drone, AppVeyor, GitLab CI. Some you can install in-house: Jenkins, TeamCity, etc. Every time you commit a change, the CI will build your app and run all the tests. If something fails a good CI system will also notify you.

I’ve used Travis a lot, and I’d like to share how to use it to test Flutter apps.

## A simple app, a simple test

If you already know how to write Flutter tests and are only interested in running them on Travis, feel free to skip to the next section. If not, let’s start with a “Hello, World!” app (lib/main.dart):

```dart
import 'package:flutter/widgets.dart';

main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  build(_) => new Text('Hello, World!');
}

```

Now let’s write a test that verifies that “Hello, World!” does indeed appear on the screen (test/app_test.dart):

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_travis_sample/main.dart';

void main() {
  testWidgets('app should work', (tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}

```

If you run `flutter test` you should see something like:

```plaintext
$ flutter test
00:00 +1: All tests passed!
```

Hurray! Now that we have the test running locally, let’s run it on Travis.

## Travis

To get things going on Travis all you need is add the correct `.travis.yml` to the root of your repository and tell Travis to start a continuous build of your repository by following [their instructions](https://docs.travis-ci.com/user/getting-started). Here I’ll only explain what goes in the `.travis.yml` file. Here’s a Linux example:

```yaml
os:
  - linux
sudo: false
addons:
  apt:
    # Flutter depends on /usr/lib/x86_64-linux-gnu/libstdc++.so.6 version GLIBCXX_3.4.18
    sources:
      - ubuntu-toolchain-r-test # if we don't specify this, the libstdc++6 we get is the wrong version
    packages:
      - libstdc++6
      - fonts-droid-fallback
before_script:
  - git clone https://github.com/flutter/flutter.git -b beta
  - ./flutter/bin/flutter doctor
script:
  - ./flutter/bin/flutter test
cache:
  directories:
    - $HOME/.pub-cache
```

There’s a little bit of boilerplate to setup a Linux environment compatible with Flutter. The important parts are the `before_script` and the `script` sections. The former installs Flutter and runs `flutter doctor` just to make sure everything is setup correctly. The latter runs all the tests, or in our case, the one test we wrote above.

A complete example can be found [here](https://github.com/yjbanov/flutter_travis_sample).

You can also build complete APKs and IPAs for your Flutter apps on Travis, but that’s a post for another time.

Happy coding!
