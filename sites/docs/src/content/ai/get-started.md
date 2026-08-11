---
title: Get started developing with AI
sidenav: ai
shortTitle: Get started
description: >-
  Learn how to set up and use AI agent plugins for Flutter and Dart,
  tailored for Antigravity, Claude Code, Codex, and Cursor.
---

AI coding assistants can accelerate your Flutter development workflow by
writing code, fixing errors, and building complete features.

To get the best experience with AI coding assistants, we recommend installing
the official Flutter agent plugins, which bundle
[agent skills](/ai/agent-skills) and configuration for the
[Dart and Flutter MCP server](/ai/mcp-server).

## Choose your AI coding agent

Select your agent below for instructions on how to install official plugins and
set up rules for Flutter development.

<Tabs key="ai-agent-tabs" wrapped="true">

<Tab name="Antigravity">

[Antigravity](https://antigravity.google/) is a suite of agentic development
tools built by Google that includes the Antigravity IDE and Antigravity CLI
(`agy`).

### Plugin, skills, and rules support

Antigravity natively supports bundled agent skills, MCP tools, and rules files
out-of-the-box.

* **Antigravity IDE**: Features an integrated agent panel, automatic rule
  loading, and native support for Dart and Flutter tools. See the
  [Antigravity IDE](/ai/antigravity) guide.
* **Antigravity CLI**: A terminal-based agentic workflow tool (`agy`). See the
  [Antigravity CLI](/ai/antigravity-cli) guide.

For advanced or manual skill installation, see
[Install agent skills](/ai/agent-skills#install-agent-skills).

</Tab>

<Tab name="Claude Code">

[Claude Code](https://code.claude.com/) is an agentic coding assistant from
Anthropic that runs in your terminal.

### 1. Install the official plugin

Equip Claude Code with domain expertise and tools for Flutter and Dart by
installing the official plugin from
[flutter/agent-plugins](https://github.com/flutter/agent-plugins):

1. Add the marketplace for Claude Code plugins:

   ```console
   $ claude plugin marketplace add flutter/agent-plugins
   ```

2. Install the Flutter and Dart plugin:

   ```console
   $ claude plugin install dart-flutter@dart-flutter
   ```

3. Verify the installation:

   ```console
   $ claude plugin marketplace list
   ```

### 2. Rules setup

:::note Rules status
Claude Code plugins currently cannot bundle rules files automatically.
We recommend installing Flutter rules manually into your project's
`CLAUDE.md` file. Official recommended rules for Claude Code are currently TBD.
For general guidance on formatting rules, see
[Rules for Flutter and Dart](/ai/ai-rules).
:::

</Tab>

<Tab name="Codex">

[Codex](https://github.com/features/copilot) is an agentic coding assistant
designed for terminal and IDE workflows.

### 1. Install the official plugin

Equip Codex with official Flutter and Dart skills and MCP configuration:

1. Add the Dart and Flutter marketplace for Codex plugins:

   ```console
   $ codex plugin marketplace add flutter/agent-plugins
   ```

2. Install the Dart and Flutter plugin:

   ```console
   $ codex plugin add dart-flutter@dart-flutter
   ```

### 2. Rules setup

:::note Rules status
Codex plugins currently cannot bundle rules files automatically.
We recommend configuring rules manually for your project.
Official recommended rules for Codex are currently TBD.
For more information, see [Rules for Flutter and Dart](/ai/ai-rules).
:::

</Tab>

<Tab name="Cursor">

[Cursor](https://cursor.com/) is an AI-first code editor built on VS Code.

### Install the local plugin

You can install the plugin locally by copying it to your Cursor plugins directory:

1. Copy the repository directory to your local Cursor plugins folder:

   ```bash
   mkdir -p ~/.cursor/plugins/local
   cp -r /path/to/flutter/agent-plugins ~/.cursor/plugins/local/dart-flutter
   ```

2. Restart Cursor. The editor automatically discovers and loads the skills
   under `skills/` and configures the MCP server defined in `.mcp.json`.

For advanced or manual skill installation, see
[Install agent skills](/ai/agent-skills#install-agent-skills).

</Tab>

<Tab name="Other agents">

If you are using another compatible agentic assistant:

* **MCP Server**: To connect your agent to Dart and Flutter developer tools,
  see the [Dart & Flutter MCP server](/ai/mcp-server) setup guide.
* **Agent Skills**: To manually install agent skills into your project's
  `.agents/skills` directory using the `skills` CLI tool, see
  [Install agent skills](/ai/agent-skills#install-agent-skills).
* **Rules**: To configure rules and project best practices for your assistant,
  see [Rules for Flutter and Dart](/ai/ai-rules).

</Tab>

</Tabs>

## Next steps

* Learn more about [Agent skills](/ai/agent-skills) and how agents use them.
* Explore the [Dart & Flutter MCP server](/ai/mcp-server) integration.
* Check out [Rules for Flutter and Dart](/ai/ai-rules) to customize model behavior.
