import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:mermaid_core/mermaid_core.dart';
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
  String? _svg;
  web.MutationObserver? _themeObserver;

  @override
  void initState() {
    super.initState();
    final isDark =
        kIsWeb && (web.document.body?.classList.contains('dark-mode') ?? false);
    _svg = _renderDiagram(isDark: isDark);

    if (kIsWeb) {
      _observeTheme();
    }
  }

  @override
  void didUpdateComponent(MermaidViewer oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.diagram != component.diagram) {
      final isDark =
          kIsWeb &&
          (web.document.body?.classList.contains('dark-mode') ?? false);
      _svg = _renderDiagram(isDark: isDark);
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
          setState(() {
            _svg = _renderDiagram(isDark: isDark);
          });
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

  String? _renderDiagram({required bool isDark}) {
    try {
      final theme =
          isDark ? MermaidTheme.darkTheme : MermaidTheme.defaultTheme;
      final mermaid = Mermaid(
        measurer: const ApproximateTextMeasurer(),
        theme: theme,
      );
      final scene = mermaid.render(component.diagram);
      return renderSceneToSvg(scene);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to render Mermaid diagram: $e');
      }
      return null;
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
