<table class="samples-table table table-striped" style="border-bottom:1px #DADCE0 solid;">
    <tr class="tr-main-head" style="text-align: left">
        <th style="width: 10%"></th>
        <th style="width: 30%">Title</th>
        <th style="width: 50%">Description</th>
        <th style="width: 10%"></th>
    </tr>
    {% for sample in samples -%}
        <tr class="table-row" id="{{sample.name}}">
            <td>
                {%- if sample.sdk == "dart" -%}
                    <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                {%- else -%}
                    <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                {% endif %}
            </td>
            <td>
                <p>{{sample.name}}</p>
            </td>
            <td>
                <p>{{sample.description}}</p>
            </td>
            <td>
                <a class="icon-button" href="{{sample.source-link.url}}" target="_blank" rel="noopener" title="{{sample.source-link.label}}">
                {%- if sample.type == "github" -%}
                    <svg width="24px" height="24px">
                        <use href="/assets/images/social/github.svg#github"></use>
                    </svg>
                {%- elsif sample.type == "codelab" -%}
                    <svg width="24px" height="24px">
                        <use href="/assets/images/social/google-developers.svg#google-developers"></use>
                    </svg>
                {%- endif -%}
                </a>
            </td>
        </tr>
    {% endfor -%}
</table>
