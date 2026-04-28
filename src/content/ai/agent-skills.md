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

Where [rules files](/ai/ai-rules) configure the AI's general behavior and
constraints, Agent Skills give the AI specific, actionable tools and
instructions for discrete tasks.

When an AI agent supports Agent Skills, it can dynamically discover and
execute these skills when they are relevant to your request.

## How it works

Skills are defined using a `SKILL.md` file that includes:

*   **Metadata:** Information like the name and description of the skill.
*   **Instructions:** Detailed steps for the agent to follow.
*   **Resources:** Optional scripts or reference files.

Agents load the metadata at startup to understand what skills are available,
and then read the full `SKILL.md` instructions when a task matches the
skill's description.

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

## Getting started

To use these skills in a compatible AI agent, you can add them directly to
your project. For example, to install the Flutter skills:

```bash
npx skills add flutter/skills
```

For more details on available skills, updating, and contributing, see the
[Dart skills repository](https://github.com/dart-lang/skills) and
[Flutter skills repository](https://github.com/flutter/skills).
