## Get the Flutter SDK

{% comment %} 
sz: For now, don't use these instructions. As Tim S reported:
7-Zip doesn't unpack hidden directories by default,
which leaves the Flutter install in a broken state.
Eventually, we'll have an Installer for windows,
but for now use "git clone".
 1. Download the following installation bundle to get the latest
    {{site.sdk.channel}} release of the Flutter SDK:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    For other release channels, and older builds, see the [SDK
    archive](/docs/development/tools/sdk/archive) page.
 1. Extract the zip file and place the contained `flutter` in the desired
    installation location for the Flutter SDK
    (for example, `C:\src\flutter`; do not
    install Flutter in a directory like `C:\Program Files\` that requires
    elevated privileges).
{% endcomment %}

<ol markdown="1">
<li markdown="1">At the command line,
    go to the desired installation location
    for the Flutter SDK (for example, `C:\src\flutter`; 
    do not install Flutter in a directory like `C:\Program Files\`
    that requires elevated privileges).
</li>
<li markdown="1">Clone the repo using `git clone`.
    The following example clones the stable channel.
    (To see Flutter's other release channels,
    see [upgrading Flutter][].)

```sh
git clone -b stable https://github.com/flutter/flutter.git
```
</li>
<li markdown="1">In Windows Explorer, navigate to the `flutter`
    directory and locate the `flutter_console.bat` file.
    Double-click the file to start it.
</li>
</ol>

You are now ready to run Flutter commands in the Flutter Console!

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

Note that you have to close and reopen any existing console windows
for these changes to take effect.

### Run `flutter doctor`

From a console window that has the Flutter directory in the path (see above),
run the following command to see if there are any platform dependencies you
need to complete the setup:

```console
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

{% include_relative _analytics.md %}


[upgrading Flutter]: /docs/development/tools/sdk/upgrading
