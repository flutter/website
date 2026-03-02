---
title: Set up and test drive Flutter
shortTitle: Quick start
description: >-
  Set up Flutter on your device with a Code OSS-based editor, such as VS Code, and
  get started developing your first multi-platform app with Flutter!
showBanner: false
sitemap: false
---

{% render "docs/install/quick.md" site: site %}

## Test drive Flutter {: #test-drive}

Now that you've set up VS Code and Flutter,
it's time to create an app and try out Flutter development!

 1. <h3>Create a new Flutter app</h3>

    1. Open the command palette in VS Code.

       Go to **View** <span aria-label="and then">></span> **Command Palette**
       or press <kbd class="special-key">Cmd/Ctrl</kbd> +
       <kbd>Shift</kbd> + <kbd>P</kbd>.

    1. In the command palette, start typing `flutter:`.

       VS Code should surface commands from the Flutter plugin.

    1. Select the **Flutter: New Project** command.

       Your OS or VS Code might ask for access to your documents,
       agree to continue to the next step.

    1. Choose the **Application** template.

       VS Code should prompt you with **Which Flutter template?**.
       Choose **Application** to bootstrap a simple counter app.

    1. Create or select the parent directory for your new app's folder.

       A file dialog should appear.

       1. Select or create the parent directory where
          you want the project to be created.
       1. To confirm your selection,
          click **Select a folder to create the project in**.

    1. Enter a name for your app.

       VS Code should prompt you to enter a name for your new app.
       Enter `trying_flutter` or a similar `lowercase_with_underscores` name.
       To confirm your selection, press <kbd>Enter</kbd>.

    1. Wait for project initialization to complete.

       Task progress is often surfaced as a notification in the bottom right
       and can also be accessed from the **Output** panel.

    1. Open the `lib` directory, then the `main.dart` file.

       If you're curious about what each portion of the code does,
       check out the preceding comments throughout the file.

 1. <h3>Run your app on the web</h3>

    While Flutter apps can run on many platforms,
    try running your new app on the web.

    1. Open the command palette in VS Code.

       Go to **View** <span aria-label="and then">></span> **Command Palette**
       or press <kbd class="special-key">Cmd/Ctrl</kbd> +
       <kbd>Shift</kbd> + <kbd>P</kbd>.

    1. In the command palette, start typing `flutter:`.

       VS Code should surface commands from the Flutter plugin.

    1. Select the **Flutter: Select Device** command.

    1. From the **Select Device** prompt, select **Chrome**.

    1. Run or start debugging your app.

       Go to **Run** <span aria-label="and then">></span>
       **Start Debugging** or press <kbd>F5</kbd>.

       `flutter run` is used to build and start your app,
       then a new instance of Chrome should open and
       start running your newly created app.

 1. <h3>Try hot reload</h3>

    Flutter offers a fast development cycle with **stateful hot reload**,
    the ability to reload the code of a live running app without
    restarting or losing app state.

    You can change your app's source code,
    run the hot reload command in VS Code,
    then see the change in your running app.

    1. In the running app, try adding to the counter a few times by
       clicking the ![increment (+)][increment-button]{: .text-icon} button.

    1. With your app still running, make a change in the `lib/main.dart` file.

       Change the `_counter++` line in the `_incrementCounter` method
       to instead decrement the `_counter` field.

       ```dart diff
         setState(() {
           // ...
       -   _counter++;
       +   _counter--;
         });
       ```

    1. Save your changes
       (**File** <span aria-label="and then">></span> **Save All**) or
       click the **Hot Reload** ![hot reload icon][]{: .text-icon} button.

       Flutter updates the running app without losing any existing state.
       Notice the existing value stayed the same.

    1. Try clicking the
       ![increment (+)][increment-button]{: .text-icon} button again.
       Notice the value decreases instead of increases.

 1. <h3>Explore the Flutter sidebar</h3>

    The Flutter plugin adds a dedicated sidebar to VS Code
    for managing Flutter debug sessions and devices,
    viewing an outline of your code and widgets,
    as well as accessing the Dart and Flutter DevTools.

    1. If your app isn't running, start debugging it again.

       Go to **Run** <span aria-label="and then">></span>
       **Start Debugging** or press <kbd>F5</kbd>.

    1. Open the Flutter sidebar in VS Code.

       Either open it with the Flutter ![Flutter logo][]{: .text-icon} button in
       the VS Code sidebar or open it from the command palette by
       running the **Flutter: Focus on Flutter Sidebar View** command.

    1. In the Flutter sidebar, under **DevTools**,
       click the **Flutter Inspector** button.

       A separate **Widget Inspector** panel should open in VS Code.

       In the widget inspector, you can view your app's widget tree,
       view the properties and layout of each widget, and more.

    1. In the widget inspector, try clicking the top-level `MyHomePage` widget.

       A view of its properties and layout should open, and
       the VS Code editor should navigate to and focus the line where
       the widget was included.

    1. Explore and try out other features in
       the widget inspector and Flutter sidebar.

{:.steps}

[increment-button]: /assets/images/docs/get-started/increment-button.png
[hot reload icon]: /assets/images/docs/get-started/hot-reload.svg
[Flutter logo]: /assets/images/branding/flutter/logo/square.svg

## Continue your Flutter journey {: #next-steps}

**Congratulations!**
Now that you've installed and tried out Flutter,
follow the codelab on [Building your first app][],
set up development for an [additional target platform][], or
explore some of these resources to continue your Flutter learning journey.

{% render "docs/get-started/setup-next-steps.html", site: site %}

[Building your first app]: /get-started/codelab
[additional target platform]: /platform-integration#setup
