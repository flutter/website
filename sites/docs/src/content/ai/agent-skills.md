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

AI agents can write Flutter and Dart code, but they sometimes are unaware of
tools and best practices that professional developers use.

[Agent Skills](https://agentskills.io/) help solve this problem by providing a
standardized way to give your AI agent a set of task-oriented blueprints to
follow. By giving the agent actual domain expertise and repeatable workflows,
you drastically reduce mistakes and can enforce consistent patterns.

To understand how Agent Skills fit into your workflow, consider how they compare
to other AI capabilities:

*   **Rules files:** While [rules files](/ai/ai-rules) configure the agent's
    general behavior across all tasks, Agent Skills give the AI step-by-step
    instructions for one specific job.
*   **Model Context Protocol (MCP):** The [Dart and Flutter MCP
    server](/ai/mcp-server) gives your agent access to specialized tools. If MCP
    provides the raw machinery, an Agent Skill provides the professional
    know-how to operate that machinery correctly.

Skills use what we call "progressive disclosure," which is similar to deferred
loading in Flutter. Instead of loading every single instruction into the context
window up front, the agent only reads the metadata first. It pulls in the heavy,
detailed instructions only when it actually needs them for the task at hand.

## Official repositories

The Dart and Flutter teams maintain official repositories packed with skills
tailored specifically for our frameworks.

*   **[dart-lang/skills](https://github.com/dart-lang/skills)**: Provides skills
    for Dart development. Use these to generate unit tests, resolve package
    dependencies, and fix static analysis errors.
*   **[flutter/skills](https://github.com/flutter/skills)**: Provides skills for
    Flutter development. These skills help the AI build responsive layouts, wire
    up declarative routing, and implement JSON serialization.

## Getting started

By default, compatible AI agents discover Agent Skills within the
`.agents/skills` directory of your project workspace.

To easily download and manage skills in that folder, you can use the `skills`
CLI tool. It's distributed through npm, so you'll need
[Node.js](https://nodejs.org/) installed to run it with `npx`.

To install the official Flutter skills:

```bash
npx skills add flutter/skills --skill '*' --agent universal
```

And to install the official Dart skills:

```bash
npx skills add dart-lang/skills --skill '*' --agent universal
```

Running these commands automatically creates the `.agents/skills` directory and
downloads the requested skills into your project.

For more details on available skills, updating, and contributing, see the
[Dart skills repository](https://github.com/dart-lang/skills) and the
[Flutter skills repository](https://github.com/flutter/skills).

:::tip
Once you've added skills to your project, try asking your AI agent to review
the `.agents/skills` directory. You can ask, "Which of my installed skills
can help me with [your current task]?" or "Summarize the capabilities of the
skills I have available."
:::
