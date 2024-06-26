{% assign id = include.ref-os | downcase -%}
{% assign jsonurl = 'https://storage.googleapis.com/flutter_infra_release/releases/releases_{{id}}.json' %}
{% assign os = include.ref-os -%}
{% assign sdk = include.sdk -%}

{% if id == 'windows' -%}
   {% assign shell = 'Powershell' -%}
   {% assign prompt = 'C:\>' -%}
   {% assign comtoset = '$env:' -%}
   {% assign installdirsuggestion = '`%USERPROFILE%\dev`' %}
   {% capture envvarset -%}{{prompt}} {{comtoset}}{% endcapture -%}
   {% capture setpath -%}{{envvarset}}PATH = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"{% endcapture -%}
   {% capture newdir -%}{{prompt}} New-Item -Path '{{installdirsuggestion}}' -ItemType Directory{% endcapture -%}
   {% capture unzip -%} {{prompt}} Extract-Archive:{% endcapture -%}
   {% capture permaddexample -%}
$newPath = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"
[System.Environment]::SetEnvironmentVariable('Path',$newPath,User)
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL','https://pub.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL','https://storage.flutter-io.cn',User)
   {% endcapture -%}
{% else -%}
   {% assign shell = 'your terminal' -%}
   {% assign prompt = '$' -%}
   {% assign comtoset = 'export ' -%}
   {% assign installdirsuggestion = '`~/dev`' %}
   {% capture envvarset -%}{{prompt}} {{comtoset}}{% endcapture -%}
   {% capture setpath -%}{{envvarset}}PATH="$PWD/flutter/bin:$PATH"{% endcapture -%}
   {% capture newdir -%}{{prompt}} mkdir ~/dev{% endcapture -%}
   {% if id == 'macos' %}
      {% capture unzip -%} {{prompt}} unzip{% endcapture -%}
   {% else %}
      {% capture unzip -%} {{prompt}} tar -xf{% endcapture -%}
   {% endif %}
   {% capture permaddexample -%}
cat <<EOT >> ~/.zprofile
{{envvarset}}PUB_HOSTED_URL="https://pub.flutter-io.cn"
{{envvarset}}FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
{{setpath}}
EOT
   {% endcapture -%}
{% endif -%}
{%- case id %}
   {% when 'windows','macos' %}
      {%- assign file-format = 'zip' %}
      {%- assign download-os = id %}
   {% when 'linux','chromeos' %}
      {%- assign download-os = 'linux' %}
      {%- assign file-format = 'tar.xz' %}
{% endcase %}

This procedure requires using {{shell}}.

1. Open a new window in {{shell}} to prepare running scripts.

1. Set `PUB_HOSTED_URL` to your mirror site.

   ```console
   {{envvarset}}PUB_HOSTED_URL="https://pub.flutter-io.cn"
   ```

1. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.

   ```console
   {{envvarset}}FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
   ```

1. Download the Flutter archive from your mirror site.
   In your preferred browser, go to
   [Flutter SDK archive](https://docs.flutter.cn/release/archive?tab={{id}}).

1. Create a folder where you can install Flutter. then change into it.

   Consider a path like {{installdirsuggestion}}.

   ```console
   {{newdir}}; cd {{installdirsuggestion}}
   ```

1. Extract the SDK from the {{file-format}} archive file.

   This example assumes you downloaded the {{os}} version of the Flutter SDK.

   ```console
   {{unzip}} {{sdk | replace: "opsys", download-os}}{{file-format}}
   ```

1. Add Flutter to your `PATH` environment variable.

   ```console
   {{setpath}}
   ```

1. Run Flutter Doctor to verify your installation.

   ```console
   {{prompt}} flutter doctor
   ```

1. Return to the [setting up Flutter](/get-started/editor)
   guide and continue from that procedure.

From this example, `flutter pub get` fetches packages from `flutter-io.cn`,
in any terminal where you set `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`.

Any environment variables set using `{{comtoset}}` in this procedure
only apply to the current window.

To set these values on a permanent basis,
{% if id == 'windows' -%}
set the environment variables as in the following example:
{% else -%}
append those three `export` commands to the `*rc` or `*profile`
file that your preferred shell uses. This would resemble the following:
{% endif -%}

```console
{{permaddexample}} 
```
