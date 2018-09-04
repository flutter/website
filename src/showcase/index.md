---
title: Showcase
---

Flutter is used by Google and developers and organizations around the world
to deliver beautiful native apps on iOS and Android.
Here is a small selection of apps made with Flutter.
If you want to be featured, [let us know][]!

[let us know]: https://docs.google.com/forms/d/e/1FAIpQLScP5iDNGrlVXdGxmRDzjCnqXS0KUDld-3cR-njAL0kDO2ULFg/viewform

For a longer list of apps check out [itsallwidgets.com](https://itsallwidgets.com/flutter-apps).

<div class="showcase-grid__row row">

{% for case in site.data.showcases %}
    {% capture modulo4 %}{{ forloop.index0 | modulo:4 }}{% endcapture %}

    {% if modulo4 == '0' %}
     <div class="clearfix d-none d-xl-block"></div>
    {% endif %}

    {% capture modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}

    {% if modulo3 == '0' %}
     <div class="clearfix d-none d-lg-block"></div>
    {% endif %}

    {% capture modulo2 %}{{ forloop.index0 | modulo:2 }}{% endcapture %}

    {% if modulo2 == '0' %}
     <div class="clearfix d-none d-md-block"></div>
    {% endif %}

    <div class="showcase-grid__item col-xl-3 col-lg-4 col-md-6">
        <h2>{{case.name}}</h2>

        <div class="showcase-grid__screenshot">
            <div class="showcase-grid__screenshot--top"></div>
            <img
                 src="{{case.screenshot}}" alt="{{case.name}} screenshot">
            <div class="showcase-grid__screenshot--bottom"></div>
        </div>

        <p>{{case.description}}</p>

        {% if case.ios_download and case.android_download %}
        <p>
            Download:
            <a href="{{case.ios_download}}">iOS</a>,
            <a href="{{case.android_download}}">Android</a>
        </p>
        {% elsif case.ios_download %}
        <p>
            Download:
            <a href="{{case.ios_download}}">iOS</a>
        </p>
        {% elsif case.android_download %}
        <p>
            Download:
            <a href="{{case.android_download}}">Android</a>
        </p>
        {% endif %}

        {% if case.learn_more_link %}
        <p><a href="{{case.learn_more_link}}">Learn more</a></p>
        {% endif %}
    </div>
{% endfor %}

</div> <!-- end of showcase--grid__row -->
