import { getPageInfo } from './utils/get-page-info.js';
import { slugify } from "./utils/slugify.js";
import { fromHtml } from 'hast-util-from-html';
import { selectAll } from 'hast-util-select';
import { toText } from 'hast-util-to-text';
import { escapeHtml } from 'markdown-it/lib/common/utils.mjs';
import { UserConfig } from '@11ty/eleventy';

export function registerFilters(eleventyConfig: UserConfig): void {
  eleventyConfig.addFilter('childPagesOf', function (pages: any[], pageUrl: string) {
    return pages.filter((page) => page.url.includes(pageUrl) && page.url !== pageUrl);
  });

  eleventyConfig.addFilter('throwError', function (error: string | null): never {
    // TODO(parlough): See if more context can be added to this error
    //   or if there's a better built-in solution.
    throw new Error(error);
  });

  eleventyConfig.addFilter('filterByProperty', _filterByProperty);
  eleventyConfig.addFilter('regexReplace', _regexReplace);
  eleventyConfig.addFilter('toISOString', _toISOString);
  eleventyConfig.addFilter('toSimpleDate', _toSimpleDate);
  eleventyConfig.addFilter('activeNavForPage', _activeNavForPage);
  eleventyConfig.addFilter('arrayToSentenceString', _arrayToSentenceString);
  eleventyConfig.addFilter('generateToc', _generateToc);
  eleventyConfig.addFilter('breadcrumbsForPage', _breadcrumbsForPage);
  eleventyConfig.addFilter('slugify', slugify);
  eleventyConfig.addFilter('camelCaseBreaker', _camelCaseBreaker);
  eleventyConfig.addFilter('startsWith', _startsWith);
}

function _filterByProperty(
  items: (object | Map<any, any>)[],
  property: string,
  valueToCompareTo: any,
  useIncludes: boolean = false,
): any[] {
  return items.filter(function (item) {
    const value = item[property];
    if (value === null) return false;

    if (useIncludes) {
      return value.includes(valueToCompareTo);
    }

    return value === valueToCompareTo;
  });
}

function _startsWith(content: string, prefix: string): boolean {
  if (typeof content !== 'string' || typeof prefix !== 'string') {
    return false;
  }

  return content.startsWith(prefix);
}

function _camelCaseBreaker(stringToBreak: string): string {
  // Only consider non-empty text.
  if (!stringToBreak
      || typeof stringToBreak !== 'string'
      || stringToBreak.length === 0) {
    return stringToBreak;
  }

  const firstCharacter = stringToBreak[0];
  const restOfString = stringToBreak.substring(1);

  // Replace all capital letters in the rest of the string with <wbr> + letter.
  const processedRest =
      restOfString.replace(/([A-Z])/g, '<wbr>$&');

  return firstCharacter + processedRest;
}

/**
 * Replace text in {@link input} that matches the specified {@link regex}
 * with the specified {@link replacement}.
 *
 * @param input
 * @param regex
 * @param replacement
 * @return The resulting string with the replacement made.
 */
function _regexReplace(input: string, regex: RegExp, replacement: string = ''): string {
  return input.toString().replace(new RegExp(regex), replacement);
}

/**
 * Convert a {@link Date} to an ISO string.
 *
 * Used to add date information to the sitemap.
 *
 * @param input The date to convert
 * @return The ISO string
 */
function _toISOString(input: string | Date): string {
  if (input instanceof Date) {
    return input.toISOString();
  }

  // If it's not a Date object, assume it's already in string format.
  return input;
}

function _toSimpleDate(input: string | Date): string {
  let dateString: string;
  if (input instanceof Date) {
    dateString = input.toISOString();
  } else {
    // If it's not a Date object, assume it's already in string format.
    dateString = input;
  }
  return dateString.split('T')[0];
}

