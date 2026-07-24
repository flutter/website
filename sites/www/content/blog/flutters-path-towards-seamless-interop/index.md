---
title: "Flutter’s path towards seamless interop"
description: >-
  Learn about Flutter's early access program for
  direct native interoperability with FFIgen and JNIgen.
publishDate: 2025-05-20
author: mariam_hasnany
category: engineering
layout: blog
---

Today, we’re excited to announce [an early access program](https://docs.google.com/forms/d/e/1FAIpQLScSSBAb0sKsrCFJhXnxbhUWx7bdFbuDqWps5C24KIXdD7E-_Q/viewform?usp=header) for Flutter plugin authors who are ready to build/re-build a plugin leveraging the codegen solutions. This is the next phase of development in our work to make it easier for Flutter developers to access native platform APIs by using FFIgen and JNIgen. There are a limited number of slots available by application to those who are ready to engage with us directly on a first wave of production plugins using FFIgen and JNIgen.

This blog post covers more on what we hope to achieve with direct native interoperability, how we plan to get there, as well as more about the early access program and how you can join us on the journey.

## The fundamental challenge

Developers often need to call APIs that are native to the host-platform the app is running on, like iOS or Android. Currently, Flutter developers can do that using method channels. Method channels rely on message passing between Dart code and native code (such asKotlin or Swift) to call the native APIs. That is, Dart code sends native code a message and the native code does something and then responds by sending the result back in a message.

The fundamental challenge with method channels is that they can be time consuming to implement and maintain. They require a lot of hand-written code. Maintenance requires manually updating their implementation to call the latest API version. They can also be error-prone, as they rely on encoding & decoding messages into strings, which can lead to runtime errors if APIs change. Finally method channels only support asynchronous calls which ensure the UI remains responsive, but can add code complexities in managing async results, handling errors, and dealing with potential latency waiting for results.

We’ve addressed some of the pain points of using method channels with [Pigeon](https://pub.dev/packages/pigeon), a tool that generates skeleton code for Dart and native APIs to handle messages that you would then manually write with method channels. While Pigeon reduces the time spent wrapping methods and writing message handlers between Dart and native code, APIs with large surface areas still require tedious code to be written. For example, the iOS in-app purchase plugin interacts with a lot of `StoreKit` objects and, since they are nested within other native objects, it takes a lot of manual coding to convert them to Pigeon serializable classes on the Objective-C side and convert those Pigeon classes back to wrapper classes on the Dart side.

Additionally, interoperability between two plugins is a challenge and there is no way to pass a non-serializable object like an Android `Image` through Dart to another plugin without each of them having a dependency on each other.

## Flutter’s vision for interoperability

Like Michael Thompson said during [#FlutterInProduction](https://flutter.dev/events/flutter-in-production), *“We’re investing a lot in a new approach for this, which we call direct native interop.”*

Our vision for interoperability is to ultimately make accessing platform APIs more effortless for developers with a simple and seamless developer experience. The goal is to enable Flutter developers to focus more time on the experience they are trying to build and less time trying to leverage the power of the underlying platform.

**The solution**

We plan on solving the fundamental interop challenge with codegen solutions called FFIgen and JNIgen that handle bridging Dart and native code for each platform directly. FFIgen will generate bindings to wrap Objective-C and Swift APIs, while similarly JNIgen will do the same for Java and Kotlin APIs.

Unlike method channels, FFIgen and JNIgen will enable APIs to be called synchronously, will support tree-shaking (removal of unused code during compilation), and allow more data to live in the platform layer.

**The ideal user**

In this early stage, the ideal users of the new direct interop are Flutter developers who are deeply knowledgeable about native platforms (iOS, Android, or both) with a strong desire to access any platform API they need more directly and with less toil. With FFIgen and JNIgen they can spend significantly less time bridging Dart with native platform code and making it easier to build and maintain plugins for the ecosystem.

As the tools become more robust over time, we imagine any Flutter developer who is well versed in native platforms will be able to access any platform API (such as one not yet available for Flutter in production or through a package on pub.dev) to generate the code they need to directly call the API with Dart code within their Flutter app.

Our hope is to land a solution significantly better than what exists today through a simplified developer experience — one that is magical in the right places without forcing developers to give up control.

## Join Interop Early Access Program

We are looking for candidates well versed in building Flutter plugins and in using Flutter tools to try an early access program, where you’d rewrite existing plugins to use direct interop, and provide detailed feedback and issues to guide the future development. Like any preview program, there will inevitably be rough edges along the way, but we’re ready to provide support and early access to overcome any obstacles that you experience.

Indicate your interest by [completing this form](https://docs.google.com/forms/d/e/1FAIpQLScSSBAb0sKsrCFJhXnxbhUWx7bdFbuDqWps5C24KIXdD7E-_Q/viewform?usp=header). We’ll likely not be able to include all who apply to this early program. Selected candidates will hear from us after June 20th, 2025.

We’re looking forward to hearing from you!
