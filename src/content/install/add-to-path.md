---
title: Add Flutter to your PATH
description: >-
  Learn how to add Flutter to your PATH after downloading the Flutter SDK.
---

Learn how to add Flutter to your `PATH` environment variable
after downloading the SDK.
Adding Flutter to your `PATH` allows you to use the
`flutter` and `dart` command-line tools in terminals and IDEs.

:::tip
If you haven't downloaded Flutter yet,
follow [Get started with Flutter][] instead.
:::

<div class="card-grid">
  <a class="card outlined-card" href="#windows">
    <div class="card-header">
      <span class="card-title">Windows</span>
    </div>
    <div class="card-content">
      <p>Add Flutter to your path on Windows.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#macos">
    <div class="card-header">
      <span class="card-title">macOS</span>
    </div>
    <div class="card-content">
      <p>Add Flutter to your path on macOS.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#linux">
    <div class="card-header">
      <span class="card-title">Linux</span>
    </div>
    <div class="card-content">
      <p>Add Flutter to your path on Linux.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#chromeos">
    <div class="card-header">
      <span class="card-title">ChromeOS</span>
    </div>
    <div class="card-content">
      <p>Add Flutter to your path on ChromeOS.</p>
    </div>
  </a>
</div>

[Get started with Flutter]: /get-started/install

## Windows

To run `flutter` and `dart` commands in a terminal on Windows,
add the Flutter SDK's `bin` directory to the `Path` environment variable.

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Navigate to the environment variables settings</h3>

   1. Press <kbd>Windows</kbd> + <kbd>Pause</kbd>.

      If your keyboard lacks a <kbd>Pause</kbd> key,
      try <kbd>Windows</kbd> + <kbd>Fn</kbd> + <kbd>B</kbd>.

      The **System > About** dialog opens.

   1. Click **Advanced System Settings**
      <span aria-label="and then">></span> **Advanced**
      <span aria-label="and then">></span> **Environment Variables...**

      The **Environment Variables** dialog opens.

 1. <h3>Add the Flutter SDK bin to your path</h3>

   1. In the **User variables for (username)** section
      of the **Environment Variables** dialog,
      look for the **Path** entry.

   1. If the **Path** entry exists, double-click it.

      The **Edit Environment Variable** dialog should open.

      1. Double-click inside an empty row.

      1. Type the path to the `bin` directory of your Flutter installation.

         For example, if you downloaded Flutter into a
         `dev\flutter` folder inside your user directory,
         you'd type the following:

         ```plaintext
         %USERPROFILE%\dev\flutter\bin
         ```

      1. Click the Flutter entry you added to select it.

      1. Click **Move Up** until the Flutter entry sits at the top of the list.

      1. To confirm your changes, click **OK** three times.

      {: type="a"}

   1. If the entry doesn't exist, click **New...**.

      The **Edit Environment Variable** dialog should open.

      1. In the **Variable Name** box, type `Path`.

      1. In the **Variable Value** box,
         type the path to the `bin` directory of your Flutter installation.

         For example, if you downloaded Flutter into a
         `dev\flutter` folder inside your user directory,
         you'd type the following:

         ```plaintext
         %USERPROFILE%\dev\flutter\bin
         ```

      1. To confirm your changes, click **OK** three times.

      {: type="a"}

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open command prompts,
    sessions in your terminal apps, and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open command prompt or your preferred terminal app,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

## macOS

To run `flutter` and `dart` commands in a terminal on macOS,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.

{% render docs/install/path/macos.md %}

## Linux

To run `flutter` and `dart` commands in a terminal on Linux,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.

{% render docs/install/path/linux.md %}

## ChromeOS

To run `flutter` and `dart` commands in a terminal on chromeOS,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.

{% render docs/install/path/chromeos.md %}
