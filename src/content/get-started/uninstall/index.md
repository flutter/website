---
title: Uninstall Flutter
description: How to remove the Flutter SDK.
toc: false
os-list: [Windows, macOS, Linux, ChromeOS]
---

To remove all of Flutter from your development machine,
delete the directories that store Flutter and its configuration files.

## Uninstall the Flutter SDK

Select your development platform from the following tabs.

{% tabs %}

{% for os in os-list %}
{% tab os %}

{% assign id = os | downcase -%}
{% case os %}
{% when 'Windows' -%}
{% assign dirinstall='C:\\user\{username}\dev\' %}
{% assign localappdata='%LOCALAPPDATA%\' %}
{% assign appdata='%APPDATA%\' %}
{% assign ps-localappdata='$env:LOCALAPPDATA\' %}
{% assign ps-appdata='$env:APPDATA\' %}
{% assign unzip='Expand-Archive' %}
{% assign path='C:\\user\{username}\dev' %}
{% assign prompt='C:\\>' %}
{% assign terminal='PowerShell' %}
{% assign rm = 'Remove-Item -Recurse -Force -Path' %}
{% capture rm-sdk %}Remove-Item -Recurse -Force -Path '{{dirinstall}}flutter'{% endcapture %}
{% capture dart-files %}
{{localappdata}}.dartServer
{{appdata}}.dart
{{appdata}}.dart-tool
{% endcapture %}
{% capture rm-dart-files %}
{{prompt}} {{rm}} {{ps-localappdata}}.dartServer,{{ps-appdata}}.dart,{{ps-appdata}}.dart-tool
{% endcapture %}
{% capture flutter-files %}{{appdata}}.flutter-devtools{% endcapture %}
{% capture rm-flutter-files %}
{{prompt}} {{rm}} {{ps-appdata}}.flutter-devtools
{% endcapture %}
{% capture rm-pub-dir %}
{{prompt}} {{rm}} {{ps-localappdata}}Pub\Cache
{% endcapture %}
{% else -%}
{% assign dirinstall='~/development' %}
{% assign dirconfig='~/' %}
{% assign path='~/development/' %}
{% assign prompt='$' %}
{% assign rm = 'rm -rf ' %}
{% assign rm-sdk = rm | append: dirinstall | append: '/flutter' %}
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

This guide presumes that you installed Flutter in `{{path}}` on {{os}}.

To uninstall the SDK, remove the `flutter` directory.

```console
{{prompt}} {{rm-sdk}}
```

## Remove configuration and package directories {:.no_toc}

Flutter and Dart install additional directories in your home directory.
These contain configuration files and package downloads.
Each of the following procedures are _optional_.

### Remove Flutter configuration files {:.no_toc}

If you don't want to preserve your Flutter configuration,
remove the following directories from your home directory.

```plaintext
{{ flutter-files | strip }}
```

To remove these directories, run the following command.

```console
{{rm-flutter-files | strip}}
```

### Remove Dart configuration files {:.no_toc}

If you don't want to preserve your Dart configuration,
remove the following directories from your home directory.

```plaintext
{{ dart-files | strip}}
```

To remove these directories, run the following command.

```console
{{rm-dart-files | strip}}
```

### Remove pub package files {:.no_toc}

:::important
If you want to remove Flutter but not Dart,
don't complete this section.
:::

If you don't want to preserve your pub packages,
remove the `.pub-cache` directory from your home directory.

```console
{{rm-pub-dir | strip}}
```

{% case os %}
{% when 'Windows','macOS' -%}
{% include docs/install/reqs/{{os | downcase}}/unset-path.md terminal=terminal -%}
{% endcase %}

{% endtab %}
{% endfor -%}

{% endtabs %}

## Reinstall Flutter

You can [reinstall Flutter](/get-started/install) at any time.
If you removed the configuration directories,
reinstalling Flutter restores them to default settings.
