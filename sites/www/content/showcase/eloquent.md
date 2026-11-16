---
title: Eloquent
description: >-
  Learn how Google AI Edge Labs used Flutter to expand Eloquent from a Top 20
  iOS dictation app to a local AI desktop showcase for Gemma 4 12B in 10 days
  and scale its local AI suite.
headline: Eloquent
summary: >-
  Google AI Edge expands Eloquent to desktop in 10 days and scales its local AI
  suite with Flutter
appName: Eloquent
companyName: Google AI Edge
logo: images/third_party/case_studies/google-ai-edge-eloquent/google_ai_edge_eloquent_logo.webp
card: images/third_party/case_studies/google-ai-edge-eloquent/google_ai_edge_eloquent_card.webp
videoEmbedUrl: "https://www.youtube.com/embed/4ZBhE4CPegA"
locations:
  - North America
platforms:
  - Mobile
  - Desktop
industries:
  - Productivity
successMetrics:
  - text: "10"
    desc: days to adapt the iOS app for desktop
  - perc: 60
    desc: shared infrastructure stack with Foresight
  - perc: 80
    desc: initial engineering time saved on Foresight
tags:
  - ai
  - mobile
  - ios
  - desktop
  - macos
publishDate: 2026-11-12
---

Most people speak faster than they type
when they don't have to plan every sentence in advance,
yet traditional dictation tools transcribe every pause,
filler word, and mid-sentence correction verbatim.
[Google AI Edge Eloquent][eloquent] solves this problem for verbal thinkers
by turning unfiltered spoken thoughts into clean, structured text
directly on a user's device.
Unlike cloud-dependent transcription apps,
Eloquent runs speech recognition and language models locally
without requiring an internet connection,
keeping voice notes fast, private, and available offline.

<Image src="images/third_party/case_studies/google-ai-edge-eloquent/google_ai_edge_eloquent_body_1.webp" format="fullwidth" alt="Google AI Edge Eloquent on iOS highlighting edits between raw speech disfluencies and polished dictation" />

Built by Google AI Edge Labs,
[Eloquent][eloquent] and its sister app [Foresight][foresight]
serve as flagship reference apps demonstrating what developers can build
with Google's core on-device AI SDKs.
After launching [Eloquent on the App Store][eloquent-ios],
real-world adoption took off:
the app climbed into the Top 20 on the App Store,
earned over 100 press mentions,
and has saved users millions of minutes of typing.
Usage patterns also surprised the team,
as users began recording 30-to-60-minute sessions
rather than short voice notes,
prompting an update that unlocked unlimited dictation duration.
Soon after, the team was invited to showcase the
[Gemma 4 12B model][gemma-4-12b] in Eloquent on launch day.
Because a 12-billion-parameter model is too large to run on a mobile phone,
meeting the launch meant transforming their iOS mobile app
into a production desktop application within a 10-day window.

**Bridging native on-device AI pipelines with Flutter**

