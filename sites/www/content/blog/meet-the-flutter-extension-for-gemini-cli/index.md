---
title: "Meet the Flutter Extension for Gemini CLI"
description: "Build high quality, feature rich apps with the new Flutter Extension for Gemini CLI"
publishDate: 2025-10-08
author: johnpryan
image: images/1CXyt0NsoasPW5__Ev4AGNg.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1CXyt0NsoasPW5__Ev4AGNg.webp" />

## Meet the Flutter Extension for Gemini CLI

### Build high quality, feature rich apps with the new Flutter Extension for Gemini CLI

Today we’re excited to share the first experimental version of the **Flutter Extension for Gemini CLI**, which combines the [Dart and Flutter MCP Server](https://blog.flutter.dev/supercharge-your-dart-flutter-development-experience-with-the-dart-mcp-server-2edcc8107b49) with additional context and commands, making it easier and more productive to build Flutter apps with [Gemini CLI](https://geminicli.com/).

AI agents are changing the way we build Flutter apps by assisting with tasks like feature prototyping, code reviews, as well as writing and running tests. In order to use an AI agent effectively, you need to provide it with context and access to tools to help it become a productive Flutter coding assistant. This is where the Flutter Extension for Gemini CLI comes in. [Gemini CLI extensions](https://blog.google/technology/developers/gemini-cli-extensions) allow you to build integrations with Gemini CLI and your tools, and the Flutter extension builds off of these capabilities.

The Flutter Extension for Gemini CLI provides commands to accelerate app development, follows explicit rules to write high-quality code following Dart and Flutter best-practices, and runs tools from the Dart and Flutter MCP server to directly access Dart and Flutter’s developer tools. You spend less time on setup and more time building high quality Flutter apps.

## See it in action

To get started, install the extension with the following command in your terminal:

```bash
$ gemini extensions install https://github.com/gemini-cli-extensions/flutter
```

The Flutter Extension for Gemini CLI comes with a set of commands to help you with critical stages of development. Here are a few of the most common commands and how to use them:

* `/create-app`: Creates a design doc and implementation plan for Gemini to follow.

* `/modify`: Creates a plan to make large changes to the app.

* `/commit`: Analyzes and tests the code, fixes any issues that were found, and then commits the change to Git.

To learn more about how to set up and use the Gemini CLI extension, follow the instructions in the [GitHub repository](https://github.com/gemini-cli-extensions/flutter).

### Create an app

You can create a new application using the `/create-app` command. This command bootstraps a brand-new, production-ready Flutter app. It goes beyond `flutter create` by asking for your app’s purpose, setting up recommended linter rules, and generating detailed `DESIGN.md` and `IMPLEMENTATION.md` files for your review before any code is written.

```plaintext
/create-app
```

<DashImage figure src="images/1xmF3JHqzQi-d9W79JcscZw.gif" alt="Create app app with the /create-app command" caption="Create app app with the /create-app command" />

The `DESIGN.md` file is a design document for the app; it specifies the problems that the app solves and provides technical details about how it will work. You can edit this file before you continue with the implementation steps, allowing you to guide Gemini to build the exact app that you’re looking for.

Once the design is ready, `/create-app` generates an `IMPLEMENTATION.md` file, a step-by-step implementation plan, so that it can iteratively work on feature implementation. It keeps a record of its progress, so you can pause and restart. By default, `/create-app` splits the plan up into 3–5 phases, where each phase is a logical stopping point. After each phase, Gemini will analyze and format the code, run tests, and commit the changes. It will also update this file after it completes a phase in the Journal section.

### Implement features from the plan

After you’ve set up your project, you’re ready to implement the features in your implementation plan using the generated `IMPLEMENTATION.md` file. Each feature will be implemented separately, as outlined in this file. Once it finishes implementing a feature, the Flutter Extension will mark it as complete.

Before moving to the next phase, the extension will ask for your approval. You can enter the prompt “looks good” to start generating code:

<DashImage figure src="images/1fK1Ra4g1hYe0nGwRFj4nCQ.gif" alt="The guided implementation plan keeps Gemini CLI on track" caption="The guided implementation plan keeps Gemini CLI on track" />

### Modify

To make changes to existing code, the `/modify` command initiates a guided development session. It asks for your goals, offers to create a new branch, and generates a `MODIFICATION_PLAN.md` design doc outlining the proposed modifications and a phased implementation plan.

```plaintext
/modify
```

<DashImage figure src="images/18hlXVoJUQVz3piOiCsg-gQ.gif" alt="Use the /modify command to create a detailed modification plan for Gemini to follow" caption="Use the /modify command to create a detailed modification plan for Gemini to follow" />

### Clean up and commit

The final step is to commit the changes using `/commit`. This command prepares your changes before committing them with Git. It automatically runs `dart fix` and `dart format`, runs the analyzer and tests, and then generates a descriptive commit message based on the changes for you to approve.

<DashImage figure src="images/1CawKl49B-kWc1XoPGHVTaw.gif" alt="Use the /commit command to clean up and prepare the code for commit" caption="Use the /commit command to clean up and prepare the code for commit" />

## Fully loaded with best-practices

Every interactive chat session includes rules containing best-practices for Flutter and Dart development. These rules ensure that Gemini writes high-quality Dart and Flutter code, interacts with MCP server tools correctly, and follows best practices such as creating unit tests, writing documentation, ensuring accessibility, and more.

<DashImage figure src="images/1tOfRiFIWVkDO3IXLRFcnEw.gif" alt="The extension includes rules and best-practices" caption="The extension includes rules and best-practices" />

## Access to development tools with the Flutter and Dart MCP server

The Dart and Flutter MCP server is automatically configured when you install the Flutter Extension for Gemini CLI. This allows Gemini CLI and other AI agents to perform common development tasks:

* **Analyze and fix errors** in your project’s code.

* **Introspect and interact with your running application** (such as trigger a hot reload, get the selected widget, fetch runtime errors).

* **Search pub.dev** for the best package for your use case.

* **Manage package dependencies** in your `pubspec.yaml` file.

* **Run tests** and analyze the results.

* …and more!

<DashImage figure src="images/1iiDlKE9ikBNvUMHvr6YWSw.gif" alt="The MCP server provides Gemini CLI access to Dart and Flutter DevTools" caption="The MCP server provides Gemini CLI access to Dart and Flutter DevTools" />

## Try it out

We hope you try out the Flutter extension for Gemini CLI and share your feedback.

Check out the [Flutter extension on GitHub](https://github.com/gemini-cli-extensions/flutter) to learn more. If you have suggestions or run into problems, please [file an issue](https://github.com/gemini-cli-extensions/flutter/issues). We can’t wait to see what you build!
