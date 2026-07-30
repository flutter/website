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
card: "images/third_party/case_studies/we-spot-turtles/case_study_card.webp"
videoEmbedUrl: "https://www.youtube.com/embed/CfzhLOiczDQ"
poster: "images/third_party/case_studies/we-spot-turtles/logo.webp"
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
publishDate: 2026-07-30
---

[We Spot Turtles\!](https://wespotturtles.org/) is a citizen science platform
dedicated to sea turtle conservation. The mobile application allows anyone, from
tourists and snorkelers to divers, volunteers, and researchers, to report sea
turtle sightings in just a few taps.

By collecting these observations, We Spot Turtles\! helps conservation
organizations better understand sea turtle populations and supports scientific
research and protection efforts around the world.

<Image src="images/third_party/case_studies/we-spot-turtles/turtles.png" format="fullwidth" alt="We Spot Turtles species selection and observation flow" />

**Why Flutter?**

We Spot Turtle's journey with Flutter began at DevFest Brest, where they came
across a Flutter codelab. Nicolas Guillot the maintainer of the We Spot
Turtles\! app was immediately impressed by how quickly it was possible to create
beautiful and high-performance mobile applications.

A few years later, We Spot Turtles\! became that project.

As a solo developer, Flutter was the perfect choice because it allowed Nicolas
to build the entire platform with a consistent technology stack. The mobile
applications for Android and iOS, as well as the web dashboard used by
conservation organizations, are all built with Flutter.

This approach allowed Nicolas to move faster, share knowledge and components
between platforms, and maintain the whole ecosystem more efficiently as a single
developer.

Beyond the technology itself, the Flutter community has been a key part of this
journey. Through meetups, conferences, and exchanges with other developers,
Nicolas has continuously learned and improved his skills. Flutter is not only
the framework that powers We Spot Turtles\!, it is also the community that
helped him bring this project to life.

<Image src="images/third_party/case_studies/we-spot-turtles/map.png" format="fullwidth" alt="We Spot Turtles interactive map showing turtle sighting locations" />

**Their solution: Building with Flutter**

We Spot Turtles\! is built entirely with Flutter, from the mobile application
used by citizens to report sea turtle sightings, to the web dashboard used by
conservation organizations to review, validate, and analyze collected data.

Using Flutter allows the We Spot Turtles\! team to maintain a unified codebase
across Android, iOS, and web, making it possible to develop new features faster
and provide a consistent experience across platforms. That shared codebase pays
off in a shared geographic qualification engine: the mobile app uses it to
classify every observation the moment it is captured, and the web dashboard uses
the very same logic to scope what each partner organization can see, so a
conservation NGO like [Te Mana O Te Moana](https://www.temanaotemoana.org/) only
accesses observations recorded inside the French Polynesian EEZ it is authorized
to monitor:

- **Geo-gating**: KML and CSV data parsed with the
  [xml](https://pub.dev/packages/xml) and [csv](https://pub.dev/packages/csv)
  packages are processed using a custom geometry utilities and the
  [geodesy](https://pub.dev/packages/geodesy) package, to determine which zone
  any given coordinate belongs to, global abundance areas, rare-sighting zones,
  or national EEZs.
- **Context-aware species picker:** Combining the
  [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) and
  [geolocator](https://pub.dev/packages/geolocator) packages with an abundance
  table attached to each zone reorders the species list at capture time,
  surfacing the sea turtles most frequently sighted locally so field observers
  get a shortlist that matches local ecology.
- **Offline-first pipeline:** The
  [isar-community](https://pub.dev/packages/isar_community) package embedded
  database keeps observations and reference zones available without a network
  connection, so field workers on remote beaches capture data first and sync
  opportunistically when connectivity returns.
- **Encrypted coordinates:** Latitudes and longitudes are AES-encrypted with the
  [encrypt](https://pub.dev/packages/encrypt) package before being written to
  Cloud Firestore, with build-time key obfuscation via
  [envied](https://pub.dev/packages/envied) package, keeping sensitive
  hatchling, nesting and sea turtles locations protected end-to-end.

Leaning on the Flutter community package ecosystem helped add complex features
quickly:

- **Home screen widgets**: Leveraging the
  [home_widget](https://pub.dev/packages/home_widget) package, users can log
  sightings with a single tap directly from their device home screen, with the
  observed species already pre-selected, one widget per turtle species pinned to
  the home screen jumps straight into the right form.
- **Photo-first observation flow:** The
  [native_exif](https://pub.dev/packages/native_exif) package reads GPS
  coordinates and capture time directly from imported photos, so an observer can
  log a sighting simply by picking a photo, the form pre-fills itself with the
  coordinates and timestamp embedded by the camera at the moment of the shot.
- **Scalable map rendering:** The
  [google_maps_cluster_manager_2](https://pub.dev/packages/google_maps_cluster_manager_2)
  package groups thousands of observation markers into dynamic clusters as users
  zoom out, keeping the map readable and performant even in densely monitored
  areas.
- **Integrated backend**: Powered by Google Maps Platform and the
  [Firebase](https://firebase.google.com/) suite of tools (Authentication, Cloud
  Firestore, Firebase Storage, and Cloud Messaging).

<Image src="images/third_party/case_studies/we-spot-turtles/web_portal.png" format="fullwidth" alt="We Spot Turtles mobile application and web dashboard" />

By combining Flutter with Google's technologies, We Spot Turtles\! provides a
scalable platform that connects citizens, researchers, and conservation
organizations to collect and share valuable data for sea turtle conservation.

**Key results and business impact**

We Spot Turtles\! makes it possible for anyone to contribute to marine
conservation by sharing their observations, while providing organizations with
the tools they need to manage and analyze this data.

- More than 6,000 Android downloads and a growing community of users
  contributing observations.
- Partnerships with conservation organizations, including
  [Te Mana O Te Moana](https://www.temanaotemoana.org/) in French Polynesia.
- A complete mobile and web platform built and maintained by a single developer,
  demonstrating how Flutter enables ambitious projects with limited resources.

By combining Flutter, Firebase, and citizen participation, We Spot Turtles\!
helps transform individual observations into valuable knowledge to better
protect sea turtles worldwide.
