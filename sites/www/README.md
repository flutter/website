<img src="content/images/flutter-logo.svg" height="130" alt="Flutter's wordmark logo.">

# [Flutter][] website source

The website for the Flutter open-source framework,
hosted at [flutter.dev](https://flutter.dev).

The website is implemented and statically generated with
[Dart][], [Jaspr][], and [Jaspr Content][] then
built using [Google Cloud Build][] and deployed to [Firebase][].

[Flutter]: https://flutter.dev
[Dart]: https://dart.dev
[Jaspr]: https://jaspr.site
[Jaspr Content]: https://docs.jaspr.site/content
[Google Cloud Build]: https://cloud.google.com/build
[Firebase]: https://firebase.google.com

## Contribute

### Get the prerequisites

- [Flutter SDK][Install Flutter]

  To build and develop the site, you'll need to
  install the latest stable release of Flutter, which includes Dart.

  If you don't have Flutter or need to update, follow the
  instructions at [Install Flutter][] or [Upgrade Flutter][].

  If you already have Flutter installed, verify it's on your path
  and already on the latest stable version:

  ```bash
  flutter --version
  ```

- [Jaspr CLI][]

  Ensure the latest version of the Jaspr CLI is installed by
  running `dart pub global activate jaspr_cli`.

  To directly use the `jaspr` CLI command,
  the pub system cache's `bin` directory must be on your PATH.
  If running `jaspr --help` doesn't work, follow the
  instructions on [Running a script from your PATH][pub-global-run].

[Install Flutter]: https://docs.flutter.dev/install
[Upgrade Flutter]: https://docs.flutter.dev/install/upgrade
[Jaspr CLI]: https://pub.dev/packages/jaspr_cli
[pub-global-run]: https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path

### Develop

Run the development server with hot-reloading:

```bash
jaspr serve
```

The site will be available at `http://localhost:8080`.

### Build

Generate the static site:

```bash
jaspr build
```

The output will be in the `build/jaspr/` directory.

## Project structure

- `content/`: Contains all static content (Markdown, YAML, JSON).
  This is where most site data lives.
- `lib/`: The core Dart source code.
  - `pages/`: Route-level components,
     such as `home_page.dart` and `consultants_page.dart`.
  - `components/`: Reusable UI components.
  - `layouts/`: Website templates and page layouts,
     such as `default_layout.dart`.
  - `models/`: Data models for content.
  - `data/`: Dart-native data providers and constants.
- `assets/`: Static assets like images and styles.
- `web/`: Web-specific entry points and configuration.
