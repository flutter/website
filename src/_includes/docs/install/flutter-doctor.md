## Check your Flutter development install

{% include docs/help-link.md location='win-doctor' %}

### Run Flutter Doctor

1. Navigate to your Flutter installation directory.

   You set this in your `PATH` environment variable.

1. Run the following command to verify your installation.

   {% if include.os == 'Windows' -%}

   ```posh
   C:\src\flutter> flutter doctor
   ```

   {% elsif include.os == "macOS" -%}

   ```terminal
   $ flutter doctor
   ```

  {% else -%}

   ```terminal
   $ flutter doctor
   ```

   {% endif -%}

### Troubleshooting Flutter Doctor raises

The `flutter doctor` command reports on the status of
your Flutter development environment.
Check the output for other software you might need to install
or further tasks to perform.

```terminal
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
    visit {{site.url}}/setup/#android-setup for detailed instructions.
```

If you change the configuration of your Flutter SDK or its related components,
run `flutter doctor` again to verify the install again.
