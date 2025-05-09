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

:::note
The following steps assume you're
using the [default shell][zsh-mac] on macOS, Zsh.
Zsh uses the `.zshenv` file for configuring [environment variables][zsh-files].

If you use another shell besides Zsh,
check out [this tutorial on setting your PATH][other-path].
:::

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Open or create the Zsh environment variable file</h3>

    If it exists, open the Zsh environment variable file `~/.zshenv`
    in your preferred text editor.
    If it doesn't exist, create the `~/.zshenv` file.

 1. <h3>Add the Flutter SDK bin to your path</h3>

    At the end of your `~/.zshenv` file,
    use the built-in `export` command to update the `PATH` variable
    to include the `bin` directory of your Flutter installation.

    Replace `<path-to-sdk>` with the path to your Flutter SDK install.

    ```bash title=".zshenv"
    export PATH="<path-to-sdk>/bin:$PATH"
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd add the following to the file:

    ```bash title=".zshenv"
    export PATH="$HOME/development/flutter/bin:$PATH"
    ```

 1. <h3>Save your changes</h3>

    Save, then close, the `~/.zshenv` file you edited.

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open Zsh sessions in your terminal apps and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open a Zsh session in your preferred terminal,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

[zsh-mac]: https://support.apple.com/en-us/102360
[zsh-files]: https://zsh.sourceforge.io/Intro/intro_3.html
[other-path]: https://www.cyberciti.biz/faq/unix-linux-adding-path/
[troubleshoot]: /install/troubleshoot

## Linux

To run `flutter` and `dart` commands in a terminal on Linux,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Determine your default shell</h3>

    If you don't know what shell you use,
    check which shell starts when you open a new console window.

    ```console
    $ echo $SHELL
    ```

 1. <h3>Add the Flutter SDK bin to your path</h3>

    To add the `bin` directory of your Flutter installation to your `PATH`:

    1. Expand the instructions for your default shell.
    1. Copy the provided command.
    1. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
    1. Run the edited command in your preferred terminal with that shell.

    <hr>

    <details>
    <summary>Expand for <code>bash</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bash_profile
    ```

    </details>

    <details>
    <summary>Expand for <code>zsh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.zshenv
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.zshenv
    ```

    </details>

    <details>
    <summary>Expand for <code>fish</code> instructions</summary>

    ```console
    $ fish_add_path -g -p <path-to-sdk>/bin
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ fish_add_path -g -p ~/development/flutter/bin
    ```

    </details>

    <details>
    <summary>Expand for <code>csh</code> instructions</summary>

    ```console
    $ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.cshrc
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.cshrc
    ```

    </details>

    <details>
    <summary>Expand for <code>tcsh</code> instructions</summary>

    ```console
    $ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.tcshrc
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.tcshrc
    ```

    </details>

    <details>
    <summary>Expand for <code>ksh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
    ```

    </details>

    <details>
    <summary>Expand for <code>sh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
    ```

    </details>

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open shell sessions in your terminal apps and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open your preferred terminal with your default shell,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

## ChromeOS

To run `flutter` and `dart` commands in a terminal on chromeOS,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.

:::note
The following steps assume
you've already [turned on Linux support][chromeos-linux] and that
you're using Bash or the default shell on ChromeOS.

If you're using a different shell besides the default or Bash,
follow the [add to path instructions for Linux](#linux) instead.
:::

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Add the Flutter SDK bin to your path</h3>

    To add the `bin` directory of your Flutter installation to your `PATH`:

    1. Copy the following command.
    1. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
    1. Run the edited command in your preferred terminal.

    ```console
    $ echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile
    ```

    For example, if you downloaded Flutter into a
    `development/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bash_profile
    ```

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open Zsh sessions in your terminal apps and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open a Zsh session in your preferred terminal,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[troubleshoot]: /install/troubleshoot
