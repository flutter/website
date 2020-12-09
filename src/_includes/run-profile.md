## Profile or release runs



{{site.alert.important}}
  Do _not_ test the performance of your app with debug and
  hot reload enabled.
{{site.alert.end}}

So far you've been running your app in *debug* mode. Debug
mode trades performance for useful developer features such
as hot reload and step debugging. It's not unexpected to
see slow performance and janky animations in debug mode.
Once you are ready to analyze performance or release your
app, you'll want to use Flutter's "profile" or "release"
build modes. For more details, see [Flutter's build modes][].

{{site.alert.important}}
  If you're concerned about the package size of your app,
  see [Measuring your app's size][].
{{site.alert.end}}

[Flutter's build modes]: /docs/testing/build-modes
[Measuring your app's size]:  /docs/perf/app-size
