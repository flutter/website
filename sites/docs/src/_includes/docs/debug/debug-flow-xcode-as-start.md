##### Start the Xcode debugger
{:.no_toc}

1. Open `ios/Runner.xcworkspace` from your Flutter app directory.

1. Select the correct device using the **Scheme** menu in the toolbar.

    If you have no preference, choose **iPhone Pro 14**.

   {% comment %}
    ![Selecting iPhone 14 in the Scheme menu in the Xcode toolbar](/assets/images/docs/testing/debugging/native/xcode/select-device.png){:width="100%"}
    <div markdown="1">{:.figure-caption}
    Selecting iPhone 14 in the Scheme menu in the Xcode toolbar.
    </div>
    {% endcomment %}

1. Run this Runner as a normal app in Xcode.

    {% comment %}
    ![Start button in Xcode interface](/assets/images/docs/testing/debugging/native/xcode/run-app.png)
    <div markdown="1">{:.figure-caption}
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
{:.no_toc}

1. To open the command palette, go to
    **View** <span aria-label="and then">></span>
    **Command Palette...**

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
