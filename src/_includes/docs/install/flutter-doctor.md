## Check your development setup

{% include docs/help-link.md location='win-doctor' %}

{% assign os = include.os %}
{% assign target = include.target %}
{% if os == 'Windows' -%}
   {% assign path='C:\src\flutter' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt1='C:>' %}
   {% assign prompt2=path | append: '>' %}
{% elsif os == "macOS" -%}
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
{% if target == 'web' %}
   {% assign limiter = '--no-enable-linux-desktop --no-enable-macos-desktop --no-enable-windows-desktop --no-enable-android --no-enable-ios' %}
   {% capture limitresponse -%}
      Setting "enable-linux-desktop" value to "false".
      Setting "enable-macos-desktop" value to "false".
      Setting "enable-windows-desktop" value to "false".
      Setting "enable-android" value to "false".
      Setting "enable-ios" value to "false".
   {% endcapture %}
{% elsif target == 'mobile' %}
   {% assign limiter = '--no-enable-web --no-enable-linux-desktop --no-enable-macos-desktop --no-enable-windows-desktop' %}
   {% capture limitresponse -%}
      Setting "enable-web" value to "false".
      Setting "enable-linux-desktop" value to "false".
      Setting "enable-macos-desktop" value to "false".
      Setting "enable-windows-desktop" value to "false".
   {% endcapture %}
{% elsif target == 'desktop' %}
   {% assign limiter = '--no-enable-web --no-enable-android --no-enable-ios' %}
   {% capture limitresponse -%}
      Setting "enable-web" value to "false".
      Setting "enable-android" value to "false".
      Setting "enable-ios" value to "false".
   {% endcapture %}
{% endif %}

### Run Flutter Doctor

The `flutter doctor` command validates that all components of a
complete Flutter development environment for {{include.os}}.

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
   {{prompt2}} flutter doctor
   ```

As you chose to develop for {{include.target}},
you do not need _all_ components.
If you followed this guide, result of your command should resemble:

```terminal
{% include docs/install/flutter-doctor-success.md %}
```

### Troubleshoot Flutter Doctor issues

If the `flutter doctor` command returns an error,
run it again with the verbose flag.

```terminal
{{prompt2}} flutter doctor -v
```

Check the output for other software you might need to install
or further tasks to perform.

If you change the configuration of your Flutter SDK or its related components,
run `flutter doctor` again to verify the install again.
