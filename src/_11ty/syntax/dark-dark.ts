// This is the dark mode version of the
// syntax highlighting theme for code blocks on the website.
// It's imported and used by `src/_11ty/plugins/highlight.ts`.
export default {
    name: 'dash-dark',
    colors: {
        'editor.background': '#242b32',
        'editor.foreground': '#dcdcdc',
    },
    tokenColors: [
        {
            settings: {
                background: '#242b32',
                foreground: '#dcdcdc',
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
                foreground: '#dcdcdc',
            },
        },
        {
            scope: ['comment', 'punctuation.definition.comment'],
            settings: {
                foreground: '#8B95A7',
            },
        },
        {
            scope: 'constant',
            settings: {
                foreground: '#1CDAC5',
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
                foreground: '#FF897E',
            },
        },
        {
            scope: [
                'keyword.operator',
                'string.interpolated.expression',
                'constant.character.escape',
            ],
            settings: {
                foreground: '#E1E2EC',
            },
        },
        {
            scope: ['string', 'string.interpolated', 'punctuation.definition.string'],
            settings: {
                foreground: '#1CDAC5',
            },
        },
        {
            scope: [
                'entity.name.function',
                'support.function',
                'entity.other.attribute-name',
            ],
            settings: {
                foreground: '#B581FF',
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
                foreground: '#6bb1ff',
            },
        },
        {
            scope: ['variable', 'variable.other'],
            settings: {
                foreground: '#E1E2EC',
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
