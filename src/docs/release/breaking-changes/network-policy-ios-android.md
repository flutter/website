---
title: Insecure connections are disabled by default on iOS and Android.
description: Connecting to a host through insecure socket will throw an exception unless the domain is explicitly allowed by policy.
---

## Summary

If your code tries to open an insecure socket to a host on iOS or Android, a `SocketException` will be thrown with the following message:

```
Insecure socket connections are disallowed by platform: <host>
```

## Context

Starting with Android [API 28](https://developer.android.com/training/articles/security-config#CleartextTrafficPermitted) and [iOS 9](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity), these platforms disable insecure connections by default.

With this change Flutter also disables insecure connections on mobile platforms. Other platforms (desktop, web, etc) are not affected.

You can override this behavior by following the platform-specific guidelines to define a domain-specific network policy. See migration guide below for details.


## Migration guide

On iOS, you can add [NSExceptionDomains](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity/nsexceptiondomains) to your applications Info.plist.

On Android, you can add a [network security config](https://developer.android.com/training/articles/security-config#CleartextTrafficPermitted) XML. For Flutter to find your XML file, you need to also add a `metadata` entry to the `<application>` tag in your manifest. This metadata entry should carry the name: `io.flutter.network-policy` and should contain the resource identifier of the XML.

For instance, if you put your XML configuration under res/xml/network_security_config.xml, your manifest would contain:

```
<application ...>
  ...
  <meta-data android:name="io.flutter.network-policy"
             android:resource="@xml/network_security_config"/>
</application>
```

Furthermore:

- Build time configuration is the only way to change network policy. It cannot be modified at runtime.
- Localhost connections are always allowed.
- You can allow insecure connections only to domains. Specific IP addresses are not accepted as input. This is in line with what platforms support.

## Timeline

This change was introduced in 1.22.

## References

API documentation: There's no API for this change since the modification to network policy is done via platform specific configuration as detailed above.

Relevant PRs:

* [PR 20218: Plumbing for setting domain network policy][]
* [Introduce per-domain policy for strict secure connections][]

[PR 20218: Plumbing for setting domain network policy]: {{site.github}}/flutter/engine/pull/20218
[Introduce per-domain policy for strict secure connections]: https://github.com/dart-lang/sdk/commit/d878cfbf20375befa09f9bf85f0ba2b87b319427
