---
title: Using Flutter in China
description: Where to find a version of the Flutter site that is localized to Simplified Chinese.
toc: true
---

{% assign path = 'flutter_infra_release/releases/stable/windows/flutter_windows_v1.0.0-stable.zip' -%}

The Flutter community has made a Simplified Chinese version of the
Flutter website available at
[https://flutter.cn](https://flutter.cn).

If you’d like to install Flutter using an [installation
bundle](/docs/development/tools/sdk/releases),
you can replace the domain of the original URL with a trusted mirror
to speed it up. For example:

* Original URL:<br>
  [`https://storage.googleapis.com/{{path}}`](https://storage.googleapis.com/{{path}})

* Mirrored URL:<br>
  [`https://storage.flutter-io.cn/{{path}}`](https://storage.flutter-io.cn/{{path}})

You must also set two environment variables to upgrade Flutter and use the pub
package repository in China. Instructions are below.

{{site.alert.important}}
  Use mirror sites only if you _trust_ the provider.
  The Flutter team cannot verify their reliability or security.
{{site.alert.end}}

## Configuring Flutter to use a mirror site

If you’re installing or using Flutter in China, it may be helpful to use
a trustworthy local mirror site that hosts Flutter’s dependencies.
To instruct the Flutter tool to use an alternate storage location,
you need to set two environment variables, `PUB_HOSTED_URL` and
`FLUTTER_STORAGE_BASE_URL`, before running the `flutter` command.

Taking MacOS or Linux as an example, here are the first few steps in
the setup process for using a mirror site. Run the following in a Bash
shell from the directory where you wish to store your local Flutter clone:


```terminal
$ export PUB_HOSTED_URL=https://pub.flutter-io.cn
$ export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
$ git clone -b dev {{site.github}}/flutter/flutter.git
$ export PATH="$PWD/flutter/bin:$PATH"
$ cd ./flutter
$ flutter doctor
```

After these steps, you should be able to continue
[setting up Flutter](/docs/get-started/editor) normally.
From here on, packages fetched by `flutter pub get` are
downloaded from `flutter-io.cn` in any shell where `PUB_HOSTED_URL`
and `FLUTTER_STORAGE_BASE_URL` are set.

The `flutter-io.cn` server is a provisional mirror for Flutter
dependencies and packages maintained by [GDG China]().
The Flutter team cannot guarantee long-term availability of this service.
You’re free to use other mirrors if they become available. If you’re
interested in setting up your own mirror in China, contact
[flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
for assistance.

## Community-run mirror sites

* Shanghai Jiaotong University Linux User Group
  * `FLUTTER_STORAGE_BASE_URL`: [https://mirrors.sjtug.sjtu.edu.cn/](https://mirrors.sjtug.sjtu.edu.cn)
  * `PUB_HOSTED_URL`: [https://dart-pub.mirrors.sjtug.sjtu.edu.cn/](https://dart-pub.mirrors.sjtug.sjtu.edu.cn)
