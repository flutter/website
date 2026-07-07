---
title: "Announcing Flutter AI Toolkit"
description: "Want AI chat in your Flutter app? This toolkit makes it easy."
publishDate: 2024-12-17
author: antfitch
image: images/1u_atZ9LOO85MJMWdLFvxow.png
category: announcements
layout: blog
---

Flutter AI developers, rejoice! Adding an AI-powered chat experience to your app just got a whole lot easier. Introducing [Flutter AI Toolkit](https://pub.dev/packages/flutter_ai_toolkit), a collection of ready-to-use AI chat widgets designed to seamlessly integrate into your Flutter projects. No more building complex chat interfaces from scratch — Flutter AI Toolkit provides everything you need to quickly and easily add a sophisticated AI chat window to your app. Ready to boost customer engagement and satisfaction across multiple platforms? You’ve got this!

<DashImage figure src="images/08PFN57i3DaWcEBvk.gif" alt="[Try Flutter AI Toolkit in Project IDX!](https://idx.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai)" caption="[Try Flutter AI Toolkit in Project IDX!](https://idx.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai)" />


## Multi-turn chat

With multi-turn chat, you can maintain context across multiple interactions in the same session.

Imagine you’re talking to a friend. They ask if you have a pet and you tell them that you have a pet rock named Rocky. A little while later after chatting with you about other things, your friend asks “How long have you had Rocky?” The friend remembers your pet rock from an earlier conversation, even though you didn’t mention it again.

That’s essentially what multi-turn chat does! It helps the LLM (generative AI Large Language Model) remember what is being talked about.

<DashImage figure src="images/1u_atZ9LOO85MJMWdLFvxow.png" alt="Multi-turn chat in Flutter AI Toolkit" caption="Multi-turn chat in Flutter AI Toolkit" />


## Rich text display

Rich-text format is supported in the responses produced by the LLM. Instead of producing just plain-text words, the LLM can format the text to be more interesting to read. For example, the response could include bold text, images, bullets, and more.

<DashImage figure src="images/1m5BA-Jaa7l9uPr9NHoWjKA.png" alt="Rich-format support in Flutter AI Toolkit" caption="Rich-format support in Flutter AI Toolkit" />


## Voice input

Voice input can be used to convert messages to text. This hands-free option is perfect for those who prefer not to type or who want a faster way to compose messages.

<DashImage figure src="images/0KgA9lHvHX_FF3r50.png" alt="Voice input support in Flutter AI Toolkit" caption="Voice input support in Flutter AI Toolkit" />


## Multimedia attachments

Pictures, videos, audio, PDFs, and other files can be added to conversations separately or all together.

<DashImage figure src="images/1HxICVJ2oeINpsTb4DDdnqg.png" alt="Multimedia attachment support in Flutter AI Toolkit" caption="Multimedia attachment support in Flutter AI Toolkit" />


## Custom response widgets

Design specialized UI components for responses. For example, if someone requests a recipe, you can show an interactive recipe card with an option to save the recipe directly to a database.

<DashImage figure src="images/1j-2lxsZJ-WEREg7X4O7Cog.png" alt="Custom AI response widget support in Flutter AI Toolkit" caption="Custom AI response widget support in Flutter AI Toolkit" />


## Custom styling

Configure the chat appearance to match your app. Change the colors of the chat bubbles, the background, the UI fonts, and even add UI pictures or animations to reflect your brand identity.

<DashImage figure src="images/1ctMwVabsBVXa-ppooNwGsw.png" alt="Custom styling support in Flutter AI Toolkit" caption="Custom styling support in Flutter AI Toolkit" />


## Cross-platform support

Flutter supports many platforms and so does Flutter AI Toolkit. Want to deploy an AI chat app made with Flutter on iOS, Android, web, and macOS? No problem!

## Pluggable LLMs

Flutter AI Toolkit makes it easy to add AI to your app, whether you want to use Google’s Gemini or Vertex AI, or even another LLM. GeminiProvider and VertexProvider are available for out-of-the-box integration, using the [Google AI Dart SDK](https://pub.dev/packages/google_generative_ai) and [Vertex AI in Firebase SDK](https://pub.dev/packages/firebase_vertexai) respectively. We highly recommend that you use the Vertex AI in Firebase SDK for production use cases beyond prototyping. In addition, you can leverage Flutter AI Toolkit’s LLM provider interface to plug in the LLM of your choice with your own custom code.

## Stand-alone chat app with multiple conversations

Build a full-fledged chat app that can store and manage multiple conversations. To help you get started, Flutter AI Toolkit comes with a sample project that leverages a [Cloud Firestore](https://firebase.google.com/docs/firestore) database and [Vertex AI in Firebase](https://firebase.google.com/docs/vertex-ai).

<DashImage figure src="images/1gAt7fwWLXUWX_nHPwzYzxg.png" alt="Flutter AI Chat App" caption="Flutter AI Chat App" />


## Try Flutter AI Toolkit now

To try Flutter AI Toolkit yourself, check out [Flutter AI Toolkit on pub.dev](https://pub.dev/packages/flutter_ai_toolkit) and the following resources:

* [Flutter AI Toolkit documentation](https://docs.flutter.dev/ai-toolkit/user-experience)

* [Flutter AI Toolkit interactive demo](https://flutter-ai-toolkit-examp-60bad.web.app/) ([GitHub](https://github.com/flutter/ai/blob/main/example/lib/demo/demo.dart))

* [Recipe example project (GitHub)](https://github.com/flutter/ai/tree/main/example/lib/recipes)

* [Flutter AI Chat sample app (GitHub)](https://github.com/csells/flutter_ai_chat/blob/main/README.md)

* [Get started in the browser (Project IDX)](https://idx.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai)