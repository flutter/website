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

    final dataKey = node.attributes['data'] ?? 'flutter_bench_task_example';
    final rootLabel = node.attributes['rootLabel'];

    final pages = node.children
        ?.whereType<ElementNode>()
        .where((n) => n.tag == 'IdePage')
        .toList(growable: false) ?? [];

    final customContents = <String, Component>{};
    for (final page in pages) {
      final id = page.attributes['id'];
      if (id != null) {
        customContents[id] = builder.build(page.children);
      }
    }

    return Builder(
      builder: (context) {
        final rawData = context.page.data[dataKey];
        if (rawData == null) {
          throw ArgumentError('No page data found for "$dataKey".');
        }

        final roots = DashIdeExplorer.parseRoots(rawData, rootLabel: rootLabel);

        return div(classes: 'flutter-bench-task-explorer', [
          IdeExplorer(
            roots: roots,
            customContents: customContents,
          ),
        ]);
      },
    );
  }
}
