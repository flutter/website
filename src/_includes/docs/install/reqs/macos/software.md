
{% assign xcode = '[Xcode][] ' | append: site.appnow.xcode | append: ' to debug and compile native Swift or ObjectiveC code.' %}
{% assign cocoapods = '[CocoaPods][] ' | append: site.appnow.cocoapods | append: ' to compile and enable Flutter plugins in your native apps.' %}
{% capture android -%}
[Android Studio][] {{site.appmin.android_studio}} or later to
debug and compile Java or Kotlin code for Android.
Flutter requires the full version of Android Studio.
{% endcapture %}
{% assign chrome = "[Google Chrome][] to debug JavaScript code for web apps." %}
{% assign git-main = '[Git][] ' | append: site.appmin.git_mac | append: ' or later to manage source code.' %}
{% assign git-xcode = "The Xcode installation includes " %}
{% capture git-other -%}
To check if you have `git` installed,
type `git version` in your Terminal.
If you need to install `git`, type `brew install git`.
{% endcapture %}

{% case include.target %}
{% when 'desktop','iOS' %}

* {{xcode}} {{git-xcode}} {{git-main}}
* {{cocoapods}}

{% when 'Android' %}

* {{android}}
* {{git-main}}
  {{- git-other}}

{% when 'web' -%}

* {{chrome}}
* {{git-main}}
  {{- git-other}}

{% endcase %}

[Git]: https://formulae.brew.sh/formula/git
[Android Studio]: https://developer.android.com/studio/install#mac
[Xcode]: {{site.apple-dev}}/xcode/
[CocoaPods]: https://cocoapods.org/
[Google Chrome]: https://www.google.com/chrome/dr/download/
