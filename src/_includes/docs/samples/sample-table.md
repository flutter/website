 <table id="table-{{category.type}}" class="samples-table table">
    <tr class="tr-main-head tr-head" style="text-align: left" id="tr-header-{{item.type}}">
        <th colspan="3">
            <h3 class="th-title">{{category.name}}</h3>
            <p class="th-description">{{category.description}}</p>
        </th>
    </tr>
    <tr class="tr-sub-head tr-head" style="text-align: left">
        <th style="width: 30%">Title</th>
        <th style="width: 40%">Description</th>
        <th align="center" style="width: 10%">Link</th>
    </tr>
    {% for item in category.items -%}
        {%- if item.type == "separator" -%}
            <tr class="tr-separator table-row" id="{{item.name}}" data-type="{{item.type}}" data-tags='{{item.tags | join: ", "}}'>
                <td colspan="3">{{item.name}}</td>
            </tr>
        {%- else -%}
            <tr class='table-row' id="{{item.name}}" data-type="{{item.type}}" data-tags='{{item.tags | join: ", "}}'>
                <td>
                    <p>{{item.name}}</p>
                </td>
                <td>
                    <p>{{item.description}}</p>
                </td>
                <td align="center">
                    <a class="td-icon" href="{{item.source-link.url}}" target="_blank" rel="noopener" title="{{item.source-link.label}}">
                    {%- if item.source-link.label == "Github" -%}
                        <svg width="24px" height="24px"><use href="/assets/images/social/github.svg#github"></use></svg>
                    {%- elsif item.source-link.label == 'Flutter docs' -%}
                        <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                    {%- elsif item.source-link.label == 'Dart docs' -%}
                        <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                    {%- elsif item.source-link.label == "Google Codelab" -%}
                        <svg width="24px" height="24px"><use href="/assets/images/social/google-developers.svg#google-developers"></use></svg>
                    {%- endif -%}
                    </a>
                </td>
            </tr>
        {%- endif -%}
    {% endfor -%}
</table>