//= require vendor/jquery-3.3.1
//= require popper
//= require bootstrap
//= require archive.js
//= require tabs.js
//= require vendor/code-prettify/prettify
//= require vendor/code-prettify/lang-css
//= require vendor/code-prettify/lang-dart
//= require vendor/code-prettify/lang-yaml

// TODO(chalin): find a way to selectively generate (as individual files) and then include archive.js and/or tabs.js

$(function () {
  adjustToc();
  initFixedColumns();
  initVideoModal();
  initCarousel();
  initSnackbar();
  prettyPrint();

  // New (dash) tabs
  setupTabs($('#editor-setup'), 'io.flutter.tool-id');
  // Old tabs
  setupToolsTabs($('#tab-set-install'), 'tab-install-', 'io.flutter.tool-id');
  setupToolsTabs($('#tab-set-os'), 'tab-os-', null, getOS());
})

// TODO(chalin): Copied (& tweaked) from site-www, consider moving into site-shared
function adjustToc() {
  // Adjustments to the jekyll-toc TOC.

  var tocId = '#site-toc--side';
  var tocWrapper = $(tocId);
  $(tocWrapper).find('.site-toc--button__page-top').click(function() {
    $('html, body').animate({ scrollTop: 0 }, 'fast');
  })

  // TODO: consider doing most of the HTML TOC manipulation statically (maybe requiring a jekyll-toc adaptor plugin)
  // Bootstrap 4's ScrollSpy works only for .nav or .list-group,
  // with items and link classes set too. Add the classes.
  var toc = $(tocWrapper).find('ul.section-nav');
  $(toc).addClass('nav');

  var ul = $(toc).find('ul');
  $(ul).addClass('nav');
  var li = $(toc).find('.toc-entry');
  $(li).addClass('nav-item');
  $(li).find('a').addClass('nav-link');

  $('body').scrollspy({ offset: 100, target: tocId });
}

function initFixedColumns() {
  var fixedColumnsSelector = '[data-fixed-column]';
  var bannerSelector = '.site-banner';
  var footerSelector = 'footer.site-footer';
  var headerSelector = '.site-header';
  var fixedColumns = $(fixedColumnsSelector);

  function adjustFixedColumns() {
    // only change values if the fixed col is visible
    if ($(fixedColumnsSelector).css('display') == 'none') {
      return;
    }

    var headerHeight = $(headerSelector).outerHeight();
    var bannerHeight = $(bannerSelector).outerHeight();
    var bannerOffset = $(bannerSelector).offset().top;
    var bannerPosition = bannerOffset - $(window).scrollTop();
    var bannerVisibleHeight = Math.max(bannerHeight - (headerHeight - bannerPosition), 0);
    var topOffset = headerHeight + bannerVisibleHeight;

    var footerOffset = $(footerSelector).offset().top;
    var footerPosition = footerOffset - $(window).scrollTop();
    var footerVisibleHeight = $(window).height() - footerPosition;

    var fixedColumnsMaxHeight = $(window).height() - topOffset - footerVisibleHeight;

    $(fixedColumnsSelector).css('max-height', fixedColumnsMaxHeight);
    $(fixedColumnsSelector).css('top', topOffset);
  }

  if (fixedColumns.length) {
    $(fixedColumnsSelector).css('position', 'fixed');

    // listen for scroll and execute once
    $(window).scroll(adjustFixedColumns);
    adjustFixedColumns();
  }
}

function getOS() {
  var ua = navigator.userAgent;
  if (ua.indexOf("Win") !== -1)
    return "windows";
  if (ua.indexOf("Mac") !== -1)
    return "macos";
  if (ua.indexOf("Linux") !== -1 || ua.indexOf("X11") !== -1)
    return "linux";
}

function initVideoModal() {
  var videoModalObject = $('[data-video-modal]');

  if (videoModalObject.length) {
    // there is a video modal in the DOM, load the YouTube API
    var tag = document.createElement('script');
    tag.src = 'https://www.youtube.com/iframe_api';
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    window.onYouTubeIframeAPIReady = function () {
      window.videoPlayer = new YT.Player('video-player-iframe');
    };
  }

  videoModalObject.on('shown.bs.modal', function (event) {
    if (window.videoPlayer) {
      var videoId = event.relatedTarget.dataset.video;
      window.videoPlayer.loadVideoById(videoId);
      window.videoPlayer.playVideo();
    }
  });

  videoModalObject.on('hide.bs.modal', function (event) {
    if (window.videoPlayer) {
      window.videoPlayer.stopVideo();
    }
  });
}

function initCarousel() {
  var CAROUSEL_SELECTOR = '.carousel';
  var CAROUSEL_ITEM_SELECTOR = '.carousel-item';
  var carousel = $(CAROUSEL_SELECTOR);

  carousel.on('slide.bs.carousel', function (e) {
    carousel.find(CAROUSEL_ITEM_SELECTOR).eq(e.from).addClass('transition-out');
  });
  carousel.on('slid.bs.carousel', function (e) {
    carousel.find(CAROUSEL_ITEM_SELECTOR).eq(e.from).removeClass('transition-out');
  });
}

function initSnackbar() {
  var SNACKBAR_SELECTOR ='.snackbar';
  var SNACKBAR_ACTION_SELECTOR = '.snackbar__action';
  var snackbars = $(SNACKBAR_SELECTOR);

  snackbars.each(function () {
    var snackbar = $(this);
    snackbar.find(SNACKBAR_ACTION_SELECTOR).click(function () {
      snackbar.fadeOut();
    });
  })
}
