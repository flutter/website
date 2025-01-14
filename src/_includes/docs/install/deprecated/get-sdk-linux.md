## Get the Flutter SDK {:#get-sdk}

{% render docs/china-notice.md %}

To install the Flutter SDK on your Linux system,
use one of the following methods.

### Method 1: Install Flutter using snapd

This offers the most direct method to install
the Flutter SDK on your Linux system.

To learn about using snapd, check [Installing snapd][].

After you install `snapd`, [install Flutter from the Snap Store][] or
run the following command:

```console
$ sudo snap install flutter --classic
```

:::note
After you install Flutter with `snapd`,
display your Flutter SDK path with the following command:

```console
$ flutter sdk-path
```
:::

### Method 2: Manual installation

If you aren't using `snapd`, follow these steps to install Flutter.

1. Download the installation bundle for the latest
   {{site.sdk.channel}} release of the Flutter SDK:

   [(loading...)](#){:.download-latest-link-{{os}} .filled-button}

   You can find older builds and other release channels in the [SDK archive][].

1. Extract the downloaded file to a location of your choice:

    ```console
    $ cd ~/development
    $ tar xf ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.tar.xz
    ```

1. Add the `flutter` tool to your path:

    ```console
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    This command sets your `PATH` environment variable for the current
    terminal window only.
    To add Flutter as permanent part of your path,
    check out [Update your path][].

1. (Optional) Pre-download development binaries:

    ```console
    $ flutter precache
    ```

    To find additional download options, run `flutter help precache`.

:::note
To update an existing version of Flutter, see [Upgrading Flutter][].
:::

### Verify your install with `flutter doctor`

After installing Flutter, run `flutter doctor`.

```console
$ flutter doctor
```

This command checks your environment and displays a report in the
terminal window.
Flutter bundles the Dart SDK. You don't need to install Dart.

To get greater detail on what you need to fix, add the `-v` flag:

```console
$ flutter doctor -v
```

Review the output for further tasks to perform.
An example would be the text shown in **bold**.

The `flutter doctor -v` output might resemble the following:

{% comment %}
Need to use HTML for this code block to get the replacements
and boldface to work.
{% endcomment
   -%}

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/dash/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit /setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks
and finish the setup process.

After completing the outlined tasks,
run the `flutter doctor` command again.

{% include docs/install/deprecated/analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[install Flutter from the Snap Store]: https://snapcraft.io/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK archive]: /release/archive
[Update your path]: #update-your-path
[Upgrading Flutter]: /release/upgrade
