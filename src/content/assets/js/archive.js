// Number of releases to show by default (rest will be behind a "show all" link).
const releasesToShow = 99999;

// The Flutter SDK archive filename prefix.
const FILE_NAME_PREFIX = 'flutter_';

const filenameReplacement = new RegExp(`^(.*)(\\bflutter_\\w+_v?([X|0-9]\\.)+[zipxztar\\.]{2,3})`, 'm');
// const filenameReplacement = new RegExp(`^((.*) )* (.*?)\\b${FILE_NAME_PREFIX}\\w+_v?[X|0-9]+\\..* (.*)`, 'm');
// const filenameReplacement = new RegExp(`^(.*?)\\b{FILE_NAME_PREFIX}\\w+_v?([X|0-9]+\\.)+[zip|tar\\.xz](.*)$`, 'm');
// const filenameReplacement = new RegExp(`\\b{FILE_NAME_PREFIX}\\w+_v?\\d+(\\.\\d+)+\\.(zip|tar\\.xz)\\b`, 'm');

// Fetches Flutter release JSON for the given OS and calls the callback once the data is available.
function fetchFlutterReleases(os, callback, errorCallback) {
  // OS: windows, macos, linux
  const url = `https://storage.googleapis.com/flutter_infra_release/releases/releases_${os}.json`;
  fetch(url, { method: 'GET' })
    .then(response => response.json())
    .then(data => callback(data, os))
    .catch(_ => {
      if (errorCallback) {
        errorCallback(os);
      }
    });
}

function updateTable(releases, os) {
  const releaseData = releases.releases;
  for (const channel in releases.current_release) {
    const table = document.getElementById(`downloads-${os}-${channel}`);

    // Table is not present when the channel is `dev`.
    if (!table) {
      continue;
    }

    const tableBody = table.querySelector('tbody');

    table.classList.add('collapsed');
    const loadingElements = tableBody.querySelectorAll('.loading');
    loadingElements.forEach(function (element) {
      element.remove();
    });

    const releasesForChannel = releaseData.filter(function (release) {
      return release.channel === channel;
    });

    releasesForChannel.forEach(function (release, index) {
      // If this is the first row after the cut-off, insert the "Show more..." link.
      if (index === releasesToShow) {
        const showAll = document.createElement('a');
        showAll.textContent = 'Show all...';
        showAll.href = '#';
        showAll.addEventListener('click', function (event) {
          this.closest('table').classList.remove('collapsed');
          this.closest('tr').remove();
          event.preventDefault();
        });

        const row = document.createElement('tr');
        const cell = document.createElement('td');
        cell.colSpan = 6;
        cell.appendChild(showAll);
        row.appendChild(cell);
        tableBody.appendChild(row);
      }

      const row = document.createElement('tr');
      if (index >= releasesToShow) {
        row.classList.add('overflow');
      }

      const hashLabel = document.createElement('span');
      hashLabel.textContent = release.hash.substr(0, 7);
      hashLabel.classList.add('git-hash');

      const url = releases.base_url + '/' + release.archive;
      const downloadLink = document.createElement('a');
      downloadLink.href = url;
      downloadLink.textContent = release.version;

      const dartSdkVersion = document.createElement('span');
      dartSdkVersion.textContent = release.dart_sdk_version ? release.dart_sdk_version.split(' ')[0] : '-';

      const dartSdkArch = document.createElement('span');
      dartSdkArch.textContent = release.dart_sdk_arch ? release.dart_sdk_arch : 'x64';

      const date = new Date(Date.parse(release.release_date));

      const provenance = getProvenanceLink(os, release, date, channel);

      const cells = [
        createTableCell(downloadLink),
        createTableCell(dartSdkArch),
        createTableCell(hashLabel),
        createTableCell(date.toLocaleDateString(), 'date'),
        createTableCell(dartSdkVersion),
        createTableCell(provenance)
      ];

      cells.forEach(function (cell) {
        row.appendChild(cell);
      });

      tableBody.appendChild(row);
    });
  }
}

