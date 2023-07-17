// Number of releases to show by default (rest will be behind a "show all" link).
const releasesToShow = 99999;

// Fetches Flutter release JSON for the given OS and calls the callback once the data is available.
function fetchFlutterReleases(os, callback, errorCallback) {
  // OS: windows, macos, linux
  const url = `https://storage.googleapis.com/flutter_infra_release/releases/releases_${os}.json`;
  fetch(url, { method: 'GET'})
    .then(response => response.json())
    .then(data => callback(data, os))
    .catch(_ => { if (errorCallback) errorCallback(os) })
}

function updateTable(releases, os) {
  const releaseData = releases.releases;

  for (const channel in releases.current_release) {
    const table = document.getElementById(`downloads-${os}-${channel}`);

    //table is not present when channel is dev
    if (!table) {
      continue;
    }

    table.classList.add('collapsed');
    const loadingElements = table.querySelectorAll('.loading');
    loadingElements.forEach(function(element) {
      element.remove();
    });

    const releasesForChannel = releaseData.filter(function (release) {
      return release.channel === channel;
    });

    releasesForChannel.forEach(function(release, index) {
      // If this is the first row after the cut-off, insert the "Show more..." link.
      if (index === releasesToShow) {
        const showAll = document.createElement('a');
        showAll.textContent = 'Show all...';
        showAll.href = '#';
        showAll.addEventListener('click', function(event) {
          this.closest('table').classList.remove('collapsed');
          this.closest('tr').remove();
          event.preventDefault();
        });

        const row = document.createElement('tr');
        const cell = document.createElement('td');
        cell.colSpan = 6;
        cell.appendChild(showAll);
        row.appendChild(cell);
        table.appendChild(row);
      }

      const row = document.createElement('tr');
      if(index >= releasesToShow) {
        row.classList.add('overflow');
      }
      const url = releases.base_url + '/' + release.archive;
      table.appendChild(row);

      const hashLabel = document.createElement('span');
      hashLabel.textContent = release.hash.substr(0, 7);
      hashLabel.classList.add('git-hash');

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
    });
  }
}

function createTableCell(content, dataClass) {
  console.log({content});
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
  const tab = $(`#tab-os-${os}`);
  tab.find('.loading').text('Failed to load releases. Refresh page to try again.');
}

let macOSArm64ArchiveFilename = '';

// Listen for the macOS arm64 download link to be clicked and update
// the example unzip command with correct arm64 filename
$('.download-latest-link-macos-arm64').click(function () {
  // Update inlined filenames in <code> element text nodes with arm64 filename:
  const fileNamePrefix = 'flutter_';
  const code = $(`code:contains("${fileNamePrefix}")`);
  const textNode = $(code).contents().filter(function () {
    return this.nodeType === 3 && this.textContent.includes(fileNamePrefix);
  });

  $(textNode).replaceWith(`unzip ~/Downloads/${macOSArm64ArchiveFilename}`);
});

/*
releases: A list of Flutter releases 
base_url: link for sdk download link such as storage.googleapis.com...
os: macos, windows, or linux
[optional] arch: Only specify if there's additional architecture, such as arm64
*/
function updateReleaseDownloadButton(releases, base_url, os, arch = '') {
  const archString = !arch.length ? '' : `-${arch}`;

  const release = releases[0];
  const linkSegments = release.archive.split('/');
  const archiveFilename = linkSegments[linkSegments.length - 1]; // Just the filename part of url
  const downloadLink = $(`.download-latest-link-${os}${archString}`);

  if (os === 'macos' && arch === 'arm64') {
    macOSArm64ArchiveFilename = archiveFilename;
  }

  downloadLink
    .text(archiveFilename)
    .attr('href', `${base_url}/${release.archive}`);


  //Update download-filename placeholders:
  $(`.download-latest-link-filename-${os}${archString}`).text(archiveFilename);
  $('.download-latest-link-filename').text(archiveFilename);

  // Update inlined filenames in <code> element text nodes:
  const fileNamePrefix = 'flutter_';
  const code = $(`code:contains("${fileNamePrefix}")`);
  const textNode = $(code).contents().filter(function () {
    return this.nodeType === 3 && this.textContent.includes(fileNamePrefix);
  });
  const text = $(textNode).text();
  const newText = text.replace(new RegExp(`^(.*?)\\b${fileNamePrefix}\\w+_v.*`), `$1${archiveFilename}`);
  $(textNode).replaceWith(newText);
}

function updateDownloadLink(releases, os, arch) {
  const channel = 'stable';
  const releasesForChannel = releases.releases.filter(function (release) {
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

    updateReleaseDownloadButton(releasesForX64, releases.base_url, os);

    // Filter releases by arm64 architecture 
    const releasesForArm64 = releasesForChannel.filter(function (release) {
      return release.dart_sdk_arch === 'arm64';
    });

    // If no arm64 releases available, delete all apple silicon elements
    if (!releasesForArm64.length) {
      $('.apple-silicon').each(function () {
        this.remove();
      })

      return;
    }

    updateReleaseDownloadButton(releasesForArm64, releases.base_url, os, 'arm64');
  } else {
    updateReleaseDownloadButton(releasesForChannel, releases.base_url, os);
  }
}

function updateDownloadLinkFailed(os) {
  $(`.download-latest-link-${os}`).text('(failed)');
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
  provenanceAnchor.textContent = `${release.version} file`;
  return provenanceAnchor;
}


// Send requests to render the tables.
$(function () {
  if ($('#sdk-archives').length) {
    fetchFlutterReleases('windows', updateTable, updateTableFailed);
    fetchFlutterReleases('macos', updateTable, updateTableFailed);
    fetchFlutterReleases('linux', updateTable, updateTableFailed);
  }
  if ($('.download-latest-link-windows').length)
    fetchFlutterReleases('windows', updateDownloadLink, updateDownloadLinkFailed);
  if ($('.download-latest-link-macos').length)
    fetchFlutterReleases('macos', updateDownloadLink, updateDownloadLinkFailed);
  if ($('.download-latest-link-linux').length)
    fetchFlutterReleases('linux', updateDownloadLink, updateDownloadLinkFailed);
});
