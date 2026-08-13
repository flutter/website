import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/ide_explorer.dart';


/// Wraps [IdeExplorer] component
final class FlutterBenchTaskExplorer extends CustomComponent {
  const FlutterBenchTaskExplorer() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag != 'FlutterBenchTaskExplorer') {
      return null;
    }

    final customContents = <String, Component>{};
    final roots = DashIdeExplorer.parseRootsFromNode(
      node,
      builder,
      customContents,
      rootLabel: node.attributes['rootLabel'],
    );

    if (roots.isEmpty && node.attributes['data'] != null) {
      final dataKey = node.attributes['data']!;
      return Builder(
        builder: (context) {
          final rawData = context.page.data[dataKey];
          if (rawData == null) {
            throw ArgumentError('No page data found for "$dataKey".');
          }

          final parsedRoots = DashIdeExplorer.parseRoots(
            rawData,
            rootLabel: node.attributes['rootLabel'],
          );

          return div(classes: 'flutter-bench-task-explorer', [
            IdeExplorer(
              roots: parsedRoots,
              customContents: customContents,
            ),
          ]);
        },
      );
    }

    return div(classes: 'flutter-bench-task-explorer', [
      IdeExplorer(
        roots: roots,
        customContents: customContents,
      ),
    ]);
  }
}
