### Use VS Code to install Flutter
{:.no_toc}

#### Start Flutter install
{:.no_toc}

1. Login to GitHub.

1. To open the Command Palette,
   press <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

1. In the Command Palette, type `flutter`.

1. Select **Flutter: New Project**.

1. VS Code prompts you to locate the Flutter SDK on your computer.

   1. If you have the Flutter SDK installed, click **Locate SDK**.

   1. If you do not have the Flutter SDK installed, click **Download SDK**.

      This option sends you the Flutter install page if you have not installed
      Git for Windows as directed in the [development tools prerequisites][].

#### Download the Flutter SDK
{:.no_toc}

1. Choose which folder to install Flutter
   using the **Select Folder for Flutter SDK** dialog.

   VS Code places you in your user profile to start.
   Choose a different location.

1. Click **Clone Flutter**.

   While downloading Flutter, a notification displays:

   ```terminal
   Downloading the Flutter SDK. This may take a few minutes.
   ```

1. Once it finishes downloading Flutter, the **Output** panel displays.

   ```terminal
   Checking Dart SDK version...
   Downloading Dart SDK from the Flutter engine ...
   Expanding downloaded archive...
   ```

   When successful, a notification displays:

   ```terminal
   Initializing the Flutter SDK. This may take a few minutes.
   ```

   While initializing, the **Output** panel displays the following:

   ```terminal
   Building flutter tool...
   Running pub upgrade...
   Resolving dependencies...
   Got dependencies.
   Downloading Material fonts...
   Downloading Gradle Wrapper...
   Downloading package sky_engine...
   Downloading flutter_patched_sdk tools...
   Downloading flutter_patched_sdk_product tools...
   Downloading windows-x64 tools...
   Downloading windows-x64/font-subset tools...
   ```

   This process also runs `flutter doctor -v`. _Ignore this output._

   When the Flutter install succeeds, a notification displays:

   ```terminal
   Do you want to add the Flutter SDK to PATH so it's accessible
   in external terminals?
   ```

1. Click **Add SDK to PATH**.

   When successful, a notification displays:

   ```terminal
   The Flutter SDK was added to your PATH
   ```

1. The notification displays the Google Analytics notice.

   If you agree, click **OK**.

### Troubleshoot Flutter VS Code install
{:.no_toc}

If you receive the following error, you need to login to your GitHub account,
then try again.

```terminal
Failed to clone Flutter: Cloning into 'flutter' ... fatal: unable
to access 'https://github.com/flutter/flutter.git/': Could not resolve
host: github.com.
```

[development tools prerequisites]: #development-tools
