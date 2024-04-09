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

<div class="tab-pane active" id="from-vscode-to-android-studio" role="tabpanel" aria-labelledby="from-vscode-to-android-studio-tab">

#### Start debugging with VS Code first {:#from-vscode-to-android-studio}

If you use VS Code to debug most of your code, start with this section.

{% include docs/debug/debug-flow-vscode-as-start.md %}

#### Attach to the Flutter process in Android Studio

{% include docs/debug/debug-android-attach-process.md %}

</div>

<div class="tab-pane" id="from-android-studio-to-vscode" role="tabpanel" aria-labelledby="from-android-studio-to-vscode-tab">

#### Start debugging with Android Studio first {:#from-android-studio}

If you use Android Studio to debug most of your code, start with this section.

{% include docs/debug/debug-flow-androidstudio-as-start.md %}

{% include docs/debug/debug-android-attach-process.md %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}
