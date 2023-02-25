## Get the Flutter SDK {#get-sdk}

 1. Install the core Linux development tools:

    ```terminal
    $ sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev
    ```

    This will download the compiler toolchain that is necessary
    to compile apps for ChromeOS.

 1. Download Flutter from the [Flutter repo][]
    on GitHub with the following command in your home directory:

    ```terminal
    $ git clone https://github.com/flutter/flutter.git -b stable
    ```

 1. Add the `flutter` tool to your path:

    ```terminal
    $ echo PATH="$PATH:`pwd`/flutter/bin" >> ~/.profile
    $ source ~/.profile
    ```

You are now ready to run Flutter commands!

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
    <strong>✗ Unable to locate Android SDK.
    Install Android Studio from:
    https://developer.android.com/studio/index.html</strong>
</pre>

The following sections describe how to perform these tasks and finish the setup
process.

Once you have installed any missing dependencies, run the `flutter doctor`
command again to verify that you’ve set everything up correctly.

{% include_relative _analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
