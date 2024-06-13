
Flutter can't handle [common dependencies with xcframeworks][common].
If both the host app and the Flutter module's plugin define the
same pod dependency and you integrate Flutter module using this option,
errors result.
These errors include issues like `Multiple commands produce
'CommonDependency.framework'`.

To work around this issue, link every plugin source in its `podspec` file
from the Flutter module to the host app's `Podfile`.
Link the source instead of the plugins' `xcframework` framework.
The next section explains how to [produce that framework][ios-framework].

To prevent the error that occurs when common dependencies exist,
use `flutter build ios-framework` with the `--no-plugins` flag.

[common]: https://github.com/flutter/flutter/issues/130220
[ios-framework]: https://github.com/flutter/flutter/issues/114692
