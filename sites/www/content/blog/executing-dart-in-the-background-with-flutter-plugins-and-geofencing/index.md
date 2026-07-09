---
title: "Executing Dart in the Background with Flutter Plugins and Geofencing"
description: "04/11/2022: This article has been updated to replace broken links due to docs and plugins changing names or locations."
publishDate: 2018-09-20
author: bkonyi
image: images/0ae_YppUn96m93qkT.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/0ae_YppUn96m93qkT.webp" alt="No garage door remote? Not a problem with Flutter and a Raspberry Pi!" caption="No garage door remote? Not a problem with Flutter and a Raspberry Pi!" />


***04/11/2022***: *This article has been updated to replace broken links due to docs and plugins changing names or locations.*

***09/10/2020***: *This article has been updated to reflect the move to the v2 Android embedding API. Migration instructions for applications created pre-1.12 can be found [here](https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects), and [here](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration) for plugins.*

Whether handling push notifications, location updates, or sensor events, many useful features require that an application has the ability to handle events without user interaction, even when not running in the foreground. Up until this point, applications written using Flutter could only handle background events using platform code, and plugins had no way of allowing for plugin users to provide a callback to handle background events in Dart. Basically, if a Flutter user wants to handle background events in an application, they were required to create a platform-specific implementation for each of their target platforms.

