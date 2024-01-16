---
title: Uninstall Flutter
description: How to remove the Flutter SDK.
toc: true
os-list: [Windows, macOS, Linux, ChromeOS]
---

To remove all of Flutter from your {{os}} development machine,
delete the directories that store Flutter and its configuration files.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="base-os-tabs" role="tablist">
{% for os in page.os-list %}
{% assign id = os | downcase -%}
  <li class="nav-item">
    <a class="nav-link {%- if id == 'windows' %} active {% endif %}" id="{{id}}-tab" href="#{{id}}" role="tab" aria-controls="{{id}} {{id}}-dl {{id}}-pub" aria-selected="true">{{os}}</a>
  </li>
{% endfor -%}
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
{% for os in page.os-list %}
{% assign id = os | downcase -%}

{% case os %}
{% when 'Windows' -%}
{% assign dirinstall='C:\dev\' %}
{% assign localappdata='%LOCALAPPDATA%\' %}
{% assign appdata='%APPDATA%\' %}
{% assign unzip='Extract-Archive' %}
{% assign path='C:\dev\' %}
{% assign prompt-start='C:\>' %}
{% assign prompt=path | append: '>' %}
{% assign terminal='PowerShell' %}
{% assign rm = 'Remove-Item -Recurse -Force -Path ' %}
{% capture rm-sdk %}Remove-Item -Recurse -Force -Path '{{dirinstall}}flutter'{% endcapture %}
{% capture dart-files %}
{{localappdata}}.dartServer
{{appdata}}.dart
{{appdata}}.dart-tool
{% endcapture %}
{% capture rm-dart-files %}
{{prompt}} {{rm}} {{localappdata}}.dartServer,{{appdata}}.dart,{{appdata}}.dart-tool
{% endcapture %}
{% capture flutter-files %}{{appdata}}.flutter-devtools{% endcapture %}
{% capture rm-flutter-files %}
{{prompt}} {{rm}} {{flutter-files}}
{% endcapture %}
{% capture rm-pub-dir %}
{{prompt}} {{rm}} {{localappdata}}Pub\Cache
{% endcapture %}
{% else -%}
{% assign dirinstall='~/development' %}
{% assign dirconfig='~/' %}
{% assign path='~/development/' %}
{% assign prompt='$' %}
{% assign prompt-start=prompt %}
{% assign rm = 'rm -rf ' %}
{% assign rm-sdk = 'rm -rf ' | append: dirinstall | append: '/flutter' %}
{% capture dart-files %}
{{dirconfig}}.dart
{{dirconfig}}.dart-tool
{{dirconfig}}.dartServer
{% endcapture %}
{% capture rm-dart-files %}
{{prompt}} {{rm}} {{dirconfig}}.dart*
{% endcapture %}
{% capture flutter-files %}
{{dirconfig}}.flutter
{{dirconfig}}.flutter-devtools
{{dirconfig}}.flutter_settings
{% endcapture %}
{% capture rm-flutter-files %}
{{prompt}} {{rm}} {{dirconfig}}.flutter*
{% endcapture %}
{% capture rm-pub-dir %}
{{prompt}} {{rm}} {{dirconfig}}.pub-cache
{% endcapture %}
{% endcase -%}

<div class="tab-pane {%- if id == 'windows' %} active {% endif %}" id="{{id}}" role="tabpanel" aria-labelledby="{{id}}-tab" markdown="1">

## Uninstall the Flutter SDK
{:.no_toc}

This guide presumes that you installed Flutter in `{{path}}` on {{os}}.

To uninstall the SDK, remove the `flutter` directory.

```terminal
{{prompt}} {{rm-sdk}}
```

## Remove configuration and package directories
{:.no_toc}

Flutter and Dart install additional directories in your home directory.
These contain configuration files and package downloads.
Each of the following procedures are _optional_.

### Remove Flutter configuration files
{:.no_toc}

If you don't want to preserve your Flutter configuration,
remove the following directories from your home directory.

```terminal
{{ flutter-files | strip }}
```

To remove these directories, run the following command.

```terminal
{{rm-flutter-files | strip}}
```

### Remove Dart configuration files
{:.no_toc}

If you don't want to preserve your Dart configuration,
remove the following directories from your home directory.

```terminal
{{ dart-files | strip}}
```

To remove these directories, run the following command.

```terminal
{{rm-dart-files | strip}}
```

### Remove pub package files
{:.no_toc}

{{site.alert.important}}
  If you want to remove Flutter but not Dart,
  don't complete this section.
{{site.alert.end}}

If you don't want to preserve your pub packages,
remove the `.pub-cache` directory from your home directory.

```terminal
{{rm-pub-dir | strip}}
```

</div>

{% endfor -%}
</div>
{% comment %} End: Tab panes. {% endcomment -%}

## Reinstall Flutter

You can [reinstall Flutter](/get-started/install) at any time.
If you removed the configuration directories,
reinstalling Flutter restores them to default settings.
