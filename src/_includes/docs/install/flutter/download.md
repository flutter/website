{% assign terminal=include.terminal %}

### Download then install Flutter
{:.no_toc}

{% assign os = include.os %}
{% assign osl = include.os | downcase %}
{% assign target = include.target %}
{% case os %}
{% when 'Windows' -%}
   {% assign unzip='Expand-Archive .\' %}
   {% assign path='C:\user\{username}\dev' %}
   {% assign flutter-path='C:\user\{username}\dev\flutter' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt='C:>' %}
   {% assign prompt2=path | append: '>' %}
   {% assign diroptions='`%USERPROFILE%` (`C:\Users\{username}`) or `%LOCALAPPDATA%` (`C:\Users\{username}\AppData\Local`)' %}
   {% assign dirinstall='`%USERPROFILE%\dev\`' %}
   {% assign dirdl='%USERPROFILE%\Downloads' %}
   {% assign ps-dir-dl='$env:USERPROFILE\Downloads\' %}
   {% assign ps-dir-target='$env:USERPROFILE\dev\' %}
   {% capture mv -%}
   {{prompt}} Move-Item `
       –Path {{ps-dir-dl}}flutter_sdk_v1.0.0.zip `
       -Destination {{ps-dir-target}}
   {%- endcapture %}
   {% capture uz -%}
   {{prompt}} Expand-Archive `
       –Path {{ps-dir-dl}}flutter_sdk_v1.0.0.zip `
       -Destination {{ps-dir-target}}
   {%- endcapture %}
{% when "macOS" -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='unzip' %}
   {% assign path='~/development/' %}
   {% assign flutter-path='~/development/flutter' %}
   {% assign terminal='the Terminal' %}
   {% assign prompt='$' %}
   {% assign dirdl='~/Downloads/' %}
   {% assign mv1 = 'mv ' | append: dirdl %}
   {% capture mv -%}
   {{prompt}} mv {{dirdl}}flutter_sdk_v1.0.0.zip {{path}}
   {%- endcapture %}
   {% capture uz -%}
   {{prompt}} {{unzip}} {{path}}flutter_sdk_v1.0.0.zip -d {{path}}
   {%- endcapture %}
{% else -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='unzip' %}
   {% assign path='/usr/bin/' %}
   {% assign flutter-path='~/development/flutter' %}
   {% assign terminal='a shell' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
   {% assign dirdl='~/Downloads/' %}
   {% capture mv %}
   {{prompt2}} mv {{dirdl}}flutter_sdk_v1.0.0.zip {{path}}
   {% endcapture %}
   {% capture uz -%}
   {{prompt}} {{unzip}} {{path}}flutter_sdk_v1.0.0.zip {{path}}
   {%- endcapture %}
{% endcase -%}

To install Flutter,
download the Flutter SDK bundle from its archive,
move the bundle to where you want it stored,
then extract the SDK.

1. Download the following installation bundle to get the latest
   {{site.sdk.channel}} release of the Flutter SDK.

   {% if os=='macOS' %}

   | Intel Processor | | Apple Silicon |
   |-----------------|-|---------------|
   | [(loading...)](#){:.download-latest-link-{{osl}}.btn.btn-primary} | | [(loading...)](#){:.download-latest-link-{{osl}}-arm64.apple-silicon.btn.btn-primary} |

   {% else %}

   [(loading...)](#){:.download-latest-link-{{osl}}.btn.btn-primary}

   {% endif -%}

   For other release channels, and older builds, check out the [SDK archive][].

   The Flutter SDK should download to the {{os}} default download directory:
   `{{dirdl}}`.
   {% if os=='Windows' %}
   If you changed the location of the Downloads directory,
   replace this path with that path.
   To find your Downloads directory location,
   check out this [Microsoft Community post][move-dl].
   {% endif %}

1. Create a folder where you can install Flutter.

   Consider creating a directory at {{diroptions}}.
   {% if os == "Windows" -%}
   {% include docs/install/admonitions/install-paths.md %}
   {% endif %}

1. Extract the zip file into the directory you want to store the Flutter SDK.

   ```terminal
   {{uz}}
   ```

   When finished, the Flutter SDK should be in the `{{flutter-path}}` directory.

[SDK archive]: {{site.url}}/release/archive

{% case os %}
{% when 'Windows' %}
{% include docs/install/reqs/windows/set-path.md terminal=terminal target=target %}
{% when 'macOS' %}
{% include docs/install/reqs/macos/set-path.md terminal=terminal target=target dir=dirinstall %}
{% endcase %}

[move-dl]: https://answers.microsoft.com/en-us/windows/forum/all/move-download-folder-to-other-drive-in-windows-10/67d58118-4ccd-473e-a3da-4e79fdb4c878
