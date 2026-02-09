---
title: AI rules for Flutter and Dart
shortTitle: AI rules
description: >-
  Learn how to add AI rules to tools that accelerate your
  development workflow.
---

This guide covers how you can leverage AI rules to
streamline your Flutter and Dart development.

## Overview

AI-powered editors use rules files to provide context and
instructions to an underlying LLM. These files help you:

*   Customize AI behavior to your team's needs.
*   Enforce project best practices for code style and
    design.
*   Provide critical project context to the AI.

The Flutter project provides several versions of the rules file to accommodate
different tool limits:

*   [`rules.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md):
    The comprehensive master rule set.
*   [`rules_10k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_10k.md):
    A condensed version (<10k chars) for tools with stricter context limits.
*   [`rules_4k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_4k.md):
    A highly concise version (<4k chars) for limited contexts.
*   [`rules_1k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_1k.md):
    An ultra-compact version (<1k chars) for very strict limits.

<a class="filled-button" style="margin-bottom: 0.5rem;" href="https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md" download>
  <Icon id="download" />
  <span>Download the Flutter and Dart rules template</span>
</a>

## Device & editor specific limits

Different AI coding assistants and tools have varying limits for their "rules"
or "custom instructions" files. *Last updated: 2026-01-05.*

| Tool / Product | Rules file / Feature | Limit (soft / hard) | Documentation |
|:---|:---|:---|:---|
| Antigravity (Google) | `.agent/rules/<rule-name>.md` | 12,000 chars (Hard) | [Configure rules][antigravity] |
| Claude Code | `CLAUDE.md` | No Hard Limit | [Claude Code Docs](https://code.claude.com/docs/en/memory) |
| Cursor | `AGENTS.md` | No Hard Limit | [Cursor Docs](https://cursor.com/docs/context/rules) |
| Gemini CLI | `GEMINI.md` | 1M+ Tokens (Context) | [Gemini CLI Docs](https://cloud.google.com/vertex-ai/generative-ai/docs/long-context) |
| GitHub Copilot | `.github/copilot-instructions.md` | ~4k chars | [GitHub Copilot Docs](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot) |
| JetBrains AI (Junie) | `.junie/guidelines.md` | No Hard Limit | [JetBrains AI Docs](https://www.jetbrains.com/help/junie/get-started-with-junie.html) |
| VS Code | `.instructions.md` | Unknown | [Configure instructions][vs-code] |

{:.table .table-striped}

:::note Support is evolving
Support for rules files is still evolving.
Please check the documentation for your specific development environment for
the most up-to-date naming conventions and instructions.
:::

[copilot]: https://code.visualstudio.com/docs/copilot/customization/custom-instructions#_use-a-githubcopilotinstructionsmd-file
[claude]: https://www.anthropic.com/engineering/claude-code-best-practices#1-customize-your-setup
[cursor]: https://cursor.com/docs/context/rules
[firebase]: https://firebase.google.com/docs/studio/set-up-gemini#custom-instructions
[gemini-cli]: https://geminicli.com/docs/cli/gemini-md
[antigravity]: https://antigravity.google/docs/rules-workflows
[junie]: https://www.jetbrains.com/help/junie/customize-guidelines.html
[vs-code]: https://code.visualstudio.com/docs/copilot/customization/custom-instructions#_use-instructionsmd-files
[windsurf]: https://docs.windsurf.com/windsurf/cascade/memories#rules

## Create rules for your editor

You can adapt our Flutter and Dart rules template for your
specific environment. To do so, follow these steps:

1.  Download the Flutter and Dart rules template:
    <a href="https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md" download><code>rules.md</code></a>

1.  In an LLM like [Gemini][], attach the
    `rules.md` file that you downloaded in
    the last step.

1.  Provide a prompt to reformat the file for your desired
    editor.

    Example prompt:

    ```text
    Convert the attached rules.md file
    into a guidelines.md file for Gemini CLI. Make sure
    to use the styles required for a guidelines.md file.
    ```

1.  Review the LLM's output and make any necessary
    adjustments.

1.  Follow your environment's instructions to add the new
    rules file. This may involve adding to an existing file
    or creating a new one.

1.  Verify that your AI assistant is using the new rules to
    guide its responses.

[Gemini]: https://gemini.google.com/
