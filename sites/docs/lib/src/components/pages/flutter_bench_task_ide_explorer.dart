import 'package:jaspr/client.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/ide_explorer.dart';

/// A custom markdown component wrapper for [IdeExplorer].
///
/// The tree is authored as data, referenced by the required `data`
/// attribute, which names a top-level key in the page's data (loaded from
/// a YAML/JSON file in the site's `src/data` directory). The data can
/// either be a single list of nodes, or a map with a `roots` list if the
/// explorer should offer more than one top-level tree (e.g. "Project" and
/// "Global", shown as tabs above the sidebar):
///
/// ```yaml
/// # A single implicit root:
/// - id: main-dart
///   label: main.dart
///   oneLiner: The app's entry point.
///   example: |
///     void main() => runApp(const MyApp());
///   exampleLanguage: dart
///
/// # Or, multiple named roots shown as tabs:
/// roots:
///   - id: project
///     label: my_app/
///     children: [ ... ]
///   - id: global
///     label: "~/"
///     children: [ ... ]
/// ```
///
/// Usage from Markdown: `<IdeExplorer data="myTreeData" />`.
class DashIdeExplorer extends CustomComponentBase {
  const DashIdeExplorer();

  @override
  Pattern get pattern => RegExp(r'^(Dash)?IdeExplorer$', caseSensitive: false);

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    final dataKey = attributes['data'];
    if (dataKey == null) {
      throw ArgumentError(
        'The <IdeExplorer> element requires a "data" attribute naming a key '
        'in the page data.',
      );
    }

    return Builder(
      builder: (context) {
        final rawData = context.page.data[dataKey];
        if (rawData == null) {
          throw ArgumentError('No page data found for "$dataKey".');
        }

        final roots = parseRoots(rawData, rootLabel: attributes['rootLabel']);

        return IdeExplorer(roots: roots);
      },
    );
  }

  /// Parses raw page data (from YAML/JSON) into a list of [IdeExplorerProjectRoot]s.
  static List<IdeExplorerProjectRoot> parseRoots(
    Object? rawData, {
    String? rootLabel,
  }) {
    if (rawData is List) {
      return [
        IdeExplorerProjectRoot(
          id: 'root',
          label: rootLabel ?? '',
          children: rawData
              .whereType<Map<Object?, Object?>>()
              .map(IdeTreeNode.fromMap)
              .toList(growable: false),
        ),
      ];
    }

    if (rawData is Map) {
      final rawRoots = rawData['roots'];
      if (rawRoots is List) {
        return rawRoots
            .whereType<Map<Object?, Object?>>()
            .map(IdeExplorerProjectRoot.fromMap)
            .toList(growable: false);
      }
    }

    throw ArgumentError(
      'Invalid <IdeExplorer> data: expected a list of nodes, or a map with '
      'a "roots" list.',
    );
  }
}
