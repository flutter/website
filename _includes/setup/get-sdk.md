## Get the Flutter SDK

To get Flutter, use `git` to clone the repository and then add the `flutter` tool to your path.
Running `flutter doctor` shows any remaining dependencies you may need to install.

### Clone the repo

If this is the first time you're installing Flutter on this machine, clone the
`beta` branch of the repository and then add the `flutter` tool to your path:

{% commandline %}
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH
{% endcommandline %}

The above command sets your PATH variable temporarily, for the current terminal window. To
permanently add Flutter to your path, see [Update your path](#update-your-path).

To update an existing version of Flutter, see [Upgrading Flutter](/upgrading/).


### Run flutter doctor

Run the following command to see if there are any dependencies you need to install to complete
the setup:

{% commandline %}
flutter doctor
{% endcommandline %}

This command checks your environment and displays a report to the terminal window.
The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately.
Check the output carefully for other software you may need to install or further 
tasks to perform (shown in **bold** text).

For example:
```
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
```

The first time you run a flutter command (such as `flutter doctor`), it downloads its own dependencies and compiles
itself. Subsequent runs should be much faster.

The following sections describe how to perform these tasks and finish the setup process.
You'll see in `flutter doctor` output that if you choose to use an IDE, plugins
are available for IntelliJ IDEA, Android Studio, and VS Code. See [Editor Setup](/get-started/editor/)
for the steps to install the Flutter and Dart plugins.

Once you have installed any missing dependencies, run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

The `flutter` tool uses Google Analytics to anonymously report feature usage statistics
and basic crash reports. This data is used to help improve Flutter tools over time.
Analytics is not sent on the very first run or for any runs involving `flutter config`,
so you can opt out of analytics before any data is sent. To disable reporting, 
type `flutter config --no-analytics` and to display the current setting, type 
`flutter config`. See Google's privacy policy:[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}
