---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

## Questions

### What scenarios are ideal for Flutter on the web?

Not every web page makes sense in Flutter, but we think Flutter is particularly
suited for app-centric experiences:

* Progressive Web Apps
* Single Page Apps
* Existing Flutter mobile apps

At this time, Flutter is not suitable for static websites with text-rich
flow-based content. For example, blog articles benefit from the document-centric
model that the web is built around, rather than the app-centric services that a
UI framework like Flutter can deliver. However, you _can_ use Flutter to embed
interactive experiences into these websites.

For more information on how you can use Flutter on the web,
see [Web support for Flutter][].

### Search Engine Optimization (SEO)

In general, Flutter is geared towards dynamic application experiences. Flutter's
web support is no exception. Flutter web prioritizes performance, fidelity, and
consistency. This means application output does not align with what search
engines need to properly index. For web content that is static or document-like,
we recommend using HTML—just like we do on [flutter.dev]({{site.main-url}}),
[dart.dev]({{site.dart-site}}), and [pub.dev]({{site.pub}}). You should also
consider separating your primary application experience—created in Flutter—from
your landing page, marketing content, and help content—created using
search-engine optimized HTML.

That said, as mentioned in the [roadmap][], the Flutter team plans to
investigate search engine indexability of Flutter web.

### Does hot reload work with a web app?

Yes! Though it's currently behind an experimental flag.
For more information, check out
[hot reload on the web][].

[hot reload on the web]: /platform-integration/web/building#hot-reload-web

Hot restart doesn't require a flag and is a fast way of seeing your
changes without having to relaunch your web app and wait for it
to compile and load. This works similarly to
the hot reload feature for Flutter mobile development.
The difference is that hot reload remembers your state and hot
restart doesn't.

### Which web browsers are supported by Flutter?

Flutter web apps can run on the following browsers:

* Chrome (mobile & desktop)
* Safari (mobile & desktop)
* Edge (mobile & desktop)
* Firefox (mobile & desktop)

During development, Chrome (on macOS, Windows, and Linux) and Edge (on Windows)
are supported as the default browsers for debugging your app.

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** or **Edge** as the target device in
Android Studio/IntelliJ and VS Code.

The device pulldown should now include the **Chrome (web)**
option for all channels.

### How do I build a responsive app for the web?

See [Creating responsive apps][].

### Can I use `dart:io` with a web app?

No. The file system is not accessible from the browser.
For network functionality, use the [`http`][]
package. Note that security works somewhat
differently because the browser (and not the app)
controls the headers on an HTTP request.

### How do I handle web-specific imports?

Some plugins require platform-specific imports, particularly if they use the
file system, which is not accessible from the browser. To use these plugins
in your app, see the [documentation for conditional imports][]
on [dart.dev]({{site.dart-site}}).

### Does Flutter web support concurrency?

Dart's concurrency support via [isolates][]
is not currently supported in Flutter web.

Flutter web apps can potentially work around this
by using [web workers][],
although no such support is built in.

### How do I deploy a web app?

See [Preparing a web app for release][].

### Does `Platform.is` work on the web?

Not currently.

### Why doesn't my app update immediately after it's deployed?

You might need to configure the `Cache-Control` header returned by your web server.
For example, if this header is set to 3600, then the browser
and CDN will cache the asset for 1 hour, and your users might see an out-of-date
version of your app up to 1 hour after you deploy a new version. For
more information about caching on the web,
check out [Prevent unnecessary network requests with the HTTP Cache][http-cache].

It is a good idea to be aware of this behavior to avoid an undesirable user experience.
After you deploy your app, users might use a
cached version of your app (cached by the browser or CDN)
for the duration defined by your cache headers.
This can lead to users using a version of your app that
is incompatible with changes that have been deployed to backend services.

### How do I clear the web cache after a deployment and force an app download?
If you wish to defeat these cache headers after each deployment, a common
technique is to append a build ID of some sort to the links of your static
resources, or update the filenames themselves.
For example, `logo.png` might become `logo.v123.png`.

```html
<!-- Option 1, append build ID as a query parameter in your links -->
<script src="flutter_bootstrap.js?v=123" async></script>

<!-- Option 2, update the filename and update your links -->
<script src="flutter_bootstrap.v123.js" async></script>
```

Flutter does not currently support appending build IDs to resources
automatically.

### How do I configure my cache headers?

If you are using Firebase Hosting,
the shared cache (CDN) is invalidated when you deploy a new version of your
app. But you might choose to configure your cache headers as follows,
so that the browser cache doesn't cache application scripts,
but the shared cache does.

```json
{
  "hosting": {
    "headers": [
      {
        "source":
          "**/*.@(jpg|jpeg|gif|png|svg|webp|css|eot|otf|ttf|ttc|woff|woff2|font.css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=3600,s-maxage=604800"
          }
        ]
      },
      {
        "source":
          "**/*.@(mjs|js|wasm|json)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=0,s-maxage=604800"
          }
        ]
      }
    ]
  }
}
```

### How do I configure a service worker?

The service worker generated by `flutter build web` is deprecated,
and you can disable it by setting the `--pwa-strategy` flag to `none`
when running the `flutter build web` command.

```console
flutter build web --pwa-strategy=none
```

If you would like to continue to use a service worker, you can
[build your own][using-service-workers] or try third-party tools
such as [Workbox][workbox].

If your service worker is not refreshing,
configure your CDN and browser cache by setting
the `Cache-Control` header to a small value such as 0 or 60 seconds.

[building a web app with Flutter]: /platform-integration/web/building
[Creating responsive apps]: /ui/adaptive-responsive
[documentation for conditional imports]: {{site.dart-site}}/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files
[Embedding Flutter web]: /platform-integration/web/embedding-flutter-web
[file an issue]: {{site.repo.flutter}}/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[`http`]: {{site.pub}}/packages/http
[http-cache]: https://web.dev/articles/http-cache
[`iframe`]: https://html.com/tags/iframe/
[isolates]: {{site.dart-site}}/guides/language/concurrency
[Issue 32248]: {{site.repo.flutter}}/issues/32248
[Preparing a web app for release]: /deployment/web
[roadmap]: {{site.github}}/flutter/flutter/blob/master/docs/roadmap/Roadmap.md#web-platform
[run your web apps in any supported browser]: /platform-integration/web/building#create-and-run
[using-service-workers]: https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API/Using_Service_Workers
[Web content in Flutter]: /platform-integration/web/web-content-in-flutter
[Web support for Flutter]: /platform-integration/web
[web workers]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers
[workbox]: https://github.com/GoogleChrome/workbox
