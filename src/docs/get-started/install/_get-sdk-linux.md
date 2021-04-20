{% if os == 'linux' -%}
  {% assign unzip = 'tar xf' -%}
  {% assign file_ext = '.tar.xz' -%}
{% else -%}
  {% assign unzip = 'unzip' -%}
  {% assign file_ext = '.zip' -%}
{% endif -%}

## Get the Flutter SDK {#get-sdk}

On Linux, you have two ways you can install Flutter.

### Install Flutter using snapd

The easiest way to install Flutter on Linux is by
using snapd. For more information,
see [Installing snapd][].

Once you have snapd, you can
[install Flutter using the Snap Store][],
or at the command line:

```sh
$ sudo snap install flutter --classic
```

{{site.alert.note}}
  Once the snap is installed, you can use the following command to display your Flutter SDK path:

  ```sh
  $ flutter sdk-path
  ```
{{site.alert.end}}

### Install Flutter manually

If you don't have `snapd`, or can't use it, you can
install Flutter using the following steps.

 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    For other release channels, and older builds,
    see the [SDK releases][] page.

 1. Extract the file in the desired location, for example:

    {% comment %}
      Our JS also updates the filename in this template, but it doesn't include the terminal formatting:

      {% prettify shell %}
      $ cd ~/development
      $ {{unzip}} ~/Downloads/[[download-latest-link-filename]]flutter_{{os}}_vX.X.X-{{site.sdk.channel}}{{file_ext}}[[/end]]
      {% endprettify %}
    {% endcomment -%}

    ```terminal
    $ cd ~/development
    $ {{unzip}} ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}{{file_ext}}
    ```
    
    If you don't want to install a fixed version of the installation bundle, 
    you can skip steps 1 and 2. 
    Instead, get the source code from the [Flutter repo][]
    on GitHub with the following command:
    
    ```terminal
    $ git clone https://github.com/flutter/flutter.git
    ```
    
    You can also change branches or tags as needed.
    For example, to get just the stable version:
    
    ```terminal
    $ git clone https://github.com/flutter/flutter.git -b stable
    ```
    
 1. Add the `flutter` tool to your path:

    ```terminal
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    This command sets your `PATH` variable for the
    _current_ terminal window only.
    To permanently add Flutter to your path, see
    [Update your path][].

 1. Optionally, pre-download development binaries:

    The `flutter` tool downloads platform-specific development binaries as
    needed. For scenarios where pre-downloading these artifacts is preferable
    (for example, in hermetic build environments,
    or with intermittent network availability), iOS
    and Android binaries can be downloaded ahead of time by running:

    ```terminal
    $ flutter precache
    ```

    For additional download options, see `flutter help precache`.

You are now ready to run Flutter commands!

{{site.alert.note}}
  To update an existing version of Flutter, see
  [Upgrading Flutter][].
{{site.alert.end}}


### Run flutter doctor

Run the following command to see if there are any dependencies you need to
install to complete the setup (for verbose output, add the `-v` flag):

```terminal
$ flutter doctor
```

This command checks your environment and displays a report to the terminal
window. The Dart SDK is bundled with Flutter; it is not necessary to install
Dart separately. Check the output carefully for other software you might
need to install or further tasks to perform (shown in **bold** text).

For example:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit {{site.url}}/setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks and finish the setup
process.

Once you have installed any missing dependencies, run the `flutter doctor`
command again to verify that you’ve set everything up correctly.

{% include_relative _analytics.md %}

[Flutter repo]: {{site.github}}/flutter/flutter
[install Flutter using the Snap Store]: https://snapcraft.io/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK releases]: /docs/development/tools/sdk/releases
[Update your path]: #update-your-path
[Upgrading Flutter]: /docs/development/tools/sdk/upgrading
