---
title: "Supercharge Your Dart & Flutter Development Experience with the Dart MCP Server"
description: "By Ander Dobo — Product Manager, and Kenzie Davisson — Engineer"
publishDate: 2025-07-23
author: anderdobo
image: images/13K1rgoDtIBWbIFZPp1VCEQ.webp
category: announcements
layout: blog
---

## Supercharge Your Dart & Flutter Development Experience with the Dart and Flutter MCP Server

**By Ander Dobo — Product Manager, and Kenzie Davisson — Engineer**

The landscape of AI development is rapidly evolving, with powerful agents capable of assisting developers across a myriad of tasks. To truly unlock their potential, these agents need to access context and tools beyond their inherent capabilities. This is where the [Model Context Protocol](https://modelcontextprotocol.io/introduction) (MCP) comes in, acting as a standardized plugin system that connects AI models to external systems and data sources. The Dart and Flutter MCP Server is our implementation of this standard for the Dart and Flutter ecosystem.

This article explores how you can leverage the Dart and Flutter MCP Server to enhance your Dart and Flutter development experience. We’ll cover useful tools provided by the Dart and Flutter MCP Server and show how you can configure the server for use in popular tools like the Gemini CLI, Gemini Code Assist in VS Code, Cursor, and GitHub Copilot in VS Code.

This approach is part of a rapidly growing ecosystem. For instance, the Firebase team recently announced their own experimental [Firebase MCP Server](https://firebase.blog/posts/2025/05/firebase-mcp-server/), which gives AI assistants tools to manage Firebase Authentication, query a Firestore database, and understand the types of application crashes impacting your application in production.

## Introducing the Dart and Flutter MCP Server

The [Dart and Flutter MCP Server](https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server) (which requires the Dart SDK 3.9/Flutter 3.35 beta or later) is a powerful tool that bridges the gap between AI coding assistants and the Dart/Flutter development ecosystem. It allows AI models to interact with your development environment and your running Dart or Flutter application, providing intelligent insights, and using tooling normally only accessible from your IDE or from Dart & Flutter DevTools.

## What can the Dart and Flutter MCP Server do for you?

The Dart and Flutter MCP Server provides a growing list of tools that grant AI assistants deep insights into your project. It can:

* **Analyze and fix errors** in your project’s code.

* **Introspect and interact with your running application** (such as trigger a hot reload, get the selected widget, fetch runtime errors).

* **Search pub.dev** for the best package for your use case.

* **Manage package dependencies** in your `pubspec.yaml`.

* **Run tests** and analyze the results.

* …and more!

See the [official documentation](https://dart.dev/tools/mcp-server) for the most up-to-date list of tools.

## The Dart and Flutter MCP Server in action

The true power of the Dart and Flutter MCP Server is how it enables AI assistants and agents to not only reason about your project’s context, but take action with tools. The Large Language Model (LLM) decides what tools to use and when, so you can focus on describing your goal in natural language. Let’s see this in action with a couple of examples using GitHub Copilot’s Agent mode in VS Code.

### Fixing a runtime layout error

We’ve all been there: you build a beautiful UI, run the app, and are greeted by the infamous yellow-and-black stripes of a `RenderFlex` overflow error. Instead of manually debugging the widget tree, you can now ask your AI assistant for help.

<DashImage figure src="images/13K1rgoDtIBWbIFZPp1VCEQ.webp" />


**Prompt:** *“Check for and fix static and runtime analysis issues. Check for and fix any layout issues.” (Note: For brevity, parts of this recording have been sped up.)*

Behind the scenes, the AI agent uses the Dart and Flutter MCP Server’s tools to:

1. **See the error:** It uses a tool to get the current runtime errors from the running application.

1. **Inspect the UI:** It accesses the Flutter widget tree to understand the layout that is causing the overflow.

1. **Applies a fix:** Armed with this context, it applies a fix and checks once more for any remaining errors.

You can then keep or undo the code changes.

### Adding new functionality with package search

Imagine you need to add a chart to your app. Which package should you use? How do you add it and write the boilerplate? The Dart and Flutter MCP Server streamlines this entire process.

<DashImage figure src="images/1DGTEKfS3-ZANFr66VG8MRw.gif" />


**Prompt:** *“Find a suitable package to add a line chart that maps the number of button presses over time.” (Note: For brevity, parts of this recording have been sped up.)*

The AI agent now acts as a true assistant:

1. **Find the right tool:** It uses the `pub_dev_search` tool to find popular and highly-rated charting libraries.

1. **Manage dependencies:** After you confirm its choice (for example, `syncfusion_flutter_charts`), it uses a tool to add the package to your `pubspec.yaml` and runs `pub get`.

1. **Generate the code:** It generates the new widget code, complete with boilerplate for a line chart that it places in the UI. It even self-corrects syntax errors introduced during the process. You can customize further from there.

What used to be a multi-step process of research, reading documentation, editing `pubspec.yaml`, and writing the appropriate code in your app, is now a single request.

## Configuring with popular AI-powered development environments and tools

Since the Model Context Protocol is rapidly becoming the standard for integrating toolchains and LLMs, there is an ever-growing list of tools that can use MCP servers. The Dart and Flutter MCP Server can be integrated with any MCP client*. Check out the [MCP user guide for a list of example clients](https://modelcontextprotocol.io/clients#feature-support-matrix).

First, the Dart and Flutter MCP Server requires Dart SDK 3.9/Flutter 3.35 beta or later, so switch to the beta channel and run `flutter upgrade` to ensure you have the latest versions.

**To access all the features of the Dart and Flutter MCP Server, an MCP client must support [Tools](https://modelcontextprotocol.io/docs/concepts/tools) and [Resources](https://modelcontextprotocol.io/docs/concepts/resources). For the best development experience with the Dart and Flutter MCP Server, an MCP client should also support [Roots](https://modelcontextprotocol.io/docs/concepts/roots).*

## Gemini CLI

The [Gemini CLI](https://github.com/google-gemini/gemini-cli) is an open-source AI agent that brings the power of Gemini directly into your terminal, providing a direct path from your prompt to the model. While it excels at coding, the Gemini CLI is a versatile, local utility that you can use for a wide range of tasks, from content generation and problem solving to deep research and task management.

<DashImage figure src="images/0gD-O6VeS0xT6EdDh.webp" />


Follow the [quickstart instructions](https://github.com/google-gemini/gemini-cli?tab=readme-ov-file#quickstart) to install the Gemini CLI on your machine.

Ensure your environment is running Dart SDK 3.9/Flutter 3.35 beta or later. Switch channels and run `flutter upgrade` if you need to.

To configure the Gemini CLI to use the Dart and Flutter MCP Server, edit the `.gemini/settings.json` file in your local project (this only enables the server for this project) or edit the global `~/.gemini/settings.json` file in your home directory (this enables the server for all projects).

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": [
        "mcp-server",
        "--experimental-mcp-server"
      ]
    }
  }
}
```


Pro tips:

* If you prompt the Gemini CLI with `/mcp`, you will be able to see the set of MCP tools available for use.

* If your project has specific guidelines or rules that you’d like the LLM to be aware of, you can document those by adding a `GEMINI.md` file to the root of your project.

## Gemini Code Assist

*Note: this currently requires the Gemini Code Assist “Insiders” channel. Follow the [Gemini Code Assist instructions](https://developers.google.com/gemini-code-assist/docs/use-agentic-chat-pair-programmer#before-you-begin) to enable the Insiders build.*

The underlying technology of the Gemini CLI has also been integrated into [Gemini Code Assist](https://codeassist.google/) in VS Code, a powerful AI assistant providing chat and agent capabilities directly in your IDE. In [Agent mode](https://developers.google.com/gemini-code-assist/docs/use-agentic-chat-pair-programmer), you can write a prompt in the chat window and watch as Gemini goes to work to meet your request. Follow the [set up guide](https://developers.google.com/gemini-code-assist/docs/set-up-gemini) to get started with Gemini Code Assist.

Ensure your environment is running Dart SDK 3.9/Flutter 3.35 beta or later. Switch channels and run `flutter upgrade` if you need to.

To configure Gemini Code Assist to use the Dart and Flutter MCP Server, use the following instructions:

1. Install and configure the Gemini CLI first.

1. Follow the same instructions as those above to configure the Gemini CLI to use the Dart and Flutter MCP Server, which also enables it for Gemini Code Assist.

You can verify the MCP server has been configured properly by entering `/mcp` in the chat window in Agent mode.

<DashImage figure src="images/1eYea3SzwoGDCQeP5Tmq-Pg.webp" />


## Firebase Studio

[Firebase Studio](https://firebase.studio/) is an agentic, cloud-based development environment that helps you build and ship production-quality full-stack AI apps, including APIs, backends, frontends, mobile, and more.

To add an MCP server in Firebase Studio

1. Create a `.idx/mcp.json` file in your project (if it doesn’t exist already) and add the same Dart and Flutter MCP Server configuration to the file, as with Gemini CLI instructions above,

1. Ensure your environment is running Dart SDK 3.9/Flutter 3.35 beta or later. Switch channels and run `flutter upgrade` if you need to.

1. Rebuild your workspace to complete setup by opening the Command Palette (Shift+Ctrl+P) and entering **Firebase Studio: Rebuild Environment**.

For more information about MCP server configuration in Firebase Studio, see [Customize your Firebase Studio workspace](https://firebase.google.com/docs/studio/customize-workspace?utm_source=firebase_blog&utm_medium=blog&utm_campaign=FY25-Q3-firebasestudio_cloudsummitlondon&utm_term=firebase_studio_devrel&utm_content=supercharge_firebase_studio_with_mcp#mcp).

<DashImage figure src="images/0Vjo7hhpe6uDe05yS.webp" />


## GitHub Copilot in VS Code

[GitHub Copilot](https://code.visualstudio.com/docs/copilot/overview) is an AI-powered coding assistant integrated into VS Code. The Dart VS Code extension provides a simple integration for Copilot by registering the Dart and Flutter MCP Server with VS Code. Copilot, or any other AI agent that supports the VS Code MCP [API](https://code.visualstudio.com/api/extension-guides/mcp), automatically configures the Dart and Flutter MCP Server on your behalf so that you don’t have to do it manually.

Ensure your environment is running Dart SDK 3.9/Flutter 3.35 beta or later. Switch channels and run `flutter upgrade` if you need to.

To configure the Dart and Flutter MCP Server, add the following to your VS Code user settings:

```
"dart.mcpServer": true
```


You might also consider adding`"chat.mcp.discovery.enabled": true` to your VS Code user settings to automatically discover servers configured in other tools like Claude Desktop or Cursor.

## Cursor

[Cursor](https://www.cursor.com/) is a popular AI-powered code editor based on VS Code. The Dart and Flutter VS Code extensions can be installed in Cursor to provide a similar development experience to what you’d expect in VS Code, with additional AI-centric features provided by Cursor.

Ensure that your environment is running Dart SDK 3.9/Flutter 3.35 beta or later. Switch channels and run `flutter upgrade` if you need to.

To configure Cursor to use the Dart and Flutter MCP Server, you can either click the **Add to Cursor** button in the Dart and Flutter MCP Server [README](https://github.com/flutter/flutter-intellij/issues/8261) file (easiest method), or follow the instructions to [install MCP servers](https://docs.cursor.com/context/model-context-protocol#installing-mcp-servers) from the official Cursor documentation. After configuring the Dart and Flutter MCP Server, you should end up with the following in your `.cursor/mcp.json` file, which can either be a [project file or a global file](https://docs.cursor.com/context/model-context-protocol#configuration-locations) depending on where you want the MCP server to be enabled:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": [
        "mcp-server",
        "--experimental-mcp-server", // Can be removed for Dart 3.9.0 or later
        "--force-roots-fallback" // Workaround for a Cursor issue with Roots support
      ]
    }
  }
}
```


## Other tools

The Dart and Flutter MCP Server can be used anywhere that MCP is supported*. Follow the instructions provided by your MCP client of choice to configure the Dart and Flutter MCP Server.

**Not all tools are supported since some require access to specific IDE services.*

## What’s coming next?

This experimental release is just the first step. Our vision is to enable Dart and Flutter developers to reach peak productivity with AI-driven experiences that meet you where you work. Here are some of the key areas we’re investing in next:

* **Deeper, seamless IDE integration:** We’re working closely with the teams behind Firebase Studio, Gemini in Android Studio, Gemini Code Assist, and others to make using the Dart and Flutter MCP Server effortless.

* **AI-powered DevTools features:** We plan to bring AI-assistance directly into **Dart and Flutter DevTools**. Instead of manually sifting through complex data, you could simply ask your AI assistant questions like, *“Why did my app stutter here?”* while looking at a timeline trace, *“What’s causing this memory leak?”* when inspecting a memory snapshot, or even *“Help me fix this layout issue”* directly from the Flutter Inspector.

* **An ever-growing toolbox:** We will continue to expand the MCP server’s capabilities, for example by supporting more complex refactorings.

While our roadmap is guided by our vision, your [feedback](https://github.com/dart-lang/ai/issues/new/choose) is critical in helping us prioritize what matters most to you.

## In conclusion

By giving your coding assistant the context of your project and access to the official toolchain, you can move faster, solve problems more efficiently, and focus on what matters most: building beautiful, high-quality applications. The Dart and Flutter MCP Server represents a significant leap forward in AI-powered development for Dart and Flutter, and is a continuation of our team’s dedication to delivering a productive developer experience.

This is just the beginning. As the Model Context Protocol becomes more widespread and the Dart and Flutter MCP Server gains more capabilities, the collaboration between you and your AI-powered development tools and agents will only get smarter and more seamless.

**This feature is still experimental, and your feedback is invaluable.** Try it out today by enabling it in your favorite editor, and let us know what you think by filing an issue on our[ GitHub repository](https://github.com/dart-lang/ai/issues/new/choose). Embrace the future of AI-assisted development and unlock new levels of productivity in your Dart and Flutter projects. We can’t wait to see what you build!