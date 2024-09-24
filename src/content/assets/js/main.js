function setupTheme() {
  const storedTheme = window.localStorage.getItem('theme');
  if (storedTheme === 'dark-mode' || storedTheme === 'light-mode') {
    document.body.classList.add(storedTheme);
  }

  const themeSwitcher = document.getElementById('theme-switcher');

  if (themeSwitcher) {
    themeSwitcher.addEventListener('click', (_) => {
      if (document.body.classList.contains('dark-mode')) {
        document.body.classList.remove('dark-mode');
        document.body.classList.add('light-mode');
        window.localStorage.setItem('theme', 'light-mode');
      } else {
        document.body.classList.remove('light-mode');
        document.body.classList.add('dark-mode');
        window.localStorage.setItem('theme', 'dark-mode');
      }
    });
  }
}

function setupMenuToggle() {
  const menuToggle = document.querySelector('#menu-button button');
  if (!menuToggle) return;

  const menuWideToggledClass = 'menu-wide-toggled';
  const storedWideToggled = window.localStorage.getItem(menuWideToggledClass);
  if (storedWideToggled === 'true') {
    document.body.classList.add(menuWideToggledClass);
  }

  menuToggle.addEventListener('click', (e) => {
    e.preventDefault();

    if (document.body.clientWidth > 768) {
      if (document.body.classList.toggle(menuWideToggledClass)) {
        window.localStorage.setItem(menuWideToggledClass, 'true');
      } else {
        window.localStorage.removeItem(menuWideToggledClass);
      }
    } else {
      document.body.classList.toggle('menu-narrow-toggled');
    }
  });
}

function scrollSidenavIntoView() {
  const sidenav = document.getElementById('sidenav');
  if (!sidenav) {
    return;
  }

  const activeEntries = sidenav.querySelectorAll('a.nav-link.active');
  if (activeEntries.length > 0) {
    const activeEntry = activeEntries[activeEntries.length - 1];

    sidenav.scrollTo({
      top: activeEntry.offsetTop - window.innerHeight / 3,
    });
  }
}

function setupBanner() {
  const bannerClose = document.getElementById('banner-close-button');
  const siteBanner = document.getElementById('site-banner');
  if (!bannerClose || !siteBanner) return;
  const bannerContents = siteBanner.querySelector('p')?.textContent;
  const closedBannerContents = window.localStorage.getItem('banner-contents');
  if (bannerContents == null || bannerContents === closedBannerContents) {
    siteBanner.remove();
    return;
  }

  bannerClose.addEventListener('click', (_) => {
    window.localStorage.setItem('banner-contents', bannerContents);
    document.getElementById('site-banner')?.remove();
  });
  siteBanner.hidden = false;
}

function setupSearch() {
  const headerSearch = document.getElementById('header-search');
  if (!headerSearch) return;
  const submitButton = headerSearch.querySelector('button');
  const input = headerSearch.querySelector('input');

  function submitSearch(e) {
    e.preventDefault();
    const query = input.value;
    const url = new URL(window.location);
    url.pathname = '/search';
    url.searchParams.set('q', query);
    window.location = url.toString();
  }

  submitButton.addEventListener('click', submitSearch);
  input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
      submitSearch(e);
    }
  });
}

document.addEventListener("DOMContentLoaded", function(_) {
  setupTheme();
  setupBanner();
  scrollSidenavIntoView();
  setupNav();
  setUpCodeBlockButtons();

  setupSearch();
  setupTabs();
  setupInlineToc();
  setupMenuToggle();
  initCookieNotice();
});

function setupNav() {
  const toggles = document.querySelectorAll('a.nav-link.collapsible');
  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', (e) => {
      toggle.classList.toggle('collapsed');
      e.preventDefault();
    });
  });
}

function setupInlineToc() {
  // Set up the inline TOC's ability to expand and collapse.
  const toggles = document.querySelectorAll('.site-toc--inline__toggle');
  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', (_) => {
      const inlineToc = document.getElementById('site-toc--inline');
      if (inlineToc) {
        inlineToc.classList.toggle('toc-collapsed');
      }
    });
  });
}

/**
 * Get the user's current operating system, or * `null` if not of one "macos", "windows", "linux", or "chromeos".
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

function initCookieNotice() {
  const cookieKey = 'cookie-consent';
  const currentDate = Date.now();
  const existingDateString = window.localStorage.getItem(cookieKey);
  if (existingDateString) {
    const existingDate = parseInt(existingDateString);
    if (Number.isInteger(existingDate)) {
      const halfYearMs = 1000 * 60 * 60 * 24 * 180;
      // If the last consent is less than 180 days old, don't show the notice.
      if (currentDate - existingDate < halfYearMs) {
        return;
      }
    }
  }

  const notice = document.getElementById('cookie-notice');
  const agreeBtn = document.getElementById('cookie-consent');
  const activeClass = 'show';

  agreeBtn.addEventListener('click', (e) => {
    e.preventDefault();
    window.localStorage.setItem(cookieKey, currentDate.toString());
    notice.classList.remove(activeClass);
  });

  notice.classList.add(activeClass);
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
