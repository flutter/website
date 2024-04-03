{% assign devos = include.devos %}

1. Allocate a minimum of 1 GB of storage for Google Chrome.
   Consider allocating 2 GB of storage for an optimal configuration.

1. Download and install the {{devos}} version of [Google Chrome][]
   to debug JavaScript code for web apps.

{% if devos == 'Linux' %}{% include docs/install/accordions/install-chrome-from-cli.md %}{% endif %}

[Google Chrome]: https://www.google.com/chrome/dr/download/
