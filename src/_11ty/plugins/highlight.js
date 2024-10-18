import {getSingletonHighlighter} from 'shiki';
import dashDarkTheme from '../syntax/dash-dark.js';
import dashLightTheme from '../syntax/dash-light.js';

const _terminalLanguages = {
  'console': '$',
};

/**
 * Replaces the markdown-it code block renderer with our own that:
 *
 * - Parses arguments on the code block meta string.
 * - Uses passed arguments to add a title, show line numbers,
 *   highlight lines, etc.
 * - Wraps the code block in a custom structure for title formatting,
 *   copy buttons, etc.
 * - Syntax highlights the contents according to the specified language
 *   using the shiki package that uses TextMate grammars
 *   and Code -OSS themes.
 *
 * @param {import('markdown-it/lib').MarkdownIt} markdown The markdown-it instance to
 *   configure syntax highlighting for.
 */
export async function configureHighlighting(markdown) {
  const highlighter = await getSingletonHighlighter({
    langs: [
      'dart',
      'yaml',
      'json',
      'swift',
      'css',
      'html',
      'xml',
      'js',
      'objc',
      'bash',
      'kotlin',
      'java',
      'md',
      'diff',
      'ps',
      'console',
      'cmd',
      'plaintext',
      'groovy',
      'properties',
      'ruby',
      'c',
      'cpp',
      'csharp',
      'cmake',
    ],
    themes: [dashLightTheme, dashDarkTheme],
  });

  markdown.renderer.rules.fence = function (tokens, index) {
    const token = tokens[index];

    const splitTokenInfo = token.info.match(/(\S+)\s?(.*?)$/m);

    if (!splitTokenInfo) {
      throw new Error('Code block missing language specifier.');
    }

    const language = splitTokenInfo.length > 1 ? splitTokenInfo[1] : '';
    const attributes = splitTokenInfo.length > 2 ? splitTokenInfo[2] : '';

    return _highlight(
      markdown,
      highlighter,
      token.content,
      language,
      attributes,
    );
  };
}

/**
 * Highlights the specified {@link content} string, makes replacements,
 * and makes modifications to the output structure based on the
 * passed in {@link attributeString}.
 *
 * @param {import('markdown-it/lib').MarkdownIt} markdown The markdown-it instance.
 * @param {import('shiki').Highlighter} highlighter The shiki highlighter
 *   configured with the correct theme(s) and languages.
 * @param {string} content The content to syntax highlight.
 * @param {string} language The language of the content.
 * @param {string} attributeString The string containing configuration.
 * @returns {string} The processed/highlighted content rendered as HTML.
 * @private
 */
