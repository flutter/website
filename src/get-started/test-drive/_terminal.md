<div class="tab-pane" id="terminal" role="tabpanel" aria-labelledby="terminal-tab" markdown="1">

## Create new app

   1. Use the `flutter create` command to create a new project:
   {% commandline %}
   flutter create myapp
   cd myapp
   {% endcommandline %}

The above command creates a Flutter project directory called `myapp` that
contains a simple demo app that uses
[Material Components](https://material.io/guidelines/).

In the project directory, the code for your app is in `lib/main.dart`.

## Run the app

   * Check that an Android device is running. If none are shown, see
     [setup](/get-started/install).
   {% commandline %}
   flutter devices
   {% endcommandline %}
   * Run the app with the `flutter run` command:
   {% commandline %}
   flutter run
   {% endcommandline %}
   * If everything works, after the app has been built, you should see your
      starter app on your device or simulator:<br>
      ![Starter App on Android](/images/flutter-starter-app-android.png)

## Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

  1. Open the file `lib/main.dart`
  1. Change the string<br>`'You have pushed the button this many times:'`
     to<br>`'You have clicked the button this many times:'`
  1. Do not press the 'Stop' button; let your app continue to run.
  1. To see your changes invoke **Save All** (`cmd-s` / `ctrl-s`), or click the
     **Hot Reload button** (the button with the lightning bolt icon).

You should see the updated string in the running app almost immediately.

</div>
