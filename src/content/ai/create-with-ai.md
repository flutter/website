---
title: Create with AI
description: >
  Learn how to use AI to build Flutter apps, from powerful SDKs that integrate
  AI features directly into your app to tools that accelerate your development
  workflow.
---

This guide covers how you can leverage AI tools to build AI-powered features for
your Flutter apps and streamline your Flutter and Dart development.

## Overview

AI can be used for building AI-powered apps with Flutter and
for accelerating your development workflow. You can
integrate AI-powered features like
natural language understanding and content generation
directly into your Flutter app using powerful SDKs,
like the Firebase SDK for Generative AI. You can also use
AI tools, such as Gemini Code Assist and Gemini CLI, to help
with code generation and scaffolding. These tools are
powered by the Dart and Flutter MCP Server, which provides
AI with a rich context about your codebase. Additionally,
rules files help fine-tune the AI's behavior and enforce
project-specific best practices.

## Build AI-powered experiences with Flutter

Using AI in your Flutter app unlocks new user experiences that allow your app
to support natural language understanding and content generation. 

To get started building AI-powered experiences in Flutter, check out these 
resources:

* [Firebase AI Logic][] - The official Firebase SDK for using generative AI
  features directly in Flutter. Compatible with the Gemini Developer API or
  Vertex AI. To get started, check out the
  [official documentation][firebase-ai-logic-docs].
* [Flutter AI Toolkit][] - A sample app with pre-built widgets to help you build
  AI-powered features in Flutter

[Firebase AI Logic]: {{site.firebase}}/docs/ai-logic
[firebase-ai-logic-docs]: {{site.firebase}}/docs/ai-logic/get-started
[Flutter AI Toolkit]: {{site.url}}/ai-toolkit

## AI development tools

AI can not only be a feature in your app, but also a powerful assistant in your
development workflow. Tools like Gemini Code Assist and the Gemini CLI can help
you write code faster, understand complex concepts, and reduce boilerplate.

### Gemini Code Assist

[Gemini Code Assist][] is an AI-powered collaborator available in
Visual Studio Code and JetBrains IDEs (including Android Studio). It has a deep
understanding of your project's codebase and can help you with:

* **Code completion and generation**: It suggests and generates entire blocks of
  code based on the context of what you're writing.
* **In-editor chat**: You can ask questions about your code, Flutter concepts,
  or best practices directly within your IDE.
* **Debugging and explanation**: If you encounter an error, you can ask Gemini
  Code Assist to explain it and suggest a fix, and
  [Dart and Flutter MCP Server][dart-mcp-flutter-docs]

[Gemini Code Assist]: https://codeassist.google/

### Gemini CLI

The [Gemini CLI][] is a command-line AI workflow tool. It allows you to interact
with Gemini models for a variety of tasks without leaving your development
environment. You can use it to:

* Quickly scaffold a new Flutter widget, Dart function, or a complete app.
* Use MCP server tools, such as the Dart and Flutter MCP server
* Automate tasks like committing and pushing changes to a Git repository

To get started, visit the [Gemini CLI][] website, or try this
[Gemini CLI codelab][].

[Gemini CLI]: {{site.github}}/google-gemini/gemini-cli
[Gemini CLI codelab]: https://codelabs.developers.google.com/gemini-cli-hands-on

## Dart and Flutter MCP Server

To provide assistance during Flutter development, AI tools such as
Gemini Code Assist and Gemini CLI need to communicate with Dart
and Flutter's developer tools. The Dart and
Flutter MCP Server facilitates this communication.
MCP (model context protocol) is a specification that
outlines how development tools can share the context of a user's code
with an AI model, which allows the AI to better understand and interact
with the code.

The Dart and Flutter MCP server provides a growing list of tools to analyze
and fix errors, hot reload, get the selected widget, and more. This bridges
the gap between the AI's natural language understanding, and
Dart and Flutter's suite of developer tools.

To get started, check out the official documentation for the
[Dart and Flutter MCP server][dart-mcp-dart-docs]
on dart.dev and the [Dart and Flutter MCP repository][dart-mcp-github].

[dart-mcp-dart-docs]: {{site.dart-site}}/tools/mcp-server
[dart-mcp-github]: {{site.github}}/dart-lang/ai/tree/main/pkgs/dart_mcp_server
[dart-mcp-flutter-docs]: #dart-and-flutter-mcp-server

## Rules for Flutter and Dart

You can use a rules file with AI-powered editors to provide
context and instructions to an underlying LLM. To get
started, see the [AI rules for Flutter and Dart][] guide.

[AI rules for Flutter and Dart]: /ai/ai-rules