function _highlight(
  markdown,
  highlighter,
  content,
  language,
  attributeString,
) {
  const attributes = _parseAttributes(attributeString);

  // Specially handle DartPad snippets so that inject_embed can convert them.
  if (language.includes('dartpad')) {
    const theme = attributes['theme'] ?? 'light';
    const title = attributes['title'] ?? 'Runnable Flutter sample';
    const height = attributes['height'];
    const runAutomatically = attributes['run'] ?? 'false';
    return `<pre><code data-dartpad="true" data-embed="true" data-theme="${theme}" title="${title}" data-run="${runAutomatically}"${height != null ? `data-height="${height}"` : ''}>${markdown.utils.escapeHtml(content)}</code></pre>`;
  }

  const showLineNumbers = 'showLineNumbers' in attributes;
  let startingLineNumber = 0;
  if (showLineNumbers) {
    const specifiedLineNumber = attributes['showLineNumbers'];
    if (specifiedLineNumber != null) {
      startingLineNumber = parseInt(specifiedLineNumber, 10);
      if (isNaN(startingLineNumber)) {
        throw new Error('showLineNumbers must equal a number!');
      }
    }
  }

  const highlightLines = attributes['highlightLines'];
  const linesToHighlight = highlightLines
    ? _parseNumbersAndRanges(highlightLines)
    : new Set();

  const isDiff = 'diff' in attributes;
  const addedLines = new Set();
  const removedLines = new Set();
  if (isDiff) {
    if (showLineNumbers) {
      throw new Error('showLineNumbers and diff are not supported on the same code block yet.');
    }

    const lines = content.split('\n');
    for (let lineIndex = 0; lineIndex < lines.length; lineIndex += 1) {
      const line = lines[lineIndex];

      switch (line.charAt(0)) {
        case '+':
          addedLines.add(lineIndex + 1);
          break;
        case '-':
          removedLines.add(lineIndex + 1);
          break;
      }

      lines[lineIndex] = line.substring(2);
    }

    content = lines.join('\n');
  }

  const dartpadGistId = attributes['dartpad'];
  const noHighlight = 'noHighlight' in attributes;

  // Find the spans enclosed in `[!` and `!]` that we should mark
  // and remove them from the text.
  const {updatedText, linesToMarkedRanges} =
      noHighlight ? {
            updatedText: content,
            linesToMarkedRanges: {},
          } :
          _findMarkedTextAndUpdate(content);

  // Update the content with the markers removed and
  // with any extra whitespace trimmed off the end.
  content = updatedText.trimEnd();

  return highlighter.codeToHtml(content, {
    lang: language,
    themes: {
      light: 'dash-light',
      dark: 'dash-dark',
    },
    transformers: [
      {
        pre(preElement) {
          // Remove hard coded background color and text color if present.
          delete preElement.properties['style'];

          if (showLineNumbers) {
            preElement.properties['class'] += ' show-line-numbers';
          }

          if (dartpadGistId && dartpadGistId.length > 5) {
            preElement.properties['data-dartpad-id'] = dartpadGistId;
          }

          const bodyChildren = [preElement];

          if (!['plaintext', 'console', 'ps', 'diff', 'powershell'].includes(language)) {
            const languageText = _createSpanWithText(language, {
              class: 'code-block-language',
              title: `Language ${language}`,
            });
            bodyChildren.unshift(languageText);
          }

          // Create a div container to wrap the pre element.
          const blockBody = {
            type: 'element',
            tagName: 'div',
            children: bodyChildren,
            properties: {
              class: 'code-block-body',
            },
          };

          // Add a tag class and element if a tag is specified,
          // such as `good` or `bad` in Effective Dart.
          const extraTag = attributes['tag'];
          if (extraTag) {
            blockBody.properties['class'] += ` has-tag tag-${extraTag}`;

            const tagText =
              {
                good: 'good',
                bad: 'bad',
                'passes-sa': '\u2714  static analysis: success',
                'fails-sa': '\u2717  static analysis: failure',
                'runtime-sa': '\u2714  runtime: success',
                'runtime-fail': '\u2717  runtime: failure',
              }[extraTag] ?? extraTag;

            const extraTagContent = _createSpanWithText(tagText, {
              class: 'code-block-tag',
            });

            bodyChildren.unshift(extraTagContent);
          }

          const wrapperChildren = [];

          // Add a title if specified, often used for filenames.
          const title = attributes['title'];
          if (title && title !== '') {
            const titleElement = {
              type: 'element',
              tagName: 'div',
              children: [{ type: 'text', value: title }],
              properties: {
                class: 'code-block-header',
              },
            };

            wrapperChildren.push(titleElement);
          }

          wrapperChildren.push(blockBody);

          // Create a div to wrap everything including the title/filename bar.
          const wrapper = {
            type: 'element',
            tagName: 'div',
            children: wrapperChildren,
            properties: {
              class: `code-block-wrapper language-${language}`,
            },
          };

          // Replace the pre element with our own wrapper.
          return wrapper;
        },
        line(lineElement, line) {
          if (showLineNumbers) {
            lineElement.properties['data-line'] = startingLineNumber + line - 1;
          }

          if (linesToHighlight.has(line)) {
            lineElement.properties['class'] += ' highlighted-line';
          } else if (addedLines.has(line)) {
            lineElement.properties['class'] += ' added-line';
          } else if (removedLines.has(line)) {
            lineElement.properties['class'] += ' removed-line';
          }

          if (lineElement.children.length < 1) return;

          if (language in _terminalLanguages) {
            // Remove terminal command marker if present.
            const firstSpan = lineElement.children[0];
            const firstText = firstSpan.children[0];
            if (firstText?.value.startsWith('$ ')) {
              // If terminal marker is present on the first span,
              // remove it and add a class to use CSS to display it.
              firstText.value = firstText.value.substring(2);
              firstSpan.properties['class'] += ' terminal-command';
            }
          }

          const highlightRange = linesToMarkedRanges[line];
          if (highlightRange) {
            // If this line has ranges to mark/highlight, do so.
            lineElement.children = _wrapMarkedText(
              lineElement.children,
              highlightRange,
            );
          }
        },
      },
    ],
  });
}

// TODO(parlough): Replace this with simpler logic.
const _attributesPattern = /([^\s=]+)(?:="([^"]*)"|=(\S+))?/g;

/**
 * Parse a space-separated attribute string, where spaces in a string literal
 * are ignored.
 *
 * @param {string} attributeString The string containing configuration.
 * @return {Object.<string, ?string>} The parsed attributes.
 * @private
 */
function _parseAttributes(attributeString) {
  const attributes = {};
  if (attributeString === '') return attributes;

  let match;
  while ((match = _attributesPattern.exec(attributeString))) {
    const key = match[1];
    attributes[key] = match[2] ?? match[3] ?? null;
  }

  return attributes;
}

/**
 * Parses a comma-separated list of numbers and ranges into a set of numbers.
 *
 * @param {string} input A comma-separated list of numbers and ranges.
 * @returns {Set<number>} All unique numbers specified in the input.
 * @private
 */
