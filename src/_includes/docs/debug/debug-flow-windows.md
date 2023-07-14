#### Build the Windows version of the Flutter app in PowerShell or the Command Prompt

To generate the needed Windows platform dependencies,
run the `flutter build` command.

```terminal
C:\> flutter build windows --debug
```

```terminal
Building Windows application...                                    31.4s
√  Built build\windows\runner\Debug\my_app.exe.
```

#### Start debugging with Visual Studio first

If you use Visual Studio to debug most of your code, start with this section.

##### Start the local Windows debugger

1. To open the project solution file, go to
   **File** <span aria-label="and then">></span>
   **Open** <span aria-label="and then">></span>
   **Project/Solution…**

   You can also press <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd>.

1. Choose the `build/windows/my_app.sln` file in your Flutter app directory.

{% comment %}
   ![Open Project/Solution dialog box in Visual Studio 2022 with my_app.sln file selected.](/assets/images/docs/testing/debugging/native/visual-studio/choose-solution.png){:width="100%"}
   <div markdown="1">{:.figure-caption}
   Open Project/Solution dialog box in Visual Studio 2022 with
   `my_app.sln`` file selected.
   </div>
{% endcomment %}

1. Click **Local Windows Debugger** to start debugging.

   You can also press <kbd>F5</kbd>.

   When the Flutter app has started, A second Flutter window displays
   a message with the Dart VM service URI. It resembles the following response:

   ```terminal
   flutter: The Dart VM service is listening on http://127.0.0.1:62080/KPHEj2qPD1E=/
   ```

1. Copy the Dart VM service URI.

##### Attach to the Dart VM in VS Code

1. To open the command palette, go to
   **View** <span aria-label="and then">></span>
   **Command Palette...**

   You can also press <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

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

#### Start debugging with VS Code first

If you use VS Code to debug most of your code, start with this section.

##### Start the debugger in VS Code

{% include docs/debug/debug-flow-vscode-as-start.md %}

{% comment %}
     !['Flutter app generated as a Windows app. The app displays two buttons to open this page in a browser or in the app'](/assets/images/docs/testing/debugging/native/url-launcher-app/windows.png){:width="50%"}
     <div markdown="1">{:.figure-caption}
     Flutter app generated as a Windows app. The app displays two buttons to open this page in a browser or in the app.
     </div>
{% endcomment %}

##### Attach to the Flutter process in Visual Studio

1. To open the project solution file, go to
   **File** <span aria-label="and then">></span>
   **Open** <span aria-label="and then">></span>
   **Project/Solution…**

   You can also press <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd>.

1. Choose the `build/windows/my_app.sln` file in your Flutter app directory.

{% comment %}
   ![Open Project/Solution dialog box in Visual Studio 2022 with my_app.sln file selected.](/assets/images/docs/testing/debugging/native/visual-studio/choose-solution.png){:width="100%"}
   <div markdown="1">{:.figure-caption}
   Open Project/Solution dialog box in Visual Studio 2022 with
   `my_app.sln`` file selected.
   </div>
{% endcomment %}

1. Go to **Debug** > **Attach to Process**.

   You can also press <kbd>Control</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd>.

1. From the **Attach to Process** dialog box, choose `my_app.exe`.

{% comment %}
   ![Selecting my_app from the Attach to Process dialog box](/assets/images/docs/testing/debugging/native/visual-studio/attach-to-process-dialog.png){:width="100%"}
{% endcomment %}

   Visual Studio starts monitoring the Flutter app.

{% comment %}
   ![Visual Studio debugger running and monitoring the Flutter app](/assets/images/docs/testing/debugging/native/visual-studio/debugger-active.png){:width="100%"}
{% endcomment %}

