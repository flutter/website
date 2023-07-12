## Get the Flutter SDK {#get-sdk}

On Linux, you have two ways you can install Flutter.

### Install Flutter using snapd

The easiest way to install Flutter on Linux is by
using snapd. For more information,
check out [Installing snapd][].

Once you have snapd, you can
[install Flutter using the Snap Store][],
or at the command line:

```terminal
$ sudo snap install flutter --classic
```

{{site.alert.note}}
  Once you install snap,
  use the following command to display your Flutter SDK path:

  ```terminal
  $ flutter sdk-path
  ```
{{site.alert.end}}

### Install Flutter manually

If you don't have `snapd`, or can't use it,
you can install Flutter using the following steps.

 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    For other release channels, and older builds,
    check out the [SDK archive][].

 1. Extract the file in the desired location. For example:

    {% comment %}
      Our JS also updates the filename in this template,
      but it doesn't include the terminal formatting:

      {% prettify shell %}
      $ cd ~/development
      $ tar xf ~/Downloads/[[download-latest-link-filename]]flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.tar.xz[[/end]]
      {% endprettify %}
    {% endcomment -%}

    ```terminal
    $ cd ~/development
    $ tar xf ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.tar.xz
    ```
    
 1. Add the `flutter` tool to your path:

    ```terminal
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    This command sets your `PATH` variable for the
    _current_ terminal window only.
    To permanently add Flutter to your path,
    check out [Update your path][].

 1. Optionally, pre-download development binaries:

    The `flutter` tool downloads platform-specific
    development binaries as needed. For scenarios
    where pre-downloading these artifacts is preferable
    (for example, in hermetic build environments,
    or with intermittent network availability), iOS
    and Android binaries can be downloaded ahead of time by running:

    ```terminal
    $ flutter precache
    ```

    For additional download options,
    check out `flutter help precache`.

You are now ready to run Flutter commands!

{{site.alert.note}}
  To update an existing version of Flutter,
  check out [Upgrading Flutter][].
{{site.alert.end}}


### Run flutter doctor

Run the following command to see if there are any
dependencies you need to install to complete the setup
(for verbose output, add the `-v` flag):

```terminal
$ flutter doctor
```

This command checks your environment and displays
a report to the terminal window.
The Dart SDK is bundled with Flutter;
it isn't necessary to install Dart separately.
Check the output carefully for other software you might
need to install or further tasks to perform (shown in **bold** text).

For example:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/dash/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit {{site.url}}/setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform
these tasks and finish the setup process.

Once you have installed any missing dependencies,
run the `flutter doctor` command again to verify
that you’ve set everything up correctly.

{% include_relative _analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[install Flutter using the Snap Store]: https://snapcraft.io/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK archive]: {{site.url}}/release/archive
[Update your path]: #update-your-path
[Upgrading Flutter]: {{site.url}}/release/upgrade
