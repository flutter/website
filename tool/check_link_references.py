import re
import sys

from pathlib import Path
from typing import Dict, List


def find_invalid_link_references(folder: str) -> Dict[str, List[str]]:
    """ Search for invalid link references in all HTML 
    files within the given directory path.
    """
    invalid_links = {}

    # Iterate all `.html`s.
    for file in Path(folder).rglob("*.html"):
        with file.open(encoding="utf8") as f:
            html = f.read()

        # Ignore blocks with TODOs:
        #
        # <!-- TODO(somebody): [Links here][are not rendered]. -->
        html = re.sub(r"<!--.*?-->", "", html, flags=re.DOTALL)

        # Ignore blocks with code:
        #
        # ```dart
        # [[highlight]]flutter[[/highlight]]
        # ```
        html = re.sub(r"<pre.*?</pre>", "", html, flags=re.DOTALL)

        # Remove PRs title that looks like a link, they're typically laid in release notes:
        #
        # <p><a href="https://github.com/flutter/engine/pull/27070">27070</a>
        # [web][felt] Fix stdout inheritance for sub-processes
        # (cla: yes, waiting for tree to go green, platform-web, needs tests)
        # </p>
        html = re.sub(
            r'<p><a href="https://github.com/.*?/pull/\d+">\d+</a> .*?</p>',
            "",
            html,
        )

        # Use regex to find all links that displayed abnormally,
        # since a valid referenced link should be an <a> tag after rendered:
        #
        #  * <p>[flutter.dev][]</p>
        #  * <p>[GitHub repo][repo]</p>
        #
        # See also:
        #  * https://github.github.com/gfm/#reference-link
        matches = re.findall(r"\[[^\[\]]+]\[[^\[\]]*]", html)
        if matches:
            invalid_links[file.relative_to(folder).as_posix()] = matches

    return invalid_links


if __name__ == "__main__":
    result = find_invalid_link_references("_site")

    if result:
        for file_path, links in result.items():
            print(f'/{file_path}')
            print(*links, '\n', sep="\n")

        sys.exit(-1)
