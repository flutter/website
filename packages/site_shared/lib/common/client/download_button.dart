// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../button.dart';

@client
class DownloadButton extends StatefulComponent {
  const DownloadButton({
    required this.name,
    super.key,
  });

  final String name;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  final buttonKey = GlobalNodeKey<web.HTMLButtonElement>();

  Future<void> saveAsFile() async {
    final content = buttonKey.currentNode
        ?.closest('.code-block-wrapper')
        ?.querySelector('pre code')
        ?.textContent
        ?.replaceAll('\u200B', ''); // Remove zero-width spaces

    if (content == null) {
      return;
    }

    if (rawShowSaveFilePicker != null) {
      try {
        final file = await showSaveFilePicker(
          SaveFilePickerOptions(
            id: 'download-project-file',
            startIn: 'documents',
            suggestedName: component.name,
            types: [
              FilePickerAcceptType(
                description: 'Dart',
                accept: {
                  'text/plain': ['.dart'],
                }.jsify(),
              ),
            ].toJS,
          ),
        ).toDart;

        final writable = await file.createWritable().toDart;
        await writable.write(content.toJS).toDart;
        await writable.close().toDart;
      } catch (_) {
        // User cancelled the picker
      }
    } else {
      // Fallback for browsers that do not support the File System API

      final blob = web.Blob(
        [content.toJS].toJS,
        web.BlobPropertyBag(type: 'text/plain'),
      );
      final objectUrl = web.URL.createObjectURL(blob);

      final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
      anchor.href = objectUrl;
      anchor.download = component.name;
      anchor.style.display = 'none';

      web.document.body?.append(anchor);
      anchor.click();

      anchor.remove();
      web.URL.revokeObjectURL(objectUrl);
    }
  }

  @override
  Component build(BuildContext context) {
    return Button(
      key: buttonKey,
      onClick: saveAsFile,
      style: ButtonStyle.filled,
      icon: 'download',
      title: 'Download file',
      content: 'Download file',
    );
  }
}

@JS('showSaveFilePicker')
external JSFunction? rawShowSaveFilePicker;

@JS()
external JSPromise<web.FileSystemFileHandle> showSaveFilePicker(
  SaveFilePickerOptions options,
);

extension type SaveFilePickerOptions._(JSObject _) implements JSObject {
  external factory SaveFilePickerOptions({
    String? id,
    String? startIn,
    String? suggestedName,
    JSArray<FilePickerAcceptType>? types,
  });
}

extension type FilePickerAcceptType._(JSObject _) implements JSObject {
  external factory FilePickerAcceptType({
    required String description,
    required JSAny? accept,
  });
}
