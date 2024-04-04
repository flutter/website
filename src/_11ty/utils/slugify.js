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
    .replace(/[^a-z0-9\s:._-]/g, '')
    .replace(/[\s-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}
