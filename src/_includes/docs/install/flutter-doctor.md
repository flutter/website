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

### Run Flutter Doctor

The `flutter doctor` command validates that all components of a
complete Flutter development environment for {{include.os}}.

1. Open {{terminal}}.

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
