---
title: "Supporting iOS 14 and Xcode 12 with Flutter"
description: "As always, our goal is to make developers successful on Flutter regardless of the platform you’re targeting. Since the announcement of iOS…"
publishDate: 2020-09-16
author: csells
category: announcement
layout: blog
---

As always, our goal is to make developers successful on Flutter regardless of the platform you’re targeting. Since the announcement of iOS 14 in June, we’ve been working on adding new features to Flutter that support this release, including updates to [support Xcode 12](https://github.com/flutter/flutter/issues/60133), as well as adding new features and improvements to [support iOS 14](https://github.com/flutter/flutter/issues/61047).

If your iOS 14 app uses [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html), [`CupertinoTextField`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField-class.html), or [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html), you’ll want to make sure that it’s built with Flutter 1.20 or later to ensure that your users are not bothered by unnecessary clipboard notification messages, as per Apple’s updated clipboard policy.

**Otherwise, existing production apps will run just fine on your end-users’ iOS 14 devices.** However, if you’re upgrading your development phone to iOS 14 today and want to continue to use it with Flutter, you have two choices.

Your first choice is to use the [latest hotfix release of Flutter](https://github.com/flutter/flutter/wiki/Hotfixes-to-the-Stable-Channel) on the stable channel (1.20.4), which supports development-time deployment to physical iOS 14 devices. Unfortunately, there’s another change that is quite a bit more intrusive (and therefore more risky) which is needed for debugging and hot reload on iOS 14. We’re deferring this fix to our next stable release, which we are planning to release in the next few weeks.

Your second choice is to use the beta for the upcoming Flutter 1.22 that we’ve released today. This release includes more comprehensive support for iOS 14, including updated visuals, app clips, and Xcode 12 support. We’ll share more about its feature set when it is published to the stable channel, but in the meantime we recommend using this beta if you need support for iOS 14 immediately.

To obtain the Flutter 1.22 beta, use the following commands:

```bash
$ flutter channel beta
$ flutter upgrade
```


In either case, you’ll want to check out [the Developing for iOS 14 page](https://flutter.dev/docs/development/ios-14) for helpful information about targeting iOS 14 with Flutter. If you have any trouble with iOS 14, please [file issues on the Flutter repo](https://github.com/flutter/flutter/issues). If you have any questions, please post them on [the flutter-dev group](https://groups.google.com/g/flutter-dev).