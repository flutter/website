---
title: "Why you should smoke-test your sample code, and how to do it in Flutter"
description: "Learn why sample apps need smoke tests and how to use Flutter widget tests with Travis CI to catch breakages on every change and across Flutter releases."
publishDate: 2018-06-06
author: filiph
image: images/1khKciHLLdyG1gIY3qmwbLw.webp
category: tutorial
layout: blog
---

*[ If you’re already convinced that you want to smoke-test your Flutter samples, you can skip to “Smoke-testing Flutter” below. What follows is a general guideline applicable to any technology. ]*

<DashImage figure src="images/1khKciHLLdyG1gIY3qmwbLw.webp" />


When learning any new technology, sooner or later developers want to look at sample code. Not just a few lines, either. Often, they want to see a whole project and how it’s assembled.

That, by itself, means that any library, framework or SDK needs to maintain a number of sample apps. But there’s more.

Samples are most useful when they’re focused. A classic mistake is to ram everything-there-is-to-know into a single sample app. That’s easier for the author (only one app to create and maintain) but unhelpful for the newcomer. Nobody learns *everything at once*.

With any sufficiently-complex technology, the developer first wants to see some code sample of the basics (“hello world”), then maybe a small app (TodoMVC, HN app), and then focused samples according to their needs (networking, parallelism, animation, etc.). The idea is that they never need to try and comprehend multiple hard concepts at once.

(Yes, very complex, real-world samples are valuable. But, generally speaking, not for beginners or intermediate developers. They are great for when you already know much of the technology, so you can navigate your way around the complex sample, and identify the parts that are relevant to you at the time.)

For the author of the samples, that means a lot of self-contained little apps. Which in turn means many code repositories. And any of these can (and will) get out of date, sooner or later.

<DashImage figure src="images/1TLJOrUTMNXDYLtEHhpk0fg.jpeg" />


You don’t want sample code to go out of date. For a developer, there are few things more frustrating than getting excited about a new technology, trying to run a sample app, and seeing it fail.

So, to summarize:

* A good sample coverage calls for a lot of independent sample apps. For the sake of argument, let’s say we have **100** independent sample apps.

* Every single sample app needs to be kept maintained. If there is any major breakage coming down the line, we should know about this as soon as possible.

What to do? Here are some options:

### Do nothing

Errors in samples get caught by the community sooner or later, but by the time you get to know about them, they will have done damage. This does not only lead to frustration of the people who find the breakage, but it will most likely be widely reported sooner or later, leading to damaged reputation of your project.

You will be shocked (*shocked!*) to learn that this is *by far* the most widely used option for sample repos.

### Test manually

Some poor soul is tasked to manually check the 100 samples every time there’s a new version of the underlying technology.

Many teams do this, and you can probably imagine how that goes, or at least how that keeps the pressure on having significantly *less* than 100 samples.

### Perform static analysis in Continuous Integration (CI)

For strongly typed languages, this is already way better than the previous option. But static analysis doesn’t catch all breakages. An app with no static errors can still fail to build, or crash at runtime.

<DashImage figure src="images/1bRHZis_QLJmRF-ieQUVlCg.jpeg" />


### Full unit testing in CI

Unit testing is indispensable, but not a good tool for this particular job. Most code samples have trivial logic (e.g. “this function always returns 42”) — not really worth testing. Also, few technologies change in a way that breaks your individual *unit* tests — so it’s not really what you want to test. You want to test that the sample app, when put together, works.

But of course, if you can spare the resources to unit test everything, awesome.

### Full functional / integration testing in CI

This is the best option *if* you have the time and resources. Which—let’s face it—you don’t. Not for 100 different sample repos.

If you can manage, then this is obviously fantastic. You verify that the app not only statically checks and compiles, but also that it runs in a real-world-ish environment. (While we’re in the mode of dreaming: let’s test the sample apps under all supported operating systems and both on real devices and in emulators.)

### Put samples directly in the tech’s repository

When you have your samples developed (and tested) in the same repo as the technology they’re “sampling” (like Flutter does with the [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)), there is no chance they’ll go out of date. When the underlying technology changes in a way that breaks the sample, the build goes red and the development team is highly motivated to get the example code fixed.

The problem is that you can’t do this with too many samples. That would slow development. Also, more often than not, you depend with your samples on technologies that you don’t own, so you can’t just put the sample in the same repo.

