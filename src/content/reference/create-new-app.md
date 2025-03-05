---
title: Create a new Flutter app
short-title: Create a new app
description: >-
  Learn how to bootstrap a new Flutter application from
  your command-line, different editors, and even in the cloud.
---

This page provides step-by-step instructions on how to
bootstrap a new Flutter app in your preferred development environment.

To create a new Flutter app, first [set up Flutter][flutter-setup], then
choose your preferred environment and follow the corresponding instructions.

<div class="card-grid">
  <a class="card outlined-card" href="#vs-code">
    <div class="card-header">
      <header class="card-title">VS Code</header>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving VS Code.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#android-studio">
    <div class="card-header">
      <header class="card-title">Android Studio</header>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving Android Studio.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#intellij">
    <div class="card-header">
      <header class="card-title">IntelliJ</header>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving your IntelliJ-based IDE.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#project-idx">
    <div class="card-header">
      <header class="card-title">Project IDX</header>
    </div>
    <div class="card-content">
      <p>For quick and easy setup, create a new Flutter app in Project IDX.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#terminal">
    <div class="card-header">
      <header class="card-title">Terminal</header>
    </div>
    <div class="card-content">
      <p>For maximum flexibility, create a new Flutter app from the command line.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/add-to-app#get-started">
    <div class="card-header">
      <header class="card-title">
        <span>Add to app</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;">open_in_new</span>
      </header>
    </div>
    <div class="card-content">
      <p>Create a new Flutter module to embed in an existing app.</p>
    </div>
  </a>
</div>

## VS Code

To create a Flutter app with [VS Code][] and other Code OSS editors,
you first need to [install Flutter][flutter-setup] and
[set up VS Code][vscode-setup] for Flutter development.
Then follow these steps:

 1. <h3>Launch VS Code</h3>

    Open VS Code or your preferred Code OSS editor.

 1. <h3>Open the command palette</h3>

    Go to **View** <span aria-label="and then">></span> **Command Palette** or
    press <kbd class="special-key">Cmd/Ctrl</kbd> +
    <kbd>Shift</kbd> + <kbd>P</kbd>.

 1. <h3>Find the Flutter commands</h3>

    In the command palette, start typing `flutter:`.
    VS Code should surface commands from the Flutter plugin.

 1. <h3>Run the new project command</h3>

    Select the **Flutter: New Project** command.
    Your OS or VS Code might ask for access to your documents,
    agree to continue to the next step.

 1. <h3>Choose a template</h3>

    VS Code should prompt you with **Which Flutter template?**.
    Depending on what type of Flutter project you want to create,
    choose the corresponding template.
    For a new Flutter app, choose **Application**.

 1. <h3>Select a project location</h3>

    A file dialog will appear.
    Select or create the parent directory where the project will be created.
    Do not create the project folder itself, the Flutter tool will do so.
    To confirm your selection,
    click **Select a folder to create the project in**.

 1. <h3>Enter a project name</h3>

    VS Code should prompt you to enter a name for your new project.
    Enter a name for your app that follows the `lowercase_with_underscores`
    naming convention, following the [Effective Dart][package-name] guidelines.
    To confirm your selection, press <kbd>Enter</kbd>.

 1. <h3>Wait for project initialization</h3>

    Based on the information you entered,
    VS Code will use `flutter create` to bootstrap your application.
    Progress is often surfaced as a notification in the bottom right
    and can also be accessed from the **Output** panel.

 1. <h3>Run your app</h3>

    Your new app should now be created and open in VS Code.
    To try your new app,
    follow the steps to [run and debug][vscode-run] in VS Code.

{:.steps}

You've successfully created a new Flutter app in VS Code!
If you need more help with developing Flutter in VS Code,
check out the [VS Code for Flutter reference][vscode-more].

[VS Code]: https://code.visualstudio.com/
[vscode-setup]: /tools/vs-code#installation-and-setup
[vscode-run]: /tools/vs-code#running-and-debugging
[vscode-more]: /tools/vs-code

## Android Studio

To create a Flutter app with Android Studio,
you first need to [install Flutter][flutter-setup] and
[set up Android Studio][as-setup] for Flutter development.
Then follow these steps:

 1. <h3>Launch Android Studio</h3>
 1. <h3>Begin project creation</h3>
 1. <h3>Choose a project type</h3>
 1. <h3>Configure your project</h3>
 1. <h3>Finish project creation</h3>
 1. <h3>Run your app</h3>

{:.steps}

You've successfully created a new Flutter app in Android Studio!
If you need more help with developing Flutter in Android Studio,
check out the [Android Studio for Flutter reference][as-more].

