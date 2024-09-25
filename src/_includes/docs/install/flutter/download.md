
### Download then install Flutter {:.no_toc}

{% assign osl = include.os | downcase | replace: "chromeos","linux" %}
{% case include.os %}
{% when 'Windows' -%}
   {% assign unzip='Expand-Archive .\\' %}
   {% assign path='C:\\user\\{username}\\dev' %}
   {% assign flutter-path='C:\\user\\{username}\\dev\\flutter' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt='PS C:\\>' %}
   {% assign prompt2=path | append: '>' %}
   {% assign diroptions='`%USERPROFILE%` (`C:\\Users\\{username}`) or `%LOCALAPPDATA%` (`C:\\Users\\{username}\\AppData\\Local`)' %}
   {% assign dirinstall='`%USERPROFILE%\\dev\\`' %}
   {% assign dirdl='%USERPROFILE%\\Downloads' %}
   {% assign ps-dir-dl='$env:USERPROFILE\\Downloads\\' %}
   {% assign ps-dir-target='$env:USERPROFILE\\dev\\' %}
   {% capture uz %}
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
   {% assign prompt='\$' %}
   {% assign dirdl='~/Downloads/' %}
   {% capture uz -%}
      {{prompt}} {{unzip}} {{dirdl}}flutter_sdk_v1.0.0.zip \
          -d {{path}}
   {%- endcapture %}
{% else -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='tar' %}
   {% assign path='~/development/' %}
   {% assign flutter-path='~/development/flutter' %}
   {% assign terminal='a shell' %}
   {% assign prompt='\$' %}
   {% assign dirdl='~/Downloads/' %}
   {% capture uz -%}
     {{prompt}} {{unzip}} -xf {{dirdl}}flutter_sdk_v1.0.0.zip -C {{path}}
   {%- endcapture %}
{% endcase -%}

To install Flutter,
download the Flutter SDK bundle from its archive,
move the bundle to where you want it stored,
then extract the SDK.

1. Download the following installation bundle to get the latest
   {{site.sdk.channel}} release of the Flutter SDK.

   {% if include.os=='macOS' %}

   | Intel Processor                                                  | Apple Silicon                                                                         |
   |------------------------------------------------------------------|---------------------------------------------------------------------------------------|
   | [(loading...)](#){:.download-latest-link-{{osl}} .filled-button} | [(loading...)](#){:.download-latest-link-{{osl}}-arm64 .apple-silicon .filled-button} |

   {% else %}

   [(loading...)](#){:.download-latest-link-{{osl}} .filled-button}

   {% endif -%}

   For other release channels, and older builds, check out the [SDK archive][].

   The Flutter SDK should download to the {{include.os}}
   default download directory: `{{dirdl}}`.
   {% if include.os=='Windows' %}
   If you changed the location of the Downloads directory,
   replace this path with that path.
   To find your Downloads directory location,
   check out this [Microsoft Community post][move-dl].
   {% endif %}

1. Create a folder where you can install Flutter.

   Consider creating a directory at {{diroptions}}.
   {% if include.os == "Windows" -%}
   {% render docs/install/admonitions/install-paths.md %}
   {% endif %}

1. Extract the file into the directory you want to store the Flutter SDK.

   ```console
   {{uz}}
   ```

   When finished, the Flutter SDK should be in the `{{flutter-path}}` directory.

[SDK archive]: /release/archive
[move-dl]: https://answers.microsoft.com/en-us/windows/forum/all/move-download-folder-to-other-drive-in-windows-10/67d58118-4ccd-473e-a3da-4e79fdb4c878

{% case include.os %}
{% when 'Windows' %}
{% include docs/install/reqs/windows/set-path.md terminal=terminal target=include.target %}
{% when 'macOS' %}
{% include docs/install/reqs/macos/set-path.md terminal=terminal target=include.target dir=dirinstall %}
{% else %}
{% include docs/install/reqs/linux/set-path.md terminal=terminal target=include.target %}
{% endcase %}
