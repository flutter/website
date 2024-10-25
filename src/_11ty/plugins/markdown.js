import markdownIt from 'markdown-it';
import markdownItContainer from 'markdown-it-container';
import markdownItDefinitionList from 'markdown-it-deflist';
import markdownItFootnote from 'markdown-it-footnote';
import markdownItAttrs from 'markdown-it-attrs';
import markdownItAnchor from 'markdown-it-anchor';
import { slugify } from '../utils/slugify.js';

/** @type {import('markdown-it/lib').MarkdownIt} */
export const markdown = (() => {
  const markdown = markdownIt({ html: true })
    .use(markdownItDefinitionList)
    .use(markdownItFootnote)
    .use(markdownItAttrs, {
      leftDelimiter: '{:',
      rightDelimiter: '}',
      allowedAttributes: ['id', 'class', /^data-.*$/],
    })
    .use(markdownItAnchor, {
      slugify: (s) => slugify(s),
      level: 2,
      tabIndex: false,
      permalink: markdownItAnchor.permalink.linkAfterHeader({
        style: 'aria-label',
        assistiveText: title => `Link to '${title}' section`,
        symbol: '#',
        class: 'heading-link',
        wrapper: ['<div class="heading-wrapper">', '</div>']
      }),
    });

  _registerAsides(markdown);
  _setUpTables(markdown);

  return markdown;
})();

/**
 * Wrap all tables in a div with `table-wrapper` class.
 *
 * @param markdown {import('markdown-it/lib').MarkdownIt} markdown
 */
function _setUpTables(markdown) {
  markdown.renderer.rules = {
    ...markdown.renderer.rules,
    table_open: function (tokens, idx, options, env, self) {
      const token = tokens[idx];
      // Render added attributes from `{:.table .table-striped}` syntax.
      return `<div class="table-wrapper">\n<table ${self.renderAttrs(token)}>\n`;
    },
    table_close: () => '</table>\n</div>',
  };
}

/**
 * Register a custom aside/admonition.
 *
 * @param {import('markdown-it/lib').MarkdownIt} markdown
 * @param id The name to use in Markdown to create the aside.
 * @param defaultTitle The title to use if no title is specified in Markdown.
 * @param icon The material icon to use in the aside.
 * @param style The classes to add to the aside.
 * @private
 */
function _registerAside(markdown, id, defaultTitle, icon, style) {
  markdown.use(markdownItContainer, id, {
    render: function (tokens, index) {
      if (tokens[index].nesting === 1) {
        const parsedArgs = /\s+(.*)/.exec(tokens[index].info);
        const title = parsedArgs?.[1] ?? defaultTitle;

        let aside = `<aside class="alert ${style}">`;
        if (title !== null) {
          aside += `<div class="alert-header">
            ${icon !== null ? `<i class="material-symbols" aria-hidden="true">${icon}</i>` : ''}
            <span>${title}</span>
          </div>`;
        }

        aside += `<div class="alert-content">`;

        return aside;
      } else {
        return '</div></aside>\n';
      }
    },
  });
}

/**
 * Registers the custom asides/admonitions used on the site.
 *
 * @param {import('markdown-it/lib').MarkdownIt} markdown
 * @private
 */
function _registerAsides(markdown) {
  _registerAside(markdown, 'note', 'Note', 'info', 'alert-info');
  _registerAside(
    markdown,
    'flutter-note',
    'Flutter note',
    'flutter',
    'alert-info',
  );
  _registerAside(
    markdown,
    'version-note',
    'Version note',
    'merge_type',
    'alert-info',
  );
  _registerAside(markdown, 'tip', 'Tip', 'lightbulb', 'alert-success');
  _registerAside(markdown, 'recommend', 'Recommended', 'bolt', 'alert-success');
  _registerAside(markdown, 'important', 'Important', 'error', 'alert-warning');
  _registerAside(
    markdown,
    'warning',
    'Warning',
    'warning',
    'alert-warning',
  );

  _registerAside(markdown, 'secondary', null, null, 'alert-secondary');
}
