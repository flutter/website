---
title: Hatay'ı Yaşat
description:
  Learn how the volunteer-built, open-source Hatay'ı Yaşat app used Flutter and
  Firebase to help earthquake survivors in Hatay find relocated businesses,
  shipping to iOS and Android in three months.
headline: Hatay'ı Yaşat
summary:
  Supporting earthquake recovery in Hatay with a community-driven Flutter and
  Firebase app
appName: Hatay'ı Yaşat
companyName: Hatay'ı Yaşat
logo: images/third_party/case_studies/hatayi-yasat/hatayi_yasat_logo.webp
card: images/third_party/case_studies/hatayi-yasat/hatayi_yasat_logo.webp
poster: images/third_party/case_studies/hatayi-yasat/hatayi_yasat_poster.webp
locations:
  - Europe
  - Asia
platforms:
  - Mobile
industries:
  - Social
tags:
  - mobile
  - android
  - ios
  - open-source
  - firebase
publishDate: 2026-09-29
successMetrics:
  - text: "1,600+"
    desc: business listings approved through self-service
  - text: "5.0"
    desc: Google Play rating across 228 reviews
  - text: 3 months
    desc: to launch on iOS and Android
---

Following the devastating February 2023 earthquakes in Turkey, thousands of
local businesses in Hatay relocated to temporary container markets across the
region. For residents and relief workers, locating local tradespeople, shops,
and essential services became a daily challenge.

To address this need, a small volunteer team created
[Hatay'ı Yaşat][hatayi-yasat-repo], an open-source mobile application. The
project aimed to reconnect residents with relocated businesses, navigate new
container markets, and preserve the visual and cultural memory of the city.
With no dedicated infrastructure budget, the team needed to build and deploy a
reliable, cross-platform solution as quickly as possible.

**Optimizing for speed and reliability**

Given the urgency on the ground, maintaining two native codebases was not
practical for a volunteer group. The team chose Flutter to achieve rapid
cross-platform reach from a single codebase without sacrificing performance or
UI quality.

Flutter's comprehensive widget catalog and flexible layout engine allowed the
team to create an intuitive, accessible interface tailored for diverse users.
Pairing Flutter with Firebase provided a complete serverless backend, including
Cloud Firestore for real-time data sync, Firebase Storage for merchant photos,
and Firebase Cloud Messaging for community alerts. This combination enabled the
team to build and launch the first production version on iOS and Android in
three months.

<Image
  src="images/third_party/case_studies/hatayi-yasat/hatayi_yasat_body_1.webp"
  format="fullwidth"
  alt="Hatay'ı Yaşat business listings, business details, and category filters"
/>

**Shipping fast and scaling with Flutter**

The open-source application is hosted on GitHub and built with a
feature-first architecture, which has helped contributors onboard smoothly
throughout three years of continuous development. The team leveraged
[Riverpod](https://riverpod.dev/) with code generation for predictable state
management, [`go_router`](https://pub.dev/packages/go_router) for declarative
navigation, and
[`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) for
interactive place discovery.

A core highlight of the application is the merchant self-service flow. Local
business owners can register their businesses directly in the app, upload
photos, set operating hours, and update their location coordinates. Each
application is reviewed by the volunteer team in a lightweight admin panel,
typically within three business days, and the owner is notified through
[Firebase](https://firebase.google.com/) Cloud Messaging the moment it is
approved. From then on, every change the owner makes reflects in real time for
all users through Cloud Firestore, with no further review cycle, keeping
community data accurate as businesses move and reopen.

<Image
  src="images/third_party/case_studies/hatayi-yasat/hatayi_yasat_body_2.webp"
  format="fullwidth"
  alt="Hatay'ı Yaşat merchant self-service registration flow"
/>

The app also catalogs the region's temporary container markets, listing the
businesses inside each one with directions and one-tap calling, so residents
can find a specific trader among dozens of relocated units. Discovery is backed
by search, 22 business categories, and district-level filtering.

To foster local connection, the app integrates a community layer: residents
share reviews with photos, business owners reply directly, and a shared feed
carries local news, events, and neighborhood groups. Firebase Cloud Messaging
keeps the community informed when weather or civic alerts affect the region.

The app also features a dedicated history archive, offering historical
photographs and information to preserve the cultural identity of Hatay during
reconstruction.

<Image
  src="images/third_party/case_studies/hatayi-yasat/hatayi_yasat_body_3.webp"
  format="fullwidth"
  alt="Hatay'ı Yaşat community feed, landmark map, and container market listings"
/>

**_"We had three months, no budget, and a rotating group of volunteers.
Flutter and Firebase let us ship to both platforms and keep shipping for three
years without a backend team."_**

_- Veli Bacık, Project Lead, Hatay'ı Yaşat_

**Results**

Flutter and Firebase enabled Hatay'ı Yaşat to deliver meaningful community
impact:

- **Rapid deployment:** Launched the first production release on both iOS and
  Android in approximately three months.
- **Real community adoption:** More than 1,600 business listings have been
  submitted and approved through the in-app merchant self-service flow,
  keeping location data current as businesses relocate.
- **Strong community trust:** Over 5,000 downloads on Google Play with a 5.0
  rating across 228 user reviews.
- **High developer velocity:** Maintained continuous, stable releases over
  three years from a single codebase, even as volunteer contributors rotated
  over time.
- **Prepared for the future:** The unified codebase already supports
  location-based exploration of the region's landmarks, and provides the
  foundation to expand to web and desktop.

To explore the source code, visit the
[Hatay'ı Yaşat repository on GitHub][hatayi-yasat-repo].

[hatayi-yasat-repo]: https://github.com/VB-CORE/hatayi_yasat
