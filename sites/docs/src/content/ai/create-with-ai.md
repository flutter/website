---
title: Create with AI
sidenav: ai
description: >
  Learn how to use AI to build Flutter apps, from powerful SDKs that integrate
  AI features directly into your app to tools that accelerate your development
  workflow.
---

This guide covers how you can leverage AI tools to build AI-powered
features for your Flutter apps and streamline your
Flutter and Dart development.

AI can be used for building AI-powered apps with Flutter
and for accelerating your development workflow.

You can integrate AI-powered features like natural language understanding
and content generation directly into your Flutter app
using powerful SDKs, like the Firebase SDK for Generative AI.

You can also use AI tools, such as Gemini Code Assist and Gemini CLI,
to help with code generation and scaffolding.

These tools are powered by the Dart and Flutter MCP server,
which provides AI with a rich context about your codebase.

The Flutter Extension for Gemini CLI makes it easy to leverage official rules,
the MCP server, and custom commands for building your app.

Additionally, rules files help fine-tune the AI's behavior
and enforce project-specific best practices.

## Build AI-powered experiences with Flutter

Using AI in your Flutter app unlocks new user experiences that allow your app to
support natural language understanding and content generation.

To get started building AI-powered experiences in Flutter, check out these
resources:

* [Firebase AI Logic Showcase][] - An application that demonstrates Firebase
  AI Logic capabilities through a series of interactive demos.
* [Firebase AI Logic][] - The official Firebase SDK for using generative AI
  features directly in Flutter. Compatible with the Gemini Developer API or
  Vertex AI. To get started, check out the
  [official documentation][firebase-ai-logic-docs].
* [Genkit Dart][] - An open-source framework for building AI-powered
  features in Dart and Flutter with support for multiple model providers,
  type-safe schemas, and built-in observability. To get started, check out the
  [quickstart guide][genkit-dart-quickstart].
* [Flutter AI Toolkit][] - A sample app with pre-built widgets to help you build
  AI-powered features in Flutter.

[Firebase AI Logic]: {{site.firebase}}/docs/ai-logic
[Firebase AI Logic Showcase]: {{site.github}}/flutter/demos/tree/main/firebase_ai_logic_showcase
[firebase-ai-logic-docs]: {{site.firebase}}/docs/ai-logic/get-started
[Genkit Dart]: https://genkit.dev
[genkit-dart-quickstart]: https://genkit.dev/docs/dart/get-started
[Flutter AI Toolkit]: /ai/ai-toolkit

## AI development tools

AI isn't only a feature in your app, but can also be a powerful assistant in
your development workflow.  Tools like [Antigravity][],
[Gemini Code Assist][], [Gemini CLI][], [Claude Code][],
[Cursor][], and [Windsurf][] can help you write code faster, understand complex
concepts, and reduce boilerplate.

[Antigravity]: /ai/coding-assistants
[Gemini Code Assist]: /ai/coding-assistants
[Gemini CLI]: /ai/coding-assistants
[Claude Code]: https://www.claude.com/product/claude-code
[Cursor]: https://cursor.com/
[Windsurf]: https://windsurf.com/

### GenUI SDK for Flutter {: #genui }

The GenUI SDK transforms text-based conversations into rich,
interactive experiences. Essentially, it acts as an orchestration layer
that coordinates the flow of information between your user, your
Flutter widgets, and an AI agent.

<YouTubeEmbed id="nWr6eZKM6no" title="Getting started with GenUI"></YouTubeEmbed>

:::experimental
The `genui` package is in
alpha and is likely to change.
:::

To learn more, visit the [GenUI SDK for Flutter][] documentation.

[GenUI SDK for Flutter]: /ai/genui

### Genkit Dart

