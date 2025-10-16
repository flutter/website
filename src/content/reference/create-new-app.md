---
title: Create a new Flutter app
shortTitle: Create a new app
description: >-
  Learn how to bootstrap a new Flutter application from
  your command-line, different editors, and even in the cloud.
showBreadcrumbs: false
---

This page provides step-by-step instructions on how to
bootstrap a new Flutter app in your preferred development environment.

To create a new Flutter app, first [set up Flutter][flutter-setup], then
choose your preferred environment and follow the corresponding instructions.

<div class="card-grid">
  <a class="card outlined-card" href="#vs-code">
    <div class="card-header">
      <span class="card-title">VS Code</span>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving VS Code.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#android-studio">
    <div class="card-header">
      <span class="card-title">Android Studio</span>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving Android Studio.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#intellij">
    <div class="card-header">
      <span class="card-title">IntelliJ</span>
    </div>
    <div class="card-content">
      <p>Create a new Flutter app without leaving your IntelliJ-based IDE.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#firebase-studio">
    <div class="card-header">
      <span class="card-title">Firebase Studio</span>
    </div>
    <div class="card-content">
      <p>For quick and easy setup, create a new Flutter app in Firebase Studio.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#terminal">
    <div class="card-header">
      <span class="card-title">Terminal</span>
    </div>
    <div class="card-content">
      <p>For maximum flexibility, create a new Flutter app from the command line.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/add-to-app#get-started">
    <div class="card-header">
      <span class="card-title">
        <span>Add to app</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;" translate="no">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Create a new Flutter module to embed in an existing app.</p>
    </div>
  </a>
</div>

## VS Code

To create a Flutter app with [VS Code][] and other Code OSS-based editors,
you first need to [install Flutter][flutter-setup] and
[set up VS Code][vscode-setup] for Flutter development.
Then follow these steps:

 1. <h3>Launch VS Code</h3>

    Open VS Code or your preferred Code OSS-based editor.

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

    A file dialog should appear.
    Select or create the parent directory where
    you want the project to be created.
    Don't create the project folder itself, the Flutter tool does so.
    To confirm your selection,
    click **Select a folder to create the project in**.

 1. <h3>Enter a project name</h3>

    VS Code should prompt you to enter a name for your new project.
    Enter a name for your app that follows the `lowercase_with_underscores`
    naming convention, following the [Effective Dart][package-name] guidelines.
    To confirm your selection, press <kbd>Enter</kbd>.

 1. <h3>Wait for project initialization</h3>

    Based on the information you entered,
    VS Code uses `flutter create` to bootstrap your app.
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

    Open Android Studio with the Dart and Flutter plugins installed.

 1. <h3>Begin project creation</h3>

    If you're on the IDE welcome dialog that says **Welcome to Android Studio**,
    find and click the **New Flutter Project** button in the center.

    If you already have a project open, either close it or
    go to **File** <span aria-label="and then">></span> **New**
    <span aria-label="and then">></span> **New Flutter Project...**.

 1. <h3>Choose a project type</h3>

    In the **New Project** dialog, under **Generators** in the left panel,
    select **Flutter**.

 1. <h3>Verify Flutter SDK setup</h3>

    At the top of the right panel, ensure the **Flutter SDK path** value matches
    the location of the Flutter SDK you'd like to develop with.
    If not, update it by choosing or specifying the correct one.

 1. <h3>Configure your project</h3>

    Click **Next** to continue to project configuration.
    Multiple configuration options should appear.

    In the **Project name** field, enter a name for your app that
    follows the `lowercase_with_underscores` naming convention,
    following the [Effective Dart][package-name] guidelines.

    If you're not creating an application,
    select another template from the **Project type** dropdown.

    If you're creating an app that you might publish in the future,
    set the **Organization** field [to your company domain][as-set-org].

    The other fields can be kept as is or
    configured according to your project's needs.

 1. <h3>Finish project creation</h3>

    Once you've completed the configuration of your project,
    click **Create** to begin project initialization.

 1. <h3>Wait for workspace initialization</h3>

    Android Studio will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while and can be tracked at the bottom of the window.

 1. <h3>Run your app</h3>

    Your new app should now be created and open in Android Studio.
    To try your new app,
    follow the steps to [run and debug][as-run] in Android Studio.

{:.steps}

You've successfully created a new Flutter app in Android Studio!
If you need more help with developing Flutter in Android Studio,
check out the [Android Studio for Flutter reference][as-more].

[as-setup]: /tools/android-studio#installation-and-setup
[as-set-org]: /tools/android-studio#set-the-company-domain
[as-run]: /tools/android-studio#running-and-debugging
[as-more]: /tools/android-studio

