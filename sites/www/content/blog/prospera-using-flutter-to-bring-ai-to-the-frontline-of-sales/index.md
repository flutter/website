---
title: "Prospera: using Flutter to bring AI to the frontline of sales"
description: >-
  Developers around the world are using Google’s Gemini models to tackle
  real-world challenges, and one of the most exciting applications…
publishDate: 2024-11-21
author: tvolkert
image: images/1rV1FMqYeyrHsOvtSUIOnOA.webp
category: story
layout: blog
---

<DashImage figure src="images/1rV1FMqYeyrHsOvtSUIOnOA.webp" />

Developers around the world are using Google’s Gemini models to tackle real-world challenges, and one of the most exciting applications we’ve seen is in the field of sales. Meet Prospera, winner of both *best Flutter app* and *most Useful app* in our recent [Gemini API Developer Competition](https://ai.google.dev/competition)! Created by Leon Kukuk and Max Hasenohr from Germany, Prospera is an AI-powered sales coach that provides real-time guidance and feedback during and after calls. This innovative Flutter app showcases the power of Gemini to transform how sales professionals learn and improve their skills.

<YoutubeEmbed id="ZTFKbhmGcUo" title="Prospera Gemini Demo" fullwidth="true"/>

## Gemini API at the core: real-time analysis and multimodal magic

Prospera leverages Gemini’s multimodal capabilities in a truly unique way. By feeding snippets of audio conversations directly into the Python SDK for the Gemini API, the app provides real-time feedback from the perspective of a seasoned sales coach. Imagine having an AI co-pilot whispering valuable insights and suggestions during your calls — that’s the power of Prospera.

But how did they achieve this seamless integration? Leon, the developer of Prospera, cleverly used Dart FFI (Foreign Function Interface) and the ffigen package to create Dart bindings for the PJSIP C library, enabling seamless phone call integration in Flutter and allowing these calls to be processed through the Gemini API. This allowed them to process audio data in real-time and deliver instant feedback to the sales representative.

**“We were impressed by Gemini’s nuanced understanding of speech, thanks to its multimodal audio capabilities as well as its ease of implementation. Flutter enabled us to develop cross-platform apps at an incredible speed, while offering powerful opportunities to run native code through FFI and platform channels.” — Leon**

## A Flutter app for all platforms

Built with Flutter, Prospera runs seamlessly across various desktop platforms from a single codebase. This not only streamlines development but also opens doors for future expansion to mobile devices, making the app accessible to an even wider audience. The developer also paid close attention to user experience, crafting a beautifully designed app with Material Design widgets and ensuring full accessibility.

## Beyond sales: a glimpse into the future of communication

By combining the power of Gemini with the versatility of Flutter, Leon and Max have created an app with the potential to revolutionize how we learn, interact, and excel in our professional lives. Prospera is more than just a sales coach; it’s a glimpse into the future of how AI can enhance human communication and professional development. While Prospera focuses on sales coaching, its underlying technology and approach have broader applications. The ability to analyze real-time conversations and provide constructive feedback can be valuable in various communication-driven professions, such as customer service and education.

**Want to learn more about Dart FFI and how it can empower your Flutter applications? Check out the [ffigen](https://pub.dev/packages/ffigen) package on pub.dev**.
