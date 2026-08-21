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

1. **Agent skills**: Task-oriented blueprints that teach assistants how to
   perform specific workflows (such as creating responsive layouts or writing
   tests).
2. **Dart and Flutter MCP server**: A Model Context Protocol (MCP) server
   exposing real-time IDE analysis, symbol resolution, and runtime
   introspection to assistants.
3. **Package skills**: Skills published directly inside third-party `pub.dev`
   packages, giving assistants instant expertise on specific libraries.
4. **AI rules**: Always-on workspace instructions providing high-level
   project conventions and style guidance.
5. **Custom agents**: Specialized agent personas configured for dedicated
   tasks like automated triage or migration.

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

## AI rules

**AI rules** provide persistent, project-wide instructions that are included
in every prompt. Unlike on-demand skills, rules define baseline standards for
your codebase, such as architectural conventions, code styling, and package
preferences.

Depending on your coding assistant, rules are stored in standard workspace
files such as `.github/copilot-instructions.md`, `.cursorrules`, `CLAUDE.md`,
or `GEMINI.md`.

You can use the official [Flutter SDK rules template](
https://github.com/flutter/flutter/blob/main/docs/rules/rules.md) as a starting
point for establishing project-wide conventions.

---

## Custom agents

**Custom agents** (or subagents) are specialized agent personas configured with
targeted system prompts, dedicated roles, and constrained tool access to perform
focused tasks.

Rather than relying on a single generalist prompt, you can configure dedicated
agents for specific workflows, such as:

* **Accessibility reviewers**: Inspecting widget trees and semantics for a11y
  compliance.
* **API migration assistants**: Converting legacy APIs to current Flutter
  patterns across large repositories.
* **Automated test generators**: Authoring regression and unit test suites
  following `package:test` best practices.

To explore pre-configured agent templates and definitions, check out the
[Flutter agent plugins repository](https://github.com/flutter/agent-plugins).

---

## When to use what

Use the following mental model to understand how different AI mechanisms
interact:

| Mechanism | Scope and behavior | Best suited for |
| :--- | :--- | :--- |
| **Agent skill** | Triggered on demand | Multi-step recipes |
| **MCP tool** | Tool execution with results | Symbols, tests, diagnostics |
| **AI rule** | Always-on workspace context | Project style, architecture |
| **Custom agent** | Standalone persona | Bug burndown, PR reviews |

{:.table .table-striped}

:::note
**Measuring AI tooling quality:** To learn how Flutter and Dart measure
agent reliability and correctness across developer workflows, check out the
[Flutter Evals repository](https://github.com/flutter/evals).
:::

## Next steps

* Follow the [Get started with AI](/ai/get-started) guide to install official
  plugins in your editor.
* Learn how to consume and publish [Package skills](/ai/package-skills).
