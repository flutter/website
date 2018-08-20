## Get the Flutter SDK {#get-sdk}

1. Download the following installation bundle to get the latest beta release of the
Flutter SDK (for other release channels, and older builds, see the [SDK
archive](/sdk-archive/) page.):
{% if page.url contains "linux" %}
    * [(loading...)](#){:.download-latest-link-linux}
{% else %}
    * [(loading...)](#){:.download-latest-link-macos}
{% endif %}<br><br>
1. Extract the file in the desired location, e.g.:
    {% commandline %}
    cd ~/development
{% if page.url contains "linux" %}
    tar xf ~/Downloads/<span class="download-latest-link-filename-linux">flutter_linux_xxx.tar.xz</span>
{% else %}
    unzip ~/Downloads/<span class="download-latest-link-filename-macos">flutter_macos_xxx.zip</span>
{% endif %}
    {% endcommandline %}

1. Add the `flutter` tool to your path:
    {% commandline %}
    export PATH=`pwd`/flutter/bin:$PATH
    {% endcommandline %}

The above command sets your PATH variable temporarily, for the current terminal window. To
permanently add Flutter to your path, see [Update your path](#update-your-path).

You are now ready to run Flutter commands!

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
<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

The following sections describe how to perform these tasks and finish the setup process.

Once you have installed any missing dependencies, run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

The `flutter` tool uses Google Analytics to anonymously report feature usage statistics
and basic crash reports. This data is used to help improve Flutter tools over time.
Analytics is not sent on the very first run or for any runs involving `flutter config`,
so you can opt out of analytics before any data is sent. To disable reporting, 
type `flutter config --no-analytics` and to display the current setting, type 
`flutter config`. See Google's privacy policy:[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}
