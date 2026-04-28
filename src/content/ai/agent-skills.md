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

By giving the AI strict, task-oriented blueprints, these skills help prevent
hallucinations and reduce the "verification tax"—the time you spend manually
auditing and refining AI-generated output.

To understand how Agent Skills fit into your workflow, it helps to compare them
with other AI capabilities:

*   **Rules files**: Where [rules files](/ai/ai-rules) configure the agent's
    default behavior for all tasks, Agent Skills give the AI specific
    instructions for discrete tasks.
*   **Model Context Protocol (MCP)**: Where the
    [Dart and Flutter MCP server](/ai/mcp-server) gives an agent access to
    specialized tools, an Agent Skill provides the instructions and professional
    know-how for using those tools to complete a specific task.

Skills improve context efficiency through "progressive disclosure" (similar to
deferred loading in Flutter). Rather than loading all instructions into the
context window at once, the agent only sees relevant metadata initially. It
dynamically discovers and executes the full skill instructions only when they
are relevant to your request. This improves accuracy while lowering token costs.

## Official repositories

The Dart and Flutter teams maintain official repositories of Agent Skills
tailored for their respective frameworks.

*   **[dart-lang/skills](https://github.com/dart-lang/skills)**: Skills for
    Dart development, such as generating unit tests, resolving package
    dependencies, and fixing static analysis errors.
*   **[flutter/skills](https://github.com/flutter/skills)**: Skills for Flutter
    development, such as building responsive layouts, setting up declarative
    routing, and implementing JSON serialization.

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
