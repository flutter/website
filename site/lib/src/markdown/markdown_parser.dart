import 'dart:collection';

import 'package:html/parser.dart' as html;
// ignore: implementation_imports
import 'package:html/src/token.dart' as html;
// ignore: implementation_imports
import 'package:html/src/tokenizer.dart' as html;
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_description_list/markdown_description_list.dart';

import '../extensions/registry.dart';
import 'alert_syntax.dart';
import 'attribute_syntax.dart';
import 'fenced_code_block_syntax.dart';
import 'header_syntax.dart';

/// The `package:markdown` block syntaxes to apply when parsing Markdown.
const List<md.BlockSyntax> _blockSyntaxes = [
  JasprHtmlBlockSyntax(),
  CustomFencedCodeBlockSyntax(),
  HeaderWithAttributesSyntax(),
  AttributeBlockSyntax(),
  AlertBlockSyntax(),
  DescriptionListSyntax(),
  md.TableSyntax(),
  md.FootnoteDefSyntax(),
  md.EmptyBlockSyntax(),
  md.BlockquoteSyntax(),
  md.HorizontalRuleSyntax(),
  md.UnorderedListSyntax(),
  md.OrderedListSyntax(),
  md.LinkReferenceDefinitionSyntax(),
  md.ParagraphSyntax(),
];

/// The `package:markdown` inline syntaxes to apply when parsing Markdown.
final List<md.InlineSyntax> _inlineSyntaxes = [
  md.InlineHtmlSyntax(),
  AttributeInlineSyntax(),
];

/// A component to use when needing to dynamically parse Markdown content and
/// render it within a different Jaspr component.
class DashMarkdown extends AsyncStatelessComponent {
  static const NodesBuilder _nodeBuilder = NodesBuilder([]);

  const DashMarkdown({
    required this.content,
    this.inline = false,
  });

  final String content;
  final bool inline;

  @override
  Future<Component> build(BuildContext context) async {
    final currentPage = context.page;
    final markdownNodes = _defaultMarkdownDocument.parse(content);
    var nodes = DashMarkdownParser.buildNodes(markdownNodes);
    for (final extension in allNodeProcessingExtensions) {
      nodes = await extension.apply(currentPage, nodes);
    }

    return _nodeBuilder.build(nodes);
  }
}

/// Creates a `package:markdown` document with our custom syntaxes configured.
md.Document get _defaultMarkdownDocument => md.Document(
  blockSyntaxes: _blockSyntaxes,
  inlineSyntaxes: _inlineSyntaxes,
  withDefaultBlockSyntaxes: false,
);

/// Uses our custom Markdown configuration and syntaxes to
/// parse the specified [markdownString] into HTML.
///
/// Assumes it's parsing at the block-level if [inline] isn't set to `true`.
String parseMarkdownToHtml(String markdownString, {bool inline = false}) {
  final nodes = inline
      ? _defaultMarkdownDocument.parseInline(markdownString)
      : _defaultMarkdownDocument.parse(markdownString);
  final renderer = md.HtmlRenderer();
  return renderer.render(nodes);
}

final RegExp _markdownFilePattern = RegExp(r'.*\.md$');

class DashMarkdownParser implements PageParser {
  const DashMarkdownParser();

  @override
  Pattern get pattern => _markdownFilePattern;

  @override
  List<Node> parsePage(Page page) {
    final markdownNodes = _defaultMarkdownDocument.parse(page.content);

    return buildNodes(markdownNodes);
  }

  static List<Node> buildNodes(Iterable<md.Node> markdownNodes) {
    final rootChildren = <Node>[];
    final root = ElementNode('_', {}, rootChildren);
    final stack = Queue<ElementNode>();
    stack.add(root);
    var currentNodes = rootChildren;

    for (final node in markdownNodes) {
      if (node is HtmlText) {
        final tokenizer = html.HtmlTokenizer(
          node.text,
          lowercaseElementName: false,
        );

        while (tokenizer.moveNext()) {
          final token = tokenizer.current;

          if (token.kind == html.TokenKind.parseError) {
            final error = (token as html.ParseErrorToken).data;
            if (error == 'expected-tag-name-but-got-question-mark') {
              // Ignore opening of processing instructions.
              continue;
            } else {
              throw AssertionError('Unexpected parse error: ${token.data}');
            }
          }

          if (token.kind == html.TokenKind.startTag) {
            final tag = (token as html.StartTagToken).name ?? '';
            final element = ElementNode(tag, {
              for (final MapEntry(:key, :value) in token.data.entries)
                key.toString(): value,
            }, []);
            currentNodes.add(element);
            final selfClosing = token.selfClosing || _isVoidElement(tag);
            if (!selfClosing) {
              stack.add(element);
              currentNodes = element.children!;
            }
          } else if (token.kind == html.TokenKind.endTag) {
            if (stack.last.tag != (token as html.EndTagToken).name) {
              // If the end tag does not match the last opened tag, ignore it.
              continue;
            }
            stack.removeLast();
            currentNodes = stack.last.children!;
          } else if (token.kind == html.TokenKind.characters ||
              token.kind == html.TokenKind.spaceCharacters) {
            currentNodes.add(TextNode((token as html.StringToken).data));
          } else if (token.kind == html.TokenKind.comment) {
            var data = (token as html.CommentToken).data;
            if (data.startsWith('?') && data.endsWith('?')) {
              data = data.substring(1, data.length - 1);
            }
            currentNodes.add(TextNode('<!--$data-->', raw: true));
          } else if (token.kind == html.TokenKind.doctype) {
            // Ignore doctype tokens.
            continue;
          }
        }
      } else if (node is md.Text) {
        currentNodes.addAll(
          HtmlParser.buildNodes(html.parseFragment(node.text).nodes),
        );
      } else if (node is md.Element) {
        final nodeChildren = node.children;
        currentNodes.add(
          ElementNode(
            node.tag,
            {
              'id': ?node.generatedId,
              ...node.attributes,
            },
            nodeChildren != null ? buildNodes(nodeChildren) : null,
          ),
        );
      }
    }

    return rootChildren;
  }
}

/// Returns whether the specified HTML [tag] corresponds to a void HTML element,
/// meaning it can't have any child nodes.
bool _isVoidElement(String tag) => const {
  'area',
  'base',
  'br',
  'col',
  'embed',
  'hr',
  'img',
  'input',
  'link',
  'meta',
  'param',
  'source',
  'track',
  'wbr',
}.contains(tag.toLowerCase());