## Smoke testing

The term “smoke test” comes from hardware. It’s the first line of Quality Assurance: “[when you turn a device on, does smoke come out of the device?](https://en.wikipedia.org/wiki/Smoke_testing_(electrical))” If so, there’s no need for more in-depth testing.

The term has taken on a broader meaning. Smoke tests are, basically, very quick and incomplete functional or integration tests. Some call them sanity checks.

Smoke tests take your code, build it, run it, and verify a thing or two. They will not verify that your software is 100% functional and correct. In a production app, they will act as a quick bail out — if the smoke test fails, the whole build fails. And it does so quickly.

My point is that, for a sample app, smoke test is often all you need.

### Recommendation:

1. Every sample app, however small, comes with a smoke test.

1. The smoke test can be very short, but it should open all screens and test at least one major piece of functionality.

1. The smoke test is performed by your CI tool on every commit to the sample repo (incl. pull requests).

1. The smoke test is *also* run periodically (e.g. once a week) to check that it’s still in sync with the underlying technology (which may have updated).

1. The CI runs the smoke test against both the current stable version of the underlying technology, and the development version. (The latter will give you an early warning of coming breakages.)

1. You (or the team responsible for the sample) subscribe to CI notifications.

1. You show the CI badge (red or green build) in the sample’s README.

*[ This marks the end of the general part of this post. Continue only if you care about how to implement this with your Flutter samples, on Travis. ]*

<DashImage figure src="images/1KfSxgSjmEBFAJQwExa18hA.jpeg" />


## Smoke-testing Flutter sample apps on Travis CI

The good news is that Flutter provides a really good testing framework: [flutter.io/testing](https://flutter.io/testing/). It has capabilities and convenience features for unit tests, widget tests, and integration tests.

Given unlimited time and resources, you’d want to use full integration testing. That means running your sample apps on a device, or at least in the iOS Simulator / Android Emulator. Thanks to `FlutterDriver`, that’s [easier than you’d think](https://flutter.io/testing/#writing-integration-tests), but still — it requires you to install an Emulator, run it, connect to it, and so on, for every commit. For most Flutter samples out there, this is overkill.

Instead, you want to use a *widget* test. Remember: in Flutter, everything is a widget, and that applies for your whole app as well. You can easily widget-test your whole app. Like so:

```dart
testWidgets('smoke test', (WidgetTester tester) async {
  final app = MyApp();
  await tester.pumpWidget(app);

  expect(find.text("0"), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text("1"), findsOneWidget);
});
```


This test runs completely headless, and, on my work laptop, it completes in 50 milliseconds. Yet it simulates the whole Flutter framework.

Just for fun, try to run it as a full app (`flutter run test/smoke_test.dart` instead of the usual `flutter test`), and you’ll see something like this:

<DashImage figure src="images/1UNPFvzQCMU0xbqqbNXUAcw.webp" alt="These are the smoke tests for all the different architectural flavors of our Google I/O talk sample app, running on device with ``flutter run`` (instead of ``flutter test``). You should be able to see “Redux”, “ValueNotifier”, “ScopedModel” etc. in the title bar up there. I’m showing this instead of the test shown above because that one finishes way too fast, so there’s not much to look at." caption="These are the smoke tests for all the different architectural flavors of our Google I/O talk sample app, running on device with ``flutter run`` (instead of ``flutter test``). You should be able to see “Redux”, “ValueNotifier”, “ScopedModel” etc. in the title bar up there. I’m showing this instead of the test shown above because that one finishes way too fast, so there’s not much to look at." />


This is useful to visualize your test, and to verify that it’s doing what you think it’s doing.

### .travis.yml

Now that you have a smoke test, let’s configure Travis CI to watch your repo (getting started instructions are [here](https://docs.travis-ci.com/user/getting-started/)) and add the following `.travis.yml` file to the root of your repository. I’ll explain its contents step-by-step below. But first, let’s see the whole file:

```yaml
os:
  - linux
sudo: false
addons:
  apt:
    sources:
      - ubuntu-toolchain-r-test
    packages:
      - libstdc++6
      - fonts-droid
git:
  depth: 3
cache:
  directories:
    - $HOME/.pub-cache
env:
  - FLUTTER_VERSION=beta
  - FLUTTER_VERSION=dev
matrix:
  allow_failures:
    - env: FLUTTER_VERSION=dev
before_script:
  - git clone [https://github.com/flutter/flutter.git](https://github.com/flutter/flutter.git) -b $FLUTTER_VERSION
  - ./flutter/bin/flutter doctor
script:
  - ./flutter/bin/flutter test
```


The lines at the top—everything between `os` and `fonts-droid`—are needed for any Flutter testing. [Yegor has a write-up](https://medium.com/flutter-io/test-flutter-apps-on-travis-3fd5142ecd8c) if you want to learn more.

I tend to add the `git:` depth option — it tells Travis to fetch the latest few git versions of your app, instead of the whole history of your repo.

Another optional but useful configuration is `cache`. It can make your builds faster while saving resources for the fabulous people at Travis.

Then, we have this:

```yaml
env:
  - FLUTTER_VERSION=beta
  - FLUTTER_VERSION=dev
```


This tells Travis to run two separate builds: one with the custom variable `FLUTTER_VERSION` set to `beta` (stable builds of Flutter), and one with it set to `dev` (~nightly builds of Flutter). These two builds run in parallel. We’ll use the variable below.

Next, we allow the `FLUTTER_VERSION=dev` build to fail using Travis’ [build matrix functionality](https://docs.travis-ci.com/user/customizing-the-build#Build-Matrix):

```yaml
matrix:
  allow_failures:
    - env: FLUTTER_VERSION=dev
```


It’s good to know whether our sample works with the bleeding edge version of Flutter, but we don’t want to paint our sample red whenever it fails there. Consider the`FLUTTER_VERSION=dev` build to be an early warning system for breaking changes. It might tell us about things that are coming to Flutter that we should fix, or prepare to fix, in our sample. But there can be false positives here—it’s a bleeding edge channel, after all.

Next, we actually use the `$FLUTTER_VERSION` variable when installing Flutter:

```yaml
before_script:
  - git clone [https://github.com/flutter/flutter.git](https://github.com/flutter/flutter.git) -b $FLUTTER_VERSION
```


Git fetches the branch specified with `-b`, which in our case is either `beta` or `dev`.

Still in `before_script`, we run `flutter doctor`. This is to make sure the Flutter installation is sound.

```yaml
  - ./flutter/bin/flutter doctor
```


Note that we didn’t add the `flutter` tool to `$PATH`, so we’re accessing it via the full path. That’s just a matter of personal preference.

Lastly, we actually run the test:

```yaml
script:
  - ./flutter/bin/flutter test
```


Nice! You can commit the `.travis.yml` file to your repository, push it to github, head over to [travis-ci.org](https://travis-ci.org/), and voilà:

<DashImage figure src="images/1PF95FgsvYP71V5_5c0DMpA.gif" alt="Notice the two jobs, one of which is “Allowed Failure”." caption="Notice the two jobs, one of which is “Allowed Failure”." />


The build runs for about 2 minutes, most of which is installation (the test itself takes a few seconds at most).

### Run the test periodically

Now, we don’t only want the build to run on every commit or PR (the default with Travis+GitHub) but also periodically. After all, most of the time when samples get broken, it’s not because someone changed them, but because the underlaying technology changed under them.

We can use Travis’ [“Cron Job” feature](https://docs.travis-ci.com/user/cron-jobs/). Just head over to [travis-ci.org](https://travis-ci.org/) and set it up.

<DashImage figure src="images/1H2OK-1btsNZfUcu57PTsPQ.webp" />


### Set up notifications

By default, Travis will send you an email any time the build fails. But I highly recommend to [check the settings for these notifications](https://docs.travis-ci.com/user/notifications/). Not only can you make sure that the right person or team is notified, but you can also set up fancy stuff like IRC or Slack alerts.

### Add badge

Last but not least, add the build badge to your sample’s README.md. Head over to Travis again, and click on the badge icon. It’ll give you the code to use.

<DashImage figure src="images/1qWrX4tkqykAQHW3kSkuo8g.webp" />


Paste this to the top of your README.md. Then commit, push, and behold:

<DashImage figure src="images/1am1D-P1vH_f6y1Q-9dgCdw.webp" />


Congratulations. Your sample code is now smoke tested.
