/**
 * Get the 11ty info and data from the page at the specified {@link url}
 * using the 11ty collection of {@link pages}.
 *
 * @param pages The `11ty` collection of pages.
 * @param url The URL of the page to look for the data for.
 * @return The info and data of the found page.
 */
export function getPageInfo(pages: any[], url: string): any {
  const cached = _cachedPages.get(url);
  if (cached) {
    return cached;
  }

  for (const page of pages) {
    if (page.url === url) {
      _cachedPages.set(url, page);
      return page;
    }
  }
}

/**
 * A cache of page URLs to their 11ty page information and data.
 */
const _cachedPages = new Map<string, any>(); // TODO(parlough): Replace this.
