---
title: "SoFi"
description:
  "SoFi delivers a unified, high-quality financial experience across mobile
  platforms using Flutter, streamlining development and reducing code by 60%."
headline: "SoFi"
summary: "Delivering a finance superapp experience with Flutter"
appName: "SoFi"
companyName: "SoFi"
logo: "images/third_party/case_studies/sofi/sofi.svg"
card: "images/third_party/case_studies/sofi/sofi.svg"
videoEmbedUrl: "https://www.youtube.com/embed/RBObC8T7ud0"
locations:
  - North America
platforms:
  - Mobile
industries:
  - Banking & Finance
successMetrics:
  - text: 15
    desc: "million users served"
  - perc: 60
    desc: "reduction in lines of code"
tags:
  - mobile
  - android
  - ios
publishDate: 2026-06-29
---

[SoFi](https://www.sofi.com/) is a leading financial technology company that
offers an all-in-one super app for its nearly 15 million members. From banking
and investing to lending products and financial insights, the digital experience
is critical to SoFi’s members, who rely on the app for time-sensitive tasks like
placing trades or making payments on time. Because reliability and security are
paramount, SoFi needed an efficient mobile development platform to deliver a
high-quality experience without doubling their engineering efforts.

Previously, SoFi maintained separate native iOS and Android applications. This
native-only approach meant they had to build everything twice, which led to
inconsistencies in the user interface and doubled the time needed for
implementation. From managing separate A/B testing pipelines to coordinating
distinct user research cycles, the development process overhead became
unsustainable.

**Why Flutter?**

SoFi's early explorations showed that Flutter offers both a better developer
experience and a superior user experience. As they evaluated the technology, the
team appreciated Flutter's flexibility, which enabled developers to work in fine
detail on custom animations and motion effects. With a promising initial proof
of concept, SoFi gradually increased its investment in Flutter to unify its
mobile development under a single, high-performing codebase.

**Their solution: Building with Flutter**

To ensure stability and security during the migration, the team chose an
in-place rewrite strategy (often referred to as
[Add-to-app](https://docs.flutter.dev/add-to-app)). They integrated a standalone
Flutter module into their existing native context, letting them rewrite features
one by one. As features were built in Flutter, the team deployed them behind
feature flags, allowing them to gradually shut down the old native
implementations.

To maximize velocity, SoFi leveraged a package-based architecture with example
apps. This setup made it possible for individual teams to develop and test
features locally inside independent packages, significantly reducing developer
iteration times. It also optimized their CI pipeline by letting them target
builds, run tests, and execute screenshot tests only on the packages that had
changed. With developers freed from constantly debugging crashes, SoFi's mobile
core team transitioned to building advanced tools and internal systems that make
the entire engineering organization more effective.

**Key results and business impact**

By adopting Flutter, SoFi transformed its mobile development workflow and
achieved significant business and technical wins:

- Achieved a 60% reduction in lines of code on a feature-per-feature,
  apples-to-apples comparison.
- Deleted over one million lines of code overall during the migration.
- Slashed the time required for code reviews, local builds, and iteration
  cycles.

<br />
<br />
