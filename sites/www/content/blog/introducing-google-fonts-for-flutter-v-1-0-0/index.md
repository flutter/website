---
title: "Introducing Google Fonts for Flutter v 1.0.0!"
description: >-
  Explore Google Fonts for Flutter and learn how to
  add and configure fonts in Flutter apps.
publishDate: 2020-04-23
author: clocksmith
image: images/1ndZ8HED7jp2f0X4IFSwtdA.webp
category: announcement
layout: blog
---

By [Anthony Robledo](https://medium.com/@clocksmith) and [MH Johnson](https://medium.com/@johnsonmh)

<DashImage figure src="images/1ndZ8HED7jp2f0X4IFSwtdA.webp" />

Google Fonts for Flutter was first announced at Flutter Interact in December 2019. With help from the community (thank you!), we have added many new features and improved stability. After a successful time in beta, it is now ready for prime time use on Android, iOS, Web, and MacOS, as [Google Fonts 1.0.0](https://pub.dev/packages/google_fonts).

Features added since beta:

* Get a list of all supported fonts with `GoogleFonts.asMap()`

* Use a font with a dynamic name: `GoogleFonts.getFont('Lato')`

* Ensure secure downloads with checksum verification

* Experience improved performance, especially on web

* Pre-bundle fonts using pubspec assets

* Optionally disable fetching fonts at runtime (useful when debugging or pre-bundling)

<DashImage figure src="images/06ZIbMT1ySdIZoHK4.gif" />

Google Fonts allows developers to easily experiment with and use any of the fonts from fonts.google.com in their app. When the app is ready to publish, the developer then decides whether the user receives the font by downloading it from the API, or it’s pre-bundled with the app package.

We have minimized the work needed to pre-bundle a font, and also kept it compatible with dynamic font loading so you don’t have to change your code if you decide to pre-bundle.

Check out the [Getting Started Guide](https://pub.dev/packages/google_fonts) to learn how to include fonts in your app via `TextStyle`s or `TextTheme`s. And once you are ready to publish, learn how to optionally pre-bundle fonts and add the font licenses to your app’s `LicenseRegistry`.

We hope you find this package useful for all of your Google Fonts needs. As always, please never hesitate to leave feedback, [file an issue](https://github.com/material-foundation/google-fonts-flutter/issues), or open a pull request!
