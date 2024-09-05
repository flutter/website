{% case include.target %}
{% when 'mobile-ios' %}
   {% assign v-target = 'iOS' %}
{% when 'mobile-android','mobile' %}
   {% assign v-target = 'Android' %}
{% else %}
   {% assign v-target = include.target %}
{% endcase %}

## Install the Flutter SDK

To install the Flutter SDK, you can use the VS Code Flutter extension
or download and install the Flutter bundle yourself.

{% tabs "vs-code-or-download" %}
{% tab "Use VS Code to install" %}

{% include docs/install/flutter/vscode.md os=include.os terminal=include.terminal target=v-target %}

{% endtab %}
{% tab "Download and install" %}

{% include docs/install/flutter/download.md os=include.os terminal=include.terminal target=v-target %}

{% endtab %}
{% endtabs %}
