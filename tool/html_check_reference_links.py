import re
import sys
from pathlib import Path
from sys import argv


def check_path(path):
    bad_files = {}

    for file in Path(path).rglob("*.html"):
        with file.open(encoding="utf8") as f:
            html = f.read()

        # remove code blocks
        html = re.sub(r"<pre.*?</pre>", "", html, flags=re.DOTALL)

        # remove such lines:
        # [foo][bar] Pull request title
        html = re.sub(
            r'<p><a href="https://github.com/.*?/pull/\d+">\d+</a> .*?</p>',
            "",
            html,
        )

        # https://github.github.com/gfm/#reference-link
        if m := re.findall(r"\[[^\[\]]+]\[[^\[\]]*]", html):
            bad_files[file.relative_to(path).as_posix()] = m

    return bad_files


if __name__ == "__main__":
    res = check_path(argv[1] if len(argv) >= 2 else input())
    prefix = argv[2] if len(argv) >= 3 else ""

    for i, kv in enumerate(res.items()):
        k, v = kv
        print(i)
        print(prefix + k)
        print(*v, sep="\n")
        print()

    if res:
        sys.exit(-1)
