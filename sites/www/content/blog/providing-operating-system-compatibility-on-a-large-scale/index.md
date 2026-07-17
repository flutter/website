---
title: "Providing operating system compatibility on a large scale"
description: >-
  Flutter’s approach to device diversity in software releases
publishDate: 2021-01-14
author: kf6gpe
image: images/0XGMajBOXRRgyu3Pa.jpg
category: engineering
layout: blog
---

Applications written using Flutter can run on Android, iOS, the web, and desktop operating systems. Because of our investment in supporting multiple platforms, a Flutter application can run on any device with the OS version (or a later version) that the application was written for without needing changes, which broadens Flutter’s cross-platform appeal.

In this article, Flutter’s core development team (we) want to share why we invest in supporting multiple platforms, how we can keep supporting multiple platforms, and how we make decisions when it comes time to add support for new platforms or drop support for old platforms.

## Looking ahead: releases of Android and iOS

Flutter is committed to providing full support for the latest features of Android and iOS. We’re always monitoring the regular guidance from Apple and Google regarding changes in their platform APIs, tool use, and licensing terms. Support for new OS releases is part of our regular product planning, and we attempt to align our releases in such a way that stable releases are always compatible with the latest guidance from both Google and Apple.

Our commitment to you to support multiple platforms and software releases of Android and iOS, such as Android 11 or iOS 14, along with their minor releases. For major revisions to the target platforms, development of necessary features and changes begin as soon as we learn what’s needed. This typically happens in late spring, after Google announces their plans for an upcoming Android release and when Apple makes their latest announcements at their Worldwide Development Conference (WWDC). After the announcements, we assess the necessary changes to the Flutter codebase, like changes to the engine because of potentially deprecated APIs, how tooling changes affect the flutter tool and the developer experience, and changes in the design language for both platforms. We also assess the scope of work with the expectation that both platforms will be available to customers in the early fall.

We do this work against the beta releases of Android and iOS, and we make these changes available regularly through our master, dev, and beta channels. The master channel releases are continual. We plan for two to three releases of the dev channel per week (a version of the master channel tested against internal Google apps and test suites). The beta channel usually releases the first week of every month. We track our progress using GitHub issues. For a list of issues, you can search by `platform-ios` or `platform-android`.

