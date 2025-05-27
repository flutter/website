
{% assign id = include.ref-os | downcase -%}
{% assign mainPath = include.filepath -%}
{%- case id %}
{% when 'windows','macos' %}
{%- assign fileFormat = 'zip' %}
{% else %}
{%- assign fileFormat = 'tar.xz' %}
{% endcase %}
{%- if id == 'chromeos' %}
{% assign plat = 'linux' %}
{%- else %}
{% assign plat = id %}
{% endif %}
{% capture filepath -%}{{mainPath | replace: "opsys", plat}}{{fileFormat}} {% endcapture -%}

To download the {{include.ref-os}} 3.13 version of the Flutter SDK,
you would change the original URL from:

```console
https://storage.googleapis.com/{{filepath}}
```

to the mirror URL:

```console
https://storage.flutter-io.cn/{{filepath}}
```