function _parseNumbersAndRanges(input) {
  const elements = input.split(',');
  /** @type {Set<number>} */
  const combinedNumbers = new Set();

  for (const element of elements) {
    const rangeParts = element.split('-');

    // If it includes a dash, it is (hopefully) a range between two numbers.
    if (rangeParts.length > 1) {
      // Split by the dash, and turn each string into a number.
      // Assume the user only included one dash.
      const start = Number.parseInt(rangeParts[0]);
      const end = Number.parseInt(rangeParts[1]);
      if (!Number.isNaN(start) && !Number.isNaN(end)) {
        for (let i = start; i <= end; i++) {
          combinedNumbers.add(i);
        }
      }
    } else {
      // It's (hopefully) just a single number.
      const number = Number.parseInt(element);
      if (!Number.isNaN(number)) {
        combinedNumbers.add(number);
      }
    }
  }

  return combinedNumbers;
}

/**
 * Wraps the text within the given list of {@link spans} with `<mark>` tags
 * based on the provided {@link ranges}.
 *
 * The spans and ranges should be
 * ordered corresponding to the source line of text.
 *
 * @param {{children: [{type: string, value: string}], type: 'element', tagName: 'span', properties: Object.<string, string>}[]} spans
 *   The list of spans to wrap the text of.
 * @param {{startIndex: number, endIndex: number}[]} ranges
 *   The ranges in the text to mark.
 * @returns {{children: [{type: string, value: string}], type: 'element', tagName: 'span', properties: Object.<string, string>}[]}
 *   A new list of spans with <mark> tags added around the specified ranges.
 */
function _wrapMarkedText(spans, ranges) {
  /**
   * The current index in the text across all spans.
   * @type {number}
   */
  let currentIndexInLine = 0;

  /**
   * The index of the current range being marked.
   * @type {number}
   */
  let currentRangeIndex = 0;

  /**
   * The new collection of spans to replace the original.
   * @type {{children: [{type: string, value: string}], type: 'element', tagName: 'span', properties: Object.<string, string>}[]}
   * */
  const updatedSpans = [];

  /**
   * The mark that will wrap the current range.
   * @type {{children: {type: string, value}[], type: string, tagName: string, properties: Object<string, string>}}
   */
  let markElement = _createEmptyMarkElement();

  for (const span of spans) {
    const [child, ...otherChildren] = span.children;
    if (otherChildren.length > 0 || child.type !== 'text') {
      throw new Error('Each span should have exactly one text child.');
    }

    /** The text within the current span. */
    const text = child.value;

    /**
     * The properties that all potentially created children should have too.
     * @type {Object.<string, string>}
     */
    const spanProperties = span.properties ?? {};

    /**
     * The current index within the current span.
     * @type {number}
     */
    let indexInCurrentSpan = 0;

    // Multiple ranges can occur within the same collection of spans,
    // or even within the same span.
    // So we need to keep track of which range we're currently searching for.
    // Use indices to loop through the ranges as it's cheaper
    // than modifying the entire array with `shift`.
    while (
      currentRangeIndex < ranges.length &&
      indexInCurrentSpan < text.length
    ) {
      const { startIndex: rangeStartIndex, endIndex: rangeEndIndex } =
        ranges[currentRangeIndex];

      /**
       * The index in relation to the start of the current span
       * where the current range starts or the index in the current span if
       * the range starts before the current index.
       * @type {number}
       */
      const relativeRangeStartIndex = Math.max(
        rangeStartIndex - currentIndexInLine,
        indexInCurrentSpan,
      );

      /**
       * The index in relation to the start of the current span
       * where the current range ends or the ending index of the current span if
       * the range ends after the current index.
       * @type {number}
       */
      const relativeEndIndex = Math.min(
        rangeEndIndex - currentIndexInLine,
        text.length,
      );

      // If `indexInCurrentSpan` is less than `relativeRangeStartIndex`,
      // all text between the two should not be marked.
      if (indexInCurrentSpan < relativeRangeStartIndex) {
        updatedSpans.push(
          _createSpanWithText(
            text.slice(indexInCurrentSpan, relativeRangeStartIndex),
            spanProperties,
          ),
        );
      }

      // If `relativeRangeStartIndex` is less than `relativeEndIndex`,
      // the text within that range should be marked.
      if (relativeRangeStartIndex < relativeEndIndex) {
        markElement.children.push(
          _createSpanWithText(
            text.slice(relativeRangeStartIndex, relativeEndIndex),
            spanProperties,
          ),
        );
      }

      /**
       * The index in the whole line of the end of the current range if
       * it has all been marked, otherwise the index in the whole line
       * of the end of the current span.
       * @type {number}
       */
      const rangeOrSpanEndIndexInLine = currentIndexInLine + relativeEndIndex;

      // If `rangeOrSpanEndIndexInLine` is greater than `rangeEndIndex`,
      // the end of the current range was in this span,
      // so it's mark element is complete.
      if (rangeOrSpanEndIndexInLine >= rangeEndIndex) {
        // Add the completed mark element for the range,
        // then move to the next range.
        updatedSpans.push(markElement);
        markElement = _createEmptyMarkElement();
        currentRangeIndex++;
      }

      // Move to the end of the current range if it was in the current span,
      // otherwise to the end of the span.
      indexInCurrentSpan = relativeEndIndex;
    }

    // If the entire span hasn't been included yet,
    // add the rest of it.
    if (indexInCurrentSpan < text.length) {
      updatedSpans.push(
        _createSpanWithText(text.slice(indexInCurrentSpan), spanProperties),
      );
    }

    // Move to the next span by adding the current span's
    // text length to the current index.
    currentIndexInLine += text.length;
  }

  return updatedSpans;
}

