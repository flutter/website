{% assign os=include.os %}
{% assign terminal=include.terminal %}
{% case target %}
{% when 'mobile-ios' %}
   {% assign v-target = 'iOS' %}
{% when 'mobile-android' %}
   {% assign v-target = 'Android' %}
{% else %}
   {% assign v-target = target %}
{% endcase %}

## Install the Flutter SDK

To install the Flutter SDK, you can use the VS Code Flutter extension
or download and install the Flutter bundle yourself.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="flutter-install" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="true">Use VS Code to install</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="download-tab" href="#download" role="tab" aria-controls="download" aria-selected="false">Download and install</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="vscode" role="tabpanel" aria-labelledby="vscode-tab" markdown="1">

{% include docs/install/flutter/vscode.md os=os terminal=terminal target=v-target %}

</div>

<div class="tab-pane" id="download" role="tabpanel" aria-labelledby="download-tab" markdown="1">

{% include docs/install/flutter/download.md os=os terminal=terminal target=v-target%}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

If you have installed all prerequisites and the Flutter SDK,
you should be able to start developing Flutter on
{{os}} for {{v-target}}.