Aligning our stable release schedule with iOS is particularly challenging because often there is very little time between a press announcement and when we get guidance about changes to the OS. We mitigate this challenge by planning one of our releases in the fall, and being prepared to hotfix our current stable release with any blocking bugs on iOS or even on Android should they occur. (This happened with Flutter 1.20 and iOS 14, and we released a [hotfix the same day](https://medium.com/flutter/supporting-ios-14-and-xcode-12-with-flutter-15fe0062e98b) that iOS 14 shipped.)

Regardless of the work it takes to support a new platform release, our goal is to support new versions of our target platforms without deprecating old ones.

## Backward compatibility and Flutter’s value proposition

Flutter is Google’s portable UI toolkit for building beautiful, natively-compiled applications for mobile, web, and desktop from a single codebase. To do this, we want to support the broadest collection of devices we can, not just specific types of platforms. We also want to support the broadest number of platform versions.

Consider Android: By [statcounter](https://gs.statcounter.com/os-version-market-share/android/mobile-tablet/worldwide), as of June 2020, Android versions in the wild consist of the following:

<DashImage figure src="images/0cn2P4AQs91rSOztB.webp" />

Looking at the numbers, Android KitKat (Android 4.x) has less than a 2% market share. The predominant share of Android devices (54%) are running Android Pie (Android 9.0) or Android 10. Supporting each version of Android requires an investment. Do you know why we invest in a platform, like KitKat, that has a low market share?

The answer is simple: raw numbers. With over a billion Android devices in use not running Android Pi or later, we want to ensure that Flutter is as broadly available as possible. We also want to support a diverse, global user base. And, because older versions of Android and iOS are often used by people in developing countries, we want to avoid deprecating support for older versions as long as we can.

Through work in Flutter’s core engine, framework, and plugins, Flutter provides abstractions for the vagaries of both OS platform and OS versions. As an example, a Material application can run on an older version of iOS or Android without being changed. In fact, developers have released commercial Material applications running on hardware that shipped at the same time that the first version of it was made available, something you can’t do on those devices with the widget set that shipped with those devices. A similar story exists for plugins. Plugins abstract away both platform and version differences, leaving you to focus on what’s important: your application.

## How Flutter supports so many targets

Flutter brings two strengths to multiple-target support. First, Flutter relies very little on the underlying OS. Flutter’s engine works directly with the graphics APIs, and plugins provide much of the device-specific implementation for additional features.

Our continuous integration (CI) system builds Flutter and its tooling for macOS, Linux, and Windows, deploying to a suite of Android and iOS devices (both physical and emulated). Some of this CI is done using a lab run on Google’s premises; other CI tests are run on the [Firebase Test Lab](https://firebase.google.com/docs/test-lab), a cloud-hosted test solution operated by Google for both Google and third-party developers.

Here’s a picture of one of the racks in our test lab:

<DashImage figure src="images/0XGMajBOXRRgyu3Pa.jpg" />

We run relatively low-end mobile devices in our device lab, because we do our [performance testing](https://flutter-dashboard.appspot.com/benchmarks.html) there. When testing, we want performance metrics from devices that are representative of what most users have. Doing this gives us worst-case, real-world performance. This philosophy carries over to the devices that the core engineering team uses. Most of the core engineering team isn’t doing Flutter debugging on the latest Google Pixel or Apple iPhone.

Because we want to test many types of mobile devices, we keep a device library where members of the core engineering team can check out specific devices for testing and debugging. (With COVID-19, we’re making good use of the US Postal Service!)

Because the lab can only test a handful of device types and versions, how can we be sure that we’re providing the support we claim? Read on to find out.

## Making general assertions about platform version support

First and foremost, we test on a variety of platforms with each code commit.

In our lab today, we’re testing on the following Android platforms:

* Android API 24 (Android N)

* Android API 28 (Android P)

* Android API 29 (Android 10)

This covers 57% of the market of deployed Android versions; more on how we cover the remaining devices through the use of Firebase Test Lab in a moment.

Our lab also tests iOS on every commit, on devices running:

* iOS 9.3.6

* iOS 12.4

* iOS 12.4.1

* iOS 13.1.3

* iOS 13.2

Finally, for desktop and web, we test every commit on:

* Chrome 84

* Firefox 72.0

* Safari on Catalina

* Edge 1.2.0.0

* Windows 10

* macOS El Capitan

* Debian 10

Clearly there’s more testing that needs to happen on the Android front. We rely on [Firebase Test Lab](https://firebase.google.com/docs/test-lab) for this, testing the following additional Android and iOS configurations:

* Android API 19 (Android K)

* Android API 21 and 22 (Android L)

* Android API 23 (Android M)

* Android API 26 and 27 (Android O)

* Android API 30 (Android 11)

* iOS 11

* iOS 13.0

* iOS 13.1

* iOS 13.3–13.7

* iOS 14

**Together this brings our testing of Android and iOS platforms to well over 95% of the currently released versions.**

For other operating system versions, we provide backward compatibility with **your** support, the Flutter development community. This is especially true of specific device/operating system combinations. Many of you use devices that we don’t have access to: either because you have an operating system version we don’t have, or because the device isn’t available in the US. In some cases, we can mitigate this. For example, we can flash an older Android build on some Google Pixel hardware, buy an older, refurbished iOS device, or run an Android version in an emulator. In many cases, a report from one of you triggered an investigation of a specific platform issue.

This is especially true with a number of original equipment manufacturers (OEMs) of Android devices. OEMs frequently customize aspects of Android like keyboard support. In the past, we’ve been able to fix a number of text input issues that only occur in certain markets on certain devices thanks to your help.

We appreciate your help because we can’t possibly find every issue on our own, but we work hard at reducing the risk of injecting issues. We’re careful when making code changes and pay attention to what’s supported on the earliest version of the operating system. We provide options when we need to support disjointed configurations. That’s why, for example, you can still build iOS applications using either OpenGL or Metal, which Flutter automatically chooses at runtime.

For these reasons —even though we go to great lengths to support testing on OS versions —some of the devices we support are supported on a “best effort” basis. We try to write code that supports the platforms we claim support for, we rely on our team’s commitment to device diversity in ad hoc use, and then look to the community for feedback on how we’re doing in practice.

We need your help with testing devices in the best effort category. There are tens of thousands (or more!) of SKUs in this category. We test as many as we can and, at times, we source older devices from auction sites to enable us to test and fix device issues that were reported when there is no other way to duplicate the issue. If you find an issue with a particular device, please file an issue on GitHub.

Finally, some platforms, such as iOS 7, are deprecated. Perhaps they work, but we do not test on deprecated platforms and make no guarantees. We do, however, consider patches for deprecated platforms on a case-by-case basis if we can support the platforms adequately when testing after the patches land.

Flutter keeps a [web page](https://flutter.dev/docs/development/tools/sdk/release-notes/supported-platforms) of the devices which we test on and those we look to the community for help with.

## Deciding to deprecate support

Although we’re committed to supporting every platform version as long as we can, supporting older platforms (or platform configurations, such as OpenGL on Apple A7) comes with a cost, and follows guidance from our upstream partners, including Skia. Flutter’s core engineering team is relatively small, and we’re continually making trade-offs to ensure that what we do has the most beneficial effect for our users. At some point, the cost in terms of engineering, bandwidth for testing in our CI lab and through ad hoc testing, and technical limitations (such as the deprecation of tooling on the part of an OS vendor) can make it difficult or impossible to continue supporting a target platform.

Before we decide to deprecate support, some of the questions we consider are:

* How many end users would this eliminate for our developers?

* What effect does this have on Flutter developers? Are there major partners whose business operations would be significantly affected?

* What engineering savings are we likely to gain? For example, does the number of applications built with Flutter grow from supporting multiple OS versions? (This is the case, for example, by supporting both OpenGL and Metal in iOS builds.)

* Does the decision align with our broad adoption and inclusivity goals?

* Is the deprecation prompted by an external cause, such as a platform vendor deprecating support for a platform version in their build tooling? If so, is it possible to mitigate that deprecation?

When evaluating whether to deprecate support, we first pose the question to you by starting an issue in GitHub and publishing an associated [Flutter design document](https://flutter.dev/docs/resources/design-docs) that proposes the deprecation, explaining why we’re considering it, and what mitigations might be available. This is a request for comment (RFC) to our community; the public design document is socialized through both our discussion list ([flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)) and our [Discord](https://github.com/flutter/flutter/wiki/Chat).

To begin deprecation, we start the RFC process at the delivery of a stable release, as part of the announcement of the stable release. We then leave time for public comments before reducing support for the platform or feature in the subsequent platform release. The RFC is an opportunity for you to provide feedback. Based on the feedback we receive, we will either move forward with the deprecation, or make changes to the proposal, extending the support for a platform version for a longer period. We take feedback about these prospective decisions very seriously, because we recognize that we have a responsibility to you and your product’s users.

## Request for comment: iOS 8 deprecation

We are considering deprecating support for iOS 8. All iOS 8 devices can be upgraded to iOS 9. According to both Google and third-party analytics, the number of devices running iOS 8 is extremely small (some report “0.0%”), and Apple is gradually deprecating support for iOS 8 in their tooling.

We have published a [request for comment about deprecating iOS 8](https://docs.google.com/document/d/1G5L7ux7ofQp3bCSNAt4ovvL5-8PF_rqo2erAVIcHHeg/edit), and we ask for you to review it and participate in the discussion. Our intention is that Flutter 1.22 (our most recent stable release) will be the last stable release to support iOS 8. The RFC includes both the justification and what to do if you’re affected.

## Request for comment: Android Jelly Bean deprecation

We are considering deprecating support for Android Jelly Bean because we no longer test devices with that version of Android in our lab, and sourcing reliable devices for lab use is increasingly difficult. Devices running Android Jelly Bean comprise some 0.46% of the user base of Android at this point.

We have published a [request for comment about deprecating Android](https://docs.google.com/document/d/1IjlypDrIIGgF2N76P6z8QL2rT5Uuh_rBvqOgDUyhCx8/edit) Jelly Bean, and we ask you to review it and participate in the discussion. Our intention is that Flutter 1.22 (our most recent stable release) will be the last stable release to support Android Jelly Bean. The RFC includes both the justification and what to do if you’re affected.

## How you can help

The easiest way to help is to get involved! We appreciate the issues you file regarding the edge cases on various devices that we haven’t encountered. In many cases, they occurred on hardware that we would never have had, even if we doubled or quadrupled our spending on hardware testing. Reporting these issues with reproducible cases and including details about software versions and hardware models is essential for us to track down the source of a problem.

In addition, we look to you to be involved with the decision making process when the time comes to reduce support for a specific platform. Your insights are invaluable when we consider Flutter’s future. Please participate in our open RFCs when you see one. You are the expert in your particular market, and are closest to your customers.

We deeply appreciate the trust you’ve given us with your users, and letting us be part of your product. We remain committed to helping you paint your vision to life on as many screens as possible.
