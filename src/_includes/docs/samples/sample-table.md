 <table id="table-{{group.type}}" class="samples-table table" style="border-bottom:1px #DADCE0 solid;" >
    <tr class="tr-main-head tr-head" style="text-align: left" id="tr-header-{{item.type}}">
        <th></th>
        <th colspan="3">
            <div class="th-section-head">{{group.name}}</div>
            <label>{{group.description}}</label>
        </th>
    </tr>
    <tr class="tr-sub-head tr-head" style="text-align: left">
        <th style="width: 5%"></th>
        <th style="width: 30%">Title</th>
        <th style="width: 40%">Description</th>
        <th align="center" style="width: 10%">Link</th>
    </tr>
    {% for item in group.items -%}
        <tr class='table-row' id="{{item.name}}" data-type="{{item.type}}" data-tags='{{item.tags | join: ", "}}'>
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
            <td align="center">
                <a class="td-icon" href="{{item.source-link.url}}" target="_blank" rel="noopener" title="{{item.source-link.label}}">
                {%- if item.type == "sample" -%}
                <svg width="24px" height="24px"><use href="/assets/images/social/github.svg#github"></use></svg>
                {%- elsif item.type == "codelab" -%}
                    <svg width="24px" height="24px"><use href="/assets/images/social/google-developers.svg#google-developers"></use></svg>
                {%- endif -%}
                </a>
            </td>
        </tr>
    {% endfor -%}
</table>