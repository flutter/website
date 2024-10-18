### Create a sample Flutter app {:#create-app-vs-code}

1. To use Flutter DevTools from VS Code, install the
    [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter).
   This also automatically installs the
   [Dart extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code).
   With these extensions, you can debug your application.

2. Open the Command Palette.

   Go to **View** <span aria-label="and then">></span> **Command Palette** or
   press <kbd class="special-key"></kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

3. Type `flutter`.

4. Select the **Flutter: New Project**.

5. When prompted for **Which Flutter Project**, select **Application**.

6. Create or select the parent directory for the new project folder.

7. When prompted for a **Project Name**, enter `test_drive`.

8. Press <kbd>Enter</kbd>.

9. Wait for project creation to complete.

10. Open the `lib` directory, then the `main.dart`.

    To learn what each code block does, check out the comments in that Dart file.

The previous commands create a Flutter project directory called `test_drive` that
contains a simple demo app that uses [Material Components][].

### Run your sample Flutter app

Run your example application on your desktop platform, in the Chrome web browser, in an iOS simulator, or
Android emulator.

:::note
Though you can deploy your app to the web,
the web target doesn't support
hot reload at this time.
:::

1. Open the Command Palette.

   Go to **View** <span aria-label="and then">></span> **Command Palette** or
   press <kbd class="special-key"></kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `flutter`.

1. Select the **Flutter: Select Device**.

   If no devices are running, this command prompts you to enable a device.

1. Select a target device from **Select Device** prompt.

1. After you select a target, start the app.
   Go to **Run** <span aria-label="and then">></span>
   **Start Debugging** or press <kbd>F5</kbd>.

1. Wait for the app to launch.

   You can watch the launch progress in the **Debug Console** view.

{% capture save_changes -%}
: invoke **Save All**, or click **Hot Reload**
{% render docs/install/test-drive/hot-reload-icon.md %}.
{% endcapture %}

{% include docs/install/test-drive/try-hot-reload.md save_changes=save_changes ide="VS Code" %}

[Material Components]: {{site.material}}/components

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const specialKey = navigator.userAgent.includes('Mac')? 'Command' : 'Control';
    document.querySelectorAll('.special-key').forEach((element)=>element.textContent=specialKey);
  });
</script>
