{% assign terminal=include.terminal %}

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

   {% if os=='macOS' %}

   | Intel | | <span class="apple-silicon">Apple Silicon</span> |
   |-------| | ---------------|
   | [(loading...)](#){:.download-latest-link-{{osl}}.btn.btn-primary} | | [(loading...)](#){:.download-latest-link-{{osl}}-arm64.apple-silicon.btn.btn-primary} |

   {% else %}

   [(loading...)](#){:.download-latest-link-{{osl}}.btn.btn-primary}

   {% endif -%}

   For other release channels, and older builds,
   check out the [SDK archive][].

1. Create a folder where you can install Flutter.

   {% if os == "Windows" -%}
   Consider `%USERPROFILE%` or `D:\dev`.

   {% include docs/install/admonitions/install-paths.md %}
   {% else -%}
   Consider `~/projects/`
   {% endif %}

1. Move the zip file into the directory you want to store the Flutter SDK.

1. Extract the zip file.

   ```terminal
   {{unzip}} flutter_sdk_v1.0.0.zip
   ```

[SDK archive]: {{site.url}}/release/archive

{% if os == 'Windows' %}
{% include docs/install/reqs/windows/set-path.md terminal=terminal %}
{% endif %}
