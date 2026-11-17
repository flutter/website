---
title: Buzz
description: >-
  Learn how Block prototyped the Buzz mobile app over a weekend and shipped an
  open-source workspace for humans and AI agents in under a month with Flutter.
headline: Buzz
summary: >-
  Buzz brings people and AI agents into one mobile workspace with Flutter
appName: Buzz
companyName: Block
logo: images/third_party/case_studies/buzz/buzz_logo.webp
card: images/third_party/case_studies/buzz/buzz_card.webp
videoEmbedUrl: "https://www.youtube.com/embed/QhYZEid79VU"
locations:
  - North America
platforms:
  - Mobile
industries:
  - Productivity
  - Social
successMetrics:
  - text: "<1"
    desc: month from weekend prototype to iOS and Android launch
  - text: "500K+"
    desc: downloads on GitHub
  - text: "33K+"
    desc: stars on GitHub
tags:
  - mobile
  - ios
  - android
  - ai
  - open-source
publishDate: 2026-11-09
---

As software teams increasingly rely on AI coding agents,
working with agents inside isolated chat windows on individual laptops
has created a new kind of silo.
When teammates cannot see what an agent was asked,
why an architectural path was chosen,
or where a prompt went sideways,
jumping in to collaborate or debug becomes much harder.
[Buzz][buzz-site], an open-source workspace created by [Block][block]
(the company behind Square, Cash App, and Tidal),
solves that disconnect by bringing people and AI agents together
inside shared channels and threads.
Built on the open [Nostr][nostr] protocol,
an open standard for cryptographically signed messages,
Buzz gives every AI agent its own cryptographic identity,
channel memberships, and searchable audit trail,
just like a human teammate.
Engineers and designers work out in the open,
calling teammates into a channel whenever an agent needs guidance,
reviewing patches together, and shaping features in real time.

<Image
  src="images/third_party/case_studies/buzz/buzz_body_1.webp"
  format="fullwidth"
  alt="Buzz mobile app on iOS showing humans and AI agents collaborating across the #research-synthesis, #mobile-design, and #agent-activity channels"
/>

What started as Block's big internal bet for running the company
quickly became the daily home for its own builders,
who were soon using Buzz to build Buzz itself.
When the team open-sourced [Buzz][buzz-repo] in July 2026
([announcement][buzz-announcement]),
launch-day adoption surged to 10 to 100 times what they expected,
climbing to about 500,000 downloads and about 33,000 stars on GitHub
in less than 3 months.
With feature requests and bug reports pouring in
from a fast-growing developer community,
shipping a responsive, high-quality mobile app
for [iOS][buzz-ios] and [Android][buzz-android] became essential.

**Why Flutter? Keeping pace with viral demand through instant iteration
for humans and AI agents**

Buzz co-creator Wes Billman knew immediately
that [Flutter][flutter] was the right choice.
Having built production apps with Flutter for years,
Wes prototyped the first version of the Buzz mobile app in just a few days
so he could keep collaborating in Buzz even when away from his laptop.
From that weekend foundation,
the team took the mobile app from beginning to launch
across iOS and Android in less than a month.

As community demand accelerated,
[Dart][dart] and Flutter helped relieve the pressure on the team.
Dart's blend of just-in-time (JIT) compilation during development
and ahead-of-time (AOT) compilation for release builds
delivered smooth, native-feeling chat performance from a single codebase.
Just as importantly,
Flutter's hot reload and fast, reliable automated testing
tightened the feedback loop not only for human engineers,
but for their AI agents too.
Inside Buzz, coding agents can implement mobile features,
run widget tests, and verify fixes faster
without waiting on slow dual-platform build cycles.

<Image
  src="images/third_party/case_studies/buzz/buzz_body_2.webp"
  format="fullwidth"
  alt="Designers Morgan Martin and Kenny Lopez collaborating with AI agent Juno on an iPhone simulator build inside the #mobile-design channel in Buzz"
/>

**Building with Flutter: Lightweight architecture and live designer-to-code
collaboration**

To keep development fast as contributors joined in,
the team designed the open-source [Buzz mobile client][buzz-mobile]
around simplicity, proven community packages,
and direct collaboration in code:

