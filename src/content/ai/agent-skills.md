---
title: Agent skills for Flutter and Dart
sidenav: ai
shortTitle: Agent skills
description: >-
  Learn how to give AI agents new capabilities and expertise
  using Agent Skills.
---

This guide covers how to enhance your AI agents and coding assistants
with domain-specific capabilities using Agent Skills.

## Overview

[Agent Skills](https://agentskills.io/) provide a standardized way to give AI
agents new capabilities, domain expertise, and repeatable workflows.

Where [rules files](/ai/ai-rules) configure the agents default behavior for all
tasks, Agent Skills give the AI specific tools and instructions for discrete
tasks.

When an AI agent supports Agent Skills, it can dynamically discover and
execute these skills when they are relevant to your request.

## Getting started

By default, compatible AI agents discover Agent Skills within the
`.agents/skills` directory of your project workspace.

To easily download and manage skills in this standard folder, you can use the
`skills` CLI tool. Since the CLI is distributed via npm, you must have
[Node.js](https://nodejs.org/) installed to use the `npx` command.

To install the official Flutter skills:
```bash
npx skills add flutter/skills
```

To install the official Dart skills:
```bash
npx skills add dart-lang/skills
```

This automatically creates the `.agents/skills` directory and copies the
requested skills into your project.

For more details on available skills, updating, and contributing, see the
[Dart skills repository](https://github.com/dart-lang/skills) and
[Flutter skills repository](https://github.com/flutter/skills).

## Official repositories

The Dart and Flutter teams maintain official repositories of Agent Skills
that you can use in your projects.

### Dart skills

The [dart-lang/skills](https://github.com/dart-lang/skills) repository
contains Agent Skills specifically designed for Dart development.

Available skills can help the AI perform tasks such as:

*   Generating unit tests
*   Resolving package dependencies and conflicts
*   Running static analysis and fixing errors
*   Collecting test coverage

### Flutter skills

The [flutter/skills](https://github.com/flutter/skills) repository
contains Agent Skills specifically designed for Flutter development.

Available skills can help the AI perform tasks such as:

*   Building responsive layouts
*   Setting up declarative routing
*   Implementing JSON serialization
*   Running accessibility audits
