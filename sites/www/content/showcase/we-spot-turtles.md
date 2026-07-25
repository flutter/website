---
title: "We Spot Turtles!"
description:
  "We Spot Turtles! is a citizen science platform helping people report sea
  turtle sightings. Built with Flutter, the app connects citizens, researchers,
  and conservation organizations to turn everyday encounters into data for
  marine protection."
headline: "We Spot Turtles!"
summary: "Empowering global sea turtle conservation with Flutter"
appName: "We Spot Turtles!"
companyName: "We Spot Turtles!"
logo: "images/third_party/case_studies/we-spot-turtles/logo.webp"
card: "images/third_party/case_studies/we-spot-turtles/case_study_card.png"
locations:
  - Europe
  - Oceania
platforms:
  - Mobile
  - Web
industries:
  - Environment & Sustainability
tags:
  - android
  - ios
  - web
  - developer-story
publishDate: 2026-07-30
---

[We Spot Turtles!](https://wespotturtles.org/) is a citizen science platform
that helps people around the world report sea turtle sightings. Built with
Flutter, the app connects citizens, researchers, and conservation organizations
to transform everyday encounters into valuable data for protecting sea turtle
populations.

**Goal**

The goal of We Spot Turtles! is to make sea turtle conservation accessible by
enabling anyone to contribute valuable field observations. As a solo developer,
the founder needed a solution to quickly build and scale across iOS, Android,
and web while keeping development and ongoing maintenance manageable.

**Why Flutter?**

After discovering Flutter at DevFest Brest in February 2019, the developer
evaluated different mechanisms for building apps. Flutter stood out due to its
multiplatform capabilities, rich widget selection, and strong Google ecosystem
support.

Choosing Flutter enabled the founder who was a solo developer at the time to
maintain a unified Dart codebase for the mobile app on iOS and Android as well
as the web dashboard used by conservation organizations.

**Building with Flutter**

Flutter's fast iteration cycle and Hot Reload enabled rapid testing and UI
refinements without waiting for long native build cycles. Leaning on the Flutter
community package ecosystem helped add complex features quickly:

- **Home screen widgets**: Leveraging the
  [home_widget](https://pub.dev/packages/home_widget) package allows users to
  log sightings with a single tap directly from their device home screen.
- **Mapping and geolocation**: Combining the
  [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) package
  with location tools enables users to pinpoint observations on land or at sea.
- **Integrated backend**: Powered by Google Maps Platform and the
  [Firebase](https://firebase.google.com/) suite of tools (Authentication, Cloud
  Firestore, Firebase Storage, and Cloud Messaging).

**Feature spotlight: "Guardian of the fenua"**

Inside the app, a specialized geo-gated feature called "Guardian of the fenua"
serves guests staying at The Brando, an eco-resort in Tetiaroa, French
Polynesia. When guest GPS coordinates cross a certain point, a dedicated hub
unlocks inside the app:

- **Geo-gating**: KML and CSV data parsed with the `xml` and `csv` packages are
  processed using a geometry library (Isar with custom geometry utilities and
  the `geodesy` package) to determine when a user enters a protected area.
- **Editorial UI**: Driven by a per-locale `PartnerContent` JSON model and
  styled with the [google_fonts](https://pub.dev/packages/google_fonts) package
  for a magazine aesthetic.
- **Custom Painter seals**: Custom Painter renders animated orbital light-catch
  effects over radial gradients to produce metallic seal badges without image
  assets.
- **Shareable certificates**: `RepaintBoundary.toImage` exports 1080×1080 PNG
  certificates, which guests share via
  [share_plus](https://pub.dev/packages/share_plus).
- **Unified workflow**: Routes scientist codes, pledges, and automatic
  photo-trigger unlocks through a single `openPartnerSealFlow` function.

**Future plans**

Future iterations of We Spot Turtles aim to integrate artificial intelligence
capabilities, including on-device AI models to assist with species recognition
from photos. The platform also plans to explore individual turtle tracking and
health indicator analysis to give conservationists deeper research tools.

**Results**

- Launched the initial cross-platform app on iOS and Android in 3 months.
- Maintained 100% code sharing across mobile apps and the web dashboard.
- Demonstrated that a solo developer using Flutter can build a scalable,
  multiplatform product with a real-world environmental impact.
