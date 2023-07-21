## Get the Flutter SDK {#get-sdk}

{% include docs/china-notice.md %}

Installing Flutter on Linux can be done via two methods. After installation, you should run the `flutter doctor` command to ensure that the environment is correctly set up.

### Understanding Linux Commands

Before we begin the installation, it would be useful to understand some common Linux commands. Refer to our [Glossary](#glossary) section for a brief overview of these commands.

### Method 1: Install Flutter using snapd

This is the simplest way to install Flutter on Linux. For more information about using snapd, check [Installing snapd][].

Once snapd is installed, you can install Flutter from the Snap Store or by using the following command:

```terminal
$ sudo snap install flutter --classic
```

{{site.alert.note}}
  Once snap is installed, you can display your Flutter SDK path by using the following command:

  ```terminal
  $ flutter sdk-path
  ```
{{site.alert.end}}

### Method 2: Manual Installation

If you do not have `snapd`, or if you can't use it, follow these steps to install Flutter manually:

1. Download the installation bundle for the latest {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    You can find older builds and other release channels in the [SDK archive][].

2. Extract the downloaded file to a location of your choice:

    ```terminal
    $ cd ~/development
    $ tar xf ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.tar.xz
    ```

3. Add the `flutter` tool to your path:

    ```terminal
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    Note that this command sets your `PATH` variable for the current terminal window only. To add Flutter to your path permanently, refer to [Update your path][].

4. (Optional) Pre-download development binaries:

    ```terminal
    $ flutter precache
    ```

    You can find additional download options by running `flutter help precache`.

{{site.alert.note}}
  To update an existing version of Flutter, see [Upgrading Flutter][].
{{site.alert.end}}

### Post Installation: Run flutter doctor

After installing Flutter, you should run `flutter doctor` to ensure that the environment is set up correctly. This command checks your environment and displays a report in the terminal window. The Dart SDK is bundled with Flutter; it isn't necessary to install Dart separately. Review the output carefully for any additional software you may need to install or further tasks to perform.

For verbose output, add the `-v` flag:

```terminal
$ flutter doctor
```

Here is an example of what you might see:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/dash/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit {{site.url}}/setup/#android-setup for detailed instructions.
</pre>

After installing any missing dependencies, run the `flutter doctor` command again to verify that everything is set up correctly.

{% include_relative _analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[install Flutter using the Snap Store]: https://snapcraft.io/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK archive]: {{site.url}}/release/archive
[Update your path]: #update-your-path
[Upgrading Flutter]: {{site.url}}/release/upgrade