[Genkit Dart](https://genkit.dev) is an open-source, model-agnostic framework
for building AI-powered applications in Dart and Flutter.
It provides a structured way to integrate AI features into your app
with support for multiple model providers, including
Google Gemini, Anthropic Claude, and OpenAI.

Key features include:

*   **Model-agnostic API**: Switch between AI providers with minimal code changes.
*   **Type-safe schemas**: Define strongly-typed inputs and outputs for AI
    interactions using the [`schemantic`](https://pub.dev/packages/schemantic) package.
*   **Flows**: Testable, observable, and deployable functions that wrap
    AI logic with typed inputs and outputs.
*   **Tools**: Define functions that models can invoke to fetch live data
    or perform actions.
*   **Developer UI**: A built-in web UI for testing prompts, viewing execution
    traces, and debugging flows.

Genkit Dart supports multiple deployment architectures for Flutter,
including running AI logic entirely in the app,
calling backend flows from Flutter, or proxying model requests
through a Genkit backend.

To get started, check out the
[Genkit Dart quickstart](https://genkit.dev/docs/dart/get-started).

### Antigravity

[Antigravity](https://antigravity.google/) is an in-IDE AI agent that can read and write code, run
terminal commands, and help you build complex features. Some of its capabilities
include:

*   **Agentic capabilities**: Unlike chat-based assistants, Antigravity can
    proactively edit files and run terminal commands to complete tasks.
*   **Complex reasoning**: It can plan and execute multi-step workflows which
    makes it suitable for larger refactors or feature implementations.
*   **Verification**: It can run tests and verify its own changes to ensure
    correctness.

<YouTubeEmbed
  id="YY2w2JEX2xk"
  title="Flutter + Antigravity in 10 minutes">
</YouTubeEmbed>

To learn more, check out the [AI Coding Assistants](/ai/coding-assistants) guide.

### Gemini Code Assist

[Gemini Code Assist](https://codeassist.google/) is an AI-powered collaborator available for IDEs like
Visual Studio Code, JetBrains IDEs, and Android Studio. It has a deep
understanding of your project's codebase and can help you with:

* **Code completion and generation**: It suggests and generates entire blocks of
  code based on the context of what you're writing.
* **In-editor chat**: You can ask questions about your code, Flutter concepts,
  or best practices directly within your IDE.
* **Debugging and explanation**: If you encounter an error, you can ask Gemini
  Code Assist to explain it and suggest a fix.

To learn more, check out the [AI Coding Assistants](/ai/coding-assistants) guide.

### Gemini CLI

The [Gemini CLI](https://geminicli.com/) is a command-line AI workflow tool. It allows you to interact
with Gemini models for a variety of tasks without leaving your development
environment. You can use it to:

* Quickly scaffold a new Flutter widget, Dart function, or a complete app.
* Use MCP server tools, such as the Dart and Flutter MCP server
* Automate tasks like committing and pushing changes to a Git repository

To get started, visit the [Gemini CLI](https://geminicli.com/) website, or try this
[Gemini CLI codelab][].

[Gemini CLI codelab]: https://codelabs.developers.google.com/gemini-cli-hands-on

#### Flutter extension for Gemini CLI

The [Flutter extension for Gemini CLI][flutter-extension] combines the
[Dart and Flutter MCP server][dart-mcp-dart-docs] with rules and commands.
It uses the default set of [AI rules for Flutter and Dart][],
adds commands like `/create-app` and `/modify` to make
structured changes to your app, and automatically configures the
[Dart and Flutter MCP server][dart-mcp-dart-docs].

You can install it by running the following command:

```bash
gemini extensions install https://github.com/gemini-cli-extensions/flutter
```

To learn more, check out
[Flutter extension for Gemini CLI](/ai/gemini-cli-extension).

[flutter-extension]: {{site.github}}/gemini-cli-extensions/flutter
[dart-mcp-dart-docs]: /ai/mcp-server
[AI rules for Flutter and Dart]: /ai/ai-rules

### Dart and Flutter MCP server

To provide assistance during Flutter development, AI tools
need to communicate with Dart and Flutter's developer tools.
The Dart and Flutter MCP server facilitates this communication.
The MCP (model context protocol) specification outlines how
development tools can share the context of a user's code with an AI model,
which allows the AI to better understand and interact with the code.

The Dart and Flutter MCP server unlocks the full potential of your AI assistant
by connecting it directly to your development environment. It enables the AI to:

*   **Introspect the widget tree**: Visualize and debug layout issues in your running app.
*   **Manage dependencies**: Search pub.dev for packages and add them to your project.
*   **Control the runtime**: Trigger hot reloads and restarts to see changes instantly.
*   **Fix complex errors**: Analyze static and runtime errors with deep context.

This bridges the gap between the AI's natural language understanding,
and Dart and Flutter's suite of developer tools.

To get started, check out the official documentation for the
[Dart and Flutter MCP server][dart-mcp-dart-docs].

### Rules for Flutter and Dart

You can use a rules file with AI-powered editors to provide
context and instructions to an underlying LLM. To get
started, visit the [AI rules for Flutter and Dart][] guide.
