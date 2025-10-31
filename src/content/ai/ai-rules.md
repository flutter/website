---
title: AI rules for Flutter and Dart
description: >
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

<a class="filled-button" style="margin-bottom: 0.5rem;" href="https://raw.githubusercontent.com/flutter/flutter/refs/heads/master/docs/rules/rules.md" download>
  <span aria-hidden="true" class="material-symbols" translate="no">download</span>
  <span>Download the Flutter and Dart rules template</span>
</a>

## Environments that support rules

Many AI environments support rules files to guide
LLM behavior. Here are some common examples and their
corresponding rule file names:

| Environment | Rules File | Installation Instructions                     |
| :--- | :--- |:----------------------------------------------|
| Copilot powered IDEs | `copilot-instructions.md` | [Configure .github/copilot-instructions.md][] |
| Cursor | `cursor.md` | [Configure cursorrules.md][]                  |
| Firebase Studio | `airules.md` | [Configure airules.md][]                      |
| Gemini CLI | `GEMINI.md` | [Configure GEMINI.md][]                       |
| JetBrains IDEs | `guidelines.md` | [Configure guidelines.md][]                   |
| VS Code | `.instructions.md` | [Configure .instructions.md][]                |
| Windsurf | `guidelines.md` | [Configure guidelines.md][]                   |

[Configure airules.md]: https://firebase.google.com/docs/studio/set-up-gemini#custom-instructions
[Configure .github/copilot-instructions.md]: https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-instructions
[Configure cursorrules.md]: https://docs.cursor.com/en/context/rules
[Configure guidelines.md]: https://www.jetbrains.com/help/junie/customize-guidelines.html
[Configure .instructions.md]: https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-instructions
[Configure guidelines.md]: https://docs.windsurf.com/windsurf/cascade/memories#rules
[Configure GEMINI.md]: https://codelabs.developers.google.com/gemini-cli-hands-on

## Create rules for your editor

You can adapt our Flutter and Dart rules template for your
specific environment. To do so, follow these steps:

1.  Download the Flutter and Dart rules template:
    <a href="https://raw.githubusercontent.com/flutter/flutter/refs/heads/master/docs/rules/rules.md" download>rules.md</a>

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
