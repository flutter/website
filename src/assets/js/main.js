$(function () {
  adjustToc();
  initFixedColumns();
  scrollSidebarIntoView();
  initVideoModal();
  initCarousel();
  initSnackbar();
  initCookieNotice();

  addCopyCodeButtonsEverywhere(); // Must be before tooltip activation.
  $('[data-toggle="tooltip"]').tooltip();
  setupClipboardJS();

  // New (dash) tabs
  setupTabs($('#editor-setup'), 'io.flutter.tool-id');
  setupTabs($('.sample-code-tabs'), 'io.flutter.tool-id');
  // Old tabs
  setupToolsTabs($('#tab-set-install'), 'tab-install-', 'io.flutter.tool-id');
  setupToolsTabs($('#tab-set-os'), 'tab-os-', null, getOS());

  prettyPrint();
});

function scrollSidebarIntoView() {
  const fixedSidebar = document.querySelector('.site-sidebar--fixed');

  if (!fixedSidebar) {
    return;
  }

  const activeEntries = fixedSidebar.querySelectorAll('a.nav-link.active');

  if (activeEntries.length > 0) {
    const activeEntry = activeEntries[activeEntries.length - 1];

    fixedSidebar.scrollTo({
      top: activeEntry.offsetTop - window.innerHeight / 3,
    });
  }
}

function adjustToc() {
  // Adjustments to the jekyll-toc TOC.

  const tocId = '#site-toc--side';

  const tocHeader = document.querySelector(tocId + ' header');

  if (tocHeader) {
    tocHeader.addEventListener('click', function (_) {
      $('html, body').animate({scrollTop: 0}, 'fast');
    });
  }

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
    var bannerVisibleHeight = 0;
    // First, make sure the banner element even exists on the page.
    if ($(bannerSelector).length > 0) {
      var bannerHeight = $(bannerSelector).outerHeight();
      var bannerOffset = $(bannerSelector).offset().top;
      var bannerPosition = bannerOffset - $(window).scrollTop();
      bannerVisibleHeight =
          Math.max(bannerHeight - (headerHeight - bannerPosition), 0);
    }
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
  var SNACKBAR_SELECTOR = '.snackbar';
  var SNACKBAR_ACTION_SELECTOR = '.snackbar__action';
  var snackbars = $(SNACKBAR_SELECTOR);

  snackbars.each(function () {
    var snackbar = $(this);
    snackbar.find(SNACKBAR_ACTION_SELECTOR).click(function () {
      snackbar.fadeOut();
    });
  })
}

function setupClipboardJS() {
  var clipboard = new ClipboardJS('.code-excerpt__copy-btn', {
    text: function (trigger) {
      var targetId = trigger.getAttribute('data-clipboard-target');
      var target = document.querySelector(targetId);
      var terminalRegExp = /^(\s*\$\s*)|(C:\\(.*)>\s*)/gm;
      var copy = target.textContent.replace(terminalRegExp, '');
      return copy;
    }
  });
  clipboard.on('success', _copiedFeedback);
}

function _copiedFeedback(e) {
  // e.action === 'copy'
  // e.text === copied text
  e.clearSelection(); // Unselect copied code

  var copied = 'Copied';
  var target = e.trigger;
  var title = target.getAttribute('title') || target.getAttribute('data-original-title')
  var savedTitle;

  if (title === copied) return;

  savedTitle = title;
  setTimeout(function () {
    _changeTooltip(target, savedTitle);
  }, 1500);

  _changeTooltip(target, copied);
}

function _changeTooltip(target, text) {
  target.setAttribute('title', text);
  $(target).tooltip('dispose'); // Dispose of tip with old title
  $(target).tooltip('show'); // Recreate tip with new title ...
  if (!$(target).is(":hover")) {
    $(target).tooltip('hide'); // ... but hide it if it isn't being hovered over
  }
}

function addCopyCodeButtonsEverywhere() {
  var elts = $('pre');
  elts.wrap(function (i) {
    return $(this).parent('div.code-excerpt__code').length === 0
      ? '<div class="code-excerpt__code"></div>'
      : '';
  });
  elts.wrap(function (i) {
    return '<div id="code-excerpt-' + i + '"></div>'
  });

  elts.parent() // === div#code-excerpt-X
    .parent() // === div.code-excerpt__code
    .prepend(function (i) {
      return '' +
        '<button class="code-excerpt__copy-btn" type="button"' +
        '    data-toggle="tooltip" title="Copy code"' +
        '    data-clipboard-target="#code-excerpt-' + i + '">' +
        '  <i class="material-icons">content_copy</i>' +
        '</button>';
    });
}

/**
 * Activate the cookie notice footer
 * @returns null
 */
function initCookieNotice() {
  const notice = document.getElementById('cookie-notice');
  const agreeBtn = document.getElementById('cookie-consent');
  const cookieKey = 'cookie-consent';
  const cookieConsentValue = 'true'
  const activeClass = 'show';

  if (Cookies.get(cookieKey) === cookieConsentValue) {
    return;
  }

  notice.classList.add(activeClass);

  agreeBtn.addEventListener('click', (e) => {
    e.preventDefault();
    Cookies.set(cookieKey, cookieConsentValue, {sameSite: 'strict', expires: 30});
    notice.classList.remove(activeClass);
  });
}
