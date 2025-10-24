// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// An iframe-embedded DartPad that can be injected into a web page,
/// then have its source code updated.
final class EmbeddedDartPad extends StatefulComponent {
  /// The unique identifier that's used to identify the created DartPad iframe.
  ///
  /// This ID is used both as the HTML element `id` and
  /// as the iframe's `name` attribute for message targeting.
  final String iframeId;

  /// The full URL of the DartPad iframe including
  /// all path segments and query parameters.
  final String _iframeUrl;

  /// The Dart source code to be displayed in the embedded DartPad's editor.
  ///
  /// The [code] should generally be valid Dart code for
  /// the latest stable versions of Dart and Flutter.
  final String code;

  /// Creates an embedded DartPad instance with
  /// the specified [iframeId] and [iframeUrl].
  EmbeddedDartPad._({
    required this.iframeId,
    required String iframeUrl,
    required this.code,
  }) : _iframeUrl = iframeUrl;

  /// Creates a new embedded DartPad element with the specified configuration.
  ///
  /// The [iframeId] is used to identify the created DartPad iframe.
  /// It must be unique within the document and a valid HTML element ID.
  ///
  /// The [scheme] and [host] are used to construct the DartPad iframe URL.
  /// [scheme] defaults to 'https' and [host] defaults to 'dartpad.dev'.
  ///
  /// To control the appearance of the embedded DartPad,
  /// you can switch to the [embedLayout] and choose a specific [theme].
  ///
  /// The [code] is the Dart source code to be injected into the DartPad editor
  /// after it has finished loading.
  factory EmbeddedDartPad.create({
    required String iframeId,
    String? scheme,
    String? host,
    bool? embedLayout,
    bool runAutomatically = false,
    DartPadTheme? theme = DartPadTheme.auto,
    required String code,
  }) {
    final dartPadUrl = Uri(
      scheme: scheme ?? 'https',
      host: host ?? 'dartpad.dev',
      queryParameters: <String, String>{
        if (embedLayout ?? true) 'embed': '$embedLayout',
        if (theme != DartPadTheme.auto) 'theme': '$theme',
        if (runAutomatically) 'run': 'true',
      },
    ).toString();

    return EmbeddedDartPad._(
      iframeId: iframeId,
      iframeUrl: dartPadUrl,
      code: code,
    );
  }

  @override
  State createState() => _EmbeddedDartPadState();
}

class _EmbeddedDartPadState extends State<EmbeddedDartPad> {
  final GlobalNodeKey<web.HTMLIFrameElement> _iframeKey = GlobalNodeKey();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // Start listening for the 'ready' message from the embedded DartPad.
      late final JSExportedDartFunction readyHandler;
      readyHandler = (web.MessageEvent event) {
        if (event.data case _EmbedReadyMessage(type: 'ready', :final sender?)) {
          // Verify the message is sent from the corresponding iframe, in case
          // there are multiple DartPads being embedded at the same time.
          if (sender != component.iframeId) {
            return;
          }

          web.window.removeEventListener('message', readyHandler);
          if (_initialized) return;
          _initialized = true;
          _updateCode();
        }
      }.toJS;

      web.window.addEventListener('message', readyHandler);
    }
  }

  @override
  void didUpdateComponent(covariant EmbeddedDartPad oldComponent) {
    super.didUpdateComponent(oldComponent);

    if (oldComponent.iframeId != component.iframeId) {
      throw StateError(
        'The iframeId of an EmbeddedDartPad cannot be changed after creation.',
      );
    }
    if (oldComponent._iframeUrl != component._iframeUrl) {
      throw StateError(
        'The iframeUrl of an EmbeddedDartPad cannot be changed after creation.',
      );
    }

    if (oldComponent.code != component.code && _initialized) {
      _updateCode();
    }
  }

  /// Updates the source code displayed in the embedded DartPad's editor
  /// with the specified Dart [code].
  void _updateCode() {
    assert(_initialized, 'Cannot update code before iframe is initialized.');
    assert(_iframeKey.currentNode != null, 'Iframe element is not available.');

    _iframeKey.currentNode!.contentWindowCrossOrigin?.postMessage(
      _MessageToDartPad.updateSource(component.code),
      _anyTargetOrigin,
    );
  }

  @override
  Component build(BuildContext context) {
    return iframe(
      key: _iframeKey,
      id: component.iframeId,
      name: component.iframeId,
      src: component._iframeUrl,
      loading: MediaLoading.lazy,
      allow: 'clipboard-write',
      [],
    );
  }
}

/// The themes available for an embedded DartPad instance.
enum DartPadTheme {
  /// Light theme with a bright background.
  light,

  /// Dark theme with a dark background.
  dark,

  /// Theme that relies on DartPad's built-in theme handling.
  auto,
}

/// The target origin to be used for cross-frame messages sent to
/// the DartPad iframe's content window.
///
/// Uses '*' to enable communication with DartPad instances
/// regardless of their actual origin.
final JSString _anyTargetOrigin = '*'.toJS;

/// Represents a ready message received from the DartPad iframe.
///
/// Sent by DartPad when it has finished loading and is ready to
/// receive code updates by sending it a cross-frame message.
extension type _EmbedReadyMessage._(JSObject _) {
  /// The message type, which should be 'ready' for initialization messages.
  external String? get type;

  /// The sender ID to identify which DartPad instance sent the message.
  external String? get sender;
}

/// Represents DartPad's expected format for receiving cross-frame messages
/// from its parent window, usually the [EmbeddedDartPad] host.
@anonymous
extension type _MessageToDartPad._(JSObject _) implements JSObject {
  /// Creates a JavaScript object with the expected structure for
  /// updating the source code in an embedded DartPad's editor.
  external factory _MessageToDartPad._updateSource({
    required String sourceCode,
    String type,
  });

  /// Creates a message to update that can be sent to
  /// update the source code in an embedded DartPad instance.
  ///
  /// The [sourceCode] should generally be valid Dart code for
  /// the latest stable versions of Dart and Flutter.
  factory _MessageToDartPad.updateSource(String sourceCode) =>
      _MessageToDartPad._updateSource(
        sourceCode: sourceCode,
        type: 'sourceCode',
      );
}
