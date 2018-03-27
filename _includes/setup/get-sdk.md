## Get the Flutter SDK {#get-sdk}

1. Download the following installation bundle to get the latest beta release of the
Flutter SDK (for other release channels, and older builds, see the [SDK
archive](/sdk-archive/) page.):
    * [flutter_macos_v0.1.5-beta.zip](https://storage.googleapis.com/flutter_infra/releases/beta/macos/flutter_macos_v0.1.5-beta.zip)
<br><br>
1. Extract the file in the desired location, e.g.:
    {% commandline %}
    cd ~/development
    unzip ~/Downloads/flutter_macos_v0.1.5-beta.zip
    {% endcommandline %}

1. Add the `flutter` tool to your path:
    {% commandline %}
    export PATH=`pwd`/flutter/bin:$PATH
    {% endcommandline %}

The above command sets your PATH variable temporarily, for the current terminal window. To
permanently add Flutter to your path, see [Update your path](#update-your-path).

You are now ready to run Flutter commands!

To update an existing version of Flutter, see [Upgrading Flutter](/upgrading/).
