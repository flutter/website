## Get the Flutter SDK {#get-sdk}

{% include docs/china-notice.md %}

Install Flutter on Linux using one of the following two methods.
After installation, verify your environment setup.

### Method 1: Install Flutter using snapd

This offers the most direct method to install Flutter on Linux.
To learn about using snapd, check [Installing snapd][].

After you install `snapd`, install Flutter from the Snap Store or
use the following command:

```terminal
$ sudo snap install flutter --classic
```

{{site.alert.note}}
  After you install `snapd`,
  display your Flutter SDK path with the following command:

  ```terminal
  $ flutter sdk-path
  ```

{{site.alert.end}}

### Method 2: Manual Installation

If you don't have or can't use `snapd`, follow these steps to install Flutter.

1. Download the installation bundle for the latest
   {{site.sdk.channel}} release of the Flutter SDK:

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

    This command sets your `PATH` environment variable for the current
    terminal window only.
    To add Flutter as permenant part of your path,
    check out [Update your path][].

4. (Optional) Pre-download development binaries:

    ```terminal
    $ flutter precache
    ```

    To find additional download options, run `flutter help precache`.

{{site.alert.note}}
  To update an existing version of Flutter, see [Upgrading Flutter][].
{{site.alert.end}}

### Post Installation: Run flutter doctor

After installing Flutter, run `flutter doctor`.
This command checks your environment and displays a report in the
terminal window.
Flutter bundles the Dart SDK. You don't need to install Dart.
Review the output for further tasks to perform.

For verbose output, add the `-v` flag:

```terminal
$ flutter doctor
```

The output might resemble the following:

```terminal
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/dash/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit {{site.url}}/setup/#android-setup for detailed instructions.
```

After installing any missing dependencies,
run the `flutter doctor` command again.

{% include_relative _analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[install Flutter using the Snap Store]: https://snapcraft.io/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK archive]: {{site.url}}/release/archive
[Update your path]: #update-your-path
[Upgrading Flutter]: {{site.url}}/release/upgrade