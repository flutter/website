---
title: "Announcing Genkit Dart 1.0: Build production-ready agentic apps with Dart and Flutter"
description: >-
  Announcing the stable 1.0 release of Genkit Dart, an open-source framework
  for building AI-powered features and agentic workflows with Dart and Flutter.
publishDate: 2026-10-08
author: chrisraygill
coverImage:
  alt: "Announcing Genkit Dart 1.0"
  url: images/banner.png
category: news
layout: blog
---

Dart and Flutter let you build high-quality apps for mobile, web, and desktop
from a single codebase. With
[Genkit Dart](https://genkit.dev/docs/dart/get-started/), you can bring that
same productivity to full-stack, agentic apps.

Today, we're announcing **Genkit Dart 1.0**, the first stable, production-ready
release of Google's open-source framework for building AI-powered features and
agents in Dart. Since our
[preview launch](https://dart.dev/blog/announcing-genkit-dart-build-full-stack-ai-apps-with-dart-and-flutter)
earlier this year, feedback from the Dart and Flutter community has helped us
refine the APIs and expand the toolkit for production workloads.

To get started, add `genkit` to your project:

```shell
dart pub add genkit
```

You can also install the agent skill to give AI coding assistants like
Antigravity, Claude Code, and Codex up-to-date knowledge of Genkit Dart APIs
and best practices:

```shell
npx skills add genkit-ai/skills
```

## Why Genkit Dart

Genkit provides a unified API across model providers, end-to-end type safety
between your server and client, and local tooling to test and debug your AI
workflows.

### Use any model with one API

Genkit supports Google Gemini, Anthropic Claude, OpenAI, and OpenAI-compatible
models through a single interface. You register model providers as plugins and
can switch between models without rewriting your application logic:

```dart
final ai = Genkit(plugins: [googleAI(), anthropic()]);
final prompt = 'Suggest a weekend getaway from San Francisco.';

final fromGemini = await ai.generate(
  model: googleAI.gemini('gemini-flash-latest'),
  prompt: prompt,
);

final fromClaude = await ai.generate(
  model: anthropic.model('claude-sonnet-5-5'),
  prompt: prompt,
);
```

### End-to-end type safety with flows

Genkit lets you wrap your AI logic into **flows**: strongly typed, observable
functions that are easy to test and deploy as HTTP endpoints. Using the
[`schemantic`](https://pub.dev/packages/schemantic) package, you can define
your data schemas once in Dart, generate structured output from the model, and
share those exact types between your backend and your Flutter app:

```dart
// shared/lib/models.dart (used by both server and app)
@Schema()
abstract class $TripRequest {
  String get destination;
  int get days;
}
// ...plus an Itinerary schema for the result.

// server/bin/server.dart
final planTrip = ai.defineFlow(
  name: 'planTrip',
  inputSchema: TripRequest.$schema,
  outputSchema: Itinerary.$schema,
  fn: (request, _) async {
    final response = await ai.generate(
      model: googleAI.gemini('gemini-flash-latest'),
      prompt: 'Plan a ${request.days}-day trip to ${request.destination}.',
      outputSchema: Itinerary.$schema,
    );
    return response.output!;
  },
);
await (GenkitRouter()..addAction(planTrip)).serve(port: 8080); // POST /planTrip

// app/lib/main.dart
final planTrip = defineRemoteAction(
  url: 'https://api.example.com/planTrip', // Your Genkit endpoint
  inputSchema: TripRequest.$schema,
  outputSchema: Itinerary.$schema,
);
final itinerary = await planTrip(
  input: TripRequest(destination: 'Kyoto', days: 5),
);
```

### Run anywhere Dart runs

Because your AI logic is written in standard Dart, you get fast iteration with
hot reload and the flexibility to run your code wherever it fits your
architecture:

* **Directly in Flutter:** Call models straight from your app for rapid
  prototyping or bring-your-own-key experiences (never embed private API keys
  in a published client app).
* **On a Dart server:** Run complex flows and keep sensitive prompts on the
  backend, then call them from Flutter using `defineRemoteAction` as shown
  above.
* **In Flutter with remote models:** Keep your AI logic in the Flutter app
  while routing model requests through a lightweight Genkit backend that
  protects your API keys and enforces authorization:

```dart
// server/bin/server.dart
final genkit = GenkitRouter()
  ..addAction(
    googleAI().model('gemini-flash-latest'),
    path: '/gemini',
    // Runs before the model; throw a GenkitException to reject the request.
    contextProvider: (request) async =>
        {'user': await verifyUser(request.headers['authorization'])},
  );
await genkit.serve(port: 8080);

// app/lib/main.dart
final ai = Genkit();
final gemini = ai.defineRemoteModel(
  name: 'gemini',
  url: 'https://api.example.com/gemini',
  headers: (context) async => {'Authorization': 'Bearer ${await getIdToken()}'},
);
final response = await ai.generate(
  model: gemini,
  prompt: 'Suggest a packing list for Kyoto in April.',
);
```

### Test and debug with the Developer UI

Genkit includes a local Developer UI for testing flows, experimenting with
prompts, and inspecting execution traces step by step. Launch it alongside your
Dart process using the Genkit CLI:

```shell
genkit start -- dart run bin/server.dart
```

<DashImage figure src="images/devui-trace.png" alt="Inspecting an agent's model and tool calls in the Genkit Developer UI" caption="Inspecting an agent's model and tool calls in the Genkit Developer UI" />

## Built for agentic workflows

Since the preview launch, we've expanded Genkit Dart with capabilities designed
for multi-step agentic workflows, including human-in-the-loop interrupts,
generation middleware, prompt management, and production telemetry.

### Give models tools with human-in-the-loop interrupts

Tools let models call your Dart functions to fetch data or trigger actions,
like searching for flights or booking a hotel. When an action requires user
confirmation, a tool can pause the generation loop by returning
`.interrupt(...)` instead of `.response(...)`:

```dart
final bookHotel = ai.defineTool(
  name: 'bookHotel',
  description: 'Books a hotel room for the user.',
  inputSchema: HotelBooking.$schema,
  fn: (input, ctx) async {
    // Ask the user to confirm before charging their card.
    if (ctx.resumed == null) {
      return .interrupt({'hotel': input.hotelName, 'total': input.totalPrice});
    }
    final confirmation = await hotels.book(input);
    return .response(confirmation.id);
  },
);
```

Putting the approval check inside the tool guarantees that the model can't
bypass it. When `generate` returns with `FinishReason.interrupted`, your
Flutter app can prompt the user for confirmation and resume execution from
where it paused.

### Extend generation with middleware

Middleware hooks directly into the `generate` loop to intercept model calls,
inject tools, or modify requests and responses. Using `genkit` and
[`genkit_middleware`](https://pub.dev/packages/genkit_middleware), you can
attach pre-packaged capabilities like automatic retries, dynamic `SKILL.md`
loading, and tool approval rules to any `generate` call:

```dart
final ai = Genkit(plugins: [googleAI(), SkillsPlugin(), ToolApprovalPlugin()]);

final response = await ai.generate(
  model: googleAI.gemini('gemini-flash-latest'),
  prompt: 'Move my Kyoto hotel check-in to Friday.',
  tools: [findBookings, updateBooking],
  use: [
    retry(maxRetries: 3),
    skills(skillPaths: ['./skills']),
    toolApproval(approved: ['findBookings', 'use_skill']),
  ],
);
```

You can also author custom middleware with `defineGenerateMiddleware` for
cross-cutting logic like logging, caching, or model fallbacks.

### Manage prompts with Dotprompt

[Dotprompt](https://genkit.dev/docs/dart/dotprompt/) lets you manage prompt
templates, model configuration, and input/output schemas together in `.prompt`
files. Genkit automatically loads prompts from your `prompts/` directory so you
can invoke them as callable functions in Dart:

```dotprompt
---
model: googleai/gemini-flash-latest
input:
  schema:
    destination: string
---
Write a friendly, two-sentence introduction to {{destination}} for a first-time visitor.
```

```dart
final introPrompt = await ai.prompt('destinationIntro');
final response = await introPrompt({'destination': 'Kyoto'});
```

### Monitor your app in production

When you're ready to deploy, the
[`genkit_otel`](https://pub.dev/packages/genkit_otel) package exports traces,
token usage, and latency metrics using the OpenTelemetry GenAI semantic
conventions, integrating directly with your existing observability backend:

```dart
import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:genkit/telemetry.dart';
import 'package:genkit_otel/genkit_otel.dart';

await OTel.initialize();
configureInstrumentation(GenAiInstrumentation());
```

## What's next: stateful agents and generative UI

Alongside the stable 1.0 core, we're developing higher-level agentic APIs under
the `package:genkit/experimental.dart` import so you can try them early and
help shape their design.

**Stateful agents** combine a model, tools, system instructions, and state into
a single `defineAgent` call. Conversations persist across turns and app
restarts using session stores, and you can use `remoteAgent` to delegate tasks
to subagents or expose agents over HTTP to connect with your Flutter app:

```dart
import 'package:genkit/experimental.dart';

final travelAgent = ai.defineAgent(
  name: 'travelAgent',
  model: googleAI.gemini('gemini-flash-latest'),
  system: 'You help users plan and book trips.',
  tools: [searchFlights, bookHotel],
  store: FirestoreSessionStore(collection: 'sessions'),
);

final chat = travelAgent.chat(sessionId: 'user-123');
final response = await chat.send(text: 'Find me a weekend in Lisbon.');
```

**Generative UI with A2UI** lets agents stream interactive UI surfaces instead
of plain text. With [`genkit_a2ui`](https://pub.dev/packages/genkit_a2ui), an
agent can emit components like date pickers, forms, and confirmation cards that
your Flutter app renders incrementally as native widgets. Check out the
[A2UI guide](https://genkit.dev/docs/dart/agents/a2ui/) to learn more.

## Get started

Genkit Dart 1.0 is available on [pub.dev](https://pub.dev/packages/genkit)
today. Thank you to everyone in the Dart and Flutter community who built with
the preview, reported issues, and contributed pull requests to help bring
Genkit Dart to 1.0.

* **Get started:** Follow the
  [quickstart guide](https://genkit.dev/docs/dart/get-started/).
* **Explore samples:** Browse the
  [sample apps on GitHub](https://github.com/genkit-ai/genkit-dart/tree/main/testapps).
* **Join the community:** Chat with the team on
  [Discord](https://discord.gg/qXt5zzQKpc).
* **Stay updated:** Follow Genkit on [X](https://x.com/genkitframework) and
  [LinkedIn](https://www.linkedin.com/company/genkit).
* **Give feedback:** Open an issue on the
  [GitHub repository](https://github.com/genkit-ai/genkit-dart).

We can't wait to see what you build with Genkit Dart 1.0!
