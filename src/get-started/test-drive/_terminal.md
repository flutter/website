<div class="tab-pane" id="terminal" role="tabpanel" aria-labelledby="terminal-tab" markdown="1">

## Create the app  {#create-app}

Use the `flutter create` command to create a new project:

```terminal
$ flutter create myapp
$ cd myapp
```

It is also possible to pass other arguments to `flutter create`,
such as the project name (*pubspec.yml*), the organization name,
or to specify the programming language used for the native platform:

```terminal
$ flutter create --project-name myapp --org dev.flutter --android-language java --ios-language objc myapp
$ cd myapp
```

The command creates a Flutter project directory called `myapp` that
contains a simple demo app that uses [Material Components][].

{% include_relative _main-code-note.md  %}

## Run the app

 1. Check that an Android device is running. If none are shown, follow the
    device-specific instructions on the [Install][] page for your OS.

    ```terminal
    $ flutter devices
    ```

 2. Run the app with the following command:

    ```terminal
    $ flutter run
    ```

{% capture save_changes -%}
.
1. Type <kbd>r</kbd> in the terminal window.
{% endcapture %}

{% include_relative _try-hot-reload.md save_changes=save_changes %}
{% include docs/run-profile.md %}

[trusted your computer]:/get-started/install/macos#trust

</div>