Luckily, this is no longer the situation, thanks to the arrival of Flutter support for background execution of Dart code. Having designed much of the Flutter background execution flow, I’m excited to share my experiences developing plugins which take advantage of this functionality, such as the [android_alarm_manager](https://pub.dartlang.org/packages/android_alarm_manager#-readme-tab-) and [an iOS location event handler](https://github.com/flutter/plugins/tree/master/packages/location_background), to help you get started creating your own plugins.

Throughout the rest of this article, I’ll explore (in detail) the process of building a Flutter plugin that handles background geofencing events on both Android and iOS. Finally, just for fun, I’ll showcase how I used this [geofencing plugin](https://github.com/bkonyi/FlutterGeofencing) to create a simple application that can be used to open my garage door automatically when I get close to home.

### Table of Contents

* [Geofencing: defining the Dart API](https://medium.com/p/2b3e40a1a124#56b7)

* [Dart background execution](https://medium.com/p/2b3e40a1a124#155c)

* [Background execution: Android (Kotlin)](https://medium.com/p/2b3e40a1a124#1b99)

* [Background execution: iOS (Objective-C)](https://medium.com/p/2b3e40a1a124#5979)

* [Usage example: operating a garage door with geofencing](https://medium.com/p/2b3e40a1a124#6db8)

* [Conclusion](https://medium.com/p/2b3e40a1a124#3d77)

* [Resources](https://medium.com/p/2b3e40a1a124#2bc9)

## Geofencing: defining the Dart API

Before writing any platform-specific code, I’ll first need to define the Dart API for the geofencing plugin. Since [Android](https://developer.android.com/training/location/geofencing) and [iOS](https://developer.apple.com/documentation/corelocation/monitoring_the_user_s_proximity_to_geographic_regions?language=objc) each have their own APIs for registering and handling geofencing events, I want the Dart interface to provide a reasonable geofencing abstraction that is compatible with both platforms. Without going into too much detail about Android and iOS APIs, the following roughly describes the Dart interface that I’ll use for my plugin:

```dart
/// A circular region which represents a geofence.
abstract class GeofenceRegion {
  /// The ID associated with the geofence.
  ///
  /// This ID identifies the geofence and is required to delete a
  /// specific geofence.
  final String id;

  /// The location (center point) of the geofence.
  final Location location;

  /// The radius around `location` that is part of the geofence.
  final double radius;

  /// Listen to these geofence events.
  final List<GeofenceEvent> triggers;

  /// Android-specific settings for a geofence.
  final AndroidGeofencingSettings androidSettings;
  
  GeofenceRegion(
    this.id, double latitude, double longitude, this.radius, this.triggers,
    {AndroidGeofencingSettings androidSettings});
}

abstract class GeofencingPlugin {
  /// Initialize the plugin and request relevant permissions from the user.
  static Future<bool> initialize() async;

  /// Register for geofence events for a [GeofenceRegion].
  ///
  /// `region` is the geofence region to register with the system.
  /// `callback` is the method to be called when a geofence event associated
  /// with `region` occurs.
  static Future<bool> registerGeofence(
    GeofenceRegion region,
    void Function(List<String> id, Location location, GeofenceEvent event) callback);

  /// Stop receiving geofence events for a given [GeofenceRegion].
  static Future<bool> removeGeofence(GeofenceRegion region);
  
  /// Stop receiving geofence events for an identifier associated with a
  /// geofence region.
  static Future<bool> removeGeofenceById(String id) async;
}
```

This interface provides the following functionality to users of the plugin:

* The ability to create instances of `GeofenceRegion`, which contain the coordinates and radius of a geofence, a unique ID, and a list of geofencing events to listen for. Since Android provides a richer set of options for defining geofences than iOS, Android-specific options are made available through the optional `androidSettings` property.

* `GeofencingPlugin.registerGeofence` allows for the registration of a `GeofenceRegion` instance with a callback that is invoked when a geofence event for that region is received.

* `GeofencingPlugin.removeGeofence` and `GeofencingPlugin.removeGeofenceById` unregister a `GeofenceRegion` from triggering additional events.

Overall, this interface is rather simple and (mostly) platform agnostic, making the plugin easy to use on both Android and iOS.

## Dart background execution

This section covers how to set up your isolate for background execution. You will learn how to reference callbacks, and how to use the callback dispatcher.

### Referencing Callbacks

Now that the Dart interface defined, start adding plumbing to communicate with the platform-specific portions of the plugin. For example, the following code initializes the geofencing plugin and registers the geofences:

```dart
abstract class GeofencingPlugin {
  static const MethodChannel _channel =
      const MethodChannel('plugins.flutter.io/geofencing_plugin');
  
  static Future<bool> initialize() async {
    final callback = PluginUtilities.getCallbackHandle(callbackDispatcher);
    await _channel.invokeMethod('GeofencingPlugin.initializeService',
        <dynamic>[callback.toRawHandle()]);
  }

  static Future<bool> registerGeofence(
      GeofenceRegion region,
      void Function(List<String> id, Location location, GeofenceEvent event)
          callback) {
    if (Platform.isIOS &&
        region.triggers.contains(GeofenceEvent.dwell) &&
        (region.triggers.length == 1)) {
      throw UnsupportedError("iOS does not support 'GeofenceEvent.dwell'");
    }
    final args = <dynamic>[
      PluginUtilities.getCallbackHandle(callback).toRawHandle()
    ];
    args.addAll(region._toArgs());
    _channel.invokeMethod('GeofencingPlugin.registerGeofence', args);
  }
  
  /*
  * … `removeGeofence` methods here …
  */
}

```

If you’ve previously developed Flutter plugins and are familiar with `MethodChannel`, this should look as expected, for the most part. (If you’re new to plugin development, check out [the platform channels article](https://flutter.io/platform-channels/) for an introduction). However, the two calls to `PluginUtilities.getCallbackHandle` might stand out.

<DashImage figure src="images/0ilMs7WWcpN3q9UxO.webp" alt="*Callback handles are managed by the Flutter engine and can be used to reference and lookup callbacks across isolates.*" caption="*Callback handles are managed by the Flutter engine and can be used to reference and lookup callbacks across isolates.*" />


In order to invoke a Dart callback as a result of a background event, you must retrieve a handle that is passed between Dart and platform code while also allowing for lookup of the callback across platform threads and Dart [isolates](https://api.dartlang.org/stable/2.0.0/dart-isolate/dart-isolate-library.html).

**Aside:** Retrieving a `CallbackHandle` for a method from `PluginUtilities.getCallbackHandle` has the side effect of populating a callback cache within the Flutter engine, as seen in the diagram above. This cache maps information required to retrieve callbacks to raw integer handles, which are simply hashes calculated based on the properties of the callback. This cache persists across launches, but be aware that ***callback lookups may fail if the callback is renamed or moved and `PluginUtilities.getCallbackHandle` is not called for the updated callback**.*

In the code above, two instances of `CallbackHandle` are obtained: one for the callback, which is associated with a `GeofenceRegion`, and another for a method of the name `callbackDispatcher`. The `callbackDispatcher` method, the entrypoint of the background isolate, is responsible for preprocessing raw geofence event data, looking up callbacks via `PluginUtilities.getCallbackFromHandle`, and invoking them for registered geofences.

### The Callback Dispatcher

As mentioned at the end of the previous section, I’ll use a pattern that I refer to as the *callback dispatcher* to create the entrypoint for the geofencing plugin’s background isolate. This pattern allows for performing the initialization required to establish communication channels with platform code while also allowing for the creation of non-trivial interfaces for callback methods. For this geofencing plugin, the callback dispatcher implementation is as follows:

```dart
void callbackDispatcher() {
  // 1. Initialize MethodChannel used to communicate with the platform portion of the plugin.
  const MethodChannel _backgroundChannel =
      MethodChannel('plugins.flutter.io/geofencing_plugin_background');
  
  // 2. Setup internal state needed for MethodChannels.
  WidgetsFlutterBinding.ensureInitialized();
  
  // 3. Listen for background events from the platform portion of the plugin.
  _backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final args = call.arguments;
    
    // 3.1. Retrieve callback instance for handle.
    final Function callback = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(args[0]));
    assert(callback != null);
    
    // 3.2. Preprocess arguments.
    final triggeringGeofences = args[1].cast<String>();
    final locationList = args[2].cast<double>();
    final triggeringLocation = locationFromList(locationList);
    final GeofenceEvent event = intToGeofenceEvent(args[3]);
    
    // 3.3. Invoke callback.
    callback(triggeringGeofences, triggeringLocation, event);
  });
  
  // 4. Alert plugin that the callback handler is ready for events.
  _backgroundChannel.invokeMethod('GeofencingService.initialized');
}

```

As you can see, on the invocation of `callbackDispatcher` (upon the creation of the geofencing plugin’s background isolate), only four operations are performed. First, a `MethodChannel` is created for listening to events from the plugin. Next, `WidgetsFlutterBinding.ensureInitialized()` is called to initialize state needed to communicate with the Flutter engine. At this point, the `MethodCall` handler is set to process plugin events before finally alerting the platform portion of the plugin that the background isolate is initialized and ready to start handling events.

Once the plugin starts sending events to the callback dispatcher, the callback provided by the plugin user can be invoked. First, `PluginUtilities.getCallbackFromHandle` is called to retrieve an instance of the callback associated with the triggered geofencing event using the raw callback handle. Next, the raw arguments from the `MethodCall` are refined into:

* An instance of `List&lt;String&gt;` for the IDs of the geofences that were triggered

* An instance of `Location` describing the current location of the device

* An instance of the `GeofenceEvent` enum that represents whether the device has entered, exited, or dwelled within the triggered geofences.

Then provide this info as arguments to our callback.

**Important Note:** You may have noticed that no state is kept within the callback handler. This is because ***there is no guarantee that the background isolate will stay alive while the application itself is backgrounded***. Both Android and iOS have lifecycle policies that can result in background services or execution being killed, meaning that the background isolate may be destroyed and then recreated the next time the application is woken up. As a result, ***best practice avoids storing volatile state in either the callback handler or user-provided callbacks***.

At this point, we now have all of the Dart code needed for the plugin! Now, onto the platform-specific portion of the geofencing plugin.

## Background execution: Android (Kotlin)

For the Android implementation of the plugin, I’ll need to implement the following classes:

* The `GeofencingPlugin` class, which is registered with the Flutter engine in order to receive and handle method calls made from Dart code

* A `GeofencingBroadcastReceiver`, which is invoked by the system on a geofence event

* The `GeofencingService`, which creates the background isolate, initializes the callback dispatcher described earlier, and processes geofence events before invoking the callback dispatcher.

This trinity of 1) plugin, 2) broadcast receiver, and 3) service classes is a common pattern for plugins on Android, so it is worth becoming familiar with it. Although I’ve decided to use Kotlin for this plugin, everything here can also be implemented using Java.

### GeofencingPlugin

As previously mentioned, the main purpose of the `GeofencingPlugin` is to process requests from Dart code and then register or remove geofences based on the contents of said request. An instance of this class is automatically created and added to the plugin registry at application startup.

This class implements two interfaces that are required for basic functionality of the plugin:

* [`FlutterPlugin`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.html): declares `onAttachedToEngine` and `onDetachedFromEngine`, used to notify the plugin of its connection status to a Flutter engine instance.

* [`MethodCallHandler`](https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodChannel.MethodCallHandler.html): declares `onMethodCall`, the method used to process messages sent to the plugin over a `MethodChannel`.

Most plugins need to implement both `FlutterPlugin` and `MethodCallHandler`, but some plugins may also require information about the current `Activity` or other application component.

To get access to application components currently attached to the plugin instance, a plugin should implement one or more of the “awareness” interfaces for [`Activity`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityAware.html), [`BroadcastReceiver`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/broadcastreceiver/package-summary.html), [`ContentProvider`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/contentprovider/package-summary.html), or [`Service`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/service/package-summary.html). These interfaces declare callbacks that can be invoked by the Flutter engine to notify the plugin when a component is attached or detached. For example, a plugin that requires access to an `Activity` would implement the `ActivityAware` interface and would be notified when the plugin gains or loses access to an `Activity` due to the application being minimized.

### Creating Geofences

In order to handle requests, create an instance of `MethodChannel` on the same channel from earlier, and then register the `GeofencingPlugin` instance with this new channel in the implementation of `onAttachedToEngine`:

```kotlin
override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  mContext = binding.getApplicationContext()
  mGeofencingClient = LocationServices.getGeofencingClient(mContext!!)
  val channel = MethodChannel(binding.getBinaryMessenger(), "plugins.flutter.io/geofencing_plugin")
  channel.setMethodCallHandler(this)
}
```

In order to manage these requests, `onMethodCall` needs to be implemented:

```kotlin
override fun onMethodCall(call: MethodCall, result: Result) {
  val args = call.arguments<ArrayList<*>>()
  when(call.method) {
    "GeofencingPlugin.initializeService" -> {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        mActivity?.requestPermissions(REQUIRED_PERMISSIONS, 12312)
      }
      // Simply stores the callback handle for the callback dispatcher
      initializeService(mContext!!, args)
      result.success(true)
    }
    "GeofencingPlugin.registerGeofence" -> registerGeofence(mContext!!,
            mGeofencingClient!!,
            args,
            result,
            true)
    "GeofencingPlugin.removeGeofence" -> removeGeofence(mContext!!,
            mGeofencingClient!!,
            args,
            result)
    else -> result.notImplemented()
  }
}
```

Finally, I’ll add the ability to register geofences (removing geofences is relatively trivial, so I’ll focus on adding geofences in this article):

```kotlin
@JvmStatic
private fun getGeofencingRequest(geofence: Geofence, initialTrigger: Int): GeofencingRequest {
  return GeofencingRequest.Builder().apply {
    setInitialTrigger(initialTrigger)
    addGeofence(geofence)
  }.build()
}

@JvmStatic
private fun getGeofencePendingIndent(context: Context, callbackHandle: Long): PendingIntent {
val intent = Intent(context, GeofencingBroadcastReceiver::class.java)
        .putExtra(CALLBACK_HANDLE_KEY, callbackHandle)
return PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)
}

// TODO(bkonyi): Reregister geofences after reboot 
// https://developer.android.com/training/location/geofencing
@JvmStatic
private fun registerGeofence(context: Context,
                              geofencingClient: GeofencingClient,
                              args: ArrayList<*>?,
                              result: Result?) {
  val callbackHandle = args!![0] as Long
  val id = args[1] as String
  val lat = args[2] as Double
  val long = args[3] as Double
  val radius = (args[4] as Number).toFloat()
  val fenceTriggers = args[5] as Int
  val initialTriggers = args[6] as Int
  val expirationDuration = (args[7] as Int).toLong()
  val loiteringDelay = args[8] as Int
  val notificationResponsiveness = args[9] as Int
  val geofence = Geofence.Builder()
          .setRequestId(id)
          .setCircularRegion(lat, long, radius)
          .setTransitionTypes(fenceTriggers)
          .setLoiteringDelay(loiteringDelay)
          .setNotificationResponsiveness(notificationResponsiveness)
          .setExpirationDuration(expirationDuration)
          .build()
  // Ensure permissions are set properly.
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
          (context.checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                  == PackageManager.PERMISSION_DENIED)) {
    val msg = "'registerGeofence' requires the ACCESS_FINE_LOCATION permission."
    Log.w(TAG, msg)
    result?.error(msg, null, null)
  }
  geofencingClient.addGeofences(getGeofencingRequest(geofence, initialTriggers),
          getGeofencePendingIndent(context, callbackHandle))?.run {
    addOnSuccessListener {
      Log.i(TAG, "Successfully added geofence")
      result?.success(true)
    }
    addOnFailureListener {
      Log.e(TAG, "Failed to add geofence: $it")
      result?.error(it.toString(), null, null)
    }
  }
}

```

There’s a lot going on here, so let’s break this down:

1. Pull the relevant arguments out of the `ArrayList` sent over the `MethodChannel`

1. Create an instance of `Geofence` that describes the location and size of the geofence as well as its various trigger parameters

1. Before registering the `Geofence` instance, do another check to ensure that the application still has the correct device permissions for geofencing

1. Finally, a `GeofencingRequest` as well as a `PendingIntent` are created and used to register the geofence. The `PendingIntent` is used to invoke the `GeofencingBroadcastReceiver` when the geofence is triggered; it contains the callback handle associated with that geofence.

That’s it! At this point the plugin can create and register a geofence. However, the plugin is not yet ready to handle actual geofence events. For that, the plugin needs to be able to be woken up by the system when there is a geofence event to be handled.

### Scheduling the geofencing service

Now that the plugin can register geofence events, it also needs to be able to handle the events themselves. When a geofence registered by the plugin is triggered, Android starts the Flutter application in the background, creates an instance of `GeofencingBroadcastReceiver`, and invokes the overridden `onReceive` method:

```kotlin
class GeofencingBroadcastReceiver : BroadcastReceiver() {
  companion object {
    private const val TAG = "GeofencingBroadcastReceiver"
  }
  
  override fun onReceive(context: Context, intent: Intent) {
    FlutterMain.startInitialization(context)
    FlutterMain.ensureInitializationComplete(context, null)
    GeofencingService.enqueueWork(context, intent)
  }
}
```

The `onReceive` implementation is simple: it ensures that the Flutter framework is initialized and then adds the `Intent` for the geofencing event to the `GeofencingService`’s work queue. Since `GeofencingService` is an implementation of a `JobIntentService`, `GeofencingService.enqueueWork` is simply a wrapper around the `enqueueWork` method in `JobIntentService`, which handles scheduling the work for the service.

### Handling Geofence Events

At some point after a geofence event is added to the work queue, Android wakes up the application to invoke `GeofencingService`’s `onHandleWork` method. However, before `onHandleWork` can be called, an instance of `GeofencingService` must be created and initialized by invoking `startGeofencingService` from `GeofencingService`’s `onCreate` method.

```kotlin
private fun startGeofencingService(context: Context) {
  // Synchronize on sServiceStarted to avoid multiple concurrent
  // initializations.
  synchronized(sServiceStarted) {
    mContext = context
    // If we don't have an existing background FlutterNativeView,
    // we need to create one and have it initialize our callback
    // dispatcher.
    if (sBackgroundFlutterEngine == null) {
      // Grab the callback handle for the callback dispatcher from
      // storage.
      val callbackHandle = context.getSharedPreferences(
          GeofencingPlugin.SHARED_PREFERENCES_KEY,
          Context.MODE_PRIVATE)
          .getLong(GeofencingPlugin.CALLBACK_DISPATCHER_HANDLE_KEY, 0)
      if (callbackHandle == 0L) {
        Log.e(TAG, "Fatal: no callback registered")
        return
      }
      // Retrieve the actual callback information needed to invoke it.
      val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
      if (callbackInfo == null) {
        Log.e(TAG, "Fatal: failed to find callback")
        return
      }
      // Create a FlutterEngine which will process the geofencing events.
      sBackgroundFlutterEngine = FlutterEngine(context)

      val args = DartCallback(
        context.getAssets(),
        FlutterMain.findAppBundlePath(context)!!,
        callbackInfo
      )
      // Start running callback dispatcher code in our background FlutterEngine instance.
      sBackgroundFlutterEngine!!.getDartExecutor().executeDartCallback(args)
    }
  }
  // Create the MethodChannel used to communicate between the callback
  // dispatcher and this GeofencingService instance.
  mBackgroundChannel = MethodChannel(sBackgroundFlutterEngine!!.getDartExecutor().getBinaryMessenger(),
      "plugins.flutter.io/geofencing_plugin_background")
  mBackgroundChannel.setMethodCallHandler(this)
}
```

`startGeofencingService` is responsible for ensuring that the plugin has an associated [`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html) instance. Each `FlutterEngine` instance provides access to a [`DartExecutor`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/dart/DartExecutor.html) which can be used to execute Dart code in a new isolate. In this case, the `FlutterEngine` instance has the important task of initializing the callback dispatcher, and executing the callbacks registered with the plugin.

After `startGeofencingService` is done executing, `onHandleWork` is called by the system with the `Intent` that was queued up earlier:

```kotlin
override fun onHandleWork(intent: Intent) {
  // Retrieve the callback handle associated with the triggered geofence.
  val callbackHandle = intent.
    getLongExtra(GeofencingPlugin.CALLBACK_HANDLE_KEY, 0)
  
  // Parse the GeofencingEvent from the Intent.
  val geofencingEvent = GeofencingEvent.fromIntent(intent)
  
  if (geofencingEvent.hasError()) {
    Log.e(TAG, "Geofencing error: ${geofencingEvent.errorCode}")
    return
  }
  
  // Get the geofence transition type (e.g., enter, dwell, exit).
  val geofenceTransition = geofencingEvent.geofenceTransition

  // Get the geofences that were triggered. A single event can trigger
  // multiple geofences.
  val triggeringGeofences = geofencingEvent.triggeringGeofences.map {
    it.requestId
  }

  val location = geofencingEvent.triggeringLocation
  val locationList = listOf(location.latitude,
    location.longitude)
  val geofenceUpdateList = listOf(callbackHandle,
    triggeringGeofences,
    locationList,
    geofenceTransition)
    
  synchronized(sServiceStarted) {
    if (!sServiceStarted.get()) {
      // Queue up geofencing events while background isolate is starting
      queue.add(geofenceUpdateList)
    } else {
      // Callback method name is intentionally left blank.
      mBackgroundChannel.invokeMethod("", geofenceUpdateList)
    }
  }
}
```

Most of the above code builds the argument list which is sent to the callback dispatcher. However, before passing the processed geofence event arguments to the callback dispatcher, the plugin must ensure that the callback dispatcher has started listening on its `MethodChannel`. To achieve this behavior, the `GeofencingService` listens for a message from the callback dispatcher, which is sent after the `MethodCall` handler for the dispatcher is set:

```kotlin
override fun onMethodCall(call: MethodCall, result: Result) {
  if (call.method == "GeofencingService.initialized") {
    synchronized(sServiceStarted) {
      // Dispatch any geofencing events that were handled before the
      // callback dispatcher was ready.
      while (!queue.isEmpty()) {
        mBackgroundChannel.invokeMethod("", queue.remove())
      }
      sServiceStarted.set(true)
      result.success(null)
    }
  } else {
    result.notImplemented()
  }
}
```

At this point, the `GeofencingService` is completely initialized and any geofencing events that have queued up are sent to the callback dispatcher.

## Background execution: iOS (Objective-C)

Now that the geofencing plugin implementation for Android is finished, the same geofencing functionality needs to be implemented for iOS.

### Initializing the plugin

One of the first tasks performed by the Flutter engine at startup is registering and initializing all plugins used by the application. On iOS, this involves invoking the static `registerWithRegistrar` method defined for each plugin. For the geofencing plugin, initialization involves creating an instance of `GeofencingPlugin` and registering it as an application delegate as seen in the code snippet below. This allows for the Flutter engine to delegate handling of certain events to the plugin.

```objective-c
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  @synchronized(self) {
    if (instance == nil) {
      NSLog(@"Registering with registrar");
      instance = [[GeofencingPlugin alloc] init:registrar];
      [registrar addApplicationDelegate:instance];
    }
  }
}
```

Additional state for the plugin is set when the `GeofencingPlugin` instance is created during plugin registration:

```objective-c
- (instancetype)init:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  NSAssert(self, @"super init cannot be nil");
  
  // 1. Retrieve NSUserDefaults which will be used to store callback handles
  // between launches.
  _persistentState = [NSUserDefaults standardUserDefaults];
  
  // 2. Initialize the location manager, and register as its delegate.
  _locationManager = [[CLLocationManager alloc] init];
  [_locationManager setDelegate:self];
  [_locationManager requestAlwaysAuthorization];
  _locationManager.allowsBackgroundLocationUpdates = YES;
  
  // 3. Initialize the Dart runner which will be used to run the callback
  // dispatcher.
  _headlessRunner = [[FlutterEngine alloc] 
                        initWithName:@"GeofencingIsolate" 
                        project:nil 
                        allowHeadlessExecution:YES];
  _registrar = registrar;
  
  // 4. Create the method channel used by the Dart interface to invoke
  // methods and register to listen for method calls.
  _mainChannel = [FlutterMethodChannel 
                  methodChannelWithName:@"plugins.flutter.io/geofencing_plugin"
                  binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:self channel:_mainChannel];
  
  // 5. Create a second method channel to be used to communicate with the
  // callback dispatcher. This channel will be registered to listen for
  // method calls once the callback dispatcher is started.
  _callbackChannel =
    [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/geofencing_plugin_background"
      binaryMessenger:_headlessRunner];
  
  return self;
}
```

### Starting the callback dispatcher

Once initialization of internal state is complete the callback dispatcher needs to be started by invoking `startGeofencingService`. This is either done when the user calls `GeofencingManager.initialize()` in their application or when the application is started to handle a geofence event (more on this later).

```objective-c
- (void)startGeofencingService:(int64_t)handle {
  NSLog(@"Initializing GeofencingService");
  [self setCallbackDispatcherHandle:handle];
  
  FlutterCallbackInformation *info = [FlutterCallbackCache lookupCallbackInformation:handle];
  NSAssert(info != nil, @"failed to find callback");
  
  NSString *entrypoint = info.callbackName;
  NSString *uri = info.callbackLibraryPath;
  [_headlessRunner runWithEntrypointAndLibraryUri:entrypoint libraryUri:uri];
  NSAssert(registerPlugins != nil, @"failed to set registerPlugins");

   // Once our headless runner has been started, we need to register the application's plugins
  // with the runner in order for them to work on the background isolate. `registerPlugins` is
  // a callback set from AppDelegate.m in the main application. This callback should register
  // all relevant plugins (excluding those which require UI).
  registerPlugins(_headlessRunner);
  [_registrar addMethodCallDelegate:self channel:_callbackChannel];
}
```

**Note**: the `FlutterMethodChannel` for the callback dispatcher is only registered *after* the headless runner has been started. If an attempt to register the callback dispatcher’s method channel is made before this is done, the application will likely crash.

### Handling method calls

Similar to how `onMethodCall` needed to be implemented on Android to allow for the plugin to handle requests from the Dart interface and callback dispatcher, `handleMethodCall` must be implemented:

```objective-c
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSArray *arguments = call.arguments;
  if ([@"GeofencingPlugin.initializeService" isEqualToString:call.method]) {
    NSAssert(arguments.count == 1,
    @"Invalid argument count for 'GeofencingPlugin.initializeService'");
    [self startGeofencingService:[arguments[0] longValue]];
    result(@(YES));
  } else if ([@"GeofencingService.initialized" isEqualToString:call.method]) {
    // Ignored on iOS.
    result(nil);
  } else if ([@"GeofencingPlugin.registerGeofence" isEqualToString:call.method]) {
    [self registerGeofence:arguments];
    result(@(YES));
  } else if ([@"GeofencingPlugin.removeGeofence" isEqualToString:call.method]) {
    result(@([self removeGeofence:arguments]));
  } else {
    result(FlutterMethodNotImplemented);
  }
}
```

### Registering geofences

With initialization completed, the plugin is ready to register for geofence events. When the plugin user requests for a geofence to be set, `registerGeofence` is called:

```objective-c
- (void)registerGeofence:(NSArray *)arguments {
  NSLog(@"RegisterGeofence: %@", arguments);
  int64_t callbackHandle = [arguments[0] longLongValue];
  NSString *identifier = arguments[1];
  double latitude = [arguments[2] doubleValue];
  double longitude = [arguments[3] doubleValue];
  double radius = [arguments[4] doubleValue];
  CLCircularRegion *region =
    [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(latitude, longitude)
      radius:radius
      identifier:identifier];
  region.notifyOnEntry = YES;
  region.notifyOnExit = YES;
  [self setCallbackHandleForRegionId:callbackHandle regionId:identifier];
  [self->_locationManager startMonitoringForRegion:region];
}
```

This method creates the geofence region and uses the `CLLocationManager`’s `startMonitoringForRegion` method to register the geofence. In order to keep track of which callback is associated with the newly registered geofence, the callback handle is mapped to the region’s user provided identifier which is stored to disk using `NSUserDefaults`. Doing this allows for the plugin to lookup the callback handle when a geofence event is received, even if the application had been closed since the geofence was registered.

### Handling geofence events

Once the system determines that a geofence has been entered or exited, the `CLLocationManager` invokes one of `didEnterRegion` or `didExitRegion`. At this point, the callback handle for the geofence which was triggered is retrieved from storage and the callback dispatcher is invoked:

```objective-c
- (void)sendLocationEvent:(CLRegion *)region eventType:(int)event {
  NSAssert([region isKindOfClass:[CLCircularRegion class]], @"region must be CLCircularRegion");
  CLLocationCoordinate2D center = region.center;
  int64_t handle = [self getCallbackHandleForRegionId:region.identifier];
  [_callbackChannel
    invokeMethod:@""
    arguments:@[
      @(handle),
      @[ region.identifier ], 
      @[ @(center.latitude), @(center.longitude) ],
      @(event)
    ]
  ];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  [self sendLocationEvent:region eventType:kEnterEvent];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  [self sendLocationEvent:region eventType:kExitEvent];
}
```

### Geofence events in a suspended state

If you are familiar with developing applications for both Android and iOS, you’ll probably know that iOS is much more restrictive than Android when it comes to executing code in the background. Instead of spawning potentially long-running services to handle background events, iOS allows for applications to register for specific types of events which, when received, wake up the application and invoke any relevant delegates. Since the [`FlutterPlugin`](https://docs.flutter.io/objcdoc/Protocols/FlutterPlugin.html) protocol allows for plugins to be registered as delegates, it’s relatively simple to handle any background event provided by the system.

For geofencing, the plugin needs to implement `didFinishLaunchingWithOptions` which is invoked when the application has just been started and is ready to run. The dictionary parameter of this method will contain `UIApplicationLaunchOptionsLocationKey` if the application was launched due to a geofence event.

```objective-c
- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  // Check to see if we're being launched due to a location event.
  if (launchOptions[UIApplicationLaunchOptionsLocationKey] != nil) {
    // Restart the headless service.
    [self startGeofencingService:[self getCallbackDispatcherHandle]];
  }
    
  // Note: if we return NO, this vetos the launch of the application.
  return YES;
}
```

If the application is launched as the result of a geofence being triggered, the callback dispatcher for the plugin will still need to be initialized by calling `startGeofencingService` with the cached callback dispatcher handle. After returning from this method, the location manager will invoke the appropriate handler described in the previous section for the geofence event.

## Usage example: operating a garage door with geofencing

Now that the geofencing plugin is fully implemented for both Android and iOS, I can finally put it to good use: automatically opening my garage door as I pedal towards my house!

<DashImage figure src="images/0ae_YppUn96m93qkT.webp" />


<DashImage figure src="images/0at7FCzjM5lAd8NC_.webp" alt="The relay is triggered by the Raspberry Pi, which opens and closes the door (left). A proximity sensor allows for the garage door service to know whether or not the door is currently open (right)." caption="The relay is triggered by the Raspberry Pi, which opens and closes the door (left). A proximity sensor allows for the garage door service to know whether or not the door is currently open (right)." />


<DashImage figure src="images/074sQ7Fl7ueommzJy.webp" alt="*My garage door remote, built using Flutter. Can you tell that I’m a backend engineer?*" caption="*My garage door remote, built using Flutter. Can you tell that I’m a backend engineer?*" />


<iframe src="https://gfycat.com/WickedHospitableEidolonhelvum" width="1920" height="1080" frameborder="0" allowfullscreen></iframe>


Over the past couple of months I’ve been tinkering with a Raspberry Pi and the Dart [rpi_gpio package](https://pub.dartlang.org/packages/rpi_gpio/versions/0.4.0-dev.1#-readme-tab-) to get back into working with circuits. I had been toying around with the idea of making a Flutter application that would open my garage door for quite awhile, so it made sense for my first hardware project to use Dart and Flutter. Over a couple of weekends, I wrote a [service to control the garage door](https://github.com/bkonyi/GarageDoorController/blob/master/bin/garage_server.dart), performed minor surgery to wire a relay across the opener button, installed a proximity sensor to query the state of the door, and finally wrote a [simple application using Flutter that functions as a remote control](https://github.com/bkonyi/FlutterGarageDoorOpener).

After using my solution for a couple of weeks, I was becoming annoyed. Although it was great that I could open the garage with a mobile application, I still had to pull out my phone, open the app, and then manually trigger the door. This is particularly painful for me since fingerprint readers apparently don’t like to work when covered in sweat, making it difficult to unlock my phone (I don’t have a car and I commute 15km each way by bike, so fingerprint reader struggles are a daily occurrence).

Luckily for me, Flutter now has a geofencing plugin that can perform tasks even while the application isn’t open, including opening my garage door!

### Setting the right permissions

The first thing I’ll do is ensure that my application has the right permissions to use the geofencing plugin.

### Permissions: Android

In order for the geofencing plugin to run in the background, `GeofencingBroadcastReceiver` and `GeofencingService` need to be registered in AndroidManifest.xml:

```xml
<receiver android:name="io.flutter.plugins.geofencing.GeofencingBroadcastReceiver"
android:enabled="true" android:exported="true"/>

<service android:name="io.flutter.plugins.geofencing.GeofencingService"
android:permission="android.permission.BIND_JOB_SERVICE" android:exported="true"/>
```

Geofencing on Android also requires the `ACCESS_FINE_LOCATION` and `ACCESS_BACKGROUND_LOCATION` (Android 10+) permissions to be requested in AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

### Permissions: iOS

Requesting the relevant permissions on iOS requires some simple modifications to `Info.plist` in the ios directory of the application. First, add the following lines to request background location updates:

```openstep property list
<dict>
…
  <key>UIRequiredDeviceCapabilities</key>
  <array>
    <string>location-services</string>
    <string>gps</string>
    <string>armv7</string>
  </array>
  <key>UIBackgroundModes</key>
  <array>
    <string>location</string>
  </array>
…
</dict>
```

Then set the `NSLocation` description messages:

```openstep property list
<dict>
…
  <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  <string>YOUR DESCRIPTION HERE</string>
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>YOUR DESCRIPTION HERE</string>
…
</dict>
```

These descriptions are shown to the user when the application requests access to their location. **If they’re not provided, geofencing registration will fail silently!**

```objective-c
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

// Add the import for the GeofencingPlugin.
#import <geofencing/GeofencingPlugin.h>

void registerPlugins(NSObject<FlutterPluginRegistry>* registry) {
  [GeneratedPluginRegistrant registerWithRegistry:registry];
}

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Register the plugins with the AppDelegate
  registerPlugins(self);
  // Set registerPlugins as a callback within GeofencingPlugin. This allows
  // for the Geofencing plugin to register the plugins with the background
  // FlutterEngine instance created to handle events. If this step is skipped,
  // other plugins will not work in the geofencing callbacks!
  [GeofencingPlugin setPluginRegistrantCallback:registerPlugins];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

Finally, similarly to what was done for Android, set a reference to the application’s plugin registrant within `GeofencingPlugin` from the application’s `AppDelegate`. This is needed to register the application’s plugins with the geofencing plugin’s background isolate, which makes it possible to use other plugins in the context of that isolate.

### Bringing it all together

Now that the permissions required for geofencing have been set correctly, all that’s left to do is wiring the plugin into the garage door remote application.

First of all, the plugin needs to be initialized. This is done in a method named `initialize`, which is invoked when the application starts:

```dart
Future<void> initialize() async {
  // Perform other initialization
  // …
  // Initialize the geofencing plugin.
  await GeofencingManager.initialize();
}
```

Next, there should be some way to toggle whether or not the garage door should open when the geofence is entered. This can be accomplished with a simple `Switch` displayed at the bottom of the application:

```dart
Widget _proximityTriggerToggle() => Container(
    padding: const EdgeInsets.fromLTRB(26.0, 2.5, 26.0, 2.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Proximity Trigger',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        Switch(
          value: _proximityTriggerEnabled,
          onChanged: (bool state) async {
            setState(() {
              _proximityTriggerEnabled = state;
            });
            if (state) {
              await GeofencingManager.registerGeofence(
                  GeofenceTrigger.homeRegion,
                  GeofenceTrigger.homeGeofenceCallback);
            } else {
              await GeofencingManager.removeGeofence(
                  GeofenceTrigger.homeRegion);
            }
          },
        ),
      ],
    )
  );

```

Depending on the state of this `Switch`, the application either registers a geofence with the callback used to open the garage door, or removes the geofence.

Finally, the geofence region around my home and its corresponding callback are defined in `GeofenceTrigger`:

```dart
abstract class GeofenceTrigger {
  static final _androidSettings = AndroidGeofencingSettings(
      initialTrigger: [GeofenceEvent.exit],
      notificationResponsiveness: 0,
      loiteringDelay: 0);
  
  static bool _isInitialized = false;

  static final homeRegion = GeofenceRegion(
      'home', HOME_LAT, HOME_LONG, 300.0, <GeofenceEvent>[GeofenceEvent.enter],
      androidSettings: _androidSettings);

  static Future<void> homeGeofenceCallback(
      List<String> id, Location location, GeofenceEvent event) async {
    // Check to see if this is the first time the callback is being called.
    if (!_isInitialized) {
      // Re-initialize state required to communicate with the garage door
      // server.
      await initialize();
      _isInitialized = true;
    }

    if (event == GeofenceEvent.enter) {
      await GarageDoorRemote.openDoor();
    }
  }
}
```

For my initial tests I created a `GeofenceRegion` with a radius of 300m around my home that will trigger at some point after I enter the area. Once the geofence is entered the `homeGeofenceCallback` is invoked, checks are performed to ensure the application can communicate with the garage door server, and then a request to open the door is sent. Once I confirmed that the logic within the callback actually triggered the garage door to open using a third-party application to mock my location and movements, it was time to do some real world testing on my bike!

After a few trips up and down the street it became apparent that, although geofences are triggered almost immediately when using a mocked location, Android provides no guarantees as to when a geofence event is delivered. Unfortunately, this means that it can potentially take minutes before my garage door remote is notified that I’ve entered the geofence region around my home. With a radius as small as 300m, I often found myself waiting a minute or two for the door to open on its own.

The temporary fix for this was to increase the radius of the geofence region to 1km, which seems to work well enough for now. Obviously, there’s some issues with this approach, but I plan on further refining the proximity triggering logic to use a larger geofence that will start more frequent location updates. These location updates will then be used to manually determine whether I’m within a certain radius of my house, at which point the request to open the door will be sent.

## Conclusion

If you’ve made it this far you should now have all the knowledge you need to create a Flutter plugin that executes Dart code in the background! Of course, I was only able to scratch the surface of plugin development for Flutter in this article but I would highly recommend the documentation for [developing packages and plugins](https://flutter.io/developing-packages/) as well as the walkthrough for [writing custom platform-specific code with platform channels](https://flutter.io/platform-channels/). If you want a deeper look into how the geofencing plugin is implemented, the full source can be found in the [FlutterGeofencing](https://github.com/bkonyi/FlutterGeofencing) repo on GitHub. I’ve also linked to all the additional documentation, sample plugins, and projects mentioned throughout this article in the Resources section below.

I’ve had a lot of fun implementing background execution support for Flutter, and even more fun creating the geofencing plugin for this article. (It was a wonderful excuse to work on a personal project as part of my job!) If you feel so inclined, [follow me on GitHub](https://github.com/bkonyi) to keep up with my work on Flutter and the Dart virtual machine, as well as my other pet projects.

Thanks for reading and happy Fluttering!

<DashImage figure src="images/0D6jZA_ksvRN5EJi1.webp" alt="Like many members of the Dart and Flutter teams, Dash loves cycling. However, for obvious reasons, Dash has a bit of trouble riding a bike." caption="Like many members of the Dart and Flutter teams, Dash loves cycling. However, for obvious reasons, Dash has a bit of trouble riding a bike." />


## Resources

### Docs for Dart:

* [**PluginUtilities**](https://api.flutter.dev/flutter/dart-ui/PluginUtilities-class.html): contains methods for dealing with CallbackHandles

* [**IsolateNameServer**](https://api.flutter.dev/flutter/dart-ui/IsolateNameServer-class.html): establishing communication between foreground and background isolates using named SendPorts

### Docs for Android:

* [**Flutter Java APIs**](https://api.flutter.dev/javadoc/overview-summary.html)

* [**FlutterEngine**: allows for spawning a background isolate](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html)

* [**FlutterCallbackInformation**](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html): lookup callback information needed for starting a background isolate using callback handles

### Docs for iOS:

* [**FlutterEngine**](https://api.flutter.dev/objcdoc/Classes/FlutterEngine.html): allows for spawning a background isolate

* [**FlutterCallbackCache**](https://api.flutter.dev/objcdoc/Classes/FlutterCallbackCache.html): lookup callback information needed for starting a background isolate using callback handles

### Sample Plugins:

* [**FlutterGeofencing**](https://github.com/bkonyi/FlutterGeofencing): the geofencing plugin created for this article

* [**android_alarm_manager**](https://pub.dartlang.org/packages/android_alarm_manager#-readme-tab-): an AlarmManager plugin for Flutter

* [**background_location**](https://pub.dev/packages/background_location): plugin for listening for significant location changes on Android and iOS

### Projects referenced:

* [**rpi_gpio**](https://github.com/danrubel/rpi_gpio.dart): package for accessing the Raspberry Pi GPIO pins.

* [**FlutterGarageDoorOpener**](https://github.com/bkonyi/FlutterGarageDoorOpener): garage door remote control using Flutter

* [**GarageDoorController**](https://github.com/bkonyi/GarageDoorController): the garage door controller library and service