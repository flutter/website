---
title: Creating flavors for Flutter
short-title: Flavors
description: How to create build flavors specific to different release types or development environments.
---

Stepping back from Flutter, here are some important Xcode concepts.  From what I can tell, flavors were conceptualized in Android land, then kind of backported to iOS with some very clunky results.

1. Targets
Represent executables like your app, or frameworks, or other extensions like notification services.  One Xcode project could have a macOS app target, an iOS app target, and a framework target they both link on and embed.  Your source files will be compiled into targets, and this is where you would set up various compilation flags, if needed.  You can also set up scripts that run at different parts of the build (there's one that calls into Flutter to compile the Dart side, for example).
2. Build configurations
Similar to Flutter's build modes.  The default for a blank Xcode app is Debug and Release.  Flutter's blank app adds a Profile configuration.  By default, running an app will run in Debug, and archiving it (to submit to the App Store, say) runs in Release.  You can change it, but you can tell from the default how they think of it.
3. Schemes (Product > Scheme > Edit Scheme)
This is essentially the organizational view into the build system.  Aside: this concept has "only" been around like 15 years so some developers still aren't aware of it.  When you build, you're building a scheme. "My iOS App" is a scheme name:
Screen Shot 2020-06-09 at 7.00.01 PM.png
This sets up what executable (Target) to run, what other targets are the dependencies, what unit tests to run, arguments passed on launch, various debugger settings.  If I were building Flutter from scratch, I would require users to set up a scheme per flavor.  But that's not how it works.
The flavor documentation is nonexistent, I recently created https://github.com/flutter/flutter/issues/57608 after I did a bunch of iOS cleanup in this area https://github.com/flutter/flutter/issues/14648#issuecomment-627079766.  And when I filed that https://flutter.dev/docs/deployment/flavors linked to some helpful though out-of-date articles, not random packages.

I'm going to assume Dev, Staging, Production your flavors.  Do you have the build configurations hooked up in Xcode?  It's kind of described in https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b Would probably look something like this:
Screen Shot 2020-06-09 at 6.32.32 PM.png

(This naming is clunky, but it's so it knows what Xcode settings to use when you run a build mode like flutter run --debug --flavor Dev, hopefully I'll come up with some better way to do this soon.)

Creating targets just for bundle IDs and icons is way overkill.  It's like having two copies of your app.  If you added a new Swift file, it would need to be compiled into both targets.  In Xcode, you would go to your Runner target build settings, then expand Product Bundle Identifier to see your flavors.  Set them to what you want.
Screen Shot 2020-06-09 at 6.37.33 PM.png
Same for the app icon:
Screen Shot 2020-06-09 at 6.39.43 PM.png
In Xcode open Info.plist and make sure Bundle Identifier is set to $(PRODUCT_BUNDLE_IDENTIFIER).  That's the default, but there are many online tutorials that tell you to change it to something else.  You can use the same technique to have different app names per flavor (it's called Product name in that list).

Backend server configuration, push notification configuration, etc. is a case for having multiple targets (I wrote the above before your last email) because you want different files compiled or copied depending on your flavor.  Check out https://github.com/flutter/flutter/tree/master/dev/integration_tests/flavors Xcode project to see how you could set up different targets and schemes.

