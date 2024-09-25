// This is the light mode version of the
// syntax highlighting theme for code blocks on the website.
// It's imported and used by `src/_11ty/plugins/highlight.js`.
export default {
  name: 'dash-light',
  colors: {
    'editor.background': '#ECEDF7',
    'editor.foreground': '#191C22',
  },
  tokenColors: [
    {
      settings: {
        background: '#ECEDF7',
        foreground: '#191C22',
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
        foreground: '#191C22',
      },
    },
    {
      scope: ['comment', 'punctuation.definition.comment'],
      settings: {
        foreground: '#59616E',
      },
    },
    {
      scope: 'constant',
      settings: {
        foreground: '#0C7064',
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
        foreground: '#BD2314',
      },
    },
    {
      scope: [
        'keyword.operator',
        'string.interpolated.expression',
        'constant.character.escape',
      ],
      settings: {
        foreground: '#191C22',
      },
    },
    {
      scope: ['string', 'string.interpolated', 'punctuation.definition.string'],
      settings: {
        foreground: '#0C7064',
      },
    },
    {
      scope: [
        'entity.name.function',
        'support.function',
        'entity.other.attribute-name',
      ],
      settings: {
        foreground: '#6200EE',
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
        foreground: '#0468D7',
      },
    },
    {
      scope: ['variable', 'variable.other'],
      settings: {
        foreground: '#191C22',
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