/**
 * Create a new individual cell for HTML table.
 * 
 * @param {string | Node} content - The content to be set in the cell.
 * @param {string | null | undefined} dataClass - The class to be set in the cell.
 * @returns {HTMLElement} The created table cell element.
 */
function createTableCell(content, dataClass) {
  const cell = document.createElement('td');

  if (dataClass) {
    cell.classList.add(dataClass);
  }

  if (typeof content === 'string') {
    cell.textContent = content;
  } else {
    cell.appendChild(content);
  }

  return cell;
}

function updateTableFailed(os) {
  const tab = document.getElementById(`tab-os-${os}`);
  if (!tab) return;
  const loadingElements = tab.querySelectorAll('.loading');
  loadingElements.forEach(function (element) {
    element.textContent = 'Failed to load releases. Refresh page to try again.';
  });
}

let macOSArm64ArchiveFilename = '';

// Listen for the macOS arm64 download link to be clicked and update
// the example unzip command with correct arm64 filename
(() => {
  const macDownload = document.querySelector('.download-latest-link-macos-arm64');
  if (!macDownload) {
    return;
  }
  macDownload.addEventListener('click', function () {
    // Update inlined filenames in <code> element text nodes with arm64 filename:
    replaceFilenameInCodeElements(macOSArm64ArchiveFilename);
  });
})();

/**
 * Replaces the placeholder text or the old filename in code blocks
 * with the specified {@link archiveFilename}.
 * 
 * @param archiveFilename The new filename to replace the
 *   old one in code blocks with
 */
function replaceFilenameInCodeElements(archiveFilename) {
  const codeElements = document.querySelectorAll('code');

  codeElements.forEach((codeElement) => {
    // Check if the <code> element itself needs replacement
    const codeElementText = codeElement.innerHTML;
    if (codeElementText.includes(FILE_NAME_PREFIX) &&
        filenameReplacement.test(codeElementText)) {
      codeElement.innerHTML = codeElementText.replace(
        filenameReplacement,
        `$1${archiveFilename}`
      );
    }

    // Process child nodes as before 
    codeElement.childNodes.forEach((node) => {
      const nodeText = node.textContent;
      if (node.nodeType === Node.TEXT_NODE &&
          nodeText.includes(FILE_NAME_PREFIX)) {
        node.textContent = nodeText.replace(
          filenameReplacement,
          `$1${archiveFilename}`
        );
      }
    });
  });
}


/**
 * Update the download button for the latest release.
 * @param {Array} releases - A list of Flutter releases 
 * @param {string} base_url - link for sdk download link such as storage.googleapis.com...
 * @param {string} os - macos, windows, or linux
 * @param {string} [arch=''] - Only specify if there's additional architecture, such as arm64
 */
function updateReleaseDownloadButton(releases, base_url, os, arch = '') {
  const archString = !arch.length ? '' : `-${arch}`;

  const release = releases[0];
  const linkSegments = release.archive.split('/');
  const archiveFilename = linkSegments[linkSegments.length - 1]; // Just the filename part of url

  if (os === 'macos' && arch === 'arm64') {
    macOSArm64ArchiveFilename = archiveFilename;
  }

  const downloadLink = document.querySelectorAll(`.download-latest-link-${os}${archString}`);
  downloadLink.forEach((link) => {
    link.textContent = archiveFilename;
    link.setAttribute('href', `${base_url}/${release.archive}`);
  })

  //Update download-filename placeholders:
  const downloadLinkOs = document.querySelectorAll(`.download-latest-link-filename-${os}${archString}`);
  downloadLinkOs.forEach(function (element) {
    element.textContent = archiveFilename;
  });

  const genericDownloadLink = document.querySelectorAll('.download-latest-link-filename');
  genericDownloadLink.forEach(function (element) {
    element.textContent = archiveFilename;
  });

  // Update inlined filenames in <code> element text nodes:
  replaceFilenameInCodeElements(archiveFilename);
}