[as-setup]: /tools/android-studio#installation-and-setup
[as-more]: /tools/android-studio

## IntelliJ

To create a Flutter app with IntelliJ or other JetBrains IDEs,
you first need to [install Flutter][flutter-setup] and
[set up IntelliJ][ij-setup] for Flutter development.
Then follow these steps:

 1. <h3>Launch IntelliJ or other JetBrains IDE</h3>
 1. <h3>Begin project creation</h3>
 1. <h3>Choose a project type</h3>
 1. <h3>Configure your project</h3>
 1. <h3>Finish project creation</h3>
 1. <h3>Run your app</h3>

{:.steps}

You've successfully created a new Flutter app in IntelliJ!
If you need more help with developing Flutter in IntelliJ,
check out the [IntelliJ for Flutter reference][ij-more].

[ij-setup]: /tools/android-studio#installation-and-setup
[ij-more]: /tools/android-studio

## Project IDX

To create a Flutter app with [Project IDX][idx],
you first need a Google account and to [set up IDX][idx-setup].
Then follow these steps:

 1. <h3>Launch Project IDX</h3>

    In your preferred browser, navigate to the [IDX dashboard][]
    found at `idx.google.com`.
    If you haven't yet, you might need to log in to your Google account.

 1. <h3>Create a new workspace</h3>

    In the IDX dashboard, find the **New workspace** card.
    It should include a variety of templates to choose from.
    Select the **Flutter** template.
    If you can't find it, it might be under the **Mobile** category.

 1. <h3>Name your workspace</h3>

    IDX should prompt you to **Name your workspace**.
    This name is distinct from the name of your Flutter app.
    Choose a descriptive name that you'll recognize
    in a list of your IDX workspaces.

 1. <h3>Provision your new workspace</h3>

    Once you've chosen a name and configured your workspace,
    click **Create** to provision your new workspace.

 1. <h3>Wait for workspace initialization</h3>

    IDX will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while.

1. <h3>Run your app</h3>

   Your new app should now be created and open in IDX.
   To try your new app, follow the docs provided by Project IDX to
   [preview your app][idx-preview] on the web or on Android.

{:.steps}

You've successfully created a new Flutter app in Project IDX!
If you need help configuring your workspace,
check out [Customize your IDX workspace][].

[idx]: https://idx.dev/
[IDX dashboard]: https://idx.google.com/
[idx-setup]: https://developers.google.com/idx/guides/get-started
[idx-preview]: https://developers.google.com/idx/guides/preview-apps
[Customize your IDX workspace]: https://developers.google.com/idx/guides/customize-idx-env

## Terminal

To create a Flutter app in your terminal,
you first need to install and [set up Flutter][flutter-setup].
Then follow these steps:

 1. <h3>Open your terminal</h3>

    Open your preferred method to access the command line,
    such as Terminal on macOS or PowerShell on Windows.

 1. <h3>Navigate to the desired directory</h3>

    Ensure your current working directory
    is the desired parent directory for your new app.
    Do not create the project folder, the `flutter` tool will do so.

 1. <h3>Configure project creation</h3>

    In your terminal, type out the `flutter create` command and
    pass in any desired flags and options to configure your project.
    For example, to create an app with a minimal `main.dart` file,
    you can add the `--empty` option:

    ```console
    $ flutter create --empty
    ```

    To learn about the available creation options,
    run `flutter create --help` in another terminal window.

 1. <h3>Enter a project name</h3>

    As the only non-option argument to `flutter create`,
    specify the directory and default name for your application.
    The name should follow the `lowercase_with_underscores` naming convention,
    following the [Effective Dart][package-name] guidelines.

    For example, if you wanted to create an app named `my_app`:

    ```console
    $ flutter create my_app
    ```

 1. <h3>Execute the configured command</h3>

    To create a project with your specified configuration,
    run the command you built in the previous step.

 1. <h3>Wait for project initialization</h3>

    The `flutter` tool will now bootstrap your project's file structure
    and retrieve any necessary dependencies.
    This might take a while.

 1. <h3>Navigate into the project directory</h3>

    Now that your project has been created,
    you can navigate to it in your terminal or your preferred editor.
    For example, with a bash shell and a project named `my_app`:

    ```console
    $ cd my_app
    ```

 1. <h3>Run your app</h3>

    To try your new app,
    run the `flutter run` command in your terminal and
    respond to its prompts to select an output device.

{:.steps}

You've successfully created a new Flutter app in your terminal!
If you need help configuring your project or with the `flutter` CLI tool,
check out the [Flutter CLI reference][cli-reference].

[cli-reference]: /reference/flutter-cli

[flutter-setup]: /get-started/install
[package-name]: {{site.dart-site}}/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores
