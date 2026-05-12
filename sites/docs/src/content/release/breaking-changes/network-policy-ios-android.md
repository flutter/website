---
title: Insecure HTTP connections are disabled by default on iOS and Android
description: >
  Accessing a URL with HTTP protocol throws an exception unless
  the domain is explicitly allowed by policy.
---

{% render "docs/breaking-changes.md" %}

## Summary

If your code tries to open an HTTP connection to a host
on iOS or Android, a `StateException` is now thrown with
the following message:

```plaintext
Insecure HTTP is not allowed by platform: <host>
```

Use HTTPS instead.

## Context

Starting with Android [API 28][] and [iOS 9][],
these platforms disable insecure HTTP connections by default.

With this change Flutter also disables insecure connections on
mobile platforms. Other platforms (desktop, web, etc)
are not affected.

You can override this behavior by following the
platform-specific guidelines to define a domain-specific
network policy. See the migration guide below for details.

[API 28]: {{site.android-dev}}/training/articles/security-config#CleartextTrafficPermitted
[iOS 9]: {{site.apple-dev}}/documentation/bundleresources/information_property_list/nsapptransportsecurity

:::important
The following only applies to platform native sockets (sockets owned
by the Android and iOS platforms).  

Flutter does not enforce any policy at socket level; you would be
responsible for securing the connection. If the socket is owned by
Dart/Flutter, no policy will be enforced.
:::

## Migration guide

On iOS, you can add [NSExceptionDomains][] to your
application's Info.plist.

On Android, you can add a [network security config][] XML.

### Allowing cleartext connection for debug builds

If you would like to allow HTTP connections for Android debug
builds, you can add the following snippet to your $project_path\android\app\src\debug\AndroidManifest.xml:

```xml
<application android:networkSecurityConfig="@xml/network_security_config">
  ...
</application>
```

Then, add the network configuration to your $project_path/android/app/src/debug/res/xml/network_security_config.xml:
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true" />
</network-security-config>
```

It is also possible to set the policy per domain.  See the Android
documentation for more information.

For iOS, you can follow [these instructions](/add-to-app/ios/project-setup/?tab=embed-using-cocoapods#set-local-network-privacy-permissions) to create a `Info-debug.plist` and put this in:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

We **do not** recommend you do this for your release builds.

## Additional Information

* Build time configuration is the only way to change
  network policy. It cannot be modified at runtime.

[network security config]: {{site.android-dev}}/training/articles/security-config#CleartextTrafficPermitted
[NSExceptionDomains]: {{site.apple-dev}}/documentation/bundleresources/information_property_list/nsapptransportsecurity/nsexceptiondomains

## Timeline

Landed in version: 1.23<br>
In stable release: 2.0.0<br>
Reverted in version: 2.2.0 (proposed)

## References

API documentation: There's no API for this change since
the modification to network policy is done through the
platform specific configuration as detailed above.

Relevant PRs:

* [PR 20218: Plumbing for setting domain network policy][]
* [Introduce per-domain policy for strict secure connections][]

[PR 20218: Plumbing for setting domain network policy]: {{site.repo.engine}}/pull/20218
[Introduce per-domain policy for strict secure connections]: {{site.github}}/dart-lang/sdk/commit/d878cfbf20375befa09f9bf85f0ba2b87b319427
