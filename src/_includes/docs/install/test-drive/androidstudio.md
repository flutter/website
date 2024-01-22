<div class="tab-pane" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

### Create your sample Flutter app {#create-app}

1. Launch the IDE.

1. Click **New Flutter Project** at the top of the
   **Welcome to Android Studio** dialog.

1. Under **Generators**, click **Flutter**.

1. Verify the **Flutter SDK path** value against the Flutter SDK location
   on your development machine.

1. Click **Next**.

1. Enter `test_drive` into the **Project name** field.
   This follows best practices for naming Flutter projects.

1. Set the directory in the **Project location** field to
   `C:\dev\test_drive` on Microsoft Windows or
   `~/development/test_drive` on other platforms.

   If you didn't create that directory before, Android Studio displays
   a warning that the **Directory Does Not Exist**. Click **Create**.

1. From **Project type** dropdown, select **Application**.

1. Change the **Organization** to `com.example.flutter.testdrive`.

   Android Studio asks for a company domain name.
   Android uses the company domain name and project name together as its
   package name when you release the app. iOS uses its Bundle ID.

   Use `com.example.flutter.testdrive` to prevent future conflicts.

1. Ignore the remaining form fields. You don't need to change them for
   this test drive. Click **Create**.

1. Wait for Android Studio to create the project.

1. Open the `lib` directory, then the `main.dart`.

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
  {% include docs/install/test-drive/hot-reload-icon.md %}.
{% endcapture %}

{% capture ide_profile -%}
  to invoke the menu item **Run > Profile** in the IDE, or
{% endcapture %}

{% include docs/install/test-drive/try-hot-reload.md save_changes=save_changes ide="Android Studio" %}

[Main IntelliJ toolbar]: {{site.url}}/assets/images/docs/tools/android-studio/main-toolbar.png
[Material Components]: {{site.material}}/components

</div>
