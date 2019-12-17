After the app build completes, you'll see the starter app on your device.

{% include app-figure.md img-class="site-mobile-screenshot border"
    path-prefix="get-started" platform="iOS" image="starter-app.png"
    caption="Starter app" %}

## Try hot reload

Flutter offers a fast development cycle with _Stateful Hot Reload_,
the ability to reload the code of a live running app without
restarting or losing app state.
Make a change to app source,
tell your IDE or command-line tool that you want to hot reload,
and see the change in your simulator, emulator, or device.

 1. Open `lib/main.dart`.
 1. Change the string

    {% prettify dart %}
      'You have [[strike]]pushed[[/strike]] the button this many times'
    {% endprettify %}

    to

    {% prettify dart %}
      'You have [!clicked!] the button this many times'
    {% endprettify %}

    {{site.alert.important}}
      Do _not_ stop your app. Let your app run.
    {{site.alert.end}}

 1. Save your changes{{include.save_changes}}

You'll see the updated string in the running app almost immediately.
