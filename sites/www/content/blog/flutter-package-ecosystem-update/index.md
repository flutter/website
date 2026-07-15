---
title: "Flutter Package Ecosystem Update"
description: "New Flutter Favorites, Apple Sign In and bringing prerelease Flutter plugins into production"
publishDate: 2020-05-20
author: csells
image: images/0jAThFFycWDnklih_.webp
category: announcements
layout: blog
---

### New Flutter Favorites, Apple Sign In, and bringing prerelease Flutter plugins into production

The Flutter team at Google has exactly one job: to unblock developers building beautiful, native applications across multiple platforms. When Flutter was new, the team accomplished that goal by focusing on a few initial customers. This resulted in the production of a portable rendering engine for text and graphics. Next up was to expand its reach, which the team accomplished by appealing to developers with a fast workflow combining the power of the Dart platform, Flutter APIs designed for ease-of-use, and native compilation across Android and iOS. As the customer base grew, so did their needs, motivating the team to leverage Dart’s pub.dev to provide a Flutter package manager and discovery mechanism that connected package authors with app developers.

This last step is especially important because it enabled the Flutter community to help each other without the Flutter team getting in the way. Nobody has to ask before they publish or use a package on [pub.dev](https://pub.dev/). On the other hand, to foster this kind of ecosystem, it’s important to have a trusted agent that establishes the infrastructure on which modern Flutter apps are built. The Flutter team at Google provides the trusted platform on which the Flutter community can continue to grow and thrive.

## Package Publishers, Ratings and Favorites

To help make the Flutter packages ecosystem trustworthy, we expose a number of metrics about each package on pub.dev:

<DashImage figure src="images/08aAcj-L2pE08dBil.webp" />


This is a screenshot of [the provider package](https://pub.dev/packages/provider), which is at the top when it comes to popularity and quality in the Flutter ecosystem. This screenshot shows off several of the metrics we use to signal quality on pub.dev. The blue shield next to the domain name is the [Verified Publisher](https://dart.dev/tools/pub/verified-publishers) and lets you know that a package was published by someone whose identity has been verified. The thumbs-up icon and the number next to it shows the number of Likes, which lets you know how other members of the community feel about this package. And finally, the logo on the far right marks the package as a Flutter Favorite, which indicates a package that you should consider first when building your apps. As just one comparison, the average likeability of an actively maintained package over the last three months is 12 likes, whereas for a Flutter Favorite, it’s 270 likes. To find the highest quality packages, [the Flutter Favorite measures](https://flutter.dev/docs/development/packages-and-plugins/favorites#metrics) combine the pub.dev score along with a number of objective and subjective measures for quality, usability, and broad applicability, including an engineering code review from one of the contributors to the Flutter framework itself.

Because of the high bar, the Flutter Favorite designation is something you won’t see very often — it only appears on [a handful of packages](https://pub.dev/flutter/favorites). Today I’m pleased to announce that the list has grown to include the following: [bloc](https://pub.dev/packages/bloc) and [flutter_bloc](https://pub.dev/packages/flutter_bloc), [convex_bottom_bar](https://pub.dev/packages/convex_bottom_bar), [geolocator](https://pub.dev/packages/geolocator), [google_fonts](https://pub.dev/packages/google_fonts), [location](https://pub.dev/packages/location), and [sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple). Congratulations to all of those authors and thank you very much for your contributions to the Flutter package ecosystem.

## Sign In with Apple

One of the most notable plugins from this round of Flutter Favorite awards is [the sign_in_with_apple plugin](https://pub.dev/packages/sign_in_with_apple).

<DashImage figure src="images/0jAThFFycWDnklih_.webp" />


Not only is it of high quality and broad applicability, but it fills an important gap in the Flutter feature set. [Apple has announced](https://developer.apple.com/news/?id=03262020b) that apps that use other third-party authentication, such as Google Sign In, must also enable Apple Sign In by June 30, 2020 to be accepted in the App Store. Obviously this was crucial functionality to provide for any Flutter developer targeting iOS, but instead of the Flutter team at Google building its own plugin to fill this gap, we leaned on our community. Reaching out to Timm Preetz and Henri Beck, the authors of sign_in_with_apple, we found them to be very responsive and quickly brought the plugin up to the required bar in record time.

## Increasing Quantity and Quality

It’s only with the maturity and diversity of the Flutter package ecosystem that we were able to work with the community to achieve something like the sign_in_with_apple plugin. If you look at the number of Flutter-dependent packages over time, you can see the growth of the ecosystem.

<DashImage figure src="images/0wGtSijeLPe4ZesC5.webp" alt="*Number of Flutter-dependent packages since the 1.0 release*" caption="*Number of Flutter-dependent packages since the 1.0 release*" />


Normally, you’d expect such amazing growth to be accompanied by an overall decrease in quality. However, the Flutter community is seeing just the opposite trend.

<DashImage figure src="images/0TBaT0BabySTA5w7A.webp" alt="*Percentage of high quality Flutter-dependent packages since 1.0 release*" caption="*Percentage of high quality Flutter-dependent packages since 1.0 release*" />


Here we’re measuring quality as the health and maintenance portion of the overall score on pub.dev. As you can see, since the Flutter 1.0 release, the overall quality of the package ecosystem has increased despite the enormous growth.

## Moving Google Flutter Plugins to 1.0

It’s not just the community that produces plugins. A team of Googlers working on Flutter also provide [a set of plugins](https://pub.dev/publishers/flutter.dev/packages). Many of those plugins are marked as Flutter Favorite packages, indicating high quality, including [shared_preferences](https://pub.dev/packages/shared_preferences), [path_provider](https://pub.dev/packages/path_provider), [url_launcher](https://pub.dev/packages/url_launcher) and more. However, those plugins are not all marked as “1.0”; for example, shared_preferences is marked as “0.5.7+2”, which may seem unintuitive when it comes to plugins we consider ready for production use. The reason lies in how Dart handles versions:

<DashImage figure src="images/0DcTQUTlLWP5XY08S.webp" />


By convention, we advise developers to use the caret syntax when depending on a package, for example: ^current-version. This syntax is interpreted by ‘flutter pub get’ to mean “I’d like the highest available version equal to or greater than the version I’ve specified without changing the major version.” This is [Dart’s implementation](https://medium.com/@nex3/pubgrub-2fb6470504f) of [semantic versioning](https://semver.org/), which states that major versions are to be used for breaking changes and should be chosen explicitly. However, in the case of this set of Flutter plugins maintained by Google, we’ve stabilized the API such that it’s safe to specify the version string to include 1.x versions, which you can do in your pubspec.yaml like so:

```yaml
dependencies:

  shared_preferences: ‘>=0.5.7+2 <2.0.0’
```


For this set of plugins, you can use the following version strings to prepare for v1.0 instead of the conventional versions:

<DashImage figure src="images/1xL8xSvDmpOJNRi8v-uLmmA.webp" />


Until your pubspec.yaml is updated along these lines, if we were to bump the version numbers to 1.0.0, your apps and dependent packages won’t get the updates. And that’s fine for 1.0, since it’s not going to be different than the 0.x version listed above, but what about 1.1 and beyond? That’s why you want to make these changes.

In some cases, we can help. For example, there are 181 packages on pub.dev that depend on shared_preferences. If your app depends on shared_preferences &lt;2.0.0 and also depends on another package that in turn depends on shared_preferences &lt;1.0.0, then the Dart version solver is never going to give you 1.0.0 (or 1.1.0 or …). However, instead of waiting and hoping for the authors of these 181 packages to read this blog post and update their dependency version string for all of the plugins listed above, we’re actively working to submit PRs to the git repositories that contain the packages’ pubspec.yaml to match the version strings in the table above. That way, when we flip the version number to 1.0.0 on the set of Google Flutter plugins currently at 0.x, your apps will be all set and the packages that you depend on will be all set, too.

## Bringing Google Flutter Plugins to Production

You may have noticed that not all of Google Flutter plugins are listed in the discussion above, like Firebase, Camera, Video Player, etc. That’s because we’ve got some more work to do on some plugins to bring them up to production quality; for example, the Firebase plugins need better, more thorough documentation as well as faster build times and simpler configuration. To help us get there, I’m happy to announce that we’ve engaged with [Invertase](http://invertase.io), a UK-based consulting firm with deep expertise in Dart and Flutter.

<DashImage figure src="images/0lfpUSCU8N0mJf1BH.webp" />


In the coming months, Invertase is going to help us bring the remaining Google Flutter plugins to production quality. If you’d like more details on the Firebase plugins specifically, you can read about Invertase’s plans on [the FlutterFire repo](https://github.com/FirebaseExtended/flutterfire/issues/2582).

## Summary

The Flutter package manager is a thriving ecosystem, with a growing number of packages to fill the gaps that the Googlers on the Flutter team could never possibly manage themselves. Luckily, with the signals on pub.dev, including the score, ratings and the Flutter Favorite designation, as well as our partnership with Invertase, you can have confidence that you’ll have the quality signals you need to find the right packages for your next Flutter app. With all the power provided by the packages on pub.dev, what are you going to build?