function _activeNavForPage(pageUrlPath: string, activeNav: any) {
  // Split the path for this page, dropping everything before the path:
  // Example: docs.flutter.dev/cookbook/networking/update-data ->
  // [cookbook, networking, update-data]
  const parts = pageUrlPath.toLowerCase().split('/').slice(1);
  let currentPathPairs = activeNav;
  let lastAllowedBackupActive = [];

  parts.forEach(part => {
    // If the current entry has active data,
    // allow its active data to be a backup if a later path isn't found.
    const currentEntryActiveData = currentPathPairs['active'];
    if (currentEntryActiveData) {
      lastAllowedBackupActive = currentEntryActiveData;
    }

    const paths = currentPathPairs['paths'];

    // If the current entry has children paths, explore those next.
    if (paths) {
      currentPathPairs = paths;
    }

    // Get the data for the next part.
    const nextPair = currentPathPairs[part];

    // If the next part of the path doesn't have data,
    // use the active data for the current backup.
    if (nextPair === undefined || nextPair === null) {
      return lastAllowedBackupActive;
    }

    currentPathPairs = nextPair;
  });

  // If the last path part has active data, use that,
  // otherwise fall back to the backup active data.
  let activeEntries = currentPathPairs['active'];
  if (activeEntries === undefined || activeEntries === null) {
    activeEntries = lastAllowedBackupActive;
  }

  return activeEntries;
}

function _arrayToSentenceString(list: string[], joiner = 'and'): string {
  if (!list || list.length === 0) {
    return '';
  }

  if (list.length === 1) {
    return list[0];
  }

  let result = '';

  for (let i = 0; i < list.length; i++) {
    const item = list[i];
    if (i === list.length - 1) {
      result += `${joiner} ${item}`;
    } else {
      result += `${item}, `;
    }
  }

  return result;
}

function _generateToc(contents: string) {
  // TODO(parlough): Speed this up.
  //   Perhaps do the processing before HTML rendering?
  //   Maybe shouldn't be a filter.
  const dom = fromHtml(contents, {fragment: true});
  const headers = selectAll('h2, h3', dom);
  if (headers.length < 1) {
    // If there's only one header, there's no point of a TOC.
    return null;
  }
  let currentH2: {text: string, id: string, children: {text: string, id: string}[]} | null = null;
  const builtToc = [];
  let count = 0;
  for (const header of headers) {
    const id = header.properties['id'];
    // Header can't be linked to without an ID.
    if (!id || typeof id !== 'string' || id === '') {
      continue;
    }

    // Don't include if no_toc is specified as a class on the header.
    if ((header.properties['className'] as string | null)?.includes('no_toc')) {
      continue;
    }

    // Remove the # added by markdown-it-anchor,
    // as that's not needed in the TOC.
    // Also escape any HTML, such as arrow brackets.
    const text = escapeHtml(toText(header).replace(/#$/, '').trim());

    if (header.tagName === 'h2') {
      currentH2 = { text: text, id: `#${id}`, children: [] };
      builtToc.push(currentH2);
      count += 1;
    } else if (header.tagName === 'h3') {
      // A level-3 header must be under a level-2 header.
      if (currentH2 === null) {
        throw new Error(`The h3 header "${id}" must be under an h2.`);
      }

      currentH2.children.push({ text: text, id: `#${id}` });
      count += 1;
    }
  }

  return {
    toc: builtToc,
    count: count,
  };
}

function _breadcrumbsForPage(page: any): {title: string, url: string}[] {
  const breadcrumbs = [];

  // Retrieve the liquid data for this page.
  let data = this.context.environments;

  while (page) {
    const urlSegments = (page.url as string)
        .split('/')
        .filter((segment) => segment.length > 0);

    breadcrumbs.push({
      title: data['breadcrumb'] ?? data['short-title'] ?? data.title,
      url: page.url,
    });

    if (urlSegments.length <= 1) {
      // If this only has one segment, it's the root page
      // and has no more parents, so don't continue on.
      break;
    } else {
      // Combine everything but the current segment to find the parent URL.
      const parentUrl = `/${urlSegments.slice(0, -1).join('/')}/`;
      // Search for a parent page with the specified URL.
      const parentPage = getPageInfo(data.collections.all, parentUrl);

      // Store the page information and other data of the parent page.
      // If no parent page exists, the breadcrumb loop won't continue.
      page = parentPage?.page;
      data = parentPage?.data;
    }
  }

  // We added the current page first, then found the ancestors,
  // so reverse since the last ancestor should be to the left.
  return breadcrumbs.reverse();
}
