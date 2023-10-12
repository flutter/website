#### Build the macOS version of the Flutter app in the Terminal
{:.no_toc}

To generate the needed macOS platform dependencies,
run the `flutter build` command.

```terminal
$ flutter build macos --debug
```

```terminal
Building macOS application...
```

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="vscode-to-xcode-macos-setup" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="from-vscode-to-xcode-macos-tab" href="#from-vscode-to-xcode-macos" role="tab" aria-controls="from-vscode-to-xcode-macos" aria-selected="true">Start from VS Code</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="from-xcode-macos-tab" href="#from-xcode-macos" role="tab" aria-controls="from-xcode-macos" aria-selected="false">Start from Xcode</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="from-vscode-to-xcode-macos" role="tabpanel" aria-labelledby="from-vscode-to-xcode-macos-tab" markdown="1">

#### Start debugging with VS Code first {#vscode-macos}
{:.no_toc}

##### Start the debugger in VS Code
{:.no_toc}

{% include docs/debug/debug-flow-vscode-as-start.md %}

##### Attach to the Flutter process in Xcode
{:.no_toc}

1. To attach to the Flutter app, go to
   **Debug** <span aria-label="and then">></span>
   **Attach to Process** <span aria-label="and then">></span>
   **Runner**.

   **Runner** should be at the top of the **Attach to Process** menu
   under the **Likely Targets** heading.

</div>

<div class="tab-pane" id="from-xcode-macos" role="tabpanel" aria-labelledby="from-xcode-macos-tab" markdown="1">

#### Start debugging with Xcode first {#xcode-macos}
{:.no_toc}

##### Start the debugger in Xcode
{:.no_toc}

1. Open `macos/Runner.xcworkspace` from your Flutter app directory.

1. Run this Runner as a normal app in Xcode.

{% comment %}
   ![Start button in Xcode interface](/assets/images/docs/testing/debugging/native/xcode/run-app.png)
   <div markdown="1">{:.figure-caption}
   Start button displayed in Xcode interface.
   </div>
{% endcomment %}

   When the run completes, the **Debug** area at the bottom of Xcode displays
   a message with the Dart VM service URI. It resembles the following response:

   ```terminal
   2023-07-12 14:55:39.966191-0500 Runner[58361:53017145]
       flutter: The Dart VM service is listening on
       http://127.0.0.1:50642/00wEOvfyff8=/
   ```

1. Copy the Dart VM service URI.

##### Attach to the Dart VM in VS Code
{:.no_toc}

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

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}
