{% assign id =  include.os | downcase -%}

{% if id == 'windows' -%}
{% assign shell = 'Powershell' -%}
{% assign prompt = 'C:\>' -%}
{% assign envvarset = 'C:\> $env:' -%}
{% assign setpath = 'C:\> $env:PATH = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"' -%}
{% assign comtoset = '$env:' -%}
{% assign unzip='Extract-Archive' %}
{% capture permaddexample -%}
$newPath = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"
[System.Environment]::SetEnvironmentVariable('Path',$newPath,User)
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL','https://pub.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL','https://storage.flutter-io.cn',User)
{% endcapture -%}
{% else -%}
{% assign shell = 'your terminal' -%}
{% assign prompt = '$' -%}
{% assign envvarset = '$ export ' -%}
{% assign setpath = '$ export PATH="$PWD/flutter/bin:$PATH"' -%}
{% assign comtoset = 'export' -%}
{% assign unzip='unzip' %}
{% capture permaddexample -%}
cat <<EOT >> ~/.zprofile
{{envvarset}}PUB_HOSTED_URL="https://pub.flutter-io.cn"
{{envvarset}}FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
{{setpath}}
EOT
{% endcapture -%}
{% endif -%}

<div id="{{id}}" class="tab-pane
  {%- if id == 'windows' %} active {% endif %}"
  role="tabpanel" aria-labelledby="{{id}}-tab" markdown="1">

1. Open a new Terminal window to prepare running scripts.

1. Set `PUB_HOSTED_URL` to your mirror site.
   In {{shell}}, run the following command:

   ```terminal
   {{envvarset}}PUB_HOSTED_URL="https://pub.flutter-io.cn"
   ```

1. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.
   In {{shell}}, run the following command:

   ```terminal
   {{envvarset}}FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
   ```

1. Download the Flutter archive from your mirror site.
   In your preferred browser, go to
   [Flutter SDK archive](https://flutter.cn/docs/release/archive?tab={{id}}).

1. Create a folder where you can install Flutter.

   Consider
   {% if id == 'windows' -%}
   `%USERPROFILE%` or `D:\dev`.
   {% else -%}
   `~/dev`.
   {% endif %}

1. Extract the zip file.

   ```terminal
   {{unzip}} flutter_sdk_v1.0.0.zip
   ```

1. Add Flutter to your `PATH` environment variable.
   In {{shell}}, run the following command:

   ```terminal
   {{setpath}}
   ```

1. Run Flutter Doctor to verify your installation.
   In {{shell}}, run the following command:

   ```terminal
   {{prompt}} flutter doctor
   ```

1. Return to the [setting up Flutter]({{site.url}}/get-started/editor)
   guide and continue from that procedure.

From this example, `flutter pub get` fetches packages from `flutter-io.cn`,
in any terminal where you set `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`.

Any environment variables set using `{{comtoset}}` in this procedure
only apply to the current window.

To set these values on a permanent basis,
{% if id == 'windows' -%}
set the enviroment variables as in the following example:
{% else -%}
append those three `export` commands to the `*rc` or `*profile`
file that your preferred shell uses. This would resemble the following:
{% endif -%}

```terminal
{{permaddexample}} 
```

</div>
