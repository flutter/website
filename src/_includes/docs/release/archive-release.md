{% assign os = include.os | downcase -%}
{% assign channel = include.channel | downcase -%}

Select from the following scrollable list:

<div class="scrollable-table">
  <table id="downloads-{{os}}-{{channel}}" class="table table-striped">
  <thead><tr><th>Flutter version</th><th>Architecture</th><th>Ref</th><th class="date">Release Date</th><th>Dart version</th><th>Provenance</th></tr></thead>
  <tbody><tr class="loading"><td colspan="6">Loading...</td></tr></tbody>
  </table>
</div>