/**
 * Creates a new mark element with the `highlight` class and no children.
 *
 * @returns {{children: [{type: string, value}], type: string, tagName: string, properties: Object.<string, string>}}
 *  The created hast HTML element.
 * @private
 */
function _createEmptyMarkElement() {
  return {
    type: 'element',
    tagName: 'mark',
    children: [],
    properties: {
      class: 'highlight',
    },
  };
}

/**
 * Creates a new hast span element with the specified
 * inline {@link text}, and {@link properties}.
 *
 * @param {string} text The text to include in the HTML element.
 * @param {Object.<string, string>} [properties = {}] The properties to specify
 *   for the HTML element, such as class.
 * @returns {{children: [{type: string, value}], type: string, tagName: string, properties: Object.<string, string>}}
 *  The created hast HTML element.
 * @private
 */
function _createSpanWithText(text, properties = {}) {
  return {
    type: 'element',
    tagName: 'span',
    children: [{ type: 'text', value: text }],
    properties: properties,
  };
}

/**
 * Searches through the specified {@link text} and finds all instances of
 * text marked with a `[!` and `!]`.
 * Returns the start and end indices of each instance of marked text,
 * as well as the updated text with all the open and close markers removed.
 *
 * @param {string} text The text to search through and potentially update.
 * @returns {{updatedText: string, linesToMarkedRanges: Object.<number, {startIndex: number, endIndex: number}[]>}}
 *   The updated text and the indices of marked text in each line.
 * @private
 */
function _findMarkedTextAndUpdate(text) {
  const lines = text.split('\n');

  /** @type {Object.<number,{startIndex: number, endIndex: number}[]>} */
  const linesToMarkedRanges = {};
  /** @type string[] */
  const textWithMarksRemoved = [];

  for (let lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    const line = lines[lineIndex];
    let currentIndexInLine = 0;

    /**
     * The updated line with the marks (`[!` and `!]`) removed.
     * @type {string}
     */
    let updatedLine = '';

    /**
     * The ranges of marked text in the current line.
     * @type {{startIndex: number, endIndex: number}[]}
     */
    let markedRanges = [];

    while (currentIndexInLine < line.length) {
      const startIndex = line.indexOf('[!', currentIndexInLine);

      // If there are no more opening markers, add the rest of the line.
      if (startIndex === -1) {
        updatedLine += line.slice(currentIndexInLine);
        break;
      }

      const endIndex = line.indexOf('!]', startIndex);
      if (endIndex === -1) {
        throw new Error(`Invalid syntax in line ${lineIndex + 1}. 
        An opening marker was found, but no closing marker was found.`);
      }

      // Add text before marker to the updated line.
      updatedLine += line.slice(currentIndexInLine, startIndex);

      // Track the marked text range.
      markedRanges.push({
        // We haven't added the marker to the updated line yet,
        // so the start index is the length of the updated line.
        startIndex: updatedLine.length,
        // Subtract the start index from the end index to
        // get the length of the marked text,
        // then subtract 2 to account for the length of the included marker.
        endIndex: updatedLine.length + (endIndex - startIndex - 2),
      });

      // Skip the marker and add the marked text to the updated line.
      updatedLine += line.slice(startIndex + 2, endIndex);

      // Update the search start index to continue searching after the marker.
      currentIndexInLine = endIndex + 2;
    }

    // If there were marked ranges in the current line, track them.
    if (markedRanges.length > 0) {
      // Point the line number to the marked ranges.
      // Add 1 to the line index because lines start at 1, not 0.
      linesToMarkedRanges[lineIndex + 1] = markedRanges;
    }

    textWithMarksRemoved.push(updatedLine);
  }

  return {
    linesToMarkedRanges: linesToMarkedRanges,
    updatedText: textWithMarksRemoved.join('\n'),
  };
}
