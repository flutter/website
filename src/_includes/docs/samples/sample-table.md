<table class="samples-table table table-striped" style="border-bottom:1px #DADCE0 solid;">
    <tr class="tr-main-head" style="text-align: left">
        <th style="width: 10%"></th>
        <th style="width: 30%">Title</th>
        <th style="width: 50%">Description</th>
        <th style="width: 10%"></th>
    </tr>
    <p>What</p>
    {% for item in items -%}
        {% if item.type == "header" -%}
            <tr class="tr-main-head" style="text-align: left">
                <th></th>
                <th>{{item.name}}</th>
                <th>{{item.description}}</th>
                <th></th>
            </tr>
        {% else -%}
            <tr class="table-row" id="{{item.name}}">
                <td>
                    {%- if item.sdk == "dart" -%}
                        <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                    {%- else -%}
                        <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                    {% endif %}
                </td>
                <td>
                    <p>{{item.name}}</p>
                </td>
                <td>
                    <p>{{item.description}}</p>
                </td>
                <td>
                    <a class="icon-button" href="{{item.source-link.url}}" target="_blank" rel="noopener" title="{{item.source-link.label}}">
                    {%- if item.type == "github" -%}
                        <svg width="24px" height="24px">
                            <use href="/assets/images/social/github.svg#github"></use>
                        </svg>
                    {%- elsif item.type == "codelab" -%}
                        <svg width="24px" height="24px">
                            <use href="/assets/images/social/google-developers.svg#google-developers"></use>
                        </svg>
                    {%- endif -%}
                    </a>
                </td>
            </tr>
       {% endif -%}
    {% endfor -%}
</table>
