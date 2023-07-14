#### In PowerShell or the Command Prompt

To generate the needed Windows platform dependencies,
run the `flutter build` command.

```terminal
C:\> flutter build windows --debug
```

#### In VS Code

{% include docs/debug/debug-flow-vscode-as-start.md %}

{% comment %}
     !['Flutter app generated as a Windows app. The app displays two buttons to open this page in a browser or in the app'](/assets/images/docs/testing/debugging/native/url-launcher-app/windows.png){:width="50%"}
     <div markdown="1">{:.figure-caption}
     Flutter app generated as a Windows app. The app displays two buttons to open this page in a browser or in the app.
     </div>
{% endcomment %}

#### In Visual Studio

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
