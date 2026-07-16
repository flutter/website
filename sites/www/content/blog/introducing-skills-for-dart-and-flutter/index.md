---
title: "Introducing Skills for Dart and Flutter"
description: "Improving AI with domain expertise"
publishDate: 2026-05-06
author: mariam_hasnany
image: images/1-cp6K90CIG7efKBLyiZ_jw.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1-cp6K90CIG7efKBLyiZ_jw.webp" alt="Introducing prepackaged Dart and Flutter Skills!" caption="Introducing prepackaged Dart and Flutter Skills!" />

## Introducing Skills for Dart and Flutter

### Improving AI with domain expertise

AI agents are generalists, but when it comes to professional Flutter development, “general” isn’t enough. To build production-grade apps, you need an assistant that understands the nuance of localization, the latest Dart language features, and how to add integration tests.

Today, we’re introducing **Agent Skills** for Flutter and Dart — a new way to give your AI tools domain-specific expertise.

## Beyond the knowledge gap

One of the primary challenges in AI development is the “knowledge gap.” Flutter and Dart can launch new features more quickly than LLMs can update their fixed training data. As a part of [how we are thinking about AI](https://medium.com/flutter/how-dart-and-flutter-are-thinking-about-ai-in-2026-e2fd64e1fdd0), we are looking for ways to not only address the knowledge gap but also ensure the agent applies that knowledge to achieve the task accurately and efficiently following the most optimal workflows.

A little over a year ago, Model Context Protocols (MCP) were the way to provide more AI domain-specific expertise. While MCP gives an agent access to specialized tools, an Agent Skill teaches the agent *how* to use those tools for a specific task. Think of it this way: MCP provides the hammer and nails (the tools), while a Skill provides the blueprint and the professional know-how to build the house.

Skills improve context efficiency through “progressive disclosure”. This is similar to how deferred loading works in Flutter, where apps can load libraries when needed, coding agents load Skills when they are relevant to what you’re trying to do .

For Flutter and Dart, these Skills provide tailored instructions for common workflows, and enhance the tools provided in the Dart MCP server to reduce the knowledge gap, which improves accuracy and lowers token usage.

## A task-oriented approach

Our early experimentation revealed that Skills that only provide documentation don’t add as much value as we initially assumed. Since Flutter’s comprehensive and well written documentation is open-sourced, modern models are already highly capable of finding relevant information for most questions and tasks.

So, we pivoted to creating Skills that are “task-oriented”. Every skill in our GitHub [Flutter Skills](https://github.com/flutter/skills) or [Dart Skills](https://github.com/dart-lang/skills) repositories focuses on developer tasks like building adaptive layouts- by providing instructions for agents to reliably complete the task. We have conducted extensive manual evaluations to define our initial set of launched skills, and are working on an automated evaluation pipeline that we will share soon.

## Using the Skills

To start using these Skills in your workflow, first install the Skill set in your project directory:

```shell
npx skills add flutter/skills - skill '*' - agent universal
npx skills add dart-lang/skills - skill '*' - agent universal
```

You will be asked to select the Skills you want to install. Pick all or select the specific ones you might find most useful.

Then choose the agent that you prefer to develop with.

Now, prompt your AI agent as usual. Here are 5 ways you can use these Skills today:

**Skill #1**: `flutter-add-integration-test`

Configures Flutter Driver for app interaction and converts MCP actions into permanent integration tests.

```plaintext
Add an integration test for the checkout flow in my app
```

**Skill #2**: `flutter-setup-localiztion`

Adds localization support to your Flutter project

```plaintext
Set up localization in my app
```

**Skill #3**: `flutter-build-responsive-layout`

Uses `LayoutBuilder`, `MediaQuery`, or `Expanded`/`Flexible` to create a layout that adapts to different screen sizes.

```plaintext
Ensure that the checkout screen uses repsonsive layout
```

**Skill #4**: `dart-use-pattern-matching`

Refactors code to use Dart’s pattern matching language capabilities where appropriate

```plaintext
Refactor my code so that it uses pattern matching where possible
```

**Skill #5**: `dart-collect-coverage`

Uses the `coverage` package to collect unit test coverage and generate an LCOV report.

```plaintext
Collect test coverage for my project
```

For more prompt examples, check out the readme [Flutter Skills](https://github.com/flutter/skills) or [Dart Skills](https://github.com/dart-lang/skills) repositories on GitHub.

## Tell us what you think

These initial core Skills, designed to handle the most common Flutter development hurdles, are just the beginning. We want to build the future of AI-assisted development with you, our community. As you use these Skills and create new ones for your projects, file issues ([Dart Skills repo](https://github.com/dart-lang/skills/issues), [Flutter Skills repo](https://github.com/flutter/skills/issues)), and let us know what additional work you’d like to see. We look forward to helping improve your productivity as you use these Skills!
