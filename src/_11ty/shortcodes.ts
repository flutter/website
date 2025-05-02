import {UserConfig} from '@11ty/eleventy';
import {slugify} from './utils/slugify.js';
import {fromHtml} from 'hast-util-from-html';
import {selectAll} from 'hast-util-select';
import {toHtml} from 'hast-util-to-html';

export function registerShortcodes(eleventyConfig: UserConfig): void {
  _setupTabs(eleventyConfig);
  _setupMedia(eleventyConfig);
  _setupOsSelector(eleventyConfig);
}

function _setupOsSelector(eleventyConfig: UserConfig): void {
  eleventyConfig.addShortcode('osSelector', function () {
    const osNames = ['Windows', 'macOS', 'Linux', 'ChromeOS'];

    function createOsButton(osName: string, selected: boolean = false) {
      const osId = osName.toLowerCase();
      return `
<button class="card outlined-card install-card${selected ? ' selected-card' : ''}" id="install-${osId}" data-os="${osId}" aria-label="Update docs to cover ${osName}">
  <div class="card-leading">
    <img src="/assets/images/docs/brand-svg/${osId}.svg" width="72" height="72" aria-hidden="true" alt="${osName} logo">
  </div>
  <div class="card-header text-center">
    <span class="card-title">${osName}</span>
  </div>
</button>`;
    }

    return `
<div class="card-grid narrow os-selector">
  ${osNames.map((osName) => {
      return createOsButton(osName, osName === 'Windows');
    }).join('\n')}
</div>`;
  });
}

function _setupMedia(eleventyConfig: UserConfig): void {
  eleventyConfig.addShortcode('ytEmbed', function (id: string, title: string, fullWidth = false) {
    return `
<lite-youtube videoid="${id}" videotitle="${title}" ${fullWidth ? 'class="full-width"' : ''}>
  <p><a class="lite-youtube-fallback" href="https://www.youtube.com/watch/${id}" target="_blank" rel="noopener">Watch on YouTube in a new tab: "${title}"</a></p>
</lite-youtube>`;
  });

  eleventyConfig.addPairedShortcode('videoWrapper', function (content: string, intro = '') {
    let wrapperMarkup = '<div class="video-wrapper">';
    if (intro && intro !== '') {
      wrapperMarkup += `<span class="video-intro">${intro}</span>`;
    }

    wrapperMarkup += content;
    wrapperMarkup += '</div>';
    return wrapperMarkup;
  });
}

function _setupTabs(eleventyConfig: UserConfig) {
  // Counter shared between all tabs and wrappers to
  // ensure each has a unique ID.
  let currentTabWrapperId = 0;
  let currentTabPaneId = 0;

  eleventyConfig.addPairedShortcode('tabs', function (content: string, saveKey: string, wrapped: boolean = false) {
    const tabWrapperId = currentTabWrapperId++;
    let tabMarkup = `<div id="${tabWrapperId}" class="tabs-wrapper${wrapped ? " wrapped" : ""}" ${saveKey ? `data-tab-save-key="${slugify(saveKey)}"` : ''}><ul class="nav-tabs" role="tablist">`;

    // Only select child tab panes that don't already have a parent wrapper.
    const tabPanes = selectAll('.tab-pane[data-tab-wrapper-id="undefined"]', fromHtml(content));
    if (tabPanes.length <= 1) {
      throw new Error(`Tabs with save key of ${saveKey} needs more than one tab!`);
    }

    let setTabToActive = true;
    for (const tabPane of tabPanes) {
      // Keep track of the tab wrapper ID to avoid including
      // a duplicate of this tab's contents in a parent wrapper.
      tabPane.properties.dataTabWrapperId = tabWrapperId;

      const tabId = tabPane.properties.dataTabId! as string;
      const tabPanelId = `${tabId}-panel`;
      const tabName = tabPane.properties.dataTabName! as string;
      const tabIsActive = setTabToActive;

      // Only set the first tab of a wrapper to active initially.
      if (tabIsActive) {
        tabPane.properties['className'] += ' active';
        setTabToActive = false;
      }

      const tabSaveId = slugify(tabName);
      tabMarkup += `<li class="nav-item">
  <a class="nav-link ${tabIsActive ? "active" : ""}" tabindex="0" data-tab-save-id="${tabSaveId}" id="${tabId}" href="#${tabPanelId}" role="tab" aria-controls="${tabPanelId}" aria-selected="${tabIsActive ? "true" : "false"}">${tabName}</a>
</li>`;
    }

    tabMarkup += '</ul><div class="tab-content">\n';
    tabMarkup += toHtml(tabPanes);
    tabMarkup += '\n</div></div>';

    return tabMarkup;
  });

  eleventyConfig.addPairedShortcode('tab', function (content: string, tabName: string) {
    const tabIdNumber = currentTabPaneId++;
    const tabId = `${tabIdNumber}-tab`;
    const tabPanelId = `${tabId}-panel`;
    return `<div class="tab-pane" id="${tabPanelId}" role="tabpanel" aria-labelledby="${tabId}" data-tab-id="${tabId}" data-tab-name="${tabName}" data-tab-wrapper-id="undefined">

${content}

</div>
`;
  });
}
