After the app build completes, your device displays your app.

{% include docs/app-figure.md img-class="site-mobile-screenshot border"
    path-prefix="get-started" platform="macOS" image="starter-app.png"
    caption="Starter app" %}

## Try hot reload

Flutter offers a fast development cycle with _Stateful Hot Reload_,
the ability to reload the code of a live running app without
restarting or losing app state.

You can change your app source code, run the hot reload command in
{{include.ide}}, and see the change in your target device.

1. Open `lib/main.dart`.

1. Change the string.

   ```diff
   --- lib/main.dart
   +++ lib/main.dart
   @@ -1,109 +1,109 @@
   -              'You have pushed the button this many times:',
   +              'You have clicked the button this many times:',
   ```

   {{site.alert.important}}
     _Don't stop your app._ Let your app run.
   {{site.alert.end}}

1. Save your changes{{include.save_changes}}

Your app updates the string as you watch.

{% include docs/app-figure.md img-class="site-mobile-screenshot border"
    path-prefix="get-started" platform="macOS" image="starter-app-hot-reload.png"
    caption="Starter app after hot reload" %}
