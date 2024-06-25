:::note
If you want to use the [GNU Project Debugger][] to debug the
Flutter engine running within an Android app process,
check out [`flutter_gdb`][].
:::

[GNU Project Debugger]: https://www.sourceware.org/gdb/
[`flutter_gdb`]: {{site.repo.engine}}/blob/main/sky/tools/flutter_gdb

#### Build the Android version of the Flutter app in the Terminal

To generate the needed Android platform dependencies,
run the `flutter build` command.

```console
flutter build appbundle --debug
```

```console
Running Gradle task 'bundleDebug'...                               27.1s
✓ Built build/app/outputs/bundle/debug/app-debug.aab.
```


{% tabs %}
{% tab "Start from VS Code" %}

#### Start debugging with VS Code first {:#from-vscode-to-android-studio}

If you use VS Code to debug most of your code, start with this section.

{% include docs/debug/debug-flow-vscode-as-start.md %}

#### Attach to the Flutter process in Android Studio

{% include docs/debug/debug-android-attach-process.md %}

{% endtab %}
{% tab "Start from Android Studio" %}

#### Start debugging with Android Studio first {:#from-android-studio}

If you use Android Studio to debug most of your code, start with this section.

{% include docs/debug/debug-flow-androidstudio-as-start.md %}

{% include docs/debug/debug-android-attach-process.md %}

{% endtab %}
{% endtabs %}
