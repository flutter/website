## Get the Flutter SDK

{% render docs/china-notice.md %}

{% render docs/help-link.md, location:'win-get-sdk' %}

 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}} .filled-button}

    For other release channels, and older builds,
    check out the [SDK archive][].
 1. Extract the zip file and place the contained `flutter`
    in the desired installation location for the Flutter SDK
    (for example, `%USERPROFILE%\flutter`, `C:\dev\flutter`).

:::warning
Do not install Flutter to a path that contains special
characters or spaces.
:::

:::warning
Do not install Flutter in a directory like
`C:\Program Files\` that requires elevated privileges.
:::

You are now ready to run Flutter commands in the Flutter Console.


### Update your path

{% render docs/help-link.md, location:'win-path', section:'#unable-to-find-the-flutter-command' %}

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

{% include docs/dart-tool-win.md %}

### Run `flutter doctor`

{% render docs/help-link.md, location:'win-doctor' %}

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
    • Android SDK at C:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit /setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks and
finish the setup process. Once you have installed any missing
dependencies, you can run the `flutter doctor` command again to
verify that you've set everything up correctly.

:::note
If `flutter doctor` returns that either the Flutter plugin
or  Dart plugin of Android Studio are not installed, move
on to [Set up an editor][] to resolve this issue.
:::

{% include docs/install/deprecated/analytics.md %}

[SDK archive]: /release/archive
[Set up an editor]: /get-started/editor?tab=androidstudio
