---
title: Get started developing with AI
shortTitle: Get started
description: >-
  Learn how to set up and use AI agent plugins for Flutter and Dart using
  your preferred coding assistant.
---

AI coding assistants can accelerate your Flutter development workflow by
writing code, fixing errors, and building complete features.

To get the best experience with AI coding assistants, install the official
Flutter agent plugins, which bundle [agent skills](/ai/agent-skills) and
configuration for the [Dart and Flutter MCP server](/ai/mcp-server).

## Choose your AI coding agent

Select your agent below for instructions on how to install official plugins and
set up rules for Flutter development.

<Tabs key="ai-agent-tabs" wrapped="true">

<Tab name="Antigravity">

[Antigravity](https://antigravity.google/) is a suite of agentic development
tools built by Google that includes the Antigravity IDE and Antigravity CLI.

**Install the official plugin**

Equip Antigravity with official Dart and Flutter tools
by installing the plugin from settings:

1. Open **Settings** in Antigravity by clicking the gear icon
   or pressing <kbd class="special-key">Cmd/Ctrl</kbd> + <kbd>,</kbd>.
1. Click the **Customizations** tab.
1. In the **Build with Google Plugins** section, click **Customize**.
1. Click **Download** next to the **Dart and Flutter** integration.

</Tab>

<Tab name="Claude Code">

[Claude Code](https://code.claude.com/) is an agentic coding assistant from
Anthropic that runs in your terminal.

**Install the official plugin**

Equip Claude Code with domain expertise and tools for Flutter and Dart by
installing the official plugin from
[flutter/agent-plugins](https://github.com/flutter/agent-plugins):

1. Add the marketplace for Claude Code plugins:

   ```console
   $ claude plugin marketplace add flutter/agent-plugins
   ```

1. Install the Flutter and Dart plugin:

   ```console
   $ claude plugin install dart-flutter@dart-flutter
   ```

1. Verify the installation:

   ```console
   $ claude plugin marketplace list
   ```

**Rules setup**

Claude Code plugins currently cannot bundle rules files automatically.
You can configure rules for your project by following [Rules for Flutter and Dart](/ai/ai-rules).

</Tab>

<Tab name="Codex">

[Codex](https://chatgpt.com/codex) is an agentic coding assistant
designed for terminal and IDE workflows.

**Install the official plugin**

Equip Codex with official Flutter and Dart skills and MCP configuration:

1. Add the Dart and Flutter marketplace for Codex plugins:

   ```console
   $ codex plugin marketplace add flutter/agent-plugins
   ```

1. Install the Dart and Flutter plugin:

   ```console
   $ codex plugin add dart-flutter@dart-flutter
   ```

**Rules setup**

Codex plugins currently cannot bundle rules files automatically.
You can configure rules for your project by following [Rules for Flutter and Dart](/ai/ai-rules).

</Tab>

<Tab name="Cursor">

[Cursor](https://cursor.com/) is an AI-first code editor built on VS Code.

**Install the local plugin**

You can install the plugin locally by copying it to your Cursor plugins directory:


1. Clone the repository:
   ```bash
   git clone https://github.com/flutter/agent-plugins.git
   ```

1. Copy the repository directory to your local Cursor plugins folder:
   ```bash
   mkdir -p ~/.cursor/plugins/local
   cp -r agent-plugins ~/.cursor/plugins/local/dart-flutter
   ```

1. Restart Cursor. The editor automatically discovers and loads the skills
   under `skills/` and configures the MCP server defined in `.mcp.json`.

</Tab>

<Tab name="Other agents">

If you're using another compatible agentic assistant:

* **MCP Server**: To connect your agent to Dart and Flutter developer tools,
  see the [Dart and Flutter MCP server](/ai/mcp-server) setup guide.
* **Agent Skills**: To manually install agent skills into your project's
  `.agents/skills` directory using the `skills` CLI tool, see
  [Install agent skills](/ai/agent-skills#install-agent-skills).
* **Rules**: To configure rules and project best practices for your assistant,
  see [Rules for Flutter and Dart](/ai/ai-rules).

</Tab>

</Tabs>

## The AI tooling stack

To get the most out of AI, it helps to understand how the different pieces work together:

| Component | What it is | How it helps |
| :--- | :--- | :--- |
| **Plugins** | Packages MCP and Skills together for your editor. | **Start here.** Recommended for quick setup. |
| **MCP Server** | Connects the AI to Flutter developer tools (hot reload, widget tree). | Provides the raw machinery for advanced tools. |
| **Agent Skills** | Step-by-step blueprints for specific tasks. | Provides the professional know-how to operate tools. |
| **AI Rules** | General guidelines and best practices for your project. | Enforces consistent coding standards. |

{:.table .table-striped}

## Next steps

* Learn more about [Agent skills](/ai/agent-skills) and how agents use them.
* Explore the [Dart and Flutter MCP server](/ai/mcp-server) integration.
* Check out [Rules for Flutter and Dart](/ai/ai-rules) to customize model behavior.
