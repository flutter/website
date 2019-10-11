---
title: AndroidX Migration 
description: How to migrate existing Flutter projects to AndroidX.
---

{{site.alert.note}}
  You might be directed to this page if the tool detects that your project
  doesn't use AndroidX.
{{site.alert.end}}

[AndroidX](https://developer.android.com/jetpack/androidx) is a major improvement 
to the original Android Support Library.

It provides the `androidx.*` package libraries, unbundled from the platform API. 
This means that it offers backward compatibility and is updated more frequently 
than the Android platform.

## Common Questions

### How do I migrate my existing app, plugin or host-editable module project to AndroidX?

_You will need Android Studio 3.2 or higher. If you don’t have it installed, 
you can download the latest version from 
[developer.android.com/studio](https://developer.android.com/studio)_.

1. Open Android Studio.
2. Select **Open an existing Android Studio Project**.
3. Open the `android` directory within your app.
4. Wait until the project has been synced successfully. 
  (This happens automatically once you open the project, but if it doesn’t,
   select **Sync Project with Gradle Files** from the **File** menu).
5. Select **Migrate to AndroidX** from the Refactor menu. 
6. If you are asked to backup the project before proceeding, 
   check **Backup project as Zip file**, then click **Migrate**. Lastly, save 
   the zip file in your location of preference.
  <img
      width="500"
      style="border-radius: 12px;"
      src="/images/androidx/migrate_prompt.png" 
      class="figure-img img-fluid"
      alt="Select backup project as zip file" />
7. The refactoring preview shows the list of changes. Finally, click **Do Refactor**:
  <img
      width="600"
      style="border-radius: 12px;"
      src="/images/androidx/do_androidx_refactor.png"
      class="figure-img img-fluid"
      alt="An animation of the bottom-up page transition on Android" />
8. That is it! You successfully migrated your project to AndroidX. 

Finally, if you migrated a plugin, publish the new AndroidX version to pub and update 
your `CHANGELOG.md` to indicate that this new version is compatible with AndroidX.

### How do I migrate my existing module project to AndroidX?

If your project is a module and contains a `.android` directory, add the following
line to `pubspec.yml`:

```yaml
 module:
   ...
    androidX: true // Add this line.
```

Finally, run `flutter clean`.

If your module contains an `android` directory instead, then follow the 
steps in previous section.


### How do I know if my project is using AndroidX?

* **Apps and Modules**
  Your project uses AndroidX if the file `android/gradle.properties` or 
  `.android/gradle.properties`contains:

  ```
  android.useAndroidX=true
  android.enableJetifier=true
  ```

* **Plugins**
  If a file under the android directory references any old support library package
  or old support support artifacts, then the plugin isn’t using AndroidX.

### What if I don’t migrate my app or module to AndroidX?

Your app may continue to work. However, combining AndroidX and Support artifacts 
is generally not recommended because it can result in dependency conflicts or 
other kind of Gradle failures. As a result, as more plugins migrate to AndroidX,
plugins depending on Android core libraries are likely to cause build failures.

### What if my app is migrated to AndroidX, but not all of the plugins I use?

The Flutter tool uses Jetifier to automatically migrate Flutter plugins using 
the Support Library to AndroidX, so you can use the same plugins even if they 
haven’t been migrated to AndroidX yet.

### I'm having issues migrating to AndroidX

[Open an issue on GitHub](https://github.com/flutter/flutter/issues/new/choose)
and add `[androidx-migration]` to the title of the issue.
