function setupSidenavInteractivity() {
  document.getElementById('menu-toggle')?.addEventListener('click', function (e) {
    e.stopPropagation();
    document.body.classList.toggle('open_menu');
  });

  window.addEventListener('resize', function() {
    if (window.innerWidth >= 1024) {
      document.body.classList.remove('open_menu');
    }
  });

  document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
      const activeElement = document.activeElement;
      if (activeElement && (activeElement.id === 'menu-toggle' || activeElement.closest('#sidenav'))) {
        document.body.classList.remove('open_menu');
      }
    }
  });

  // Set up collapse and expand for sidenav buttons.
  const toggles = document.querySelectorAll('.nav-link.collapsible');
  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', (e) => {
      toggle.classList.toggle('collapsed');
      e.preventDefault();
    });
  });
}

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

function scrollSidenavIntoView() {
  const sidenav = document.getElementById('sidenav');
  if (!sidenav) {
    return;
  }

  const activeEntries = sidenav.querySelectorAll('.nav-link.active');
  if (activeEntries.length > 0) {
    const activeEntry = activeEntries[activeEntries.length - 1];

    sidenav.scrollTo({
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

/**
 * Activate the cookie notice footer.
 */
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

function setupSiteSwitcher() {
  const siteSwitcher = document.getElementById('site-switcher');

  if (!siteSwitcher) {
    return;
  }

  const siteSwitcherButton = siteSwitcher.querySelector('.dropdown-button');
  const siteSwitcherMenu = siteSwitcher.querySelector('#site-switcher-menu');
  if (!siteSwitcherButton || !siteSwitcherMenu) {
    return;
  }

  function _closeMenusAndToggle() {
    siteSwitcherMenu.classList.remove('show');
    siteSwitcherButton.ariaExpanded = 'false';
  }

  siteSwitcherButton.addEventListener('click', (_) => {
    if (siteSwitcherMenu.classList.contains('show')) {
      _closeMenusAndToggle();
    } else {
      siteSwitcherMenu.classList.add('show');
      siteSwitcherButton.ariaExpanded = 'true';
    }
  });

  document.addEventListener('keydown', (event) => {
    // If pressing the `esc` key in the menu area, close the menu.
    if (event.key === 'Escape' && event.target.closest('#site-switcher')) {
      _closeMenusAndToggle();
    }
  });

  siteSwitcher.addEventListener('focusout', (e) => {
    // If focus leaves the site-switcher, hide the menu.
    if (e.relatedTarget && !e.relatedTarget.closest('#site-switcher')) {
      _closeMenusAndToggle();
    }
  });

  document.addEventListener('click', (event) => {
    // If not clicking inside the site switcher, close the menu.
    if (!event.target.closest('#site-switcher')) {
      _closeMenusAndToggle();
    }
  });
}

function setupSite() {
  scrollSidenavIntoView();
  initCookieNotice();

  setupSidenavInteractivity();
  setUpCodeBlockButtons();

  setupSearch();
  setupSiteSwitcher();
  setupTabs();

  adjustToc();
  setupInlineToc();
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', setupSite);
} else {
  setupSite();
}
