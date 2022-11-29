# DevTools 2.20.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## Memory updates

- Retire the Analysis tab - [#4714](https://github.com/flutter/devtools/pull/4714)
- Add a new tab, Diff, to enable memory leak detection and troubleshooting
by comparing heap snapshots, and providing insights about the number of
instances, shallow size, retained size, and retaining
paths - [#4714](https://github.com/flutter/devtools/pull/4714)

  ![diff]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/diff.png "Diff in Memory tab")
