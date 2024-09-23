/**
 * Converts the specified text, usually header,
 * into a valid slug for URL fragments.
 *
 * @param text {string} The text to convert
 * @returns {string} The converted text
 */
export function slugify(text) {
  if (!text || text.length === 0) {
    return text;
  }

  return text
    .toLowerCase()
    .trim()
    .replace(/[:.]/g, '-')
    .replace(/[^\p{L}\p{N}\s:._-]/gu, '')
    .replace(/[\s-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}
