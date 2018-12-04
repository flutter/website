{% assign id =  include.os | downcase -%}

<div id="{{id}}" class="tab-pane
  {%- if id == 'windows' %} active {% endif %}"
  role="tabpanel" aria-labelledby="{{id}}-tab" markdown="1">

## {{site.sdk.channel | capitalize }} channel ({{include.os}})

Select from the following scrollable list:

<div class="scrollable-table">
  <table id="downloads-{{id}}-{{site.sdk.channel}}" class="table table-striped">
  <thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
  <tr class="loading"><td colspan="3">Loading...</td></tr>
  </table>
</div>

## Dev channel ({{include.os}})

Select from the following scrollable list:

<div class="scrollable-table">
  <table id="downloads-{{id}}-dev" class="table table-striped">
  <thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
  <tr class="loading"><td colspan="3">Loading...</td></tr>
  </table>
</div>

</div>
