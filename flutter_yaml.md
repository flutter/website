---
layout: page
title: flutter.yaml Format
permalink: /manifest/
---

Every Flutter application needs some metadata so it can specify its dependencies
(services, assets, etc.). Flutter stores this information in a file named
`flutter.yaml`, which is written in the [YAML](http://www.yaml.org/) language.

At the top level are a series of fields. The currently supported ones are:

`name`
: Required for every application.

`assets`
: Optional. Array of strings. Relative paths to assets for the application.

`material-design-icons`
: Optional. Array of dictionaries specifying icons to include as assets.

`services`
: Optional. Array of strings.  Names of platform and third-party services
(Firebase, Google Cloud Messaging, etc.) to expose to your application.

`version`
: Optional. String used by [updater service][]. Follows [semantic versioning][].

`update-url`
: Optional. Url string used by [updater service][].

All other fields are ignored. A complete `flutter.yaml` looks something like the
following:

{% prettify yaml %}
name: example
assets:
  - assets/flutter_logo.png
  - packages/flutter_gallery_assets/sun.png
material-design-icons:
  - name: action/alarm
  - name: action/android
services:
  - firebase
{% endprettify %}

## Name

Every application needs a name.  This is used by the flutter tool when
manipulating files relating to your application on your behalf.

There are no restrictions at this time on valid characters in a name.

## Assets

Assets are optional, however nearly every application includes them.  These are
any files which you wish to have bundled in your applications `flx` file for
access via the `asset_bundle` service, or through the `AssetImage` widget, etc.

## Material Design Icons

Material Design Icons are optional. These icons are separate from general assets
as the flutter tools know how to handle bundling the right icons for the devices
you are targeting.

Google [documents](https://design.google.com/icons/) the full list of available
material design icons.  If you find one missing from Flutter, please [file an
issue](https://github.com/flutter/flutter/issues/new)

## Services

Services are optional, but most applications will want to include them.
Services are how Flutter applications access platform APIs or third party
frameworks.

At time of writing only two services are optional `firebase` and `gcm`.

## Version

A version number is only required to update your application via the
[updater service][].

Each time you publish your package, you publish it at a specific version.
Once that's been done, consider it hermetically sealed: you can't touch it
anymore. To make more changes, you'll need a new version.

When you select a version, follow [semantic versioning][].

# Update URL

An update url is only required to update your application via the
[updater service][].


[semantic versioning]: http://semver.org/spec/v2.0.0.html
[updater service]: https://github.com/flutter/flutter/wiki/On-the-fly-app-updates
