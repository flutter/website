---
title: AI rules for Flutter and Dart
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

<a class="filled-button" style="margin-bottom: 0.5rem;" href="https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md" download>
  <span aria-hidden="true" class="material-symbols" translate="no">download</span>
  <span>Download the Flutter and Dart rules template</span>
</a>

## Environments that support rules

Many AI environments support rules files to guide LLM behavior.
Here are some common examples and their corresponding
rule file or directory names:

| Environment          | Rules file or directory           | Configuration instructions                            |
|:---------------------|:----------------------------------|:------------------------------------------------------|
| Copilot-powered IDEs | `.github/copilot-instructions.md` | [Configure instructions for Copilot][copilot]         |
| Claude Code          | `CLAUDE.md`                       | [Configure rules for Claude Code][claude]             |
| Cursor               | `AGENTS.md`                       | [Configure rules in Cursor][cursor]                   |
| Firebase Studio      | `.idx/airules.md`                 | [Configure instructions in Firebase Studio][firebase] |
| Gemini CLI           | `GEMINI.md`                       | [Configure context in Gemini CLI][gemini-cli]         |
| Google Antigravity   | `.agent/rules/<rule-name>.md`     | [Configure rules for Antigravity Agent][antigravity]  |
| JetBrains IDEs       | `.junie/guidelines.md`            | [Configure guidelines for Junie][junie]               |
| VS Code              | `.instructions.md`                | [Configure instructions in VS Code][vs-code]          |
| Windsurf             | `.windsurf/rules/<rule-name>.md`  | [Configure rules in Windsurf][windsurf]               |

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
[antigravity]: https://antigravity.google/docs/rules
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
