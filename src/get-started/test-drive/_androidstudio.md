<div class="tab-pane active" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

{% comment %}
TODO(chalin): we've written this already on the editor page. Avoid repeating it?

  Android Studio offers a complete, integrated IDE experience for Flutter.

{% endcomment -%}

## Create the app {#create-app}

 1. Select **File > New Flutter Project**
 1. Select **Flutter application** as the project type, and press Next
 1. Enter a project name (e.g. `myapp`), and press Next
 1. Click **Finish**
 1. Wait for Android Studio to install the SDK, and create the project.

The above command creates a Flutter project directory called `myapp`
that contains a simple demo
app that uses [Material Components](https://material.io/guidelines/).

In the project directory, the code for your app is in `lib/main.dart`.

## Run the app

 1. Locate the main Android Studio toolbar:<br>
    ![Main IntelliJ toolbar](/development/tools/images/main-toolbar.png)
 1. In the **target selector**, select an Android device for running the app.
    If none are listed as available, select **Tools> Android > AVD Manager** and
    create one there. For details, see [Managing
    AVDs](https://developer.android.com/studio/run/managing-avds.html).
 1. Click the **Run icon** in the toolbar, or invoke the menu item **Run >
    Run**.

{% capture save_changes -%}
  : invoke **Save All**, or click
    **Hot Reload** (the button with the lightning bolt icon)
{% endcapture %}

{% include_relative _try-hot-reload.md save_changes=save_changes %}

</div>
