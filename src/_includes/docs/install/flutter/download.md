### Download then install Flutter
{:.no_toc}

{% assign os = include.os %}
{% assign osl = include.os | downcase %}
{% if os == 'Windows' -%}
   {% assign unzip='Extract-Archive' %}
{% elsif os == "macOS" -%}
   {% assign unzip='unzip' %}
{% else -%}
   {% assign unzip='unzip' %}
{% endif -%}

1. Download the following installation bundle to get the latest
   {{site.sdk.channel}} release of the Flutter SDK.

   [(loading...)](#){:.download-latest-link-{{osl}}.btn.btn-primary}

   For other release channels, and older builds,
   check out the [SDK archive][].

1. Create a folder where you can install Flutter.

   Consider `%USERPROFILE%` or `D:\dev`.

   {% include docs/install/admonitions/install-paths.md %}

1. Move the zip file into the directory you want to store the Flutter SDK.

1. Extract the zip file.

   ```terminal
   {{unzip}} {:.download-latest-link-{{osl}}}
   ```

[SDK archive]: {{site.url}}/release/archive

### Update your Windows PATH variable
{:.no_toc}

{% include docs/help-link.md location='win-path' section='#unable-to-find-the-flutter-command' %}

To run Flutter commands in PowerShell,
add Flutter to the `PATH` environment variable.

1. In the **Start** search bar, type `env`.

1. Select **Edit environment variables for your account**.

1. Under **User variables** check for the **Path** entry.

   * If the entry exists, prepend the full path to `flutter\bin`
     followed with a semicolon (`;`) to separate the new value from
     existing values.

   * If the entry doesn't exist,
     create a new user variable named **Path**.

     Set its value to the full path to `flutter\bin`.

1. For these changes to take effect,
   close and reopen any existing command prompts and PowerShell instances.
