{{site.alert.note}}
  If you want to use the [GNU Project Debugger][] to debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].
{{site.alert.end}}

[GNU Project Debugger]: https://www.sourceware.org/gdb/
[`flutter_gdb`]: https://github.com/flutter/engine/blob/main/sky/tools/flutter_gdb

#### Build the Android version of the Flutter app in the Terminal
{:.no_toc}

To generate the needed Android platform dependencies,
run the `flutter build` command.

```terminal
$ flutter build appbundle --debug
```

```terminal
Running Gradle task 'bundleDebug'...                               27.1s
✓ Built build/app/outputs/bundle/debug/app-debug.aab.
```

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="vscode-to-android-studio-setup" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="from-vscode-to-android-studio-tab" href="#from-vscode-to-android-studio" role="tab" aria-controls="from-vscode-to-android-studio" aria-selected="true">Start from VS Code</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="from-android-studio-to-vscode-tab" href="#from-android-studio-to-vscode" role="tab" aria-controls="from-android-studio-to-vscode" aria-selected="false">Start from Android Studio</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="from-vscode-to-android-studio" role="tabpanel" aria-labelledby="from-vscode-to-android-studio-tab" markdown="1">

#### Start debugging with VS Code first {#from-vscode-to-android-studio}
{:.no_toc}

If you use VS Code to debug most of your code, start with this section.

{% include docs/debug/debug-flow-vscode-as-start.md %}

#### Attach to the Flutter process in Android Studio
{:.no_toc}

{% include docs/debug/debug-android-attach-process.md %}

[`url_launcher`]: {{site.url}}/examples/testing/oem_debugging

</div>

<div class="tab-pane" id="from-android-studio-to-vscode" role="tabpanel" aria-labelledby="from-android-studio-to-vscode-tab" markdown="1">

#### Start debugging with Android Studio first {#from-android-studio}
{:.no_toc}

If you use Android Studio to debug most of your code, start with this section.

1. To open the Flutter app directory, go to
   **File** <span aria-label="and then">></span>
   **Open...** and choose the `my_app` directory.

1. Open the `lib/main.dart` file.

1. Choose a virtual Android device.
   Go to the toolbar, open the leftmost dropdown menu, and click on
   **Open Android Emulator: \<device\>**.

   You can choose any installed emulator that's doesn't include `arm64`.

1. From that same menu, select the virtual Android device.

1. From the toolbar, click **Run main.dart**.

   You can also press <kbd>Control</kbd> + <kbd>R</kbd>.

   After the app displays in the emulator, continue to the next step.

{% include docs/debug/debug-android-attach-process.md %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}
