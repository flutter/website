---
title: Google Antigravity
shortTitle: Antigravity
description: Learn about the Antigravity agentic coding assistant.
---

## Introduction

[Antigravity][ag] is a powerful agentic coding assistant
and IDE for building apps, including Flutter apps.
You can pair with Antigravity to solve your
coding tasks, create new codebases, modify existing ones,
and answer questions.

[ag]: https://antigravity.google/

## Installation and setup {: #setup}

Install the latest version of Antigravity for your platform by visiting
the [Antigravity site](https://antigravity.google/download).

 1. <h3>Open Antigravity</h3>

    When opening Antigravity for the first time,
    a **How do you want to use Antigravity** screen displays and
    provides some radio buttons and pulldown menus
    for customizing your use of the tool.

    We recommend that you select **Review-driven development**.
    This means that Antigravity asks you to approve each command
    that it wants to run.

    You can change this setting at any time to give Antigravity
    more or less control. Even if you select **Agent driven development**,
    which allows Antigravity to directly run commands without approval,
    you can specify certain commands that will _always_ ask
    for your approval, such as the `rm` command to remove files.

 1. <h3>Install the Dart and Flutter extensions</h3>

    Open the **Extensions** menu in the left nav and search for Dart.
    The search results bring up both the Dart and Flutter extensions.
    Click the **Install** button for Dart and then do the same
    for Flutter.

 1. <h3>Set up any MCP servers that you use</h3>

    1.  Navigate to or open the **Agent** side panel.

        If it's closed, open it by either:

        * Pressing <kbd class="special-key">Cmd/Ctrl</kbd> + <kbd>L</kbd>.
        * Going to **View**
          <span aria-label="and then">></span> **Open View...**
          <span aria-label="and then">></span> **Agent**.

        In the upper right of the **Agent** panel,
        click the **Additional options** (`...`) menu button.

    1.  Select **MCP Servers**.

    1.  In the upper right of the **Agent** panel,
        click **Manage MCP Servers**.

        The **MCP Store** screen appears and you can search for Dart,
        which is likely already in the list.
        Click **Install**.

        After installing any servers that you want,
        view them by clicking the **Manage MCP Servers** button
        and click **View raw config** to access your JSON manifest.

 1. <h3>Get started developing</h3>

    For these tips and more that show some of Antigravity's benefits,
    watch the following 10-minute [Flutter + Antigravity video][ag-video]:

    <YouTubeEmbed id="YY2w2JEX2xk"
      title="Flutter + Antigravity in 10 minutes"></YouTubeEmbed>

    For a walkthrough on creating a new Flutter app in Antigravity,
    visit [Create a new Flutter app][].
    To learn more about the development features enabled by
    the Dart and Flutter extensions,
    check out [How to develop Flutter apps in VS Code][vs-code].

{:.steps}

[ag-video]: {{site.youtube-site}}/watch?v=YY2w2JEX2xk&t=1s
[Create a new Flutter app]: /reference/create-new-app#antigravity
[vs-code]: /tools/vs-code
