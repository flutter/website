---
title: Dart and Flutter MCP server
description: >
  Learn about the Dart and Flutter MCP server tool that
  exposes Dart and Flutter tools to compatible
  AI-assistant clients and agents.
---

This guide discusses the Dart and Flutter MCP server.

:::note experimental
The Dart and Flutter MCP server is experimental and likely to evolve quickly.
The following instructions require Dart 3.9 or later.
:::

## Overview

The [Dart and Flutter MCP server][]
exposes Dart and Flutter development tool actions to
compatible AI-assistant clients. MCP (model context protocol)
is a protocol that enables communication between development tools
and AI assistants, allowing the assistants to understand the
context of the code and perform actions on behalf of the developer.

The Dart and Flutter MCP server can work with any MCP client that
supports standard I/O (stdio) as the transport medium.
To access all the features of the Dart and Flutter MCP server,
an MCP client must support [Tools][] and [Resources][].
For the best development experience with the Dart and Flutter MCP server,
an MCP client should also support [Roots][].

If you are using a client that claims it
supports roots but doesn't actually set them,
pass `--force-roots-fallback` to enable tools for managing the roots.

The Dart and Flutter MCP server provides a growing list of tools that
grant AI assistants deep insights into your project.
Here is an overview of a few things it can do:

*  Analyze and fix errors in your project's code.
*  Resolve symbols to elements to ensure their existence and
   fetch documentation and signature information for them.
*  Introspect and interact with your running application.
*  Search the [pub.dev site]({{site.pub}}) for the best package for a use case.
*  Manage package dependencies in your `pubspec.yaml` file.
*  Run tests and analyze the results.
*  Format code with the same formatter and config as
   [`dart format`][] and the Dart analysis server.

[Tools]: https://modelcontextprotocol.io/docs/concepts/tools
[Resources]: https://modelcontextprotocol.io/docs/concepts/resources
[Roots]: https://modelcontextprotocol.io/docs/concepts/roots
[Dart and Flutter MCP server]: https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server
[`dart format`]: {{site.dart-site}}/tools/dart-format

## Set up your MCP client

Run the server with the `dart mcp-server` command,
which must be configured in your preferred client.

This section provides instructions for setting up the
Dart and Flutter MCP server with popular tools like Firebase Studio,
Gemini CLI, Gemini Code Assist, Cursor, and GitHub Copilot.

### Gemini CLI

To configure the [Gemini CLI][] to use the Dart and Flutter MCP server,
add a Dart entry to the `mcpServers` section of the Gemini config.

-  To enable the server for all projects on your device,
   edit the `~/.gemini/settings.json` file in your home directory.
-  To enable the server for a specific project,
   edit the `.gemini/settings.json` file in the project's root directory.

```json title=".gemini/settings.json"
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": [
        "mcp-server"
      ]
    }
  }
}
```

For more information, check out the official Gemini CLI
documentation for [setting up MCP servers][].

[Gemini CLI]: https://geminicli.com/docs/
[setting up MCP servers]: https://geminicli.com/docs/tools/mcp-server/#how-to-set-up-your-mcp-server

### Firebase Studio

If you wish to use the Dart and Flutter MCP Server in [Firebase Studio][],
an agentic cloud-based development environment that helps
you build and ship production-quality full-stack AI apps,
follow these steps:

1.  In your Firebase Studio app project, create a
    `.idx/mcp.json` file in your project if it
    doesn't exist already and add the following
    Dart and Flutter MCP Server configuration to the file:

    ```json title=".idx/mcp.json"
    {
      "mcpServers": {
        "dart": {
          "command": "dart",
          "args": [
            "mcp-server"
          ]
        }
      }
    }
    ```

1.  Ensure your environment is running Dart SDK 3.9/Flutter 3.35 or later.
1.  Rebuild your workspace to complete the setup.
    *   Open the Command Palette (**Shift+Ctrl+P**).
    *   Enter **Firebase Studio: Rebuild Environment**.

For more information about MCP server configuration in
Firebase Studio, see [Customize your Firebase Studio workspace][].

[Firebase Studio]: https://firebase.studio/
[Customize your Firebase Studio workspace]: https://firebase.google.com/docs/studio/customize-workspace

### Gemini Code Assist in VS Code

[Gemini Code Assist][]'s [Agent mode][] integrates the
Gemini CLI to provide a powerful AI agent directly in your IDE.
If you haven't set up Gemini Code Assist or its agent mode yet,
follow its [Before you begin instructions][gca-setup] to get started.

To configure Gemini Code Assist to use the Dart and Flutter MCP server,
follow the instructions to [configure the Gemini CLI][].

You can verify the MCP server has been configured
properly by typing `/mcp` in the chat window in Agent mode.

For more information see the official Gemini Code Assist
documentation for [using agent mode][].

[gca-setup]: https://developers.google.com/gemini-code-assist/docs/use-agentic-chat-pair-programmer#before-you-begin
[Gemini Code Assist]: https://codeassist.google/
[Agent mode]: https://developers.google.com/gemini-code-assist/docs/use-agentic-chat-pair-programmer
[configure the Gemini CLI]: #gemini-cli
[using agent mode]: https://developers.google.com/gemini-code-assist/docs/use-agentic-chat-pair-programmer#before-you-begin

