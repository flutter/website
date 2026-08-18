import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

@client
final class MermaidViewer extends StatefulComponent {
  const MermaidViewer({required this.diagram, super.key});

  final String diagram;

  @override
  State<MermaidViewer> createState() => _MermaidViewerState();
}

final class _MermaidViewerState extends State<MermaidViewer> {
  static int _idCounter = 0;
  final String _diagramId = 'mermaid-diagram-${_idCounter++}';

  String? _svg;
  web.MutationObserver? _themeObserver;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      context.binding.addPostFrameCallback(() {
        unawaited(_renderDiagram());
        _observeTheme();
      });
    }
  }

  @override
  void dispose() {
    _themeObserver?.disconnect();
    super.dispose();
  }

  void _observeTheme() {
    final body = web.document.body;
    if (body == null) return;

    var isDark = body.classList.contains('dark-mode');
    _themeObserver = web.MutationObserver(
      ((JSArray<web.MutationRecord> _, web.MutationObserver _) {
        final newIsDark = body.classList.contains('dark-mode');
        if (newIsDark != isDark) {
          isDark = newIsDark;
          unawaited(_renderDiagram());
        }
      }).toJS,
    );

    _themeObserver?.observe(
      body,
      web.MutationObserverInit(
        attributes: true,
        attributeFilter: ['class'.toJS].toJS,
      ),
    );
  }

  Future<void> _renderDiagram() async {
    try {
      final isDark =
          web.document.body?.classList.contains('dark-mode') ?? false;
      final theme = isDark ? 'dark' : 'default';

      // Dynamically import Mermaid ESM from CDN only when a
      // diagram component mounts
      final module = await _importMermaid();
      final mermaid = module.defaultExport;

      mermaid.initialize(
        MermaidConfig(
          startOnLoad: false.toJS,
          theme: theme.toJS,
          securityLevel: 'loose'.toJS,
        ),
      );

      final result = await mermaid
          .render(_diagramId.toJS, component.diagram.toJS)
          .toDart;

      if (mounted) {
        setState(() {
          _svg = result.svg.toDart;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to render Mermaid diagram: $e');
      }
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'mermaid-container',
      [
        if (_svg case final svg?)
          RawText(svg)
        else
          // Fallback during SSR or while loading
          pre(
            classes: 'mermaid',
            attributes: {'data-source': component.diagram},
            [.text(component.diagram)],
          ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// JS Interop Bindings (Dart 3 Extension Types)
// -----------------------------------------------------------------------------

@JS('eval')
external JSAny? _eval(JSString code);

Future<MermaidModule> _importMermaid() {
  final importFn = _eval('(url) => import(url)'.toJS) as JSFunction;
  final promise = importFn.callAsFunction(
    null,
    'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs'.toJS,
  ) as JSPromise<MermaidModule>;
  return promise.toDart;
}

extension type MermaidModule._(JSObject _) implements JSObject {
  @JS('default')
  external MermaidApi get defaultExport;
}

extension type MermaidApi._(JSObject _) implements JSObject {
  external void initialize(MermaidConfig config);
  external JSPromise<MermaidRenderResult> render(JSString id, JSString text);
}

extension type MermaidConfig._(JSObject _) implements JSObject {
  external factory MermaidConfig({
    JSBoolean? startOnLoad,
    JSString? theme,
    JSString? securityLevel,
  });
}

extension type MermaidRenderResult._(JSObject _) implements JSObject {
  external JSString get svg;
}
