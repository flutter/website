If everything works, after the app has been built, you'll see the starter app on
your device:
{% comment %}
FIXME: use a figure here?
{% endcomment -%}
![Starter App on Android](/images/flutter-starter-app-android.png)

## Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

 1. Open `lib/main.dart`
 1. Change the string<br>
    `'You have pushed the button this many times:'` to<br>
    `'You have clicked the button this many times:'`<br>
    **Important**: do _not_ press the _Stop_ button; let your app run.
 1. Save your changes{{include.save_changes}}.

You'll see the updated string in the running app almost immediately.
