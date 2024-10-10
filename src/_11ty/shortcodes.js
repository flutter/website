import {slugify} from './utils/slugify.js';

export function registerShortcodes(eleventyConfig) {
  _setupTabs(eleventyConfig);
  _setupMedia(eleventyConfig);
}

function _setupMedia(eleventyConfig) {
  eleventyConfig.addShortcode('ytEmbed', function (id, title, skipAlternativeLink = false, fullWidth = false) {
    let embedMarkup = `<iframe ${fullWidth ? 'class="full-width"' : 'width="560" height="315"'} 
        src="https://www.youtube.com/embed/${id}" title="${title}" frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
        allowfullscreen loading="lazy"></iframe>`;

    if (!skipAlternativeLink) {
      embedMarkup += `<p><a href="https://www.youtube.com/watch/${id}" target="_blank" rel="noopener" title="Open '${title}' video in new tab">${title}</a></p>`;
    }

    return embedMarkup;
  });

  eleventyConfig.addPairedShortcode('videoWrapper', function (content, intro = '') {
    let wrapperMarkup = '<div class="video-wrapper">';
    if (intro && intro !== '') {
      wrapperMarkup += `<span class="video-intro">${intro}</span>`;
    }

    wrapperMarkup += content;
    wrapperMarkup += '</div>';
    return wrapperMarkup;
  });
}

function _setupTabs(eleventyConfig) {
  // Variable shared between all tabs to ensure each has a unique ID.
  let currentTabId = 0;

  // Variables that are shared between the tabs within a tabs shortcode,
  // and should be reset before returning from tabs.
  let tabs = [];
  let markTabAsActive = true;

  eleventyConfig.addPairedShortcode('tabs', function (content, saveKey) {
    let tabMarkup = `<div class="tabs-wrapper" ${saveKey ? `data-tab-save-key="${slugify(saveKey)}"` : ''}><ul class="nav nav-tabs" role="tablist">`;
    let activeTab = true;

    tabs.forEach((tab) => {
      const tabName = tab.name;
      const tabSaveId = slugify(tabName);
      const tabId = `${tab.id}-tab`;
      const tabPanelId = `${tabId}-panel`;
      tabMarkup += `<li class="nav-item">
  <a class="nav-link ${activeTab ? "active" : ""}" data-tab-save-id="${tabSaveId}" id="${tabId}" href="#${tabPanelId}" role="tab" aria-controls="${tabPanelId}" aria-selected="${activeTab ? "true" : "false"}">${tabName}</a>
</li>`;
      activeTab = false;
    });

    tabMarkup += '</ul><div class="tab-content">\n';
    tabMarkup += content;
    tabMarkup += '\n</div></div>';

    // Reset shared variables.
    tabs = [];
    markTabAsActive = true;

    return tabMarkup;
  });

  eleventyConfig.addPairedShortcode('tab', function (content, tabName) {
    const tabIdNumber = currentTabId++;
    tabs.push({name: tabName, id: tabIdNumber});
    const tabId = `${tabIdNumber}-tab`;
    const tabPanelId = `${tabId}-panel`;
    const tabContent = `<div class="tab-pane ${markTabAsActive ? "active" : ""}" id="${tabPanelId}" role="tabpanel" aria-labelledby="${tabId}">

${content}

</div>
`;

    // No other tabs should be marked as active.
    markTabAsActive = false;

    return tabContent;
  });
}
