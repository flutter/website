import re
import sys
import yaml
from pathlib import Path
from sys import argv


def check_files(folder):
    bad_links = {}

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
        if m := re.findall(r"\[[^\[\]]+]\[[^\[\]]*]", html):
            bad_links[file.relative_to(folder).as_posix()] = m

    return bad_links


def read_config_url():
    with open("../_config.yaml", "r") as stream:
        try:
            loaded_yaml = yaml.safe_load(stream)
            return loaded_yaml["url"]
        except yaml.YAMLError:
            return None


if __name__ == "__main__":
    # Check all files under the provided path,
    # which is typically "_site" according to the "Makefile".
    result = check_files("_site")

    # Obtain site url as the prefix.
    site_url = read_config_url()

    # Print all invalid links and which page they're located at.
    for i, kv in enumerate(result.items()):
        path, link = kv
        print(i + 1)
        print(site_url + path)
        print(*link, sep="\n")
        print()

    if result:
        sys.exit(-1)
