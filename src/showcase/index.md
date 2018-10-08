---
title: Showcase
layout: landing
body_class: landing-page showcase
show-nav-get-started-button: true
toc: false
---

<section class="landing-page__hero">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-4 offset-md-5 offset-lg-7">
                <div class="card">
                    <div class="card-body">
                        <h2>Featured</h2>
                        <h3>Hamilton Musical</h3>
                        <p>
                        Official app of the hit Broadway musical, Hamilton. Includes daily lotteries,  exclusive news and
                        videos, a trivia game, merchandise store, and more.
                        </p>
                        <a class="btn btn-link" href="#">Learn more</a>
                        <button class="btn btn-link btn-icon" type="button" data-toggle="modal" data-target="#videoModal"><i class="material-icons">play_circle_filled</i> Watch the video</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="showcase__apps card text-center">
    <div class="card-body">
        <div class="row">
            <div class="col-lg-6 offset-lg-3">
                <h2>Made with Flutter</h2>
                <p>
                Flutter is used by Google and developers and organizations around  the world to deliver beautiful native apps on
                iOS and Android. Here is a  small selection of apps made with Flutter. 
                </p>
            </div>
        </div>
        
        {% for case in site.data.showcases %}
            {% capture modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
            {% if modulo3 == '0' %}
                <div class="showcase__apps__cards text-left card-deck">
            {% endif %}
                    <div class="card">
                        <div class="card-body">
                            <h3>{{ case.name }}</h3>
                            <p>{{ case.description }}</p>
                        </div>
                        <div class="card-footer">
                            <a class="btn btn-link" href="{{ case.learn_more_link }}">Learn more</a>
                        </div>
                    </div>
            {% if modulo3 == '2' or forloop.last %}
                </div>
            {% endif %}
        {% endfor %}
    </div>
</section>

<section class="landing-page__cta card text-center">
    <div class="card-body">
        <h2 class="landing-page__cta__headline">Try Flutter today.</h2>
        <p class="landing-page__cta__body">Getting started is easy.</p>
        <a class="landing-page__cta__button btn btn-primary" href="/get-started/install">Get started</a>
    </div>
</section>

<!-- Featured App Modal -->
<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div class="embedded-video-wrapper">
            <iframe class="embedded-video-wrapper__frame" width="auto" height="auto" src="https://www.youtube.com/embed/fq4N0hgOWzU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        </div>
      </div>
    </div>
  </div>
</div>
