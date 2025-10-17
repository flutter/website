import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;

import '../markdown/markdown_parser.dart';
import '../util.dart';

class ExpansionListItem {
  ExpansionListItem({
    required this.data,
    required this.content,
    required this.url,
    this.expanded = false,
    this.order = 0,
  });

  factory ExpansionListItem.fromPage(Page page) {
    final data = page.data.page;
    final content = truncateWordsMarkdown(page.content, 100);

    return ExpansionListItem(
      data: ExpansionListItemData(
        title: data['title'] as String,
        description: data['description'] as String,
        contentTags: List<String>.from(data['contentTags'] as List<dynamic>),
        iconPath: data['iconPath'] as String?,
      ),
      content: content,
      url: page.url,
      expanded: data['expanded'] as bool? ?? false,
      order: data['order'] as int? ?? 0,
    );
  }

  final ExpansionListItemData data;
  final String content;
  final String url;
  final bool expanded;
  final int order;
}

class ExpansionListItemData {
  ExpansionListItemData({
    required this.title,
    required this.description,
    required this.contentTags,
    required this.iconPath,
  });

  final String title;
  final String description;
  final List<String> contentTags;
  final String? iconPath;
}

class ExpansionList extends StatefulComponent {
  const ExpansionList({required this.baseId, this.items = const [], super.key});

  final String baseId;
  final List<ExpansionListItem> items;

  /// Loads an [ExpansionList] by finding all pages in the current context that
  /// are located in the specified [listName] directory (relative to the current
  /// page's path).
  ///
  /// Pages are sorted by their `order` frontmatter value.
  static Component load(String listName, {required String baseId}) {
    return Builder(
      builder: (context) {
        final listPath = path.join(
          path.dirname(context.page.path),
          listName + path.separator,
        );
        final items = [
          for (final page in context.pages)
            if (page.path.startsWith(listPath) && page.path.endsWith('.md'))
              ExpansionListItem.fromPage(page),
        ]..sort((a, b) => a.order.compareTo(b.order));

        return ExpansionList(
          key: ValueKey(listName),
          baseId: baseId,
          items: items,
        );
      },
    );
  }

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  @override
  Component build(BuildContext context) {
    return div(classes: 'expansion-panel-list', [
      for (final (index, item) in component.items.indexed)
        div(classes: 'expansion-panel', [
          a(
            classes: ['collapsible', if (!item.expanded) 'collapsed'].toClasses,
            href: '#${component.baseId}-expansion-$index',
            attributes: {
              'data-toggle': 'collapse',
              'data-target': '#${component.baseId}-expansion-$index',
              'role': 'button',
              'aria-expanded': item.expanded ? 'true' : 'false',
              'aria-controls': '#${component.baseId}-expansion-$index',
            },
            [
              div(classes: 'expansion-panel-title', [
                div(classes: 'expansion-panel-title-leading', [
                  if (item.data.iconPath case final iconPath?)
                    img(
                      src: iconPath,
                      alt: 'An icon showing a generic application.',
                    )
                  else
                    img(
                      src:
                          '/assets/images/docs/app-architecture/design-patterns/kv-store-icon.svg',
                      alt: 'A icon showing a generic application.',
                    ),
                ]),
                div(classes: 'expansion-panel-title-content', [
                  p(classes: 'content-title', [
                    text(item.data.title),
                  ]),
                  ul(classes: 'content-tags', [
                    for (final contentTag in item.data.contentTags)
                      li(classes: 'tag', [
                        text(contentTag),
                      ]),
                  ]),
                  p(classes: 'content-description', [
                    text(item.data.description),
                  ]),
                ]),
              ]),
            ],
          ),
          div(
            id: '${component.baseId}-expansion-$index',
            classes: [
              'expansion-panel-body collapse',
              if (item.expanded) 'show',
            ].toClasses,
            [
              DashMarkdown(content: item.content),
              p([
                a(href: item.url, [
                  text('Read full article'),
                ]),
              ]),
              // Required to add "margin" that doesn't cause expansion jank
              div(
                classes: 'separator',
                attributes: {'aria-hidden': 'true'},
                [],
              ),
            ],
          ),
        ]),
    ]);
  }
}