<Image
  src="images/third_party/case_studies/buzz/buzz_body_3.webp"
  format="fullwidth"
  alt="Buzz Flutter mobile architecture diagram showing state and persistence across Flutter UI, Flutter Hooks, Riverpod, WebSocket and HTTP Relay, and on-device storage"
/>

- **Lightweight, feature-focused state management:**
  Rather than over-engineering heavy architectural layers,
  the team kept the codebase intentionally lean
  by pairing [Riverpod][riverpod] ([`hooks_riverpod`][hooks-riverpod])
  and [`flutter_hooks`][flutter-hooks].
  This combination cuts out verbose boilerplate
  so engineers and agents can stay focused on shipping user-facing features.
- **Core protocol and AI chat rendering from pub.dev:**
  Instead of reinventing foundational plumbing from scratch,
  the team leaned on reliable open-source packages on [pub.dev][pub-dev].
  At the heart of the app,
  [`nostr`][nostr-pkg] handles cryptographic event signing
  and real-time WebSocket relay communication,
  while [`gpt_markdown`][gpt-markdown] renders rich AI agent responses,
  markdown threads, and code blocks smoothly
  without weeks of custom chat-list tuning.
- **Designers pushing Flutter code directly in Buzz:**
  Working in Buzz reshaped how design and engineering collaborate on mobile.
  Working alongside co-creators Wes Billman and Tyler Longwell
  and Buzz Lead Designer Morgan Martin,
  mobile designer Kenny Lopez, who had not pushed production code before,
  now iterates directly in Flutter through Buzz,
  launching the simulator and seeing changes live
  instead of handing off static mockups.

Looking ahead,
the Buzz team is building remote agents, remote workspaces,
and voice collaboration directly into the Flutter app.
Once remote agents arrive on mobile,
builders will be able to spin up tasks, review patches,
and steer multi-agent workflows entirely from their phones on the go,
freeing teams from needing to sit at a laptop to build software.

**Key results and business impact**

By choosing Flutter,
Block turned a weekend mobile prototype into a fast-growing,
open-source workspace built for human and agent collaboration:

- **Weekend prototype to launch in under a month:**
  Built the first version of the Buzz mobile app in just a few days
  and launched on iOS and Android in less than a month
  from a single shared codebase.
- **Sustained velocity through 10x to 100x launch demand:**
  Kept pace with community feature requests and bug fixes
  as open-source adoption grew to roughly 500,000 downloads
  and 33,000 stars on GitHub.
- **Faster feedback loops for both people and AI agents:**
  Leveraged hot reload and fast, reliable Flutter tests
  so both human developers and AI coding agents
  can ship features and verify fixes rapidly.
- **Designers shipping live UI instead of static handoffs:**
  Enabled mobile designers who had never pushed code before
  to iterate directly in Flutter, run the simulator,
  and refine live agent-activity indicators in real time.
- **Lean, open-source architecture powered by pub.dev:**
  Delivered a smooth, native-feeling real-time chat
  and cryptographic relay client without over-engineering
  by combining Dart, `hooks_riverpod`, `flutter_hooks`, `nostr`,
  and `gpt_markdown`.

[buzz-site]: https://buzz.xyz
[block]: https://block.xyz
[nostr]: https://nostr.com
[buzz-repo]: https://github.com/block/buzz
[buzz-announcement]: https://block.xyz/inside/introducing-buzz-where-humans-and-agents-work-together
[buzz-ios]: https://apps.apple.com/us/app/buzz-chat-with-your-hive/id6779728271
[buzz-android]: https://play.google.com/store/apps/details?id=xyz.block.buzz.mobile&hl=en_US
[flutter]: https://flutter.dev
[dart]: https://dart.dev
[buzz-mobile]: https://github.com/block/buzz/tree/main/mobile
[riverpod]: https://riverpod.dev
[hooks-riverpod]: https://pub.dev/packages/hooks_riverpod
[flutter-hooks]: https://pub.dev/packages/flutter_hooks
[pub-dev]: https://pub.dev
[nostr-pkg]: https://pub.dev/packages/nostr
[gpt-markdown]: https://pub.dev/packages/gpt_markdown
