---
title: $FLUTTER_ROOT/bin/cache/flutter.version.json replaces $FLUTTER_ROOT/version
description: >-
  The deprecated '$FLUTTER_ROOT/version' tool file output has been replaced by
  '$FLUTTER_ROOT/bin/cache/flutter.version.json', and any build scripts or
  references to it must also be updated.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `flutter` tool will no longer
output the `$FLUTTER_ROOT/version` metadata file, and
only output `$FLUTTER_ROOT/bin/cache/flutter.version.json`.

Tools and build scripts that rely on the presence of `$FLUTTER_ROOT/version`
need to be updated.

## Background

[In 2023][PR 124558], `$FLUTTER_ROOT/bin/cache/fluttter.version.json` was added
as a newer file format that replaces `$FLUTTER_ROOT/version`.

So a file that looked something like this:

```plaintext title="version"
3.33.0-1.0.pre-1070
```

Was replaced by something like this:

```json title="flutter.version.json"
{
  "frameworkVersion": "3.33.0-1.0.pre-1070",
  "channel": "master",
  "repositoryUrl": "unknown source",
  "frameworkRevision": "be9526fbaaaab9474e95d196b70c41297eeda2d0",
  "frameworkCommitDate": "2025-07-22 11:34:11 -0700",
  "engineRevision": "be9526fbaaaab9474e95d196b70c41297eeda2d0",
  "engineCommitDate": "2025-07-22 18:34:11.000Z",
  "engineContentHash": "70fb28dde094789120421d4e807a9c37a0131296",
  "engineBuildDate": "2025-07-22 11:47:42.829",
  "dartSdkVersion": "3.10.0 (build 3.10.0-15.0.dev)",
  "devToolsVersion": "2.48.0",
  "flutterVersion": "3.33.0-1.0.pre-1070"
}
```

Generating both files is a source of technical debt.

## Migration guide

Most Flutter developers don't parse or use this file, but
custom tools or CI configurations might.

For example, the Flutter team's own `api.flutter.dev` generation script:

```dart title="post_processe_docs.dart"
final File versionFile = File('version');
final String version = versionFile.readAsStringSync();
```

Was updated in [172601][PR 172601] to:

```dart
final File versionFile = File(path.join(checkoutPath, 'bin', 'cache', 'flutter.version.json'));
final String version = () {
  final Map<String, Object?> json =
      jsonDecode(versionFile.readAsStringSync()) as Map<String, Object?>;
  return json['flutterVersion']! as String;
}();
```

To temporarily opt-out of `$FLUTTER_ROOT/version` no longer being emitted:

```sh
flutter config --no-enable-omit-legacy-version-file
```

## Timeline

Landed in version: 3.33.0-1.0.pre-1416<br>
Stable release: _Not published yet_

One stable release after this change lands,
`--no-enable-omit-legacy-version-file` will be removed.

## References

Relevant Issues:

- [Issue 171900][], where `FLUTTER_ROOT/version` was slated for removal

Relevant PRs:

- [PR 124558][], where `flutter.version.json` was added as the new format
- [PR 172601][], an example of migrating a script to use `flutter.version.json`

[Issue 171900]: {{site.repo.flutter}}/issues/171900
[PR 124558]: {{site.repo.flutter}}/pull/124558
[PR 172601]: {{site.repo.flutter}}/pull/172601
