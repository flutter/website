/**
 * Converts the specified text, usually header,
 * into a valid slug for URL fragments.
 *
 * @param text The text to convert
 * @returns The converted text
 */
export function slugify(text: string): string {
  if (!text || text.length === 0) {
    return text;
  }

  return text
    .toLowerCase()
    .trim()
    .replace(/\+/g, 'plus')
    .replace(/[:.]/g, '-')
    .replace(/[^\p{L}\p{N}\s:._-]/gu, '')
    .replace(/[\s-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}
