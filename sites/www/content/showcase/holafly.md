---
title: "Holafly"
description:
  "Learn how Holafly rebuilt its mobile apps in Flutter in just 3 months,
  scaling to over 2 million active users and 25 million eSIMs sold."
headline: "Holafly"
summary:
  "Holafly rebuilt its mobile apps with Flutter in 3 months, unifying a
  distributed global engineering team."
appName: "Holafly"
companyName: "Holafly"
logo: images/third_party/case_studies/holafly/holafly_logo.png
card: images/third_party/case_studies/holafly/holafly_logo.png
videoEmbedUrl: "https://www.youtube.com/embed/Y2D6mFHfohI"
locations:
  - Europe
  - South America
  - North America
  - Asia
platforms:
  - Mobile
  - Web
industries:
  - Travel & Lifestyle
successMetrics:
  - text: "2M+"
    desc: monthly active users
  - text: "3"
    desc: months to rebuild and release app
tags:
  - mobile
  - android
  - ios
  - ai
publishDate: 2026-09-10
---

[Holafly](https://holafly.com/) is a leading international eSIM provider
dedicated to bringing peace of mind to travelers worldwide. By offering seamless
mobile connectivity in over 200 destinations with an
[outstanding 4.7/5 on Trustpilot](https://www.trustpilot.com/review/holafly.com),
Holafly enables travelers to navigate new cities, book late-night rides, and
stay in touch with family without worrying about roaming fees. Today, Holafly
connects over 2 million monthly active users across iOS, Android, and the web,
with more than 25 million eSIMs sold.

As Holafly grew, maintaining separate native Android and iOS applications became
an operational bottleneck. With two separate teams working in silos on distinct
codebases, delivering new features was slow and resulted in frequent
discrepancies between platforms. To accelerate feature delivery and ensure a
consistent user experience, Holafly sought a unified cross-platform framework.

**Why Flutter? Unifying Global Mobile Engineering and Accelerating Delivery**

Holafly chose [Flutter](https://flutter.dev) to break down team silos and unify
their mobile engineering under a single codebase. Rather than attempting a slow,
piecemeal transition, the team took a bold approach: rebuilding their existing
native apps entirely in Flutter. Remarkably, the team completed the full rewrite
in just three months. The Flutter app performed so well in testing that Holafly
retired their legacy native codebases and released the Flutter app directly to
production.

<Image
  src="images/third_party/case_studies/holafly/holafly_body_1.png"
  format="fullwidth"
  alt="Holafly mobile application interface showing home and eSIM data plan screens"
/>

Beyond development velocity, Flutter transformed how Holafly's engineering team
collaborates. With engineers distributed around the globe (including Uruguay,
Argentina, Italy, and Germany), working on separate native codebases had created
isolation. Adopting Flutter allowed the entire international engineering team to
collaborate seamlessly on the same codebase, drastically streamlining code
reviews, sprint planning, and knowledge sharing across time zones.

**Building with Flutter: Type-Safe Platform Channels and Modular Architecture**

Holafly's application relies on deep platform-level integration for eSIM
installation, real-time data consumption tracking, and managing multiple eSIMs
for travelers hopping between countries. Because each operating system exposes
different APIs for eSIM profiles and cellular network management, the team built
standalone modular packages that encapsulate platform-specific logic. To
establish seamless, type-safe communication between Flutter and the underlying
native iOS and Android platform code, Holafly integrated
[Pigeon](https://pub.dev/packages/pigeon). By generating type-safe platform
channel code, Pigeon enables developers to call clean, single-method
[Dart](https://dart.dev) APIs without writing manual serialization or managing
platform channel boilerplate.

<Image
  src="images/third_party/case_studies/holafly/holafly_body_2.png"
  format="fullwidth"
  alt="Holafly mobile app interface showing plan management and the homagepage"
/>

To support scalability and future development, Holafly architected their project
as a monorepo. They divided functionality into distinct, modular packages with
clearly defined public interfaces. This architecture enables any engineer on the
team to consume or contribute to a package without having to navigate its
internal implementation details. These standalone packages can also be reused
directly across future internal applications.

Localization is vital for Holafly's global user base, as the app must speak each
traveler's native language. Holafly upgraded their localization pipeline across
20+ languages by pairing
[Flutter's internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
support and Application Resource Bundle (`.arb`) files with
[Gemini](https://ai.google.dev/) and the
[Crowdin Flutter SDK](https://github.com/crowdin/flutter-sdk). Because the ARB
format natively supports metadata, contextual descriptions, parameter
definitions, and examples, it provides Gemini with the rich context necessary to
generate accurate, culturally grounded translations. This integration made
Holafly's localization process faster, simpler, and substantially less prone to
errors.

**Key results and business impact**

By transitioning to Flutter, Holafly achieved remarkable development velocity
and scaled their global reach:

- **Shipped in 3 months:** Rebuilt the full native application and deployed the
  new Flutter version directly to production in only three months.
- **Rapid global scale:** Scaled to over 2 million monthly active users across
  iOS, Android, and web.
- **Unified global team:** United a distributed engineering team across five
  countries (Uruguay, Argentina, Italy, and Germany) on a single, collaborative
  codebase.
- **Native performance with Pigeon:** Built modular packages for eSIM management
  using [Pigeon](https://pub.dev/packages/pigeon) for type-safe platform
  communication, preserving native performance with clean Dart APIs.
- **AI-driven localization with Gemini:** Automated internationalization across
  20+ languages using Flutter ARB files, [Gemini](https://ai.google.dev/), and
  the [Crowdin Flutter SDK](https://github.com/crowdin/flutter-sdk),
  accelerating translation while reducing errors.
