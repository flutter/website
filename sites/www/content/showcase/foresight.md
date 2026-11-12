---
title: Foresight
description: >-
  Learn how Google AI Edge Labs built Foresight, an offline-first AI meeting and
  note-taking companion for macOS, reusing 60% of Eloquent's Flutter and C++ AI
  stack to cut initial engineering time by 80%.
headline: Foresight
summary: >-
  Google AI Edge accelerates Foresight on macOS by sharing 60% of its Flutter
  and on-device AI stack
appName: Foresight
companyName: Google AI Edge
logo: images/third_party/case_studies/google-ai-edge-foresight/google_ai_edge_foresight_logo.webp
card: images/third_party/case_studies/google-ai-edge-foresight/google_ai_edge_foresight_card.webp
videoEmbedUrl: "https://www.youtube.com/embed/4ZBhE4CPegA"
locations:
  - North America
platforms:
  - Desktop
industries:
  - Productivity
successMetrics:
  - perc: 60
    desc: shared infrastructure stack with Eloquent
  - perc: 80
    desc: initial engineering time saved through package reuse
  - text: "22"
    desc: MediaPipe tasks available to Flutter developers
tags:
  - ai
  - desktop
  - macos
publishDate: 2026-11-12
---

During fast-moving meetings,
staying engaged in the conversation while capturing accurate,
actionable notes is a constant balancing act.
[Google AI Edge Foresight][foresight] solves this challenge
as an offline-first, AI-enhanced meeting and note-taking companion for macOS,
powered locally by EmbeddingGemma 2 and [Gemma 4][gemma-4-12b].
Foresight lets users jot down shorthand notes during a meeting
and expands them into complete, structured notes
alongside live transcripts, real-time Q&A, and summaries,
all running directly on the user's device.

<Image
  src="images/third_party/case_studies/google-ai-edge-foresight/google_ai_edge_foresight_body_1.webp"
  format="fullwidth"
  alt="Google AI Edge Foresight on macOS showing live meeting transcription, enhanced notes, and AI summary powered by EmbeddingGemma 2"
/>

Built by Google AI Edge Labs alongside its sister dictation app
[Google AI Edge Eloquent][eloquent-showcase],
Foresight serves as a flagship reference application
demonstrating what developers can build on desktop
using Google's core on-device AI SDKs.
After Eloquent climbed into the Top 20 on the App Store,
earned over 100 press mentions,
and expanded from iOS to macOS in 10 days for the Gemma 4 12B launch,
the team turned that modular Flutter foundation
into the launchpad for Foresight.

**Why Flutter? Sharing native C++ AI pipelines and UI across a desktop suite**

When the Google AI Edge team began building with
[Flutter](https://flutter.dev) and [Dart](https://dart.dev),
none of the engineers had prior Flutter experience.
Thanks to Dart's approachable syntax,
Flutter's declarative widget model, and thorough documentation,
the team became productive right away,
using Flutter not only for responsive desktop interfaces
but also as a unified orchestration layer for local machine learning models.

Under the hood, Foresight runs local Gemma and EmbeddingGemma 2 models
through [LiteRT-LM][litert-lm],
Google's high-performance on-device inference framework.
Foresight and Eloquent's transcription, embedding, and retrieval pipelines
run on the same code that powers Google's newly released MediaPipe Tasks,
including Audio Transcriber, Universal Embedder, and SemanticRetriever.
By bridging Dart to native C++ via [`dart:ffi`][dart-ffi],
the team exposed low-level inference, embeddings, and audio capture
through clean, reusable Dart packages.
Any Flutter developer can build on top of these same underpinnings
with the [Flutter MediaPipe][flutter-mediapipe-github] package,
which supports all 22 MediaPipe tasks.

**Building with Flutter: Reusing 60% of the stack to focus on meeting UX**

Because the team architected [Eloquent][eloquent] as modular Dart
and Flutter packages from the start,
Eloquent and Foresight share roughly 60% of their overall infrastructure stack.
Rather than spending months rebuilding low-level systems plumbing from scratch,
the Foresight team reused shared middle-tier packages for chunked model
downloading, local encryption, isolate management, and C++ LiteRT-LM FFI
orchestration from day one.

<Image
  src="images/third_party/case_studies/google-ai-edge-foresight/google_ai_edge_foresight_demo.webp"
  format="fullwidth"
  alt="Animated demo of Google AI Edge Foresight expanding shorthand meeting notes into structured enhanced notes"
/>

On the surface, Foresight also reused Eloquent's shared Flutter design library,
ensuring both applications look and feel like one cohesive Google AI Edge suite.
Interactive UI components built for Eloquent,
including the custom diff animation that visually highlights AI-generated edits,
carried directly over into Foresight's note-enhancement workflow.
Eliminating that duplicate UI and C++ runtime work cut an estimated 80%
of initial engineering time,
freeing engineers and designers to focus on Foresight's meeting intelligence
experience across note-taking, enhanced notes, and contextual retrieval.

**_"Flutter is not only great for UI,
you can use it as a single bridge to native pipelines as well.
Don't limit yourself to thinking Flutter is a great UI tool
for you to build cross-platform,
but also think of ways to optimize your entire stack using Flutter."_**

_- Google AI Edge Engineering Team_

**Key results and business impact**

By building Foresight on a shared Flutter and Dart architecture,
Google AI Edge Labs accelerated desktop delivery across its local AI suite:

- **60% shared infrastructure stack:**
  Reused Eloquent's Flutter design library, interactive UI components,
  and Dart-to-C++ AI middle tier directly across applications.
- **Nearly 80% initial engineering time saved:**
  Avoided months of duplicate systems engineering by sharing model downloading,
  local encryption, isolate orchestration, and LiteRT-LM FFI bindings.
- **Cohesive multi-app desktop experience:**
  Delivered consistent visual polish and shared interactive components,
  including the signature diff animation,
  across Eloquent and Foresight on macOS.
- **Graduated SDKs for the Flutter ecosystem:**
  Packaged the underlying C++ ML capabilities into the open-source
  [Flutter MediaPipe][flutter-mediapipe-github] package supporting all 22
  [MediaPipe][mediapipe-solutions] tasks, including Audio Transcriber,
  Universal Embedder, and SemanticRetriever.

Ready to build on-device AI experiences in your own Flutter apps?
Get started with the
[`flutter_mediapipe` package on pub.dev][flutter-mediapipe-pub],
explore the source code in the
[`flutter-mediapipe` GitHub repository][flutter-mediapipe-github],
and consult the [Google AI Edge and LiteRT-LM documentation][ai-edge-docs].

To experience the Google AI Edge Labs showcase apps firsthand,
explore [Google AI Edge Foresight][foresight],
visit [Google AI Edge Eloquent][eloquent],
or download [Eloquent on the App Store][eloquent-ios].

[foresight]: https://developers.google.com/edge/foresight
[eloquent]: https://developers.google.com/edge/eloquent
[eloquent-showcase]: /showcase/eloquent
[eloquent-ios]: https://apps.apple.com/us/app/google-ai-edge-eloquent/id6756505519
[gemma-4-12b]: https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/
[litert-lm]: https://developers.google.com/edge/litert-lm
[mediapipe-solutions]: https://developers.google.com/edge/mediapipe/solutions
[flutter-mediapipe-github]: https://github.com/google/flutter-mediapipe
[flutter-mediapipe-pub]: https://pub.dev/packages/flutter_mediapipe
[ai-edge-docs]: https://ai.google.dev/edge
[dart-ffi]: https://dart.dev/interop/c-interop
