import { getPageInfo } from './utils/get-page-info.js';
import { fromHtml } from 'hast-util-from-html';
import { selectAll } from 'hast-util-select';
import { toText } from 'hast-util-to-text';
import { escapeHtml } from 'markdown-it/lib/common/utils.mjs';

export function registerFilters(eleventyConfig) {
  eleventyConfig.addFilter('children_pages', function (pages, pageUrl) {
    return pages.filter((page) => page.url.includes(pageUrl) && page.url !== pageUrl);
  });

  // TODO(parlough): Make this more generic.
  eleventyConfig.addFilter('widget_filter', function (widgets, field, subName) {
    return widgets.filter((comp) => comp[field]?.includes(subName) ?? false);
  });

  eleventyConfig.addFilter('throw_error', function (error) {
    // TODO(parlough): See if more context can be added to this error
    //   or if there's a better built-in solution.
    throw new Error(error);
  });

  eleventyConfig.addFilter('regex_replace', regexReplace);
  eleventyConfig.addFilter('toISOString', toISOString);
  eleventyConfig.addFilter('toSimpleDate', toSimpleDate);
  eleventyConfig.addFilter('active_nav_for_page', activeNavForPage);
  eleventyConfig.addFilter('array_to_sentence_string', arrayToSentenceString);
  eleventyConfig.addFilter('generate_toc', generateToc);
  eleventyConfig.addFilter('breadcrumbsForPage', breadcrumbsForPage);
}

/**
 * Replace text in {@link input} that matches the specified {@link regex}
 * with the specified {@link replacement}.
 *
 * @param {string} input
 * @param {RegExp} regex
 * @param {string} replacement
 * @return {string} The resulting string with the replacement made.
 */
function regexReplace(input, regex, replacement = '') {
  return input.toString().replace(new RegExp(regex), replacement);
}

/**
 * Convert a {@link Date} to an ISO string.
 *
 * Used to add date information to the sitemap.
 *
 * @param {string|Date} input The date to convert
 * @return {string} The ISO string
 */
function toISOString(input) {
  if (input instanceof Date) {
    return input.toISOString();
  } else {
    // If it's not a Date object, assume it's already in string format.
    return input;
  }
}

function toSimpleDate(input) {
  let dateString;
  if (input instanceof Date) {
    dateString = input.toISOString();
  } else {
    // If it's not a Date object, assume it's already in string format.
    dateString = input;
  }
  return dateString.split('T')[0];
}

function activeNavForPage(pageUrlPath, activeNav) {
  // Split the path for this page, dropping everything before the path:
  // Example: docs.flutter.dev/cookbook/networking/update-data ->
  // [cookbook, networking, update-data]
  const parts = pageUrlPath.toLowerCase().split('/').slice(1);
  let currentPathPairs = activeNav;
  let lastAllowedBackupActive = [];

  parts.forEach(part => {
    // If the current entry allows children and has active data,
    // allow its active data to be a backup if a later path is not found.
    const currentEntryActiveData = currentPathPairs['active'];
    if (currentEntryActiveData &&
        currentPathPairs['allow-children'] === true) {
      lastAllowedBackupActive = currentEntryActiveData;
    }

    const paths = currentPathPairs['paths'];

    // If the current entry has children paths, explore those next.
    if (paths) {
      currentPathPairs = paths;
    }

    // Get the data for the next part.
    const nextPair = currentPathPairs[part];

    // If the next part of the path does not have data,
    // use the active data for the current backup.
    if (nextPair === undefined || nextPair === null) {
      return lastAllowedBackupActive;
    }

    currentPathPairs = nextPair;
  });

  // If the last path part has active data, use that,
  // otherwise fallback to the backup active data.
  let activeEntries = currentPathPairs['active'];
  if (activeEntries === undefined || activeEntries === null) {
    activeEntries = lastAllowedBackupActive;
  }

  return activeEntries;
}

function arrayToSentenceString(list, joiner = 'and') {
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

function generateToc(contents) {
  // TODO(parlough): Speed this up.
  //   Perhaps do the processing before HTML rendering?
  //   Maybe shouldn't be a filter.
  const dom = fromHtml(contents);
  const headers = selectAll('h2, h3', dom);
  if (headers < 1) {
    // If there is only one header, there is no point of a TOC.
    return null;
  }
  let currentH2 = null;
  const builtToc = [];
  let count = 0;
  for (const header of headers) {
    const id = header.properties['id'];
    // Header can't be linked to without an ID.
    if (!id || id === '') {
      continue;
    }

    // Don't include if no_toc is specified as a class on the header.
    if (header.properties['className']?.includes('no_toc')) {
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

function breadcrumbsForPage(page) {
  const breadcrumbs = [];

  // Retrieve the liquid data for this page.
  let data = this.context.environments;

  while (page) {
    const urlSegments = page.url
        .split('/')
        .filter((segment) => segment.length > 0);

    breadcrumbs.push({
      title: data['breadcrumb'] ?? data['short-title'] ?? data.title,
      url: page.url,
    });

    if (urlSegments.length <= 1) {
      // If this only has one segment, it is the root page
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
