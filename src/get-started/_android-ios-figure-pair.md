{% comment %}
TODO: Fernando, should we set all `figure-caption` to have centered text,
      or locally use class="text-center"? I'd favor the former.
      I've (chalin) temporarily used .text-center below.

Sadly, Jekyll doesn't seem to supported nested includes, so the following won't work:

  {% include_relative _app-figure.md image="{{include.image}}" platform="Android" %}
  {% include_relative _app-figure.md image="{{include.image}}" platform="iOS" %}

{% endcomment -%}

<figure class="site-figure">
  <div>
      {% asset 'get-started/android/{{include.image}}'
          alt='{{include.alt}} on Android' %}
      <figcaption class="figure-caption">Android</figcaption>
  </div>
  <div>
      {% asset 'get-started/ios/{{include.image}}'
          alt='{{include.alt}} on iOS' %}
      <figcaption class="figure-caption">iOS</figcaption>
  </div>
</figure>
