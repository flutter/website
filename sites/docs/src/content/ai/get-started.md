---
title: Get started developing with AI
shortTitle: Get started
description: >-
  Learn how to set up and use AI agent plugins for Flutter and Dart
  using your preferred coding assistant.
---

AI coding assistants can accelerate your Flutter development workflow by
writing code, fixing errors, and building complete features.

By default, general-purpose AI assistants might not have the latest context on
Flutter patterns, project diagnostics, or third-party packages. Installing the
official Flutter agent plugin equips your assistant with dedicated tools and
recipes tailored for Flutter and Dart development.

## How Flutter AI plugins work

An **agent plugin** bundles the tools and knowledge that an AI assistant needs
to understand and modify your Flutter codebase.

When you install an official Flutter agent plugin, it connects your assistant
to two core capabilities:

* **[Agent skills](/ai/tools#agent-skills)**: On-demand procedural guides from
  the official Flutter and Dart repositories that teach the assistant how to
  perform specific tasks, such as creating responsive layouts, managing state,
  or writing widget tests.
* **[Dart and Flutter MCP server](/ai/tools#dart-and-flutter-mcp-server)**:
  A Model Context Protocol (MCP) server that connects the assistant to the
  Dart SDK, giving it real-time access to analyzer diagnostics, symbol
  resolution, test runners, and runtime inspection.

These tools work together automatically: the assistant uses MCP tools to query
live project state and static analysis, while using agent skills to guide its
coding strategies and best practices.

In addition to core Flutter plugins, you can also equip your assistant with
skills that are shipped directly by third-party `pub.dev`
packages using the [skills](/ai/package-skills) package.

To learn more about the underlying architecture and capabilities of each tool,
check out [How Flutter AI tools work](/ai/tools).

## Choose your AI coding agent

Select your agent below for instructions on how to install official plugins
and configure tools for Flutter development.

<Tabs key="ai-agent-tabs" wrapped="true">

<Tab name="Antigravity">

[Antigravity](
https://antigravity.google/docs/build-with-google/#dart-and-flutter)
is an agentic development platform by Google that includes the Antigravity
IDE, IDE extensions (for VS Code and other editors), and the Antigravity CLI.

**Antigravity IDE and extensions**

Equip the Antigravity IDE or Antigravity extension (such as in VS Code)
with official Dart and Flutter tools:

1. Open **Settings** in Antigravity by clicking the gear icon or pressing
   <kbd class="special-key">Cmd/Ctrl</kbd> + <kbd>,</kbd>.
1. Click the **Customizations** tab.
1. In the **Build with Google Plugins** section, click **Customize**.
1. Click **Download** next to the **Dart and Flutter** integration.

To verify the installation, open the **Agent** panel
(<kbd class="special-key">Cmd/Ctrl</kbd> + <kbd>L</kbd>) and ask the agent:

```text
Summarize the Dart and Flutter tools and skills available in this project.
```

**Antigravity CLI**

The Antigravity CLI runs as the `agy` command in your terminal.

1. Configure the Dart and Flutter MCP server in your project's
   `.agents/mcp_config.json` file (or globally in
   `~/.gemini/config/mcp_config.json`):

   ```json
   {
     "mcpServers": {
       "dart": {
         "command": "dart",
         "args": ["mcp-server"]
       }
     }
   }
   ```

1. Install official Flutter and Dart skills into your workspace:

   ```bash
   # Install Flutter skills
   npx skills add flutter/agent-plugins --skill '*' --agent universal --yes

   # Install Dart skills
   npx skills add dart-lang/skills --skill '*' --agent universal --yes
   ```

1. Start an interactive session in your project root:

   ```bash
   agy
   ```

</Tab>

<Tab name="Claude Code">

[Claude Code](https://code.claude.com/) is an agentic coding assistant from
Anthropic that runs in your terminal.

**Install the official plugin**

Equip Claude Code with official Flutter and Dart skills and MCP configuration:

1. Add the marketplace for Claude Code plugins:

   ```bash
   claude plugin marketplace add flutter/agent-plugins
   ```

1. Install the Flutter and Dart plugin:

   ```bash
   claude plugin install dart-flutter@dart-flutter
   ```

**Verify installation**

Verify that the plugin is active in Claude Code:

```bash
claude plugin marketplace list
```

</Tab>

<Tab name="Cursor">

[Cursor](https://cursor.com/) is an AI-powered code editor built on top of
VS Code.

**Install the local plugin**

You can install the official plugin bundle locally by copying it to your Cursor
plugins directory:

1. Clone the repository:

   ```bash
   git clone https://github.com/flutter/agent-plugins.git
   ```

1. Copy the repository to your local Cursor plugins folder:

   ```bash
   mkdir -p ~/.cursor/plugins/local
   cp -r agent-plugins ~/.cursor/plugins/local/dart-flutter
   ```

1. Restart Cursor. The editor automatically discovers the bundled skills and
   configures the Dart and Flutter MCP server.

</Tab>

<Tab name="Codex">

[Codex](https://chatgpt.com/codex) is an agentic coding assistant designed for
terminal and IDE workflows.

**Install the official plugin**

Equip Codex with official Flutter and Dart skills and MCP configuration:

1. Add the Dart and Flutter marketplace for Codex plugins:

   ```bash
   codex plugin marketplace add flutter/agent-plugins
   ```

1. Install the Dart and Flutter plugin:

   ```bash
   codex plugin add dart-flutter@dart-flutter
   ```

**Verify installation**

Verify that the plugin is active in Codex:

```bash
codex plugin list
```

</Tab>

<Tab name="GitHub Copilot">

[GitHub Copilot](https://github.com/features/copilot) in VS Code supports
agentic coding, tool calling via MCP, and custom workspace instructions.

**Configure the MCP server**

1. Ensure the **Model Context Protocol (MCP)** extension is enabled in VS Code.
1. Create or open `.vscode/mcp.json` in your workspace and add the Dart MCP
   server:

   ```json
   {
     "servers": {
       "dart": {
         "command": "dart",
         "args": ["mcp-server"]
       }
     }
   }
   ```

**Install agent skills**

In your Flutter project root, install official skills using the universal flag:

```bash
# Install Flutter skills
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes

# Install Dart skills
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

</Tab>

<Tab name="Other">

If you're using another coding assistant (such as Windsurf, Zed, or Cline)
that supports the Model Context Protocol (MCP) or Agent Skills specification,
configure the tools manually.

**Configure the MCP server**

Most MCP-compatible clients use a standard JSON configuration format. Add the
following entry to your client's MCP configuration file:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

For client-specific setup guides, command-line arguments, and troubleshooting,
check out the [Dart and Flutter MCP server repository](
https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server).

**Install agent skills**

Use the `skills` CLI to download skills into your workspace's standard
`.agents/skills` directory:

```bash
# Install Flutter skills
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes

# Install Dart skills
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

</Tab>

</Tabs>

## Next steps

* To learn more about how skills and tools interact, check out
  [How Flutter AI tools work](/ai/tools).
* To publish or consume skills from dependencies, refer to
  [Package skills](/ai/package-skills).
* To give your assistant search access to official Flutter and Dart
  documentation, connect to the [Developer Knowledge MCP server](
  https://developers.google.com/knowledge/mcp).
* To explore the official plugins, check out the
  [flutter/agent-plugins](https://github.com/flutter/agent-plugins) repository.
