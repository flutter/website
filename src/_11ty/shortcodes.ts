import {UserConfig} from '@11ty/eleventy';
import {slugify} from './utils/slugify.js';
import {fromHtml} from 'hast-util-from-html';
import {selectAll} from 'hast-util-select';
import {toHtml} from 'hast-util-to-html';

export function registerShortcodes(eleventyConfig: UserConfig): void {
  _setupTabs(eleventyConfig);
  _setupMedia(eleventyConfig);
}

function _setupMedia(eleventyConfig: UserConfig): void {
  eleventyConfig.addShortcode('ytEmbed', function (id: string, title: string, skipAlternativeLink = false, fullWidth = false) {
    let embedMarkup = `<iframe ${fullWidth ? 'class="full-width"' : 'width="560" height="315"'} 
        src="https://www.youtube.com/embed/${id}" title="${title}" frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
        allowfullscreen loading="lazy"></iframe><br>`;

    if (!skipAlternativeLink) {
      embedMarkup += `<p><a href="https://www.youtube.com/watch/${id}" target="_blank" rel="noopener" title="Open '${title}' video in new tab">${title}</a></p>`;
    }

    return embedMarkup;
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

  eleventyConfig.addPairedShortcode('tabs', function (content: string, saveKey: string) {
    const tabWrapperId = currentTabWrapperId++;
    let tabMarkup = `<div id="${tabWrapperId}" class="tabs-wrapper" ${saveKey ? `data-tab-save-key="${slugify(saveKey)}"` : ''}><ul class="nav-tabs" role="tablist">`;

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
  <a class="nav-link ${tabIsActive ? "active" : ""}" data-tab-save-id="${tabSaveId}" id="${tabId}" href="#${tabPanelId}" role="tab" aria-controls="${tabPanelId}" aria-selected="${tabIsActive ? "true" : "false"}">${tabName}</a>
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
