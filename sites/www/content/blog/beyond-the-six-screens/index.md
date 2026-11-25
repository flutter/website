---
title: "Beyond the six screens"
description: >-
  How Flutter is expanding to TVs, cars, wearables, and emerging operating
  systems and what it means for developers and platform builders
publishDate: 2026-11-25
author: carlosmendonca
coverImage:
  alt: >-
    Dash wearing safety goggles plugs a TV into a central Flutter hub
    connected to phones, laptops, and desktop monitors, with additional
    cables reaching toward a car, a headset, and a smartwatch.
  url: images/hero.webp
category: news
layout: blog
---

For years, Flutter has been known for its six officially supported targets:
**Android, iOS, Linux, macOS, Windows, and web.**
Today, however, Flutter is running well beyond those six screens,
powering everything from indie developer experiments on watchOS and tvOS
to consumer hardware from LG, Samsung, Toyota, and Xiaomi.

A major driver behind this momentum is AI-assisted development.
As more apps launch for mobile, web, and desktop than ever before,
third-party platform makers building operating systems for smart TVs,
car infotainment units, wearables, or emerging devices
want that catalog on their hardware.
**Porting Flutter to a new platform has become one of the most practical ways to bring those apps over.**

For Flutter developers, that means the apps, packages, and Dart skills
you already have can reach entirely new form factors without starting from scratch.

## Why Flutter travels well to new platforms

