#### Build the macOS version of the Flutter app in the Terminal

To generate the needed macOS platform dependencies,
run the `flutter build` command.

```console
flutter build macos --debug
```

```console
Building macOS application...
```

{% tabs "darwin-debug-flow" %}
{% tab "Start from VS Code" %}

#### Start debugging with VS Code first {:#vscode-macos}

##### Start the debugger in VS Code

{% include docs/debug/debug-flow-vscode-as-start.md %}

##### Attach to the Flutter process in Xcode

1. To attach to the Flutter app, go to
   **Debug** <span aria-label="and then">></span>
   **Attach to Process** <span aria-label="and then">></span>
   **Runner**.

   **Runner** should be at the top of the **Attach to Process** menu
   under the **Likely Targets** heading.

{% endtab %}
{% tab "Start from Xcode" %}

#### Start debugging with Xcode first {:#xcode-macos}

##### Start the debugger in Xcode

1. Open `macos/Runner.xcworkspace` from your Flutter app directory.

1. Run this Runner as a normal app in Xcode.

{% comment %}
   ![Start button in Xcode interface](/assets/images/docs/testing/debugging/native/xcode/run-app.png)
   <div class="figure-caption">

   Start button displayed in Xcode interface.

   </div>
{% endcomment %}

   When the run completes, the **Debug** area at the bottom of Xcode displays
   a message with the Dart VM service URI. It resembles the following response:

   ```console
   2023-07-12 14:55:39.966191-0500 Runner[58361:53017145]
       flutter: The Dart VM service is listening on
       http://127.0.0.1:50642/00wEOvfyff8=/
   ```

1. Copy the Dart VM service URI.

##### Attach to the Dart VM in VS Code

1. To open the command palette, go to **View** > **Command Palette...**

   You can also press <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `debug`.

1. Click the **Debug: Attach to Flutter on Device** command.

{% comment %}
   !['Running the Debug: Attach to Flutter on Device command in VS Code.'](/assets/images/docs/testing/debugging/vscode-ui/screens/attach-flutter-process-menu.png){:width="100%"}
{% endcomment %}

1. In the **Paste an VM Service URI** box, paste the URI you copied
   from Xcode and press <kbd>Enter</kbd>.

{% comment %}
   ![Alt text](/assets/images/docs/testing/debugging/vscode-ui/screens/vscode-add-attach-uri-filled.png)
{% endcomment %}

{% endtab %}
{% endtabs %}
