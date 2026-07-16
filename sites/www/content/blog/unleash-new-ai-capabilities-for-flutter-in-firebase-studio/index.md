---
title: "Unleash new AI capabilities for Flutter in Firebase Studio"
description: "Flutter development just got a lot smarter in Firebase Studio! At I/O Connect India, we unveiled new AI-powered features designed to give…"
publishDate: 2025-07-23
author: antfitch
image: images/1lPy6kRkj2N5ybEhHIKjbVw.webp
category: announcement
layout: blog
---

Flutter development just got a lot smarter in Firebase Studio! At I/O Connect India, we unveiled new AI-powered features designed to give you a more automated and productive workflow. In this post, we’ll dive into the new AI enhancements specifically for Flutter in Firebase Studio, and show you how you can use them to build powerful applications like the demo we showcased on stage.

## Upgraded AI-optimized Flutter template

The Flutter template in [Firebase Studio](https://firebase.studio/) received a significant upgrade. With its new AI capabilities, you can optimize your workspace for an AI-first experience. For example, when building the I/O Connect India demo with this new template, Firebase Studio generated a multi-screen, e-commerce app complete with state management, Firebase authentication, products, a cart, and checkout. The AI-optimized template defaults to autonomous Agent mode, allowing Gemini to make changes directly without waiting for approval. We’ve also incorporated rules for Gemini into an (automatically generated) `airules.md` file to further refine the code Gemini generates, enabling you to add features or generate an entire Flutter app in a more streamlined flow.

<DashImage figure src="images/1lPy6kRkj2N5ybEhHIKjbVw.webp" alt="The Flutter template in Firebase Studio has been upgraded for an AI-first experience" caption="The Flutter template in Firebase Studio has been upgraded for an AI-first experience" />


## Autonomously make changes

Previously, when working on a Flutter project in Firebase Studio, you would manually approve each code change in Agent mode. This workflow has evolved significantly and can make edits autonomously (independently and automatically). With the new Agent (Auto-run) mode, Gemini can now autonomously make changes, generate entire apps, and add features in a streamlined flow. For instance, when developing an app similar to our I/O Connect India demo, you can use Agent (Auto-run) mode to seamlessly integrate Firebase backend services and implement complex navigation patterns in a single interaction. Given Gemini’s robust support for Dart and Flutter, this autonomous mode keeps you in the development flow. And if a change isn’t exactly what you intended, rest assured that Firebase Studio leverages Git, allowing you to quickly revert your changes to a previous commit.

<DashImage figure src="images/1i5KGoCCzGQXV5SuTYhbpbw.webp" alt="Agent (Auto-run) mode with a Flutter project in Firebase Studio" caption="Agent (Auto-run) mode with a Flutter project in Firebase Studio" />


## AI rules

With the upgraded Flutter template, we’ve incorporated AI instructions into a new file: `airules.md`. This file (located at the root of your project), contains explicit rules for Gemini to follow as it generates code, enhancing the quality and relevance of the output. You have the flexibility to either use the default AI rules or customize them to fit your project’s specific needs. While there are numerous rules, here are a few examples:

* Act as a Flutter co-developer

* Writes unit tests

* Proactively look for and fix errors

* Choose which themes, tools, extensions, and startup commands to use

* Add and remove Flutter packages

* Adhere to Flutter and Dart best practices for code quality

* Set up complex navigation

<DashImage figure src="images/1FPNH3GWzShcGYInVxc30qA.webp" alt="Overview of the default Flutter AI rules (airules.md) in Firebase Studio" caption="Overview of the default Flutter AI rules (airules.md) in Firebase Studio" />


## Compatible with Dart MCP Server

Firebase Studio now includes foundational support for the Model Context Protocol (MCP), and we’re excited to share that it works with our [Dart MCP Server](https://dart.dev/tools/mcp-server). When integrated within Firebase Studio, the Dart MCP Server empowers Gemini in Firebase Studio to analyze and automatically fix Dart and Flutter-specific errors in your project’s code. You can also efficiently search pub.dev for optimal packages, manage dependencies in `pubspec.yaml`, run tests, and much more. For example, when building a Flutter app similar to the one we demoed on stage at I/O Connect India, Gemini should identify and autonomously correct both static and runtime errors. Currently, Dart MCP Server is in beta.

To learn how you can use the Dart MCP Server while building your Flutter app in Firebase Studio, see the [Supercharge Your Dart & Flutter Development Experience with the Dart MCP Server](https://medium.com/flutter/supercharge-your-dart-flutter-development-experience-with-the-dart-mcp-server-2edcc8107b49) blog post.

<DashImage figure src="images/0CHTpeFMydBD0KQY9.webp" alt="Dart MCP Server configuration for a Flutter app in Firebase Studio" caption="Dart MCP Server configuration for a Flutter app in Firebase Studio" />


## Build with us

We have ambitious plans for the continued integration of Firebase Studio with Flutter, and we’re eager to [hear your feedback on using Flutter in Firebase Studio](https://community.firebasestudio.dev/) as you explore these new capabilities. We’re incredibly excited to see what you create!