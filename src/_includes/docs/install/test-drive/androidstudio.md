### Create a sample Flutter app {:#create-app-android-studio}

1. Launch the IDE.

2. To be able to create flutter projects on Android Studio you will need to install the
   [Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter) and for smart Dart 
   coding assistance that includes code completion, formatting, navigation, intentions, 
   refactorings, and more install the [Dart Plugin](https://plugins.jetbrains.com/plugin/6351-dart/).

3. Head back to your IDE start page and Click **New Flutter Project** at the top of the
   **Welcome to Android Studio** dialog.

4. Under **Generators**, click **Flutter**.

5. Verify the **Flutter SDK path** value against the Flutter SDK location
   on your development machine.

6. Click **Next**.

7. Enter `test_drive` into the **Project name** field.
   Your project name should be written in [snake case](https://developer.mozilla.org/en-US/docs/Glossary/Snake_case) and in lowercase. This follows the Flutter best practices for naming projects.

8. Set the directory in the **Project location** field to
   `C:\dev\test_drive` on Microsoft Windows or
   `~/development/test_drive` on other platforms.

   If you didn't create that directory before, Android Studio displays
   a warning that the **Directory Does Not Exist**. Click **Create**.

9. From **Project type** dropdown, select **Application**.

10. Ignore the remaining form fields. You don't need to change them for
    this test drive. Click **Create**.

11. Wait for Android Studio to create the project.

12. Open the `lib` directory, then the `main.dart`.

    To learn what each code block does, check out the comments in that Dart file.

The previous commands create a Flutter project directory
called `test_drive` that contains a simple demo app that
uses [Material Components][].

### Run your sample Flutter app

1. Locate the main Android Studio toolbar at the top of the
   Android Studio edit window.

   ![Main IntelliJ toolbar][]{:.mw-100}

1. In the **target selector**, select an Android device for running the app.
   You created your Android target device in the **Install** section.

1. To run your app, make one of the following choices:

   {:type="a"}
   1. Click the run icon in the toolbar.

   1. Go to **Run** <span aria-label="and then">></span> **Run**.

   1. Press <kbd>Ctrl</kbd> + <kbd>R</kbd>.

{% capture save_changes -%}
  : invoke **Save All**, or click **Hot Reload**
  {% render docs/install/test-drive/hot-reload-icon.md %}.
{% endcapture %}

{% capture ide_profile -%}
  to invoke the menu item **Run > Profile** in the IDE, or
{% endcapture %}

{% include docs/install/test-drive/try-hot-reload.md save_changes=save_changes ide="Android Studio" %}

[Main IntelliJ toolbar]: /assets/images/docs/tools/android-studio/main-toolbar.png
[Material Components]: {{site.material}}/components