Both platform makers and app developers are converging on Flutter
as their shared common denominator.
**According to [Appfigures' SDK Intelligence](https://g.dev/flutter/blog-pp2611-597), Flutter is the #2 most used development SDK on mobile across both the Apple App Store and Google Play,**
trailing only Swift and Kotlin and leading every other cross-platform framework.
For device manufacturers and emerging OS teams, supporting Flutter opens
immediate access to [over a million existing apps](https://g.dev/flutter/blog-pp2611-f3c)
and a massive ecosystem of Dart developers.

Just as important is how Flutter is built.
Flutter was designed from the ground up as a multi-platform toolkit
that uses as little of the operating system as possible.
When porting Flutter to a new platform, you only need to provide basic primitives,
such as a graphical surface to render into and operating system input events
like key presses.
Flutter does the rest: it builds upon the primitives exposed by the platform
to reimplement everything, from rendering text to handling gestures and animations.
For **platform maintainers,** that clean boundary makes Flutter practical to adapt to a new OS.
For **Flutter developers,** it means your app's layout, interactions,
and 60 to 120fps performance hold up reliably on a brand-new screen.

## The agentic era changes the cost of going from two to dozens of platforms

A common question today is:
_If AI coding agents can translate Swift to Kotlin in seconds, do teams still need a multi-platform framework like Flutter?_

As we examined previously in our blog on
[_Flutter's multiplatform value for agentic development_](https://g.dev/flutter/blog-pp2611-e3d)
and [_AI makes it easy to migrate; Flutter makes it easy to scale_](https://g.dev/flutter/blog-pp2611-635),
that question confuses **Day 1 syntax translation with Day 2000 production maintenance.**
In AI-assisted workflows, generating initial code is no longer the bottleneck.
**Verification speed, keeping behavior consistent across platforms, and debugging are.**
With Flutter, teams and coding agents reason over a single strongly typed Dart codebase
and validate UI changes in under 200 milliseconds with Stateful Hot Reload.

Now extrapolate that math beyond mobile.
Asking an engineering team (or a fleet of AI coding agents) to synchronize
a dozen native codebases across Swift, Kotlin, C++, C#, TS, and proprietary TV toolkits
is a recipe for drift and gridlock.
A single portable codebase lets developers reach new form factors
without maintaining endless AI-generated ports,
and gives platform makers a low enough maintenance bar to attract production apps.

## Flutter beyond mobile and desktop

Across the industry, hardware manufacturers and community maintainers
are already forking and embedding Flutter to bring it to new surfaces:

| Category | Platform / Project | How Flutter is used |
| --- | --- | --- |
| **Smart TVs** | **LG webOS Flutter SDK** ([flutter-webos](https://g.dev/flutter/blog-pp2611-438)) | Powers TV apps on webOS via an [open-source embedder maintained by LG](https://g.dev/flutter/blog-pp2611-5e1). |
| **Smart TVs** | **Samsung Tizen Flutter SDK** ([flutter-tizen](https://g.dev/flutter/blog-pp2611-66a)) | Brings Flutter to Samsung smart TVs, appliances, and IoT devices via Samsung's embedder. |
| **Smart TVs** | **Apple TV / tvOS** ([fluttertv.dev](https://g.dev/flutter/blog-pp2611-24f)) | Community-led out-of-tree engine fork bringing Flutter to tvOS. |
| **Wearables** | **Apple Watch / watchOS** ([flutterwatch.dev](https://g.dev/flutter/blog-pp2611-3c6)) | Community-led effort bringing Flutter to watchOS. |
| **Emerging OSes** | **OpenHarmony Flutter SDK** ([openharmony-sig/flutter_flutter](https://g.dev/flutter/blog-pp2611-95a)) | Community-maintained fork enabling Flutter apps on OpenHarmony devices. |
| **Automotive & Embedded Systems** | **Automotive Grade Linux (AGL) / [Toyota](https://g.dev/flutter/blog-pp2611-00a)** | Powers in-vehicle infotainment (IVI) systems, backed by Toyota's contributions to Impeller. |
| **Automotive & Embedded Systems** | **Raspberry Pi** ([flutter-pi](https://g.dev/flutter/blog-pp2611-135)) | Community-maintained engine fork and tooling enabling Flutter apps on Raspberry Pi boards. |

## The value of pluggable platforms

While this organic momentum is inspiring, bringing Flutter to a new platform
still involves too much friction.
Today, platform maintainers often have to fork the Flutter SDK,
ship a separate wrapper CLI, maintain out-of-tree engine patches,
and port plugins one by one.
At the same time, app developers want consistent tooling
and long-term stability before committing to a new target.

We are working in the open to move Flutter towards **pluggable platforms,**
which boils down to the ability for a third-party to add support
for a new target platform via extensibility APIs.
Our goal is straightforward: make it easy for out-of-tree maintainers
to stay current with the latest Flutter releases,
and make targeting those platforms feel just like targeting Flutter's core platforms.
Here is where we are focusing:

- **Extensible developer tooling ([flutter/rfc#40](https://g.dev/flutter/blog-pp2611-946)):**
  Enabling platforms to plug directly into the standard `flutter` CLI,
  reducing the need for custom wrapper tools and giving developers
  a familiar build-and-debug workflow.
- **A single, shared platform interface ([flutter/rfc#24](https://g.dev/flutter/blog-pp2611-ebc) and [flutter/rfc#27](https://g.dev/flutter/blog-pp2611-375)):**
  Rebuilding how platforms connect to the Flutter engine around one common interface
  that everyone uses, including our own first-party targets like Android and iOS.
  When every platform builds on the same foundation, out-of-tree targets get
  first-class stability and stay compatible across Flutter upgrades
  without needing heavy patching.
- **Better package discoverability on pub.dev:**
  Expanding plugin and package tooling so developers can easily find packages
  that support custom targets and platform teams can expose native capabilities cleanly.
- **Continuous compatibility testing ([flutter/rfc#29](https://g.dev/flutter/blog-pp2611-69b)):**
  Building out-of-tree CI infrastructure so breaking changes are caught before they land,
  giving maintainers and app teams confidence in every release.

Even if you only ship on mobile, desktop, or web today,
this shared foundation is already paying off.
Partners aren't just consuming Flutter; they're strengthening it for everyone,
from **Samsung's** [Impeller OpenGL startup improvements](https://g.dev/flutter/blog-pp2611-e73)
and **Toyota's** [Impeller Vulkan support](https://g.dev/flutter/blog-pp2611-5e9)
to **Comcast (Sky)'s** [compressed texture design work](https://g.dev/flutter/blog-pp2611-70c).

We are just getting started, and **we will have news on pluggable platforms to share next year.**
If you are a Flutter developer, follow along and share your thoughts on the RFCs above.
If you are building, maintaining, or considering a custom Flutter platform embedder,
we would love to hear from you.
