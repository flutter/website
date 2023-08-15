## Check your development setup

{% include docs/help-link.md location='win-doctor' %}

{% if include.os == 'Windows' -%}
   {% assign path='C:\src\flutter' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt1='C:>' %}
   {% assign prompt2=path | append: '>' %}
{% elsif include.os == "macOS" -%}
   {% assign path='~/Applications/flutter' %}
   {% assign terminal='the Terminal' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
{% else -%}
   {% assign path='/usr/bin/flutter' %}
   {% assign terminal='a shell' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
{% endif -%}

### Run Flutter Doctor

1. Open {{terminal}}.

1. Navigate to your Flutter installation directory.

   You set this in your `PATH` environment variable.

   This example installed Flutter in `{{path}}`.

   ```terminal
   {{prompt1}} cd {{path}}
   {{prompt2}}
   ```

   The Flutter directory `{{path}}` is now your working directory.

1. To verify your installation of all the components,
   run the following command.

   ```terminal
   {{prompt2}} flutter doctor -v
   ```

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

{% elsif include.platform == 'mobile' %}

Visual Studio
VS Code

{% else include.platform == 'web' %}



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
