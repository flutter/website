## Android setup (without Android Studio)

### Install Java

```terminal
$ sudo apt update
$ sudo apt install default-jre
$ sudo apt install default-jdk
```

### Install the Android SDK's

Download the [Android SDK tools][] and
select the “Command Line Tools only” option.

Drag and drop the downloaded zip into your Linux Files folder through the
Chrome OS Files app. This moves it to the home directory, notated as
$TOOLS_PATH going forward (`~/`).

Unzip the tools and then add it to your path.

```terminal
$ unzip ~/sdk-tools-linux*
$ export PATH="$PATH:$TOOLS_PATH/tools/bin"
```

Navigate to where you'd like to keep the SDK packages
($PLATFORM_PATH in these snippets) and download the SDK
packages using the sdkmanager tool (version numbers here are
the latest at time of publishing):

```terminal
$ sdkmanager "build-tools;28.0.3" "emulator" "tools" "platform-tools" "platforms;android-28" "extras;google;google_play_services" "extras;google;webdriver" "system-images;android-28;google_apis_playstore;x86_64"
```

Add the Android platform tools to your path (you should find this where you
ran the sdkmanager command: $PLATFORM_PATH):

```terminal
$ export PATH="$PATH:$PLATFORM_PATH/platform-tools"
```

Set the `ANDROID_SDK_ROOT` variable to where you unzipped sdk-tools before (aka
your $TOOLS_PATH):

```terminal
$ export ANDROID_SDK_ROOT="$TOOLS_PATH"
```

Now, run flutter doctor to accept the android-licenses:

```terminal
$ flutter doctor --android-licenses
```

[Android SDK tools]: {{site.android-dev}}/studio/#downloads
