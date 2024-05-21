---
title: Capabilities & policies
description: >-
  Learn how to adapt your app to the
  capabilities and policies required
  by the platform, app store, your company,
  and so on.
---

Most real-world apps have the need to adapt to the
capabilities and policies of different devices and platforms.
This page contains advice for how to
handle these scenarios in your code.

## Design to the strengths of each device type

Consider the unique strengths and weaknesses of different devices.
Beyond their screen size and inputs, such as touch, mouse, keyboard,
what other unique capabilities can you leverage?
Flutter enables your code to _run_ on different devices,
but strong design is more than just running code.
Think about what each platform does best and
see if there are unique capabilities to leverage.

For example: Apple's App Store and Google's Play Store
have different rules that apps need to abide by.
Different host operating systems have differing
capabilities across time as well as each other. 

Another example is leveraging the web's extremely
low barrier for sharing. If you're deploying a web app,
decide what deep links to support,
and design the navigation routes with those in mind.

Flutter's recommended pattern for handling different
behavior based on these unique capabilities is to create
a set of `Capability` and `Policy` classes for your app.

### Capabilities

A _capability_ defines what the code or device _can_ do.
Examples of capabilities include:

* The existence of an API
* OS-enforced restrictions
* Physical hardware requirements (like a camera) 

### Policies

A _policy_ defines what the code _should_ do.

Examples of policies include:

* App store guidelines
* Design preferences
* Assets or copy that refers to the host device
* Features enabled on the server side 

### How to structure policy code 

The simplest mechanical way is `Platform.isAndroid`,
`Platform.isIOS`, and `kIsWeb`. These APIs mechanically
let you know where the code is running but have some
problems as the app expands where it can run, and
as host platforms add functionality. 

The following guidelines explain best practices
when developing the capabilities and policies for your app:

**Avoid using `Platform.isAndroid` and similar functions
to make layout decisions or assumptions about what a device can do.**

Instead, describe what you want to branch on in a method. 

Example: Your app has a link to buy something in a
website, but you don't want to show that link on iOS
devices for policy reasons. 

```dart
bool shouldAllowPurchaseClick() {
  // Banned by Apple App Store guidelines. 
  return !Platform.isIOS;
}

...
TextSpan(
  text: 'Buy in browser',
  style: new TextStyle(color: Colors.blue),
  recognizer: shouldAllowPurchaseClick ? TapGestureRecognizer()
    ..onTap = () { launch('<some url>') : null;
  } : null,
```

What did you get by adding an additional layer of indirection?
The code makes it more clear why the branched path exists.
This method can exist directly in the class but it's likely
that other parts of the code might need this same check.
If so, put the code in a class. 

```dart title="policy.dart"

class Policy {

  bool shouldAllowPurchaseClick() {
    // Banned by Apple App Store guidelines. 
    return !Platform.isIOS;
  }
}
```

With this code in a class, any widget test can mock
`Policy().shouldAllowPurchaseClick` and verify the behavior
independently of where the device runs. 
It also means that later, if you decide that
buying on the web isn't the right flow for
Android users, you can change the implementation
and the tests for clickable text won't need to change. 

## Capabilities 

Sometimes you want your code to do something but the
API doesn't exist, or maybe you depend on a plugin feature
that isn't yet implemented on all of the platforms you support.
This is a limitation of what the device _can_ do. 

Those situations are similar to the policy decisions
described above, but these are referred to as _capabilities_.
Why separate policy classes from capabilities
when the structure of the classes is similar?
The Flutter team has found with productionized apps that making
a logical distinction between what apps _can_ do and
what they _should_ do helps larger products respond to
changes in what platforms can do or require
in addition to your own preferences after
the initial code is written. 

For example, consider the case where one platform adds
a new permission that requires users to interact with
a system dialog before your code calls a sensitive API.
Your team does the work for platform 1 and creates a
capability named `requirePermissionDialogFlow`.
Then, if and when platform 2 adds a similar requirement
but only for new API versions,
then the implementation of `requirePermissionDialogFlow`
can now check the API level and return true for platform 2.
You've leveraged the work you already did.

## Policies 

We encourage starting with a `Policy` class initially
even if it seems like you won't make many policy based decisions.
As the complexity of the class grows or the number of inputs expands,
you might decide to break up the policy class by feature
or some other criteria.  

For policy implementation, you can use compile time,
run time, or Remote Procedure Call (RPC) backed implementations.

Compile-time policy checks are good for platforms
where the preference is unlikely to change and where
accidentally changing the value might have large consequences.
For example, if a platform requires that you not
link to the Play store, or requires that you use
a specific payment provider given the content of your app.

Runtime checks can be good for determining if there
is a touch screen the user can use. Android has a feature
you can check and your web implementation could
check for max touch points. 

RPC-backed policy changes are good for incremental
feature rollout or for decisions that might change later. 

## Summary 

Use a `Capability` class to define what the code *can* do.
You might check against the existence of an API,
OS-enforced restrictions,
and physical hardware requirements (like a camera).
A capability usually involves compile or runtime checks.

Use a `Policy` class (or classes depending on complexity)
to define what the code _should_ do to comply with
App store guidelines, design preferences,
and assets or copy that need to refer to the host device.
Policies can be a mix of compile, runtime, or RPC checks. 

Test the branching code by mocking capabilities and
policies so the widget tests don't need to change
when capabilities or policies change.

Name the methods in your capabilities and policies classes
based on what they are trying to branch, rather than on device type.

