## Get the Flutter SDK

 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    For other release channels, and older builds, see the
    [SDK releases][] page.
 1. Extract the zip file and place the contained `flutter`
    in the desired installation location for the Flutter SDK
    (for example, `C:\Users\<your-user-name>\Documents`).
    
{{site.alert.warning}}
  Do not install Flutter in a directory like 
  `C:\Program Files\` that requires elevated privileges.
{{site.alert.end}}

If you don't want to install a fixed version of the installation 
bundle, you can skip steps 1 and 2. Instead, get the source code 
from the [Flutter repo][] on 
GitHub, and change branches or tags as needed. For example:

```batchfile
C:\src>git clone https://github.com/flutter/flutter.git -b stable
```

You are now ready to run Flutter commands in the Flutter Console.

[Flutter repo]: {{site.github}}/flutter/flutter

### Update your path

If you wish to run Flutter commands in the regular Windows console,
take these steps to add Flutter to the `PATH` environment variable:

* From the Start search bar, enter 'env'
  and select **Edit environment variables for your account**.
* Under **User variables** check if there is an entry called **Path**:
  * If the entry exists, append the full path to `flutter\bin` using
    `;` as a separator from existing values.
  * If the entry doesn't exist,
    create a new user variable named `Path` with
    the full path to `flutter\bin` as its value.

You have to close and reopen any existing console windows
for these changes to take effect.

{% include dart-tool-win.md %}

### Run `flutter doctor`

From a console window that has the Flutter directory in the
path (see above), run the following command to see if there
are any platform dependencies you need to complete the setup:

```batchfile
C:\src\flutter>flutter doctor
```

This command checks your environment and displays a report of the status
of your Flutter installation. Check the output carefully for other
software you might need to install or further tasks to perform
(shown in **bold** text).

For example:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit {{site.url}}/setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks and
finish the setup process. Once you have installed any missing
dependencies, you can run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

{{site.alert.note}}
  If `flutter doctor` returns that either the Flutter plugin
  or  Dart plugin of Android Studio are not installed, move
  on to [Set up an editor][] to resolve this issue.
{{site.alert.end}}

{% include_relative _analytics.md %}


[Flutter repo]: {{site.github}}/flutter/flutter
[SDK releases]: /docs/development/tools/sdk/releases
[Set up an editor]: /docs/get-started/editor?tab=androidstudio
