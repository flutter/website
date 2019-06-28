## Profile or release runs

{{site.alert.important}}
  Do _not_ test the performance of your app with debug and
  hot reload enabled.
{{site.alert.end}}

The app you've run so far is built in debug mode,
which allows faster development
(for example, by supporting hot reload)
at a big performance cost. Therefore,
janky animations are expected in such mode.
Once you are ready to analyze performance or
release your app, you'll want to use Flutter's
profile or release builds. For more information,
see [Flutter's build modes](/docs/testing/build-modes).
