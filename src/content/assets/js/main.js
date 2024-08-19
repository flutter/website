document.addEventListener("DOMContentLoaded", function(_) {
  adjustToc();
  setupInlineToc();
  initFixedColumns();
  scrollSidebarIntoView();
  initCookieNotice();
  setUpCodeBlockButtons();

  setupSearch();
  setupTabs();
});

/**
 * Get the user's current operating system, or
 * `null` if not of one "macos", "windows", "linux", or "chromeos".
 *
 * @returns {'macos'|'linux'|'windows'|'chromeos'|null}
 */
function getOS() {
  const userAgent = window.navigator.userAgent;
  if (userAgent.indexOf('Mac') !== -1) {
    // macOS or iPhone
    return 'macos';
  }

  if (userAgent.indexOf('Win') !== -1) {
    // Windows
    return 'windows';
  }

  if ((userAgent.indexOf('Linux') !== -1 || userAgent.indexOf("X11") !== -1)
    && userAgent.indexOf('Android') === -1) {
    // Linux, but not Android
    return 'linux';
  }

  if (userAgent.indexOf('CrOS') !== -1) {
    // ChromeOS
    return 'chromeos';
  }

  // Anything else
  return null;
}

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

/**
 * Adjusts the behavior of the table of contents (TOC) on the page.
 * 
 * This function enables a "scrollspy" feature on the TOC, 
 * where the active link in the TOC is updated
 * based on the currently visible section in the page.
 * 
 * Enables a "back to top" button in the TOC header.
 */
function adjustToc() {
  const tocId = '#site-toc--side';

  const tocHeader = document.querySelector(tocId + ' header');

  if (tocHeader) {
    tocHeader.addEventListener('click', (_) => {
      _scrollToTop();
    });
  }

  // This will not be migrated for now until we migrate 
  // the entire site to Bootstrap 5.
  // see https://github.com/flutter/website/pull/9167#discussion_r1286457246
  $('body').scrollspy({ offset: 100, target: tocId });

  function _scrollToTop() {
    const distanceBetweenTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (distanceBetweenTop > 0) {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }
}

function setupSearch() {
  document.addEventListener('keydown', handleSearchShortcut);
}

function handleSearchShortcut(event) {
  const activeElement = document.activeElement;
  if (activeElement instanceof HTMLInputElement ||
      activeElement instanceof HTMLTextAreaElement ||
      event.code !== 'Slash'
  ) {
    return;
  }

  // If the page has a search field in the body, focus that.
  const bodySearch = document.querySelector('input.gsc-input');
  // Otherwise, focus the search field in the navbar.
  const searchElement = bodySearch ? bodySearch : document
      .querySelector('input.search-field');

  // If we successfully found a search field, focus that.
  if (searchElement) {
    searchElement.focus();
    // Prevent the initial slash from showing up in the search field.
    event.preventDefault();
  }
}

function initFixedColumns() {
  const fixedColumnsSelector = '[data-fixed-column]';
  const bannerSelector = '.site-banner';
  const footerSelector = 'footer.site-footer';
  const headerSelector = '.site-header';
  const fixedColumns = $(fixedColumnsSelector);

  function adjustFixedColumns() {
    // only change values if the fixed col is visible
    if ($(fixedColumnsSelector).css('display') == 'none') {
      return;
    }

    const headerHeight = $(headerSelector).outerHeight();
    let bannerVisibleHeight = 0;
    // First, make sure the banner element even exists on the page.
    const siteBanner = $(bannerSelector);
    if (siteBanner.length > 0) {
      const bannerHeight = siteBanner.outerHeight();
      const bannerOffset = siteBanner.offset().top;
      const bannerPosition = bannerOffset - $(window).scrollTop();
      bannerVisibleHeight =
        Math.max(bannerHeight - (headerHeight - bannerPosition), 0);
    }
    const topOffset = headerHeight + bannerVisibleHeight;

    const footerOffset = $(footerSelector).offset().top;
    const footerPosition = footerOffset - $(window).scrollTop();
    const footerVisibleHeight = $(window).height() - footerPosition;

    const fixedColumnsMaxHeight = $(window).height() - topOffset - footerVisibleHeight;

    $(fixedColumnsSelector).css('max-height', fixedColumnsMaxHeight);
    $(fixedColumnsSelector).css('top', topOffset);
  }

  if (fixedColumns.length) {
    $(fixedColumnsSelector).css('position', 'fixed');

    // listen for scroll and execute once
    $(window).scroll(adjustFixedColumns);
    $(window).resize(adjustFixedColumns);
    adjustFixedColumns();
  }
}

/**
 * Activate the cookie notice footer.
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
    Cookies.set(cookieKey, cookieConsentValue, { sameSite: 'strict', expires: 90 });
    notice.classList.remove(activeClass);
  });
}

function setupInlineToc() {
  // Set up the inline TOC's ability to expand and collapse.
  const toggle = document.querySelectorAll('.site-toc--inline__toggle');
  toggle.forEach(function (toggle) {
    toggle.addEventListener('click', (_) => {
      const inlineToc = document.getElementById('site-toc--inline');
      if (inlineToc) {
        inlineToc.classList.toggle('toc-collapsed');
      }
    });
  });
}

// A pattern to remove terminal command markers when copying code blocks.
const terminalReplacementPattern = /^(\s*\$\s*)|(C:\\(.*)>\s*)/gm;

function setUpCodeBlockButtons() {
  const codeBlocks =
      document.querySelectorAll('.code-block-body');

  const canUseClipboard = !!navigator.clipboard;

  codeBlocks.forEach(codeBlock => {
    const preElement = codeBlock.querySelector('pre');
    if (!preElement) {
      return;
    }

    const buttonWrapper = document.createElement('div');
    buttonWrapper.classList.add('code-inner-buttons');

    const dartPadGistId = preElement.getAttribute('data-dartpad-id');
    if (dartPadGistId && dartPadGistId.length > 5) {
      const dartPadButton = document.createElement('button');
      const innerIcon = document.createElement('span');

      dartPadButton.title = 'Open in DartPad';

      innerIcon.textContent = 'open_in_new';
      innerIcon.ariaHidden = 'true';
      innerIcon.classList.add('material-symbols');

      dartPadButton.addEventListener('click',  (e) => {
        const codeBlockBody = e.currentTarget.parentElement;
        if (codeBlockBody) {
          const codePre = codeBlock.querySelector('pre');
          if (codePre) {
            window.open(`https://dartpad.dev?id=${dartPadGistId}&run=true`);
          }
        }
      });

      dartPadButton.appendChild(innerIcon);
      buttonWrapper.appendChild(dartPadButton);
    }

    if (canUseClipboard) {
      const copyButton = document.createElement('button');
      const innerIcon = document.createElement('span');

      copyButton.title = 'Copy to clipboard';

      innerIcon.textContent = 'content_copy';
      innerIcon.ariaHidden = 'true';
      innerIcon.classList.add('material-symbols');

      copyButton.addEventListener('click', async (e) => {
        const codeBlockBody = e.currentTarget.parentElement;
        if (codeBlockBody) {
          const codePre = codeBlock.querySelector('pre');
          if (codePre) {
            const contentToCopy = codePre.textContent
                .replace(terminalReplacementPattern, '');
            if (contentToCopy && contentToCopy.length !== 0) {
              await navigator.clipboard.writeText(contentToCopy);
            }
            e.preventDefault();
          }
        }
      });

      copyButton.appendChild(innerIcon);
      buttonWrapper.appendChild(copyButton);
    }

    codeBlock.appendChild(buttonWrapper);
  });
}
