// This is the light mode version of the
// syntax highlighting theme for code blocks on the website.
// It's imported and used by `src/_11ty/plugins/highlight.js`.
export default {
  name: 'dash-light',
  colors: {
    'editor.background': '#F8F9FA',
    'editor.foreground': '#222222',
  },
  tokenColors: [
    {
      settings: {
        background: '#F8F9FA',
        foreground: '#222222',
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
        foreground: '#222222',
      },
    },
    {
      scope: ['comment', 'punctuation.definition.comment'],
      settings: {
        foreground: '#6E6E70',
      },
    },
    {
      scope: 'constant',
      settings: {
        foreground: '#11796D',
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
        foreground: '#D43324',
      },
    },
    {
      scope: [
        'keyword.operator',
        'string.interpolated.expression',
        'constant.character.escape',
      ],
      settings: {
        foreground: '#222222',
      },
    },
    {
      scope: ['string', 'string.interpolated', 'punctuation.definition.string'],
      settings: {
        foreground: '#11796D',
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
        foreground: '#222222',
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
