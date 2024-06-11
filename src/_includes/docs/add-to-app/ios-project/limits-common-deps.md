
Flutter can't handle [common dependencies with xcframeworks][common].
If both the host app and the Flutter module's plugin define the
same pod dependency and you integrate Flutter module using this option,
errors result.
These errors include issues like Multiple commands produce
'CommonDependency.framework'.

To work around this issue, link every plugin source in its `podspec` file
from the Flutter module to the host app's `Podfile`.
Do this instead of using the plugins' `xcframework` files that the
[`flutter build ios-framework` command produces][ios-framework].

This issue contributed to the introduction of the
`--no-plugins` flag for the `flutter build ios-framework` command.

[common]: https://github.com/flutter/flutter/issues/130220
[ios-framework]: https://github.com/flutter/flutter/issues/114692
