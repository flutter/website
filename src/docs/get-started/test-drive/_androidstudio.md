<div class="tab-pane active" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

## Create the app {#create-app}

 1. Open the IDE and select **Create New Flutter Project**.
 1. Select **Flutter Application** as the project type. Then click **Next**.
 1. Verify the Flutter SDK path specifies the SDK’s location
    (select **Install SDK...** if the text field is blank).
 1. Enter a project name (for example, `myapp`). Then click **Next**.
 1. Click **Finish**.
 1. Wait for Android Studio to install the SDK and create the project.

{% include_relative _package-name.md  %}

The above commands create a Flutter project directory called `myapp` that
contains a simple demo app that uses [Material Components][].

{% include_relative _main-code-note.md  %}

## Run the app

 1. Locate the main Android Studio toolbar:<br>
    ![Main IntelliJ toolbar][]{:.mw-100}
 1. In the **target selector**, select an Android device for running the app.
    If none are listed as available,
    select **Tools> Android > AVD Manager** and create one there.
    For details, see [Managing AVDs][].
 1. Click the run icon in the toolbar, or invoke the menu item **Run > Run**.

{% capture save_changes -%}
  : invoke **Save All**, or click **Hot Reload**
  {% include_relative _hot-reload-icon.md %}.
{% endcapture %}

{% capture ide_profile -%}
  to invoke the menu item **Run > Profile** in the IDE, or
{% endcapture %}

{% include_relative _try-hot-reload.md save_changes=save_changes %}
{% include run-profile.md ide_profile=ide_profile %}

[trusted your computer]: /docs/get-started/install/macos#trust
</div>



