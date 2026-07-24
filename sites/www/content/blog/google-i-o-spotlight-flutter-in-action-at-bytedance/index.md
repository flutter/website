---
title: "Google I/O spotlight: Flutter in action at ByteDance"
description: >-
  Explore how ByteDance uses Flutter at scale to
  build and maintain applications across multiple platforms.
publishDate: 2021-06-29
author: sfshaza
image: images/0s0fEzRKPUlPITzxE.webp
category: story
layout: blog
---

Note: This article, originally written in Chinese by the ByteDance team,
has been translated to English.

Flutter, a technology that [ByteDance](https://www.bytedance.com/en/) has been using and contributing to for some years now, was recently highlighted on the main stage of Google I/O. Developed and open sourced by Google, the multi-platform framework for front end UI development, has garnered over 120,000 stars on GitHub.

<DashImage figure src="images/0s0fEzRKPUlPITzxE.webp" alt="At Google I/O, Zoey Fan, one of Flutter’s product managers, talked about how the framework was adopted at ByteDance." caption="At Google I/O, Zoey Fan, one of Flutter’s product managers, talked about how the framework was adopted at ByteDance." />

<DashImage figure src="images/0V8DV37bsn0UNXkvE.webp" alt="More than 70 apps by ByteDance use Flutter as their multi-platform solution." caption="More than 70 apps by ByteDance use Flutter as their multi-platform solution." />

<DashImage figure src="images/0jfsCt8xhuizJO7uf.webp" alt="Flutter has reduced development time by 33%, as compared to developing separate apps for Android and iOS." caption="Flutter has reduced development time by 33%, as compared to developing separate apps for Android and iOS." />

Today, there are more than 500 Flutter developers at ByteDance, and more than 200 of those are actively developing with Flutter. The developers use Flutter not only for mobile apps, but are also experimenting with it on web, desktop, and embedded platforms.

Beyond this, ByteDance fundamental work across the organization and has made major contributions to the Flutter project by submitting dozens of pull requests (PRs).

<DashImage figure src="images/084RzNeoAVCQu3shZ.webp" />

## What has ByteDance done to make Flutter really work for them?

The story of Flutter at ByteDance started 2 years ago.

At the time, the ByteDance front end engineering team noticed that many teams within the company needed to develop for multiple platforms, but they lacked a tool to achieve high-efficiency, high-performance, multi-platform development.

When Google open sourced Flutter, the ByteDance team discovered that with Flutter they only needed to develop the app once to support platforms such as Android, iOS, and web. Also, because Flutter has its own rendering engine, they could achieve more consistent performance across platforms.

With Flutter the Android, iOS, and web versions of an app automatically stay in sync. There is no need to design and program the UI separately for each platform, so a significant portion of redundant work is eliminated.

To support business development more efficiently, the ByteDance team performed fundamental work on the framework itself, such as optimizing performance, creating app frameworks, containerizing, and supporting add to app. They also improved Flutter performance tools including improvements to the Frames Per Second (FPS) info in the [Frame chart](https://flutter.dev/docs/development/tools/devtools/performance#flutter-frames-chart), and to the [timeline events chart](https://flutter.dev/docs/development/tools/devtools/performance#timeline-events-chart). Both of these charts are part of the [Performance View](https://flutter.dev/docs/development/tools/devtools/performance) in [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools/overview).

When adopting Flutter, the ByteDance team encountered some unique challenges. For example, Flutter must be added to the app installation package increasing the size of the app downloaded by the users. Additionally, Flutter uses the Dart programming language, which is larger in size than native code, further increasing the package size.

The ByteDance team started a special plan to optimize the package size by compressing the iOS data section, and stripping out the Skia library and other libraries (such as BoringSSL, ICU, text rendering, and libwebp). They analyzed Flutter Dart code against iOS native code and found that, to implement the same business feature, the Dart code generated more machine code instructions. To close the gap, they reduced alignment of instructions, removed debugging trap instructions, dropped redundant initialization of stores with null, removed `RawInstruction` headers with bare instructions mode, compressed `StackMap`s, removed `CodeSourceMap`, and so on.

<DashImage figure src="images/0SHp5ZrnQvQ_bva8K.webp" />

Individually, each of these optimizations reduced the package size by 0.2 to 4 MB, and significantly reduced the total package size when combined. The ByteDance team shared their experience with Google engineers, and many improvements made their way to the Flutter open source project for the benefit of the larger community.

However, when ByteDance released their first Flutter app, new issues emerged. Users asked: ‘Why is the UI so janky when I scroll in the app?’

When the ByteDance team looked into the issue, they saw that when a `FlutterView` extended a `TextureView`, the UI was noticeably jankier than when it extended `SurfaceView`. However, in the official [Timeline](https://flutter.dev/docs/development/tools/devtools/performance#timeline-events-chart) tool, the UI thread time and GPU thread time for each rendered frame are about the same, with `TextureView` pulling a bit ahead occasionally.

The metrics contradicted the real-world user experience, which puzzled the team.

At first, the team used the [Timeline](https://flutter.dev/docs/development/tools/devtools/performance#timeline-events-chart) tool to troubleshoot the issue, to no avail. After digging into the tool’s source code, they discovered the root cause of the issue.

`SurfaceView` had better performance than `TextureView`. Because `SurfaceView` had its own surface, and rendering was performed in its own OpenGL context, it could interact with `SurfaceFlinger` independently, and took full advantage of triple-buffering. On the other hand, `TextureView` was a regular view that depended on the surface of its host window for rendering. That meant the rendering wasn’t performed immediately after the UI and GPU threads had finished their work, but needed to wait for the native main thread and `renderThread` before the view could interact with `SurfaceFlinger`. That was a much longer rendering pipeline than that of `SurfaceView`.

These findings not only helped the team eliminate the jank, but resulted in 10 PRs being submitted to the Flutter open source project. With this fundamental work done, Flutter eventually became the go-to framework for multi-platform app development at ByteDance. Soon, the ByteDance team’s work with Flutter will be available to external developers using their mobile development framework, [veMARS](https://www.volcengine.com/product/vemars), benefiting the entire developer community.

<DashImage figure src="images/03xKb80lXnsfJg3pP.webp" />

## From experiment to production, this is how ByteDance put Flutter into use

It wasn’t exactly smooth sailing for ByteDance to put Flutter into real-world use.

At first, the ByteDance team chose a mature product and planned to re-implement the app’s video playback feature with Flutter.

The feature, originally written in native code for Android and iOS, wasn’t straightforward to rewrite with Flutter. After 6 months, the team came to the conclusion that it would be difficult to make all the live data compatible, and challenging to update the existing business logic.

The team decided that it wasn’t productive to update the existing features of a mature product with the new framework. Flutter’s strengths would be better used in a brand new app. The team lead said, “In a mature product, everything is already well built with native Android or iOS technology. There isn’t much gain in re-implementing the features with Flutter only to make minor improvements. It also increases the package size since the Flutter engine is included in the package. In new products or new scenarios, however, Flutter can greatly increase our productivity.”

With this changed mindset, the team turned their focus to new business areas such as education.

One of their education apps in China helps students learn the order of strokes of Chinese characters; the team wanted to add a stroke tracking feature.

To implement it, the team took inspiration from some open source projects, and decided to use SVG paths to represent strokes. The paths would then be adjusted and positioned to compose the characters:

<DashImage figure src="images/0eJK4geRY6r6kvPb-.webp" />

They defined the skeleton of each stroke to guide the movement of the virtual brush pen, so the pen moves just like it would in calligraphy:

<DashImage figure src="images/0KRHUVfNaxppJLr86.webp" />

Based on the defined order of the skeletons, a circle with a certain radius is drawn along each skeleton, and together these circles form the stroke. After that, the team added key frames to ensure that the frame rate of the animation is high enough to avoid jank.

That is how they created the smooth tracking effect, as shown in the following GIF:

<DashImage figure src="images/0WeR31rSBMqkRT6q_.webp" />

The feature, built with Flutter, now supports more than 9,000 Chinese characters, including most of the commonly used characters. Compared to developing with native code, Flutter saved time and resources.

Today, many apps by ByteDance employ a hybrid approach to development, combining the strengths of Flutter and other technologies, with newer apps leaning toward pure Flutter. For apps such as Xigua Video, TikTok Volcano, and Open Language, Flutter increased the productivity of the teams by about 33%.

<DashImage figure src="images/0h1swTfindfOd_uAB.webp" />

## ByteDancers embrace the latest technology

Even now, the Flutter team at ByteDance continues to explore the latest technologies. According to the team lead, “We have in our team many tech enthusiasts with global vision, and will continue to explore global technology developments and discuss the implementation of technology. We have close connections and collaborations with many tech companies. We have quarterly sync meetings with Google, for instance, to exchange progress, thoughts, needs, and ideas from both sides.”

One day, the maintainer of the Dart open source project on GitHub came to the ByteDance team lead with the following remarks, “Someone from your team submitted more than a dozen PRs to Dart and they’re all very good and well thought out.“

The Dart open source project maintainer was talking about Frank. Frank is a passionate open source contributor, and just got his bachelor’s degree 3 years ago. His journey in the open source world first started during his first year of university in 2015. One of the projects he created and open sourced on GitHub had over 700 stars. “It has had hundreds of downloads per year, and many game developers use it to create demos“, Frank said.

After graduation, Frank joined the Flutter team at ByteDance and became one of the most active open source contributors on the team, contributing a number of PRs to Dart and Flutter. Frank remembers that when he was working on the package size issues he proactively followed up on a relevant issue on the Dart GitHub project, and he noticed that the `Specializer` component could use some further tuning. He created a patch with his improvements to the Dart compiler middleware and submitted it to the project. The patch wasn’t accepted initially because of the large number of code blocks affected and a few minor concerns. He modified the patch seven times before it was accepted, and it was merged into the code base a week later.

There are many other open source enthusiasts like Frank in the Flutter team at ByteDance.

The ByteDance team summarized this passionate attitude toward innovation with the following words:

“There are indeed many people in the industry who prefer mature technology, but it takes time for every technology to mature, and there will always be people like us who love to stay on the cutting edge.”

This is especially true for something as novel as Flutter. There needs to be some daring people who take the first steps. At ByteDance, the Flutter engineering team, as well as the engineering teams that they support, actively try and embrace new technologies. Doing this benefited ByteDance tremendously and greatly increased our productivity.

ByteDance has always wanted to be part of things that could push the industry forward, and Flutter is likely to be one of those things.
