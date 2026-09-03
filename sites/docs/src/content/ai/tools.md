---
title: How Flutter AI tools work
shortTitle: How AI tools work
description: >-
  Learn how agent skills, the Dart and Flutter MCP server, and package skills
  interact to assist your development workflow.
---

Flutter and Dart provide an integrated suite of tools designed to help AI
coding assistants understand your codebase, follow best practices, and execute
development tasks accurately.

## Tooling ecosystem overview

The Flutter AI tooling ecosystem consists of five complementary components:

1. **Agent skills**: task-oriented blueprints that teach assistants how to
   perform specific workflows (such as creating responsive layouts or writing
   tests).
2. **Dart and Flutter MCP server**: a Model Context Protocol (MCP) server
   exposing real-time SDK diagnostics, symbol resolution, and runtime
   introspection to assistants.
3. **Developer Knowledge MCP server**: a cloud-hosted documentation search
   server giving assistants direct access to official Flutter and Dart docs.
4. **Package skills**: skills published directly inside third-party `pub.dev`
   packages, giving assistants instant expertise on specific libraries.
5. **Specialized agents**: dedicated agent personas equipped with focused tools
   and system instructions for isolated workflows, such as accessibility
   auditing.

---

## Agent skills

[Agent skills](https://agentskills.io/) provide a standardized way to equip AI
assistants with procedural domain expertise.

### Progressive disclosure

Skills use **progressive disclosure** to conserve model context:

* **Discovery phase**: The assistant initially reads only skill metadata (name
  and short description) from the `.agents/skills` directory.
* **Execution phase**: When the assistant determines a skill is relevant to
  your prompt, it loads the complete instructions (`SKILL.md`) and supporting
  reference scripts.

### Official skills repositories

* [**flutter/agent-plugins**](https://github.com/flutter/agent-plugins):
  Provides skills for Flutter development, including widget construction,
  declarative navigation, responsive design, and state management.
* [**dart-lang/skills**](https://github.com/dart-lang/skills): Provides skills
  for Dart development, including unit test authoring, dependency resolution,
  and static analysis remediation.

---

## Dart and Flutter MCP server

The [Dart and Flutter MCP server](
https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server)
implements the open Model Context Protocol (MCP), connecting AI assistants to
live Dart SDK and Flutter tooling over standard I/O (stdio).

Key capabilities provided by the MCP server include:

* **Static analysis & diagnostics**: Inspect and fix analyzer errors and
  warnings across your project.
* **Symbol resolution**: Resolve symbols to their definitions, signatures, and
  documentation.
* **Runtime introspection**: Query the state of a running Flutter application
  during active debugging sessions.
* **Package management**: Search [pub.dev](https://pub.dev) and manage
  dependencies in `pubspec.yaml`.
* **Testing & formatting**: Execute unit and widget tests and format code using
  `dart format` rules.

---

## Developer Knowledge MCP server

While the local Dart and Flutter MCP server focuses on local codebase analysis
and runtime debugging, you can also equip your assistant with search access to
official online documentation.

The [Developer Knowledge MCP server](
https://developers.google.com/knowledge/mcp)
connects AI assistants to Google's developer documentation corpus, including
[docs.flutter.dev](https://docs.flutter.dev),
[dart.dev](https://dart.dev), and official API references. This allows
assistants to retrieve up-to-date guides, migration notes, and API references
directly during conversation.

---

## Package skills

In addition to core Flutter skills, library authors can bundle official skills
directly inside their packages on [pub.dev](https://pub.dev).

When you add a dependency to your project, you can discover and install its
skills using the `skills` CLI:

```bash
dart run skills@ get
```

To learn how to install or publish package skills, check out
[Package skills](/ai/package-skills).

---

## Specialized agents

**Specialized agents** (referred to as custom agents in platforms like
Antigravity) are AI assistants configured with dedicated system prompts,
curated tool sets, and focused skill subsets.

While agent skills guide general-purpose assistants during active coding,
specialized agents run in isolated contexts to perform deep, single-purpose
workflows without cluttering your primary conversation history.

### Flutter Accessibility agent

The **Flutter Accessibility (`a11y`) agent** is an official specialized agent
designed to audit Flutter widget trees and recommend accessibility
improvements. The accessibility agent is currently available in
[Google Antigravity](https://antigravity.google).

Key capabilities of the accessibility agent include:

* **Semantic label inspection**: identifies interactive widgets (such as
  `IconButton` or `InkWell`) that lack descriptive semantic labels.
* **Touch target validation**: flags interactive elements with hit test
  areas smaller than the recommended 48x48 logical pixels.
* **Contrast and visual checks**: highlights potential contrast ratio issues
  and missing focus indicators.
* **Automated code fixes**: generates idiomatic Flutter fixes (such as
  wrapping widgets in `Semantics` or adjusting tap bounds) that you can review
  and accept.

### Using the accessibility agent in Antigravity

After installing the official [Dart and Flutter plugin](
https://antigravity.google/docs/build-with-google/#dart-and-flutter)
in Antigravity, you can invoke the accessibility agent directly when chatting
with Antigravity by selecting the **Flutter Accessibility Agent** from the
agent picker, mentioning `@flutter_a11y_agent`, or asking your assistant to
review your code for accessibility:

```text
@flutter_a11y_agent Audit this screen for accessibility issues.
```

---

## When to use what

Use the following mental model to understand how different AI mechanisms
interact:

| Mechanism | Scope and behavior | Best suited for |
| :--- | :--- | :--- |
| **Agent skill** | On demand | Multi-step recipes, patterns |
| **Dart MCP server** | Local SDK tools | Diagnostics, tests, runtime |
| **Developer Knowledge MCP** | Online search | Live docs, API references |
| **Package skill** | From dependencies | Library APIs, code generation |
| **Specialized agent** | Isolated subagent | Accessibility audits |

{:.table .table-striped}

## Next steps

* Follow the [Get started with AI](/ai/get-started) guide to install official
  plugins in your editor.
* Learn how to consume and publish [Package skills](/ai/package-skills).
