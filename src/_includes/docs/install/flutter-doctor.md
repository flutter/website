## Check your development setup

{% include docs/help-link.md location='win-doctor' %}

### Run Flutter Doctor

{% if include.os == 'Windows' -%}

1. Open PowerShell.

{% elsif include.os == "macOS" -%}

1. Open the Terminal.

{% else -%}

1. Open a shell.

{% endif -%}

1. Navigate to your Flutter installation directory.

   You set this in your `PATH` environment variable.

   {% if include.os == 'Windows' -%}

   This example installed Flutter in `c:\src\flutter`.

   ```batchfile
   C:\> cd C:\src\flutter
   C:\src\flutter>
   ```

   {% elsif include.os == "macOS" -%}

   This example installed Flutter in `~/Applications/flutter`.

   ```terminal
   $ cd ~/Applications/flutter
   ```

   {% else -%}

   This example installed Flutter in `/usr/bin/flutter`.

   ```terminal
   $ cd /usr/bin/flutter
   ```

   {% endif -%}

   The Flutter directory is now your working directory.

1. To verify your installation of all the components,
   run the following command.

   {% if include.os == 'Windows' -%}

   ```batchfile
   C:\src\flutter> flutter doctor -v
   ```

   {% elsif include.os == "macOS" -%}

   ```terminal
   $ flutter doctor -v
   ```

   {% else -%}

   ```terminal
   $ flutter doctor -v
   ```

   {% endif -%}

   The `flutter doctor` command validates that all components of a
   complete Flutter development environment for {{include.os}}.

   As you chose to develop for {{include.target}},
   you do not need _all_ components.
   You can ignore the following warnings:

### Troubleshoot Flutter Doctor issues

The `flutter doctor` command reports on the status of
your Flutter development environment.
Check the output for other software you might need to install
or further tasks to perform.

The `flutter doctor` should report success for the following components:

{% if include.platform == 'desktop' %}

Android toolchain
VS Code

{% elsif include.platform == 'desktop' %}

Visual Studio
VS Code

{% else include.platform == 'desktop' %}


{% endif %}

```terminal
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
    visit {{site.url}}/setup/#android-setup for detailed instructions.
```

If you change the configuration of your Flutter SDK or its related components,
run `flutter doctor` again to verify the install again.
