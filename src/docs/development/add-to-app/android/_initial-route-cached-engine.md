The concept of an initial route is available when configuring a
`FlutterActivity` or a `FlutterFragment` with a new `FlutterEngine`.
However, `FlutterActivity` and `FlutterFragment` don't offer the
concept of an initial route when using a cached engine.
This is because a cached engine is expected to already be
running Dart code, which means it's too late to configure the
initial route.

Developers that would like their cached engine to begin
with a custom initial route can configure their cached
`FlutterEngine` to use a custom initial route just before
executing the Dart entrypoint. The following example
demonstrates the use of an initial route with a cached engine:

{% samplecode cached-engine-with-initial-route %}
{% sample Java %}
<!--code-excerpt "MyApplication.java" title-->
```java
public class MyApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    // Instantiate a FlutterEngine.
    flutterEngine = new FlutterEngine(this);
    // Configure an initial route.
    flutterEngine.getNavigationChannel().setInitialRoute("your/route/here");
    // Start executing Dart code to pre-warm the FlutterEngine.
    flutterEngine.getDartExecutor().executeDartEntrypoint(
      DartEntrypoint.createDefault()
    );
    // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
    FlutterEngineCache
      .getInstance()
      .put("my_engine_id", flutterEngine);
  }
}
```
{% sample Kotlin %}
<!--code-excerpt "MyApplication.kt" title-->
```kotlin
class MyApplication : Application() {
  lateinit var flutterEngine : FlutterEngine
  override fun onCreate() {
    super.onCreate()
    // Instantiate a FlutterEngine.
    flutterEngine = FlutterEngine(this)
    // Configure an initial route.
    flutterEngine.navigationChannel.setInitialRoute("your/route/here");
    // Start executing Dart code to pre-warm the FlutterEngine.
    flutterEngine.dartExecutor.executeDartEntrypoint(
      DartExecutor.DartEntrypoint.createDefault()
    )
    // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
    FlutterEngineCache
      .getInstance()
      .put("my_engine_id", flutterEngine)
  }
}
```
{% endsamplecode %}

By setting the initial route of the navigation channel, the associated
`FlutterEngine` displays the desired route upon initial execution of the
`runApp()` Dart function.

Changing the initial route property of the navigation channel
after the initial execution of `runApp()` has no effect.
Developers who would like to use the same `FlutterEngine`
between different `Activity`s and `Fragment`s and switch
the route between those displays need to setup a method channel and
explicitly instruct their Dart code to change `Navigator` routes.

