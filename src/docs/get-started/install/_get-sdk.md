{% if os == 'linux' -%}
  {% assign unzip = 'tar xf' -%}
  {% assign file_ext = '.tar.xz' -%}
{% else -%}
  {% assign unzip = 'unzip' -%}
  {% assign file_ext = '.zip' -%}
{% endif -%}

## Get the Flutter SDK {#get-sdk}

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
    
 1. Add the `flutter` tool to your path:

    ```terminal
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    This command sets your `PATH` variable for the
    _current_ terminal window only.
    To permanently add Flutter to your path, see
    [Update your path][].
    
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

### Downloading straight from GitHub instead of using an archive

_This is only suggested for advanced use cases._

You can also use git directly instead of downloading the prepared archive. For example,
to download the stable branch:
    
```terminal
$ git clone https://github.com/flutter/flutter.git -b stable
```

[Update your path][], and run `flutter doctor`. That will let you know if there are
other dependencies you need to install to use Flutter (e.g. the Android SDK).

If you did not use the archive, Flutter will download necessary development binaries as they
are needed (if you used the archive, they are included in the download). You may wish to
pre-download these development binaries (for example, you may wish to do this when setting
up hermetic build environments, or if you only have intermittent network availability). To
do so, run the following command:

```terminal
$ flutter precache
```

For additional download options, see `flutter help precache`.


{% include_relative _analytics.md %}

[Flutter repo]: {{site.github}}/flutter/flutter
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[SDK releases]: /docs/development/tools/sdk/releases
[Snap Store]: https://snapcraft.io/store
[snapd]: https://snapcraft.io/flutter
[Update your path]: #update-your-path
[Upgrading Flutter]: /docs/development/tools/sdk/upgrading
