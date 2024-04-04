// noinspection JSUnusedGlobalSymbols
export default {
  activeNav: (data) => {
    const sidenav = data['sidenav'];

    const results = {};
    _visitPermalinks(results, sidenav, []);
    return results;
  },
};

/**
 *
 * @param results {object}
 * @param navTree {object[]}
 * @param path {number[]}
 * @private
 */
function _visitPermalinks(results, navTree, path) {
  navTree.forEach((entry, i) => {
    const permalink = entry['permalink'];
    const newPath = [...path, i + 1];

    if (typeof permalink === 'string' || permalink instanceof String) {
      _addLink(results, permalink, newPath, entry['match-page-url-exactly'] === true);
    }

    const children = entry['children'];
    if (Array.isArray(children)) {
      _visitPermalinks(results, children, newPath);
    }
  });
}

/**
 *
 * @param results {object}
 * @param permalink {string}
 * @param path {number[]}
 * @param matchPathExactly {boolean}
 * @private
 */
function _addLink(results, permalink, path, matchPathExactly = false) {
  // Skip external links.
  if (permalink.startsWith('http')) {
    return;
  }

  // Throw an error if a permalink does not start with a `/`.
  if (!permalink.startsWith('/')) {
    throw new Error(`${permalink} does not begin with a '/'`);
  }

  // Split the specified permalink into parts.
  const parts = permalink.split('/');

  // Add active nav data for the specified permalink.
  _addPart(results, path, parts, 1, matchPathExactly);
}

/**
 *
 * @param result {object}
 * @param path {number[]}
 * @param parts {string[]}
 * @param index {number}
 * @param matchPathExactly {boolean}
 * @private
 */
function _addPart(result, path, parts, index, matchPathExactly = false) {
  const isLast = index === parts.length - 1;
  let current = result[parts[index]];

  if (!current) {
    // If the current part isn't in the results map yet, add a new map.
    current = {};
    result[parts[index]] = current;
  }

  // If this is the last part of the path,
  // store the active nav data.
  if (isLast) {
    const active = current['active'];
    // Only override active nav data if
    // it doesn't already exist for this part.
    if (!active || matchPathExactly) {
      current['active'] = path;
      if (matchPathExactly) {
        current['allow-children'] = false;
      }
    }
  } else {
    if (!current['paths']) {
      current['paths'] = {};
    }

    // Continue to the next part.
    _addPart(current['paths'], path, parts, index + 1, matchPathExactly);
  }
}
