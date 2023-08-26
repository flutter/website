##### Enable automatic attachment

You can configure VS Code to attach to your Flutter module project
whenever you start debugging.
To enable this feature,
create a `.vscode/launch.json` file in your Flutter module project.

1. Go to **View** <span aria-label="and then">></span> **Run**.

   You can also press
   <kbd>Control</kbd> or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd>.

   VS Code displays the **Run and Debug** sidebar.

1. In this sidebar, click **create a launch.json file**.

   VS Code displays the **Select debugger** menu at the top.

1. Select **Dart & Flutter**.

   VS Code creates then opens the `.vscode/launch.json` file.

   <details markdown="1">
   <summary>Open to see an example launch.json file</summary>

    ```json
    {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "name": "my_app",
                "request": "launch",
                "type": "dart"
            },
            {
                "name": "my_app (profile mode)",
                "request": "launch",
                "type": "dart",
                "flutterMode": "profile"
            },
            {
                "name": "my_app (release mode)",
                "request": "launch",
                "type": "dart",
                "flutterMode": "release"
            }
        ]
    }
    ```

    </details>

1. To attach, go to **Run** <span aria-label="and then">></span>
   **Start Debugging**.

   You can also press <kbd>F5</kbd>.
