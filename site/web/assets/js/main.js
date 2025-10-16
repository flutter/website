function setupCollapsibleElements() {
  const toggles = document.querySelectorAll('[data-toggle="collapse"]');
  toggles.forEach(function (toggle) {
    const targetSelector = toggle.getAttribute('data-target');
    if (!targetSelector) return;
    const target = document.querySelector(targetSelector);
    if (!target) return;

    toggle.addEventListener('click', (e) => {
      if (toggle.classList.contains('collapsed')) {
        toggle.classList.remove('collapsed');
        toggle.ariaExpanded = 'true';

        target.classList.add('show');
      } else {
        toggle.classList.add('collapsed');
        toggle.ariaExpanded = 'false';

        target.classList.remove('show');
      }

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

/**
 * Adjusts the behavior of the table of contents (TOC) on the page.
 *
 * This function enables a "scrollspy" feature on the TOC,
 * where the active link in the TOC is updated
 * based on the currently visible section in the page.
 *
 * Enables a "back to top" button in the TOC header.
 */
function setupToc() {
  _setupTocActiveObserver();
  _setupInlineTocDropdown();
}

function _setupInlineTocDropdown() {
  const inlineToc = document.getElementById('toc-top');
  if (!inlineToc) return;

  const dropdownButton = inlineToc.querySelector('.dropdown-button');
  const dropdownMenu = inlineToc.querySelector('.dropdown-content');
  if (!dropdownButton || !dropdownMenu) return;

  function _closeMenu() {
    dropdownMenu.classList.remove('show');
    dropdownButton.ariaExpanded = 'false';
  }

  dropdownButton.addEventListener('click', (_) => {
    if (dropdownMenu.classList.contains('show')) {
      _closeMenu();
    } else {
      dropdownMenu.classList.add('show');
      dropdownButton.ariaExpanded = 'true';
    }
  });

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape') {
      _closeMenu();
    }
  });

  // Close the dropdown if any link in the TOC is navigated to.
  inlineToc.querySelectorAll('a').forEach(tocLink => {
    tocLink.addEventListener('click', (_) => {
      _closeMenu();
    });
  });

  // Close the dropdown if anywhere not in the inline TOC is clicked.
  document.addEventListener('click', (event) => {
    if (event.target.closest('#toc-top')) {
      return;
    }
    _closeMenu();
  });
}

function _setupTocActiveObserver() {
  const headings = document.querySelectorAll('article > .header-wrapper, #site-content-title');
  const currentHeaderText = document.getElementById('current-header');

  // No need to have toc scrollspy if there is only one non-title heading.
  if (headings.length < 2 || currentHeaderText === null) return;

  const visibleAnchors = new Set();
  const initialHeaderText = currentHeaderText.textContent;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        const headingId = entry.target.querySelector('h1, h2, h3')?.id;
        if (!headingId) return;

        if (entry.isIntersecting) {
          visibleAnchors.add(headingId);
        } else {
          visibleAnchors.delete(headingId);
        }
      });

      if (visibleAnchors.size > 0) {
        let isFirst = true;

        // If the page title is visible, set the current header to its contents.
        if (visibleAnchors.has('document-title')) {
          currentHeaderText.textContent = initialHeaderText;
          isFirst = false;
        }

        document.querySelectorAll(`.site-toc .sidenav-item a`).forEach(tocLink => {
          const headingId = tocLink.getAttribute('href')?.substring(1);
          if (!headingId) return;

          const sidenavItem = tocLink.closest('.sidenav-item');
          if (!sidenavItem) return;

          if (visibleAnchors.has(headingId)) {
            sidenavItem.classList.add('active');

            if (isFirst) {
              currentHeaderText.textContent = tocLink.textContent;
              isFirst = false;
            }
          } else {
            sidenavItem.classList.remove('active');
          }
        });
      }
    },{ rootMargin: '-80px 0px -25% 0px' });

  headings.forEach(heading => observer.observe(heading));
}

function setupPlatformKeys() {
  const os = getOS();
  const specialKey = os === 'macos' ? 'Command' : 'Control';
  document.querySelectorAll('kbd.special-key')
      .forEach(function (element) {
        element.textContent = specialKey;
      });
}

function _osNameFromId(osId) {
  switch (osId) {
    case 'macos':
      return 'macOS';
    case 'linux':
      return 'Linux';
    case 'chromeos':
      return 'ChromeOS';
    default:
      return 'Windows';
  }
}

function _adjustSelectedOs(osId) {
  if (!osId) return;

  const osName = _osNameFromId(osId);
  const selectedOsTextSpans = document.querySelectorAll('.selected-os-text');
  selectedOsTextSpans.forEach(function (span) {
    span.textContent = osName;
  });

  const osSelectors = document.querySelectorAll('.os-selector button');
  osSelectors.forEach(function (osSelector) {
    if (osSelector.getAttribute('data-os') === osId) {
      osSelector.classList.add('selected-card');
    } else {
      osSelector.classList.remove('selected-card');
    }
  });

  document.body.classList.remove('show-macos', 'show-linux', 'show-windows', 'show-chromeos');
  document.body.classList.add(`show-${osId}`);
}

function setupOsSelectors() {
  const currentOsId = getOS() ?? 'windows';
  _adjustSelectedOs(currentOsId);

  const osSelectors = document.querySelectorAll('.os-selector');

  for (const osSelector of osSelectors) {
    const osButtons = osSelector.querySelectorAll('button');
    for (const osButton of osButtons) {
      const osId = osButton.getAttribute('data-os');
      osButton.addEventListener('click', (e) => {
        _adjustSelectedOs(osId);
      });
    }
  }
}

function setupSite() {
  setupOsSelectors();

  setupToc();
  setupPlatformKeys();
  setupCollapsibleElements();
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', setupSite);
} else {
  setupSite();
}
