---
title: Antigravity CLI
shortTitle: CLI
sidenav: ai
description: Learn how to use the Antigravity CLI for Dart and Flutter.
---

## Introduction

[Antigravity CLI][] (using the executable command `agy`)
is a terminal-based interface (TUI)
for the **Antigravity 2.0** agentic coding assistant.
It connects directly to your workspace
and leverages the **Dart and Flutter MCP server**
to help you build, modify, test, and release Flutter applications
from the command line.

The Antigravity CLI replaces the legacy Gemini CLI.

[Antigravity CLI]: https://antigravity.google/docs/cli

## Installation

Install the Antigravity CLI on your machine by running the
appropriate command for your platform:

<Tabs key="install-antigravity-cli">
<Tab name="macOS / Linux">

```bash
curl -fsSL https://antigravity.google/install.sh | bash
```

</Tab>
<Tab name="Windows (PowerShell)">

```powershell
irm https://antigravity.google/install.ps1 | iex
```

</Tab>
<Tab name="Windows (Command Prompt)">

```cmd
winget install Google.AntigravityCLI
```

</Tab>
</Tabs>

After installation, verify that the tool is available on your path by running:

```console
$ agy --version
agy version 2.0.0
```

## Migration from Gemini CLI

If you previously used the Gemini CLI or Gemini CLI extension for Flutter,
migrating to the Antigravity CLI is straightforward.

### Automatic migration

The first time you run `agy` in your terminal,
the tool checks for existing Gemini configuration files
(such as `~/.gemini/config/mcp_config.json`
or legacy environment variables).
If found, the tool asks if you would like to
automatically migrate your settings,
preferences, and API configuration.

### Manual migration

If you want to migrate your plugins and history manually,
or if you skipped the automated setup,
run the import plugin tool command:

```bash
agy plugin import gemini
```

This command parses your local Gemini configuration
and copies its configurations over to your active Antigravity profile.

## Workspace configuration and rules

Like the legacy Gemini CLI tool,
Antigravity CLI respects custom development guidelines
and configurations stored in your workspace directory:

- **Local rules**: You can place rules files in your project directory
  (such as `.agents/skills/` or `AGENTS.md`)
  to instruct the agent on specific coding style guidelines
  or architectural patterns.
  Note that Antigravity CLI also supports backward compatibility
  with the legacy `GEMINI.md` file;
  however, we recommend renaming it to `AGENTS.md`.
- **Global configuration**: Antigravity CLI stores global settings
  and configured MCP servers in `~/.antigravity/`
  (e.g., `~/.antigravity/mcp_config.json`).