function updateDownloadLink(releases, os, arch) {
  const channel = 'stable';
  const releasesOrDefault = releases?.releases ?? [];
  const releasesForChannel = Array.from(releasesOrDefault).filter(function (release) {
    return release.channel === channel;
  });
  if (!releasesForChannel.length)
    return;

  // On macOS, update the download buttons for both architectures, x64 and arm64
  if (os === 'macos') {
    // Filter releases by x64 architecture
    const releasesForX64 = releasesForChannel.filter(function (release) {
      return release.dart_sdk_arch === 'x64';
    });

    // Filter releases by arm64 architecture
    const releasesForArm64 = releasesForChannel.filter(function (release) {
      return release.dart_sdk_arch === 'arm64';
    });

    // If no arm64 releases available, delete all apple silicon elements
    if (!releasesForArm64.length) {
      const appleSiliconElements = document.querySelectorAll('.apple-silicon');
      appleSiliconElements.forEach(function (element) {
        element.remove();
      });

      return;
    }

    updateReleaseDownloadButton(releasesForArm64, releases.base_url, os, 'arm64');
    updateReleaseDownloadButton(releasesForX64, releases.base_url, os);
  } else {
    updateReleaseDownloadButton(releasesForChannel, releases.base_url, os);
  }
}

function updateDownloadLinkFailed(os) {
  const allDownloadLinks = document.querySelectorAll(`.download-latest-link-${os}`);
  allDownloadLinks.forEach(function (link) {
    link.textContent = '(failed)';
  });
}

function getProvenanceLink(os, release, date, channel) {
  const baseUrl = 'https://storage.googleapis.com/flutter_infra_release/releases/';
  if (os === 'windows' && date < new Date(Date.parse('4/3/2023'))) {
    // provenance not available before 4/3/2023 for Windows
    const spanElement = document.createElement('span');
    spanElement.textContent = '-';
    return spanElement;
  } else if (date < new Date(Date.parse('12/15/2022'))) {
    // provenance not available before 12/15/2022 for macOS and Linux
    const spanElement = document.createElement('span');
    spanElement.textContent = '-';
    return spanElement;
  }

  const extension = os === 'linux' ? 'tar.xz' : 'zip';
  const provenanceAnchor = document.createElement('a');
  provenanceAnchor.href = `${baseUrl}${channel}/${os}/flutter_${os}_${release.version}-${channel}.${extension}.intoto.jsonl`;
  provenanceAnchor.textContent = `Attestation bundle`;
  provenanceAnchor.target = '_blank';
  return provenanceAnchor;
}


// Send requests to render the tables.
document.addEventListener("DOMContentLoaded", function(_) {
  const foundSdkArchivesElement = document.querySelector('.tabs-wrapper[data-tab-save-key="os-archive-tabs"]') !== null;
  if (foundSdkArchivesElement) {
    fetchFlutterReleases('windows', updateTable, updateTableFailed);
    fetchFlutterReleases('macos', updateTable, updateTableFailed);
    fetchFlutterReleases('linux', updateTable, updateTableFailed);
  }

  // The checks below come from getting started page. see https://github.com/flutter/website/issues/8889#issuecomment-1639033078
  const foundLatestWindows = document.getElementsByClassName('download-latest-link-windows').length > 0;
  if (foundLatestWindows) {
    fetchFlutterReleases('windows', updateDownloadLink, updateDownloadLinkFailed);
  }

  const foundLatestMacOS = document.getElementsByClassName('download-latest-link-macos').length > 0;
  if (foundLatestMacOS) {
    fetchFlutterReleases('macos', updateDownloadLink, updateDownloadLinkFailed);
  }

  const foundLatestLinux = document.getElementsByClassName('download-latest-link-linux').length > 0;
  if (foundLatestLinux) {
    fetchFlutterReleases('linux', updateDownloadLink, updateDownloadLinkFailed);
  }
});
