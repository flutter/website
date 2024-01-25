## Check your development setup

{% include docs/help-link.md location='win-doctor' %}

{% assign os = include.os %}
{% assign target = include.target %}
{% assign compiler = include.compiler %}

{% case target %}
{% when 'mobile-ios' %}
   {% assign v-target = 'iOS' %}
{% when 'mobile-android' %}
   {% assign v-target = 'Android' %}
{% else %}
   {% assign v-target = target %}
{% endcase %}

{% case os %}
{% when 'Windows' -%}
   {% assign terminal='PowerShell' %}
   {% assign prompt='C:\>' %}
{% when "macOS" -%}
   {% assign terminal='your Terminal' %}
   {% assign prompt='$' %}
{% else -%}
   {% assign terminal='a shell' %}
   {% assign prompt='$' %}
{% endcase -%}

### Run Flutter doctor

The `flutter doctor` command validates that all components of a
complete Flutter development environment for {{os}}.

1. Open {{terminal}}.

1. To verify your installation of all the components,
   run the following command.

   ```terminal
   {{prompt}} flutter doctor
   ```

As you chose to develop for {{v-target}},
you do not need _all_ components.
If you followed this guide, the result of your command should resemble:

```terminal
{% include docs/install/flutter-doctor-success.md %}
```

### Troubleshoot Flutter doctor issues

When the `flutter doctor` command returns an error, it could be for Flutter,
VS Code, {{compiler}}, the connected device, or network resources.

If the `flutter doctor` command returns an error for any of these components,
run it again with the verbose flag.

```terminal
{{prompt}} flutter doctor -v
```

Check the output for other software you might need to install
or further tasks to perform.

If you change the configuration of your Flutter SDK or its related components,
run `flutter doctor` again to verify the install.
