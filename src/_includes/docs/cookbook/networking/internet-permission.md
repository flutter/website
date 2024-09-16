If you are deploying to Android, edit your `AndroidManifest.xml` file to 
add the Internet permission.

```xml
<!-- Required to fetch data from the internet. -->
<uses-permission android:name="android.permission.INTERNET" />
```

Likewise, if you are deploying to macOS, edit your 
`macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`
files to include the network client entitlement.

```xml
<!-- Required to fetch data from the internet. -->
<key>com.apple.security.network.client</key>
<true/>
```
