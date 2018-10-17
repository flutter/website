## Get the Flutter SDK

 1. Download the following installation bundle to get the latest beta release of the
    Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    For other release channels, and older builds, see the [SDK
    archive](/development/tools/sdk/archive) page.
 1. Extract the zip file and place the contained `flutter` in the desired
    installation location for the Flutter SDK (eg. `C:\src\flutter`; do not
    install flutter in a directory like `C:\Program Files\` that requires
    elevated privileges).
 1. Locate the file `flutter_console.bat` inside the `flutter` directory. Start
    it by double-clicking.

You are now ready to run Flutter commands in the Flutter Console!

To update an existing version of Flutter, see [Upgrading Flutter](/development/tools/sdk/upgrading).

### Update your path

If you wish to run Flutter commands in the regular Windows command prompt, take
these steps to add Flutter to the `PATH` environment variable:

* Go to **Control Panel > User Accounts > User Accounts > Change my environment
  variables**
* Under **User variables** check if there is an entry called **Path**:
  * If the entry does exist, append the full path to `flutter\bin` using `;` as
    a separator from existing values.
  * If the entry does not exist, create a new user variable named `Path` with
    the full path to `flutter\bin` as its value.

Reboot Windows to fully apply this change.

### Run flutter doctor

In the Flutter Console, run the following command to see if there are any
dependencies you need to install to complete the setup:

```terminal
$ flutter doctor
```

This command checks your environment and displays a report to the terminal
window. The Dart SDK is bundled with Flutter; it is not necessary to install
Dart separately. Check the output carefully for other software you may need to
install or further tasks to perform (shown in **bold** text).

For example:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks and finish the setup
process. Once you have installed any missing dependencies, run the `flutter
doctor` command again to verify that you’ve set everything up correctly.

{% include_relative _analytics.md %}
