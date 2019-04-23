## Profile run

{{site.alert.important}}
  Do _not_ test the performance of your app with debug and hot reload enabled.
{{site.alert.end}}

The app you've run so far is in the debug mode which allows faster development (e.g., hot reload) at a big performance overhead. Therefore, janky animations are expected in such mode. To see how the app performs in release, try {{include.ide_profile}} the following terminal command.

```terminal
$ flutter run --profile
```

The animations should be much smoother compared to those in the debug mode.