When the team started building Eloquent,
none of the engineers had prior experience with
[Flutter](https://flutter.dev) or [Dart](https://dart.dev).
Thanks to Dart's approachable syntax,
Flutter's declarative widget model, and thorough documentation,
the team became productive right away,
using Flutter to orchestrate complex on-device AI pipelines
alongside responsive, interactive interfaces.

<Image src="images/third_party/case_studies/google-ai-edge-eloquent/google_ai_edge_shared_architecture.webp" format="fullwidth" alt="Architecture diagram showing AI Edge Eloquent and AI Edge Foresight built on a shared Flutter and Dart application layer bridging to native C++ on-device inference via dart:ffi" />

At the core of Eloquent's local intelligence is [LiteRT-LM][litert-lm],
Google's on-device inference framework for running Gemma models efficiently
on consumer hardware.
Eloquent and Foresight's transcription, embedding, and retrieval pipelines
run on the same code that powers Google's newly released MediaPipe Tasks,
including Audio Transcriber, Universal Embedder, and SemanticRetriever.
Rather than maintaining separate native UI and model-execution layers
for each operating system,
the team used Flutter and [`dart:ffi`][dart-ffi]
as a single bridge to the native C++ API.
That architecture allowed one shared Dart library to power model management,
audio transcription, and UI state across platforms,
and any Flutter developer can build on top of the same underpinnings
with the [Flutter MediaPipe][flutter-mediapipe-github] package,
supporting all 22 MediaPipe tasks.

**Shipping on desktop in 10 days**

When the 10-day countdown to the Gemma 4 12B showcase began,
the team's Flutter foundation paid off immediately.
Building directly on their iOS codebase,
designers and engineers adapted the interface for larger desktop screens,
added window resizing and desktop keyboard shortcuts,
and integrated local 12B model execution on macOS in time for launch day.

<Image src="images/third_party/case_studies/google-ai-edge-eloquent/google_ai_edge_eloquent_body_2.webp" format="fullwidth" alt="Google AI Edge Eloquent running locally on macOS desktop alongside the iOS mobile app" />

Flutter also made it straightforward to craft expressive,
custom UI interactions that make on-device AI feel transparent.
A signature example is Eloquent's diff animation,
which visually highlights the differences between a user's raw spoken words
and the polished version generated by the local model.

That modular Flutter architecture became the launchpad
for the team's next application,
[Google AI Edge Foresight][foresight-showcase],
an AI-enhanced meeting and note-taking companion
powered by EmbeddingGemma 2 and Gemma 4.
Foresight lets users jot down shorthand notes during a meeting
and expands them into complete, structured notes
alongside live transcripts and summaries.

<Image src="images/third_party/case_studies/google-ai-edge-foresight/google_ai_edge_foresight_demo.webp" format="fullwidth" alt="Animated demo of Google AI Edge Foresight expanding shorthand meeting notes into structured enhanced notes on macOS" />

Because Eloquent was built as reusable Dart and Flutter packages,
Eloquent and Foresight share roughly 60% of their overall infrastructure stack.
Foresight reused Eloquent's entire design library,
including the diff animation,
along with shared middle-tier packages for model downloading,
local encryption, and LiteRT-LM orchestration,
cutting an estimated 80% of initial engineering time
compared to building that low-level C++ FFI,
model-management, and UI infrastructure from scratch.

**_"Flutter is not only great for UI,
you can use it as a single bridge to native pipelines as well.
Don't limit yourself to thinking Flutter is a great UI tool
for you to build cross-platform,
but also think of ways to optimize your entire stack using Flutter."_**

_- Google AI Edge Engineering Team_

**Key results and business impact**

By selecting Flutter,
the Google AI Edge team delivered the following results:

- **Mobile to desktop in 10 days:**
  Adapted the iOS application for macOS desktop layouts,
  window management, keyboard shortcuts, and local Gemma 4 12B inference
  within a 10-day launch window.
- **60% shared infrastructure stack:**
  Reused Eloquent's Flutter design system, interactive UI components,
  and Dart-to-C++ middle tier as the foundation for Google AI Edge Foresight.
- **Nearly 80% engineering time saved:**
  Accelerated Foresight's development by sharing model-management, speech,
  and UI libraries rather than rebuilding low-level plumbing from scratch.
- **Strong App Store adoption and rapid iteration:**
  Reached the Top 20 on the App Store with 100+ press mentions
  and millions of minutes of typing saved,
  shipping unlimited dictation support within three weeks
  despite the team starting with zero prior Flutter experience.
- **Single cross-platform bridge to C++ ML runtimes:**
  Connected [LiteRT-LM][litert-lm], [MediaPipe][mediapipe-solutions],
  and local Gemma models through `dart:ffi` and a shared Dart library
  across mobile and desktop targets.

Ready to build on-device AI experiences in your own Flutter apps?
Get started with the
[`flutter_mediapipe` package on pub.dev][flutter-mediapipe-pub],
explore the source code in the
[`flutter-mediapipe` GitHub repository][flutter-mediapipe-github],
and consult the [Google AI Edge and LiteRT-LM documentation][ai-edge-docs].

To experience the Google AI Edge Labs showcase apps firsthand,
visit [Google AI Edge Eloquent][eloquent],
download [Eloquent on the App Store][eloquent-ios],
or explore [Google AI Edge Foresight][foresight].

[eloquent]: https://developers.google.com/edge/eloquent
[eloquent-ios]: https://apps.apple.com/us/app/google-ai-edge-eloquent/id6756505519
[foresight]: https://developers.google.com/edge/foresight
[foresight-showcase]: /showcase/foresight
[gemma-4-12b]: https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/
[litert-lm]: https://developers.google.com/edge/litert-lm
[mediapipe-solutions]: https://developers.google.com/edge/mediapipe/solutions
[flutter-mediapipe-github]: https://github.com/google/flutter-mediapipe
[flutter-mediapipe-pub]: https://pub.dev/packages/flutter_mediapipe
[ai-edge-docs]: https://ai.google.dev/edge
[dart-ffi]: https://dart.dev/interop/c-interop
