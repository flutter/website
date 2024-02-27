---
title: Networking and data
description: Learn how to network your Flutter app.
prev:
  title: Handling user input
next:
    title: Local data and caching
---

While it's said that "no man is an island",
a Flutter app without any networking capability can feel a tad disconnected.
In this section you will learn how to add networking features to your Flutter app.
Your app will retrieve data, parse JSON into usable in memory representations, and then send data out again.

## Introduction to retrieving data over the network

The following two tutorials introduce you to the [`http`][] package which enables your app to make [HTTP][] requests with ease, whether you are running on Android, iOS, inside a web browser, or natively on Windows, macOS or Linux. 
The first tutorial shows you how to make an unauthenticated `GET` request to a website, parse the retrieved data as `JSON` and then display the resulting data.
The second tutorial builds on the first by adding authentication headers, enabling access to web servers requiring authorization. The article by the Mozilla Developer Network (MDN) gives more background on how authorisation works on the web.

* Tutorial: [Fetch data from the internet][]
* Tutorial: [Make authenticated requests][]
* Article: [MDN's article on Authorization for websites][]

## Making data retrived from the network useful

Once you are retrieving data from the network, you will want a way to convert the data from the network into something that you can easily work with in Dart.
The tutorials in the previous section used hand rolled Dart to convert network data into an in memory representation. 
In this section you'll see other options for handling this conversion.
The first is a YouTube video giving an overview of the [`freezed` package][]. 
While the second is a codelab covering patterns and records using the case study of parsing JSON. 
On point, no?

* YouTube video: [Freezed (Package of the Week)][]
* Codelab: [Dive into Dart's patterns and records][]

## Going both ways, getting data out again

Now that you have mastered the art of retrieving data, it's time to look at pushing data out.
This starts with sending data to the network, but then dives into asynchronicity.
The truth is, once you are in a conversation over the network, you'll need to deal with the fact that web servers that are far away take a while to respond, and you can't stop rendering to the screen while you wait for packets to round trip.
Dart has really great support for asynchonicity, as does Flutter.
You'll learn all about Dart's support in a tutorial, then see Flutter's capability covered in a Widget of the Week video.
Once you are through that, you'll learn how to debug network traffic using DevTool's Network View.


* Tutorial: [Send data to the internet][]
* Tutorial: [Asynchronous programming: futures, async, await][]
* YouTube video: [FutureBuilder (Widget of the Week)][]
* Article: [Using the Network View][]

## Extension material

Now that you have mastered using Flutter's networking APIs, it'll help to see Flutter's network usage in context.
The first is a codelab ostensibly on creating Adaptive Apps in Flutter, but it uses a web server written in Dart to work around the web browsers' [Cross-Origin Resource Sharing (CORS) restrictions][].
Next is a long form YouTube video where Flutter DevRel alumni Fitz talks about how the location of data matters for Flutter apps.
Finally, a really useful series of articles by Flutter GDE Anna (Domashych) Leushchenko covering advanced networking in Flutter.

* Codelab: [Adaptive Apps in Flutter][]
* Video: [Keeping it local: Managing a Flutter app's data][]
* Article series: [Basic and advanced networking in Dart and Flutter][]


[Adaptive Apps in Flutter]: https://codelabs.developers.google.com/codelabs/flutter-adaptive-app
[Asynchronous programming: futures, async, await]: https://dart.dev/codelabs/async-await
[Basic and advanced networking in Dart and Flutter]: https://medium.com/tide-engineering-team/basic-and-advanced-networking-in-dart-and-flutter-the-tide-way-part-0-introduction-33ac040a4a1c
[Cross-Origin Resource Sharing (CORS) restrictions]: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
[Dive into Dart's patterns and records]: https://codelabs.developers.google.com/codelabs/dart-patterns-records
[Fetch data from the internet]: https://docs.flutter.dev/cookbook/networking/fetch-data
[Freezed (Package of the Week)]: https://www.youtube.com/watch?v=RaThk0fiphA
[`freezed` package]: https://pub.dev/packages/freezed
[FutureBuilder (Widget of the Week)]: https://www.youtube.com/watch?v=zEdw_1B7JHY
[`http`]: https://pub.dev/packages/http
[HTTP]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview
[Keeping it local: Managing a Flutter app's data]: https://www.youtube.com/watch?v=uCbHxLA9t9E
[Make authenticated requests]: https://docs.flutter.dev/cookbook/networking/authenticated-requests
[MDN's article on Authorization for websites]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization
[Using the Network View]: https://docs.flutter.dev/tools/devtools/network
[Send data to the internet]: https://docs.flutter.dev/cookbook/networking/send-data