---
title: Flutter extension for Gemini CLI
description: >
  Learn how to use the Flutter extension for Gemini CLI
  to make structured changes to your app at the command line
  using the Dart and Flutter MCP server.
---

You might be familiar with Gemini CLI,
a command-line AI workflow tool that enables you
to interact with Gemini AI models without leaving
your development environment.
(If you aren’t familiar with Gemini, you can learn more
by working through the [Hands on with Gemini][] codelab.)

[Hands on with Gemini]: {{site.codelabs}}/gemini-cli-hands-on

AI agents are changing the way we build Flutter apps by
assisting with tasks like feature prototyping, code reviews,
as well as writing and running tests.
To use an AI agent effectively, you need to provide it with
context and access to tools to help it become a productive
Flutter coding assistant.
This is where the Flutter Extension for Gemini CLI comes in.
Gemini CLI extensions allow you to build integrations with
Gemini CLI and your tools,
and the Flutter extension expands on these capabilities.

The Flutter Extension for Gemini CLI provides commands
to accelerate app development, follows explicit rules to
write high-quality code following Dart and Flutter best practices,
and runs tools from the Dart and Flutter MCP server to directly
access Dart and Flutter’s developer tools. You spend less time
on setup and more time building high quality Flutter apps.

The following video showcases
[how to build multiplatform apps with Gemini CLI][gemini-cli-video]:

<iframe width="560" height="315" src="https://www.youtube.com/embed/RZPkE5sllck?si=szuMDq8uisH7OnVI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

[gemini-cli-video]: https://youtu.be/RZPkE5sllck?si=lM0sGs-V6nx7Tw6T

## Prerequisites

1. Install Gemini CLI 0.4.0 or later.
   You can do this with npm or brew, depending on your platform,
   preference, and system configuration.

2. Install the Flutter SDK, which includes the Dart SDK.
   If Flutter is already installed,
   make sure that you have the latest versions of
   Flutter and Dart by running flutter upgrade.

3. Install Git and make sure it’s available on your PATH.

## Get started

:::experimental
The Flutter extension for Gemini CLI is in
alpha and is likely to change.
:::

Once the prerequisites are satisfied, install the Flutter
extension for Gemini CLI by using one of the following commands:

1. To install the current version, run the following:

    ```console
    gemini extensions install https://github.com/gemini-cli-extensions/flutter
    ```

2. To install the current version and ensure that future
   updates are automatically installed, use the `auto-upate` tag:

   ```console
   gemini extensions install https://github.com/gemini-cli-extensions/flutter.git --auto-update
   ```
After asking if you are sure you want to proceed,
you will see a message that the Flutter extension is installed and enabled.

3. You can manage the extension with the following commands:

   - Update to the latest version:

      ```console
      gemini extensions update flutter
      ```

   - Uninstall the extension:

      ```console
      gemini extensions uninstall flutter
      ```

## Available commands

After installing the extension,
these commands are available when you open
a new Gemini CLI session:

* `/create-app` - Guides you through bootstrapping a new
  Flutter project with best practices.
* `/create-package` - Guides you through bootstrapping
  a new Dart package with best practices.
* `/modify` - Manages a structured modification session
  with automated planning.
* `/commit` - Automates pre-commit checks and generates
  a descriptive commit message.

## Create an app

You can create a new application using the `/create-app` command.
This command bootstraps a brand-new, production-ready Flutter app.
It goes beyond flutter create by asking for your app’s purpose,
setting up recommended linter rules,
and generating detailed `DESIGN.md` and `IMPLEMENTATION.md`
files for your review before any code is written.

```console
/create-app
```

The `DESIGN.md` file is a design document for the app;
it specifies the problems that the app solves and provides
technical details about how it will work. You can edit
this file before you continue with the implementation steps,
allowing you to guide Gemini to build the exact app that you’re looking for.

Once the design is ready, `/create-app` generates an
`IMPLEMENTATION.md` file, a step-by-step implementation plan,
so that it can iteratively work on feature implementation.
It keeps a record of its progress, so you can pause and restart.
By default, `/create-app` splits the plan up into 3–5 phases,
where each phase is a logical stopping point.
After each phase, Gemini will analyze and format the code,
run tests, and commit the changes. It also updates this file
after it completes a phase in the Journal section.

## Implement features from the plan

After you’ve set up your project, you’re ready to implement
the features in your implementation plan using the generated
`IMPLEMENTATION.md` file. Each feature is implemented separately,
as outlined in this file. Once it finishes implementing a feature,
the Flutter extension will mark it as complete.

Before moving to the next phase, the extension asks for your approval.
You can enter the prompt "looks good" to start generating code.

## Modify

To make changes to existing code, the `/modify` command
initiates a guided development session. It asks for your goals,
offers to create a new branch, and generates a `MODIFICATION_PLAN.md`
design doc outlining the proposed modifications and a phased implementation plan.

```console
/modify
```

## Clean up and commit

The final step is to commit the changes using `/commit`.
This command prepares your changes before committing them with Git.
It automatically runs `dart fix` and `dart format`,
runs the analyzer and tests, and then generates a descriptive
commit message based on the changes for you to approve.

## Fully loaded with best practices

Every interactive chat session includes rules containing
best practices for Flutter and Dart development.
These rules ensure that Gemini writes high-quality Dart and Flutter code,
interacts with MCP server tools correctly,
and follows best practices such as creating unit tests,
writing documentation, ensuring accessibility, and more.

## Access to development tools with the Flutter and Dart MCP server

The Dart and Flutter MCP server is automatically configured
when you install the Flutter Extension for Gemini CLI.
This allows Gemini CLI and other AI agents to perform common
development tasks. For example:

* Analyze and fix errors in your project’s code.
* Introspect and interact with your running application
  (such as trigger a hot reload, get the selected widget,
  fetch runtime errors).
* Search `pub.dev` for the best package for your use case.
* Manage package dependencies in your `pubspec.yaml` file.
* Run tests and analyze the results.

## Resources

As previously mentioned, this extension is in alpha.
If you find a bug, please [file an issue][].

You also might want to check out the
[Gemini CLI extension][] repo.

[file an issue]: {{site.github}}/gemini-cli-extensions/flutter/issues
[Gemini CLI extension]: {{site.github}}/gemini-cli-extensions/flutter