## IntelliJ

To create a Flutter app with IntelliJ or other JetBrains IDEs,
you first need to [install Flutter][flutter-setup] and
[set up IntelliJ][ij-setup] for Flutter development.
Then follow these steps:

 1. <h3>Launch IntelliJ</h3>

    Open IntelliJ IDEA or your preferred IntelliJ-based IDE by JetBrains
    that has the Dart and Flutter plugins installed.

 1. <h3>Begin project creation</h3>

    If you're on the IDE welcome dialog that says **Welcome to IntelliJ IDEA**,
    find and click the **New Project** button in the upper right corner.

    If you already have a project open, either close it or
    go to **File** <span aria-label="and then">></span> **New**
    <span aria-label="and then">></span> **New Project...**.

 1. <h3>Choose a project type</h3>

    In the **New Project** dialog, under **Generators** in the left panel,
    select **Flutter**.

 1. <h3>Verify Flutter SDK setup</h3>

    At the top of the right panel, ensure the **Flutter SDK path** value matches
    the location of the Flutter SDK you'd like to develop with.
    If not, update it by choosing or specifying the correct one.

 1. <h3>Configure your project</h3>

    Click **Next** to continue to project configuration.
    Multiple configuration options should appear.

    In the **Project name** field, enter a name for your app that
    follows the `lowercase_with_underscores` naming convention,
    following the [Effective Dart][package-name] guidelines.

    If you're not creating an application,
    select another template from the **Project type** dropdown.

    If you're creating an app that you might publish in the future,
    set the **Organization** field [to your company domain][ij-set-org].

    The other fields can be kept as is or
    configured according to your project's needs.

 1. <h3>Finish project creation</h3>

    Once you've completed the configuration of your project,
    click **Create** to begin project initialization.

 1. <h3>Wait for workspace initialization</h3>

    IntelliJ will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while and can be tracked at the bottom of the window.

 1. <h3>Run your app</h3>

    Your new app should now be created and open in IntelliJ.
    To try your new app,
    follow the steps to [run and debug][ij-run] in IntelliJ.

{:.steps}

You've successfully created a new Flutter app in IntelliJ!
If you need more help with developing Flutter in IntelliJ,
check out the [IntelliJ for Flutter reference][ij-more].

[ij-setup]: /tools/android-studio#installation-and-setup
[ij-more]: /tools/android-studio
[ij-run]: /tools/android-studio#running-and-debugging

<a id="project-idx" aria-hidden="true"></a>

## Firebase Studio

To create a Flutter app with [Firebase Studio][fbs],
you first need a Google account and to [set up Firebase Studio][fbs-setup].
Then follow these steps:

 1. <h3>Launch Firebase Studio</h3>

    In your preferred browser, navigate to the [Firebase Studio dashboard][]
    found at `studio.firebase.google.com/`.
    If you haven't yet, you might need to log in to your Google account.

 1. <h3>Create a new workspace</h3>

    In the Firebase Studio dashboard, find the **Start coding an app** section.
    It should include a variety of templates to choose from.
    Select the **Flutter** template.
    If you can't find it, it might be under a **Mobile** category.

 1. <h3>Name your workspace</h3>

    Firebase Studio should prompt you to **Name your workspace**.
    This name is distinct from the name of your Flutter app.
    Choose a descriptive name that you'll recognize
    in a list of your workspaces.

 1. <h3>Provision your new workspace</h3>

    Once you've chosen a name and configured your workspace,
    click **Create** to provision your new workspace.

 1. <h3>Wait for workspace initialization</h3>

    Firebase Studio will now initialize your workspace,
    bootstrap your project file structure,
    and retrieve your app's dependencies.
    This might take a while.

1. <h3>Run your app</h3>

   Your new app should now be created and opened in the Firebase Studio editor.
   To try your new app, follow the docs provided by Firebase Studio to
   [preview your app][fbs-preview] on the web or on Android.

{:.steps}

You've successfully created a new Flutter app in Firebase Studio!
If you need help configuring your workspace,
check out [Customize your Firebase studio workspace][fbs-customize].

[fbs]: https://firebase.studio
[Firebase Studio dashboard]: https://studio.firebase.google.com/
[fbs-setup]: https://firebase.google.com/docs/studio/get-started
[fbs-preview]: https://firebase.google.com/docs/studio/preview-apps
[fbs-customize]: https://firebase.google.com/docs/studio/customize-workspace

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
    Don't create the project folder, the `flutter` tool will do so.

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

[flutter-setup]: /get-started
[package-name]: {{site.dart-site}}/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores
