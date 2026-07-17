---
title: "Flutter & Dart’s 2026 roadmap"
description: >-
  Transparency is a core goal of the Flutter open source project,
  and today we're happy to share our roadmap for the next generation of apps.
publishDate: 2026-02-24
author: twerske
image: images/1Nx4rPo-suELodUsEQqLFdQ.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1Nx4rPo-suELodUsEQqLFdQ.webp" />

## Flutter & Dart’s 2026 roadmap

Transparency is a core goal of the Flutter open source project, and today we’re happy to share our roadmap for the next generation of apps. Our mission remains largely unchanged, we’re still working toward our long-term goal of creating the most popular, fastest growing, and highest-productivity multi-platform UI framework. You can check out the [**freshly updated roadmap on GitHub**](https://github.com/flutter/flutter/blob/master/docs/roadmap/Roadmap.md) for all the details, and in this post we will cover the themes driving our mission.

As you dive into our plans for the year, keep in mind that this roadmap is — as it’s always been — our **aspirational** **strategy** for what’s ahead. As with any other roadmap, plans tend to shift and adapt throughout the year, so don’t be surprised if some changes happen along the way. While it primarily reflects the work our teams at Google are focusing on, the truth is that the Flutterverse is now so much bigger than any one company.

## High-fidelity multiplatform: Impeller, Wasm, and beyond

Our driving mission is to continue to deliver the best multiplatform stack by focusing on native-level quality and performance. In 2026, we are completing the migration to the [Impeller](https://docs.flutter.dev/perf/impeller) renderer on Android. By finally removing the legacy Skia backend on Android 10 and above, we’re ensuring smooth animations and reducing jank for every user. We continue to see Impeller as the best solution for fast startup and consistent performance.

On the web, we intend for [WebAssembly (Wasm)](https://webassembly.org/) to become the default to deliver native-quality experiences and performance. We are also committed to deep platform integration, ensuring day-zero support for Android 17 and upcoming iOS releases, alongside multi-window support for desktop where our partners at Canonical continue to make progress.

## GenUI, ephemeral experiences and agentic apps

We are fundamentally changing app architecture to enable agentive UIs — interfaces that aren’t just pre-built, but adapt in real-time to user intent. This is powered by the [Flutter GenUI SDK](https://docs.flutter.dev/ai/genui) and the [A2UI protocol](https://a2ui.org/), enabling AI models to generate rich experiences dynamically.

To support this, we are investigating evolving the Dart language by adding support for interpreted bytecode in the Dart runtime. This enables “ephemeral” code delivery, where specific portions of an app can be loaded on demand without requiring a full app store update — a critical technical step for truly agentic apps.

## Full-stack Dart: Bring your tooling everywhere

We are broadening our stack to support the evolution towards full-stack and agentive apps. A major focus is Dart Cloud Functions for Firebase, providing ~10ms cold starts to ensure high-performance backend logic. We are also investigating Dart support for the Google Cloud SDK to enable you to easily connect and build your backend on Google Cloud. Additionally, we are working with the Genkit team on enabling Dart support to help you build sophisticated AI features.

## AI-reimagined developer experience

AI coding agents are disrupting the way apps are built. We’ll continue to collaborate within Google to ensure Dart and Flutter have top-tier support in [Gemini CLI](https://docs.flutter.dev/ai/create-with-ai#gemini-cli) and Antigravity, ensuring core workflows like stateful hot reload work seamlessly with AI agents.

We are also investing in [MCP (Model Context Protocol)](https://docs.flutter.dev/ai/mcp-server) servers for Dart tooling, enabling AI agents to perform complex refactors and choose secure, performant libraries with high accuracy by “talking” directly to the Dart analyzer.

## Sustainable open-source & governance

To unlock Flutter’s full potential, we are moving towards an open and sustainable operating model. This includes decoupling the Material and Cupertino design systems into standalone packages to accelerate development and allow them to evolve independently. We are also improving the extensibility of the Flutter Engine so support for new platforms can be authored “out-of-tree.”

We are deepening our commitment to the ecosystem by formalizing how we collaborate with stakeholders. Central to this is the expansion of our Consultancy Program, Insiders and Google Developer Expert (GDE) network, Customer Advisory Board (CAB), and Partners Advisory Board (PAB), which provide direct feedback to our teams.

## Modern syntax & compiled performance

Dart continues to evolve as a high-performance language. In 2026, we plan to ship Primary Constructors to streamline class declarations and Augmentations to simplify code generation. We will continue to focus on improving build_runner and Dart/Wasm compilation, while refactoring the analyzer to improve performance for large-scale applications.

## Bringing developers to Flutter and Dart

Our recently completed new [Dart and Flutter learning pathway](https://docs.flutter.dev/learn/pathway) provides a streamlined, guided onboarding path for new builders. In 2026, we plan to continue our outreach both in-person and across digital platforms to improve the experience for developers and their AI tools.

## See you at Google Cloud Next & I/O!

While this roadmap is our plan for the year, you won’t have to wait long to see the next big things from the team. Mark your calendars for [Google Cloud Next 2026](https://cloud.google.com/next) in Las Vegas (April 22–24) and [Google I/O 2026](https://io.google/2026/) (May 19–20). These will be the best moments to see Flutter in action next!

With non-Google contributors now outnumbering those of us employed by Google, there is an incredible amount of exciting work happening that isn’t even captured on this list! Accurate forecasting is always a challenge in an open source project, so please take this as a sincere **statement of our intent** and priorities rather than a fixed guarantee. We are unbelievably excited to keep building the future of apps alongside all of you and can’t wait to see what you’ll build!

**What are you most excited for?** Let us know on socials with the hashtag **#Flutter2026**. And if you’re excited about hearing more from us, be sure to follow us on [**X**](https://x.com/flutterdev), check out the repos on [**GitHub**](https://github.com/flutter/flutter), and keep an eye on this **blog** for the latest updates. Let’s build the future of apps together! 🚀
