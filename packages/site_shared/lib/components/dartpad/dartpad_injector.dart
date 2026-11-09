// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../utils/component_ref.dart';

/// The DartPad deployment that serves archive-backed embeds.
///
/// Only DartPad's preview deployment supports loading a project from
/// an archive URL. Switch to `dartpad.dev` once production supports it.
const _dartPadHost = 'preview.dartpad.dev';

/// Replaces a server-rendered code example with an archive-backed DartPad.
@client
class DartPadInjector extends StatefulComponent {
  const DartPadInjector({
    required this.archive,
    required this.file,
    required this.source,
    required this.title,
    this.theme,
    this.height,
    super.key,
  });

  final String archive;
  final String? file;
  final ComponentRef source;
  final String title;
  final String? theme;
  final String? height;

  @override
  State<DartPadInjector> createState() => _DartPadInjectorState();
}

class _DartPadInjectorState extends State<DartPadInjector> {
  late final Uri _archiveUri = Uri.base.resolve(component.archive);

  // A hosted iframe can't fetch a loopback URL. When serving a static build
  // locally, read its archive from the parent page's origin instead.
  late final Future<String>? _localArchive = switch (_archiveUri.host) {
    'localhost' || '127.0.0.1' || '::1' =>
      http
          .readBytes(_archiveUri)
          .then(
            (bytes) => Uri.dataFromBytes(
              bytes,
              mimeType: 'application/gzip',
            ).toString(),
          ),
    _ => null,
  };

  @override
  Component build(BuildContext context) {
    if (!kIsWeb) return _frame();
    if (_localArchive case final local?) {
      return FutureBuilder<String>(
        future: local,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _frame(message: 'Could not load the local DartPad archive.');
          }
          if (snapshot.data case final archive?) return _embed(archive);
          return _frame();
        },
      );
    }
    return _embed(_archiveUri.toString());
  }

  Component _embed(String archive) {
    final url = Uri.https(_dartPadHost, '/', {
      'embed': 'true',
      'url': archive,
      'file': ?component.file,
      if (component.theme != 'auto') 'theme': component.theme ?? 'light',
    });
    // Preview's hosting rejects request targets of 8 KiB or more.
    if (archive.startsWith('data:') &&
        url.path.length + 1 + url.query.length >= 8192) {
      return _frame(
        message:
            'Open this page on a Firebase preview channel to run this example. '
            'Its project is too large for a local DartPad URL.',
      );
    }
    return _frame(url: url);
  }

  Component _frame({Uri? url, String? message}) {
    return Component.fragment([
      div(attributes: {if (url != null) 'hidden': ''}, [component.source]),
      if (message != null) p([.text(message)]),
      if (url != null) ...[
        // Archive-backed embeds can't run on load, so prompt the reader to.
        const p(classes: 'embedded-dartpad-hint', [
          .text('Select '),
          strong([.text('Run')]),
          .text(' to start the example.'),
        ]),
        iframe(
          const [],
          classes: 'embedded-dartpad',
          src: url.toString(),
          loading: MediaLoading.lazy,
          allow: 'clipboard-write',
          attributes: {'title': component.title},
          styles: Styles(raw: {'height': ?component.height}),
        ),
      ],
    ]);
  }
}
