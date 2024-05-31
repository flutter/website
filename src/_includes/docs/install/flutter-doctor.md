
## Check your development setup

{% render docs/help-link.md, location:'win-doctor' %}

{% assign compiler = include.compiler %}

{% case include.devos %}
{% when 'Windows' -%}
   {% assign terminal='PowerShell' %}
   {% assign prompt='PS C:\>' %}
{% when "macOS" -%}
   {% assign terminal='your Terminal' %}
   {% assign prompt='$' %}
{% else -%}
   {% assign terminal='a shell' %}
   {% assign prompt='$' %}
{% endcase -%}
{% case include.target %}
{% when 'macOS','Windows','Linux' %}
{% assign work-target = include.target | append: ' desktop' %}
{% when 'desktop' %}
{% assign work-target = include.devos | append: ' desktop' %}
{% else %}
{% assign work-target = include.target | append: ' on ' | append: include.devos %}
{% endcase %}
{% case work-target %}
{% when 'macOS desktop','Web on macOS','iOS on macOS' %}
{% assign compiler = 'Xcode' %}
{% when 'Android on Windows','Android on macOS','Android on Linux' %}
{% assign compiler = 'Android Studio' %}
{% when 'Linux desktop','Web on Linux' %}
{% assign compiler = 'one of the Linux libraries' %}
{% when 'Windows desktop','Web on Windows' %}
{% assign compiler = 'Visual Studio' %}
{% endcase %}

### Run Flutter doctor

The `flutter doctor` command validates that all components of a
complete Flutter development environment for {{include.devos}}.

1. Open {{terminal}}.

1. To verify your installation of all the components,
   run the following command.

   ```console
   {{prompt}} flutter doctor
   ```

As you chose to develop for {{include.target}},
you do not need _all_ components.
If you followed this guide, the result of your command should resemble:

{% include docs/install/flutter-doctor-success.md config=include.config devos=include.devos -%}

### Troubleshoot Flutter doctor issues

When the `flutter doctor` command returns an error, it could be for Flutter,
VS Code, {{compiler}}, the connected device, or network resources.

If the `flutter doctor` command returns an error for any of these components,
run it again with the verbose flag.

```console
{{prompt}} flutter doctor -v
```

Check the output for other software you might need to install
or further tasks to perform.

If you change the configuration of your Flutter SDK or its related components,
run `flutter doctor` _again_ to verify the installation.

## Start developing {{work-target}} apps with Flutter

Congratulations!
Now that you have installed all prerequisites and the Flutter SDK,
you should be able to start developing Flutter apps for
{{work-target}}.
