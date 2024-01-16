{% assign terminal=include.terminal %}

### Download then install Flutter
{:.no_toc}

{% assign os = include.os %}
{% assign osl = include.os | downcase %}
{% case os %}
{% when 'Windows' -%}
   {% assign unzip='Extract-Archive' %}
   {% assign path='C:\dev\' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt1='D:>' %}
   {% assign prompt2=path | append: '>' %}
   {% assign diroptions='`%USERPROFILE%` or `C:\dev`' %}
   {% assign dirinstall='`C:\dev\`' %}
   {% assign dirdl='%CSIDL_DEFAULT_DOWNLOADS%\' %}
   {% assign mv1 = 'Move-Item –Path ' | append: dirdl %}
   {% assign mv2 = '-Destination ' %}
{% when "macOS" -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='unzip' %}
   {% assign path='~/development/' %}
   {% assign terminal='the Terminal' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
   {% assign dirdl='~/Downloads/' %}
   {% assign mv1 = 'mv ' | append: dirdl %}
{% else -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='unzip' %}
   {% assign path='/usr/bin/' %}
   {% assign terminal='a shell' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
   {% assign dirdl='~/Downloads/' %}
   {% assign mv1 = 'mv ' | append: dirdl %}
{% endcase -%}

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

   This guide presumes that you downloaded your Flutter SDK to the
   default download directory for {{os}}: `{{dirdl}}`.

1. Create a folder where you can install Flutter.

   Consider {{diroptions}}.
   {% if os == "Windows" -%}
   {% include docs/install/admonitions/install-paths.md %}
   {% endif %}

1. Move the zip file into the directory you want to store the Flutter SDK.

   ```terminal
   {{prompt2}} {{mv1}}flutter_sdk_v1.0.0.zip {{mv2}}{{path}}
   ```

1. Extract the zip file.

   ```terminal
   {{prompt2}} {{unzip}} flutter_sdk_v1.0.0.zip
   ```

   When finished, the Flutter SDK should be in the {{dirinstall}}`flutter`
   directory.

[SDK archive]: {{site.url}}/release/archive

{% if os == 'Windows' %}
{% include docs/install/reqs/windows/set-path.md terminal=terminal %}
{% endif %}
