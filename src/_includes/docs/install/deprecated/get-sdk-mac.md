## Get the Flutter SDK {:#get-sdk}

{% render docs/china-notice.md %}

 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    |Intel | | <span class="apple-silicon">Apple Silicon</span> |
    |------| | ---------------|
    |[(loading...)](#){:.download-latest-link-{{os}} .filled-button} | | [(loading...)](#){:.download-latest-link-{{os}}-arm64 .apple-silicon .filled-button} |

    <br>
    For other release channels, and older builds,
    check out the [SDK archive][].

    <div class="apple-silicon">
    
    :::tip
    To determine whether your Mac uses an Apple silicon processor,
    refer to [Mac computers with Apple silicon][]{:target="_blank"}
    on apple.com.
    :::

    </div>

 1. Extract the file in the desired location. For example:

    {% comment %}
      Our JS also updates the filename in this template,
      but it doesn't include the terminal formatting:

      ```console
      $ cd ~/development
      $ unzip ~/Downloads/[[download-latest-link-filename]]flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.zip[[/end]]
      ```
    {% endcomment
   -%}

    ```console
    $ cd ~/development
    $ unzip ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}.zip
    ```
    
 1. Add the `flutter` tool to your path:

    ```console
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    This command sets your `PATH` variable for the
    _current_ terminal window only.
    To permanently add Flutter to your path,
    check out [Update your path][].
    
You are now ready to run Flutter commands!

:::note
To update an existing version of Flutter,
check out [Upgrading Flutter][].
:::

### Run flutter doctor

Run the following command to see if there are any
dependencies you need to install to complete the setup
(for verbose output, add the `-v` flag):

```console
$ flutter doctor
```

This command checks your environment and displays
a report to the terminal window.
The Dart SDK is bundled with Flutter;
it isn't necessary to install Dart separately.
Check the output carefully for other software you might
need to install or further tasks to perform
(shown in **bold** text).

For example:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/dash/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit /setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks
and finish the setup process.

Once you have installed any missing dependencies,
run the `flutter doctor` command again
to verify that you've set everything up correctly.

### Downloading straight from GitHub instead of using an archive

_This is only suggested for advanced use cases._

You can also use git directly instead of downloading
the prepared archive. For example,
to download the stable branch:
    
```console
$ git clone https://github.com/flutter/flutter.git -b stable
```

[Update your path][], and run `flutter doctor`.
This lets you know if there are other dependencies
you need to install to use Flutter (such as the Android SDK).

If you didn't use the archive,
Flutter downloads necessary development binaries as they
are needed (if you used the archive,
they are included in the download). You might want to
pre-download these development binaries
(for example, you might do this when setting
up hermetic build environments,
or if you only have intermittent network availability).
To do so, run the following command:

```console
$ flutter precache
```

For additional download options, check out `flutter help precache`.

{% include docs/install/deprecated/analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[SDK archive]: /release/archive
[Snap Store]: https://snapcraft.io/store
[snapd]: https://snapcraft.io/flutter
[Update your path]: #update-your-path
[Upgrading Flutter]: /release/upgrade
[Mac computers with Apple silicon]: https://support.apple.com/en-us/HT211814
