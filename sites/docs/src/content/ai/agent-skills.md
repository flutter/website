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

[Agent skills](https://agentskills.io/) help solve this problem by providing a
standardized way to give your AI agent a set of task-oriented blueprints to
follow. By giving the agent actual domain expertise and repeatable workflows,
you drastically reduce mistakes and can enforce consistent patterns.

To understand how agent skills fit into your workflow, consider how they compare
to other AI capabilities:

*   **Rules files:** While [rules files](/ai/ai-rules) configure the agent's
    general behavior across all tasks, agent skills give the AI step-by-step
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
*   **[flutter/agent-plugins](https://github.com/flutter/agent-plugins)**:
    Provides skills for Flutter development.
    These skills help the AI build responsive layouts,
    set up declarative routing, and implement JSON serialization.

## Install agent skills

The recommended way to install skills for your project is by following the
[Get started with AI](/ai/get-started) guide, which provides step-by-step
plugin and skill installation for Claude Code, Codex, Antigravity, Cursor, and
other tools.

### Universal agent installation

By default, compatible AI agents discover agent skills within the
`.agents/skills` directory of your project workspace.

To download and manage skills in that folder, you can use the `skills` CLI tool.
It's distributed through npm, so you need [Node.js](https://nodejs.org/)
installed to run it with `npx`.

To install the official Flutter skills:

```bash
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes
```

And to install the official Dart skills:

```bash
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

Running these commands automatically creates the `.agents/skills`
directory and downloads the requested skills into your project.

## Manage and verify agent skills

For more details on available skills, updating, and contributing, see the
[Dart skills repository](https://github.com/dart-lang/skills) and the
[Flutter agent-plugins repository](https://github.com/flutter/agent-plugins).

:::tip
Once you've added skills to your project, try asking your AI agent to review
your installed skills. You can ask, "Which of my installed skills
can help me with [your current task]?" or "Summarize the capabilities of the
skills I have available."
:::
