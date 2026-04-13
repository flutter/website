---
title: AI Coding Assistants
sidenav: ai
description: >
  Learn how to use AI-powered coding assistants like Antigravity and Gemini CLI
  to accelerate your Flutter development.
---

AI tools are not only features in your app,
but can also be powerful assistants in your development workflow.

Tools like Antigravity and Gemini CLI can help you write code faster,
understand complex concepts, and reduce boilerplate.

## Antigravity

[Antigravity](https://antigravity.google/) is an in-IDE AI agent that can read and write code, run terminal commands, and help you build complex features. Some of its capabilities include:

*   **Agentic capabilities**: Unlike chat-based assistants, Antigravity can proactively edit files and run terminal commands to complete tasks.
*   **Complex reasoning**: It can plan and execute multi-step workflows which makes it suitable for larger refactors or feature implementations.
*   **Verification**: It can run tests and verify its own changes to ensure correctness.

<YouTubeEmbed
  id="YY2w2JEX2xk"
  title="Flutter + Antigravity in 10 minutes">
</YouTubeEmbed>

## Gemini CLI

The [Gemini CLI](https://geminicli.com/) is a command-line AI workflow tool. It allows you to interact with Gemini models for a variety of tasks without leaving your development environment. You can use it to:

* Quickly scaffold a new Flutter widget, Dart function, or a complete app.
* Use MCP server tools, such as the Dart and Flutter MCP server.
* Automate tasks like committing and pushing changes to a Git repository.

To get started, visit the [Gemini CLI](https://geminicli.com/) website, or try this [Gemini CLI codelab](https://codelabs.developers.google.com/gemini-cli-hands-on).

## Flutter extension for Gemini CLI

The [Flutter extension for Gemini CLI]({{site.github}}/gemini-cli-extensions/flutter) combines the [Dart and Flutter MCP server]({{site.dart-site}}/tools/mcp-server) with rules and commands. It uses the default set of [AI rules for Flutter and Dart](/ai/ai-rules), adds commands like `/create-app` and `/modify` to make structured changes to your app, and automatically configures the [Dart and Flutter MCP server]({{site.dart-site}}/tools/mcp-server).

You can install it by running the following command:

```bash
gemini extensions install https://github.com/gemini-cli-extensions/flutter
```

To learn more, check out [Flutter extension for Gemini CLI](/ai/gemini-cli-extension).
