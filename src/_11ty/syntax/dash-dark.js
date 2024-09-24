// This is the dark mode version of the
// syntax highlighting theme for code blocks on the website.
// It's imported and used by `src/_11ty/plugins/highlight.js`.
export default {
  name: 'dash-dark',
  colors: {
    'editor.background': '#282c34',  // Dark grey background
    'editor.foreground': '#abb2bf',  // Light grey foreground
  },
  tokenColors: [
    {
      settings: {
        background: '#282c34',
        foreground: '#abb2bf',
      },
    },
    {
      scope: 'emphasis',
      settings: {
        fontStyle: 'italic',
      },
    },
    {
      scope: 'strong',
      settings: {
        fontStyle: 'bold',
      },
    },
    {
      scope: [
        'punctuation',
        'punctuation.separator.inheritance-clause',
        'storage.modifier.package.java',
      ],
      settings: {
        foreground: '#abb2bf',
      },
    },
    {
      scope: ['comment', 'punctuation.definition.comment'],
      settings: {
        foreground: '#5c6370',  // Slightly lighter shade of grey for comments
      },
    },
    {
      scope: 'constant',
      settings: {
        foreground: '#98c379',  // Green for constants
      },
    },
    {
      scope: [
        'keyword',
        'storage.modifier',
        'storage.type',
        'variable.language',
      ],
      settings: {
        foreground: '#c678dd',  // Purple for keywords
      },
    },
    {
      scope: [
        'keyword.operator',
        'string.interpolated.expression',
        'constant.character.escape',
      ],
      settings: {
        foreground: '#abb2bf',
      },
    },
    {
      scope: ['string', 'string.interpolated', 'punctuation.definition.string'],
      settings: {
        foreground: '#98c379',
      },
    },
    {
      scope: [
        'entity.name.function',
        'support.function',
        'entity.other.attribute-name',
      ],
      settings: {
        foreground: '#61afef',  // Cyan for functions
      },
    },
    {
      scope: [
        'entity.name.class',
        'entity.name.type',
        'entity.name.type.class',
        'entity.name.type.enum',
        'entity.name.type.protocol',
        'support.class',
        'support.type',
        'entity.name.tag',
      ],
      settings: {
        foreground: '#e5c07b',  // Yellow for classes
      },
    },
    {
      scope: ['variable', 'variable.other'],
      settings: {
        foreground: '#abb2bf',
      },
    },
    {
      scope: 'markup.underline',
      settings: {
        fontStyle: 'underline',
      },
    },
    {
      scope: 'markup.bold',
      settings: {
        fontStyle: 'bold',
      },
    },
    {
      scope: 'markup.heading',
      settings: {
        fontStyle: 'bold',
      },
    },
    {
      scope: 'markup.italic',
      settings: {
        fontStyle: 'italic',
      },
    },
    {
      scope: 'markup.strikethrough',
      settings: {
        fontStyle: 'strikethrough',
      },
    },
  ],
};