---
title: "Building a QR code Widget in Flutter"
description: "Making Flutter Widgets is fun so get going!"
publishDate: 2018-03-05
author: lukeaf
image: images/1iuOxHUF0bBlZtiktVx6XyA.webp
category: tutorial
layout: blog
---

In my latest (client) project I needed a way to get a QR code into a Flutter app. Turns out it [used to be super easy](https://developers.google.com/chart/infographics/docs/qr_codes) with the [Google Chart API](https://developers.google.com/chart/). Unfortunately, that API is deprecated now so it’s probably best to avoid it. *Google, if you’re reading, it’s probably a good addition to the new Charts API.*

So with the Google API option out the window, it was time to look for a different solution. Enter [qr.dart](https://pub.dartlang.org/packages/qr) written by the world renowned conference host and Dart developer, [Kevin Moore](https://github.com/kevmoo/). qr.dart makes the whole generation thing a cinch so we only have to focus on the “getting the image onto the screen” bit. But first, let’s talk about how we want to define all this. If you don’t care or just want to see the code, skip the next section.

## Defining our Widget

The way that qr.dart (and QR codes) works is that you give it a QR code **version** and **error correction level**. The Higher the [version](https://www.qrcode.com/en/about/version.html), the more data you can store. The error correction value determines how much of the QR code can be missing / damaged before it is unusable (up to 30%). However, a higher error correction value increases the data needed for redundancy which reduces your total allowed characters so keep that in mind. Anyway, that’s the low down on QR codes for our purposes.

Rather than just jumping into code, let’s talk about how we want to define the Widget so that it’s helpful to everyone and not just something we shove into our code. I feel like most tutorials of this kind don’t bother, so I figured let’s give this a try. Anyhow, let’s move to list form:

1. The error correction is probably not super important (in this case) because we’re only going to draw to a screen and it’s unlikely that we will lose 30% of it so probably **Low** is a good default. The developer can always change these.

1. Most people probably only need a small amount of information so we should set a default value so that not everyone has to go off and find out the data limitations of version 26 of the QR code standard. So, let’s pick **Version 4** as our default, which gives us 114 alphanumeric chars at Low error correction.

1. We want to be able to determine the size of the QR code image either explicitly or implicitly; the squares should be proportional to that. You probably should pick a size that best allows for a QR code reader to read it effectively but, generally, most scanners are pretty good.

1. Seeing as we’re doing custom painting we probably can do a painter and a Widget for maximum flexibility.

1. We probably want to customize colours and stuff.

We could keep going but I figure this is a good start so let’s go write some code.

## The code

Let’s start with the painter. Here is the full source code:
[Gist error: HTTP 404 Not Found: {"message":"Not Found","documentation_url":"https://docs.github.com/rest/gists/gists#get-a-gist","status":"404"}]

The built **QrCode** will return a **moduleCount** that determines the square size (W x H) of the QR code so that you can iterate over each grid square to determine if it **isDark()** or is not. The rest of the code is setup, error checking, and checks to see if the data has changed. As this is the painter and not the widget, all the properties are **required**.

OK, so on to the **Widget**. Here is the code:
[Gist error: HTTP 404 Not Found: {"message":"Not Found","documentation_url":"https://docs.github.com/rest/gists/gists#get-a-gist","status":"404"}]

There is basically nothing in this Widget. Its mostly setup because the painter and qr.dart do all the heavy lifting. Let’s focus on the **build()** method because that’s the most important.

The painter itself is contained in a [**CustomPaint**](https://docs.flutter.io/flutter/widgets/CustomPaint-class.html) Widget and that will do all the necessary bits and pieces to (re)draw our final QR code so we don’t have to worry about anything. However, we do want to constrain our **CustomPaint** somehow so that the painter knows an appropriate **size** value so it can do its magic. That’s where container comes in.

As you can see on *line 20 + 21*, this is where the developer can constrain the **Container** size if they want. If no size is set then the **Container** will be inherently zero sized unless it is inside something else that determines its size. This is great because it allows for a lot of flexibility if you want to explicitly define the size in a different part of your app without having to hard code it or define it explicitly on your **QrImage** instance.

That’s pretty much all she wrote on the subject, so, how does it all look? With a simple **QrImage** definition like so:

```dart
new QrImage(
  data: "Hello, world in QR form!",
  size: 200.0,
),
```


You can create the following QR code in your app:

<DashImage figure src="images/1iuOxHUF0bBlZtiktVx6XyA.webp" alt="Beaut!" caption="Beaut!" />


All this will be in pub soon so you wont’ have to reproduce it for your purposes, but if you want to then have at it because it is open source. Hopefully, beyond getting a cool QR code Widget for your app, this gave you some small insight into how quick and easy it is to build a Widget in Flutter.

Writing Widgets in Flutter is super easy and super fast. Flutter is ramping up and it needs **high quality** Widgets so taking the time to plan things out is super important. But, my advice, is to share what you have anyway so that people can build on it or help you out.

The finished product is available on [Github](https://github.com/lukef/qr.flutter) and on [pub](https://pub.dartlang.org/packages/qr_flutter).

<GitHubEmbed repo="lukef/qr.flutter" title="qr.flutter - Create QR codes in Flutter" image="images/0_19ljt157eUKJMX7.jpg" />


And that’s it. If you have specific questions feel free to reach out on the Flutter [Gitter](https://gitter.im/flutter/flutter) or leave a comment here and I’ll get back to you!