### GitHub Copilot in VS Code

:::note
Support for the Dart and Flutter MCP server in VS Code requires
v3.116 or later of the [Dart Code extension][].
:::

By default, the Dart extension uses the
[VS Code MCP API][] to register the Dart and Flutter MCP server, as well
as a tool to provide the URI for the active Dart Tooling Daemon.

Explicitly enable or disable the Dart and Flutter MCP server by
configuring the `dart.mcpServer` setting in your VS Code settings.

To change this globally, update your user settings:

1.  In VS Code, click **View > Command Palette** and then
    search for **Preferences: Open User Settings (JSON)**.

1.  Add the following setting:

    ```json
    "dart.mcpServer": true
    ```

If you'd like this setting to apply only to a specific workspace,
add the entry to your workspace settings:

1.  In VS Code, click **View > Command Palette** and then
    search for **Preferences: Open Workspace Settings (JSON)**.

1.  Add the following setting:

    ```json
    "dart.mcpServer": true
    ```

For more information, see the official VS Code
documentation for [enabling MCP support][].

[Dart Code extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code
[VS Code MCP API]: https://code.visualstudio.com/api/extension-guides/mcp
[enabling MCP support]: https://code.visualstudio.com/docs/copilot/chat/mcp-servers#_enable-mcp-support-in-vs-code

### Cursor

The easiest way to configure the Dart and Flutter MCP server with
Cursor is by clicking the **Add to Cursor** button:

[![Add to Cursor](https://cursor.com/deeplink/mcp-install-dark.svg)](cursor://anysphere.cursor-deeplink/mcp/install?name=dart&config=eyJjb21tYW5kIjoiZGFydCBtY3Atc2VydmVyIn0%3D){:.light-mode-visible}
[![Add to Cursor](https://cursor.com/deeplink/mcp-install-light.svg)](cursor://anysphere.cursor-deeplink/mcp/install?name=dart&config=eyJjb21tYW5kIjoiZGFydCBtY3Atc2VydmVyIn0%3D){:.dark-mode-visible}

Alternatively, you can configure the server manually:

1.  Go to **Cursor > Settings > Cursor Settings > Tools & Integrations**.
1.  Click **Add Custom MCP** or **New MCP Server**
    depending on whether you already have other MCP servers configured.
1.  Edit the `.cursor/mcp.json` file in your local project
    (configuration will only apply to this project) or
    edit the global `~/.cursor/mcp.json` file in your home directory
    (configuration will apply for all projects) to
    configure the Dart and Flutter MCP server:

    ```json title=".cursor/mcp.json"
    {
      "mcpServers": {
        "dart": {
          "command": "dart",
          "args": [
            "mcp-server"
          ]
        }
      }
    }
    ```

For more information, see the official Cursor
documentation for [installing MCP servers][].

[installing MCP servers]: https://docs.cursor.com/context/model-context-protocol#installing-mcp-servers

## Use your MCP client

Once you've set up the Dart and Flutter MCP server with a client,
the Dart and Flutter MCP server enables the client to not only reason
about your project's context but also to take action with tools.

The [Large Language Model (LLM)][LLM] decides which tools to use and when,
so you can focus on describing your goal in natural language.
Let's see this in action with a couple of examples using
GitHub Copilot's Agent mode in VS Code.

[LLM]: https://developers.google.com/machine-learning/resources/intro-llms

### Fix a runtime layout error in a Flutter app

We've all been there: you build a beautiful UI, run the app,
and are greeted by the infamous yellow-and-black stripes of
a RenderFlex overflow error.
Instead of manually debugging the widget tree, you can now
ask your AI assistant for help with a prompt similar to the following:

> Check for and fix static and runtime analysis issues.
> Check for and fix any layout issues.

Behind the scenes, the AI agent uses the Dart and Flutter MCP server's tools to:

*  See the error: It uses a tool to get the current runtime errors
   from the running application.
*  Inspect the UI: It accesses the Flutter widget tree to understand
   the layout that is causing the overflow.
*  Apply a fix: Armed with this context, it applies a fix and
   checks once more for any remaining errors.

You can then keep or undo the code changes.

### Add new functionality with package search

Imagine you need to add a chart to your app.
Which package should you use? How do you add it and write the boilerplate?
The Dart and Flutter MCP server can streamline this entire process with
a prompt similar to the following:

> Find a suitable package to add a line chart that
> maps the number of button presses over time.

The AI agent now acts as a true assistant:

*  Find the right tool: It uses the `pub_dev_search` tool to
   find popular and highly-rated charting libraries.
*  Manage dependencies: After you confirm its choice,
   such as [`package:fl_chart`][],
   it uses a tool to add the package as a dependency.
*  Generate the code: It generates the new widget code,
   complete with boilerplate for a line chart that it places in the UI.
   It even self-corrects syntax errors introduced during the process.
   You can customize further from there.

What used to be a multi-step process of research,
reading documentation, editing `pubspec.yaml`, and
writing the appropriate code in your app,
is now a single request.

[`package:fl_chart`]: {{site.pub-pkg}}/fl_chart
