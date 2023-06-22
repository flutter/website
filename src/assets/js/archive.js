// Number of releases to show by default (rest will be behind a "show all" link).
const releasesToShow = 99999;

// Fetches Flutter release JSON for the given OS and calls the callback once the data is available.
function fetchFlutterReleases(os, callback, errorCallback) {
  // OS: windows, macos, linux
  const url = `https://storage.googleapis.com/flutter_infra_release/releases/releases_${os}.json`;
  $.ajax({
    type: 'GET',
    url: url,
    dataType: 'json',
    success: function (data) { callback(data, os); },
    error: function (xhr, textStatus, errorThrown) {
      if (errorCallback) errorCallback(os);
    }
  })
}

function updateTable(releases, os) {
  const releaseData = releases.releases;

  for (const channel in releases.current_release) {
    const table = $(`#downloads-${os}-${channel}`);
    table.addClass('collapsed').find('.loading').remove();

    const releasesForChannel = releaseData.filter(function (release) {
      return release.channel === channel;
    });

    releasesForChannel.forEach(function (release, index) {
      // If this is the first row after the cut-off, insert the "Show more..." link.
      if (index === releasesToShow) {
        const showAll = $('<a />').text('Show all...').attr('href', '#').click(function (event) {
          $(this).closest('table').removeClass('collapsed');
          $(this).closest('tr').remove();
          event.preventDefault();
        });
        $('<tr>').append($('<td colspan="6"></td></tr>').append(showAll)).appendTo(table);
      }

      const className = index >= releasesToShow ? 'overflow' : '';
      const url = releases.base_url + '/' + release.archive;
      const row = $('<tr />').addClass(className).appendTo(table);
      const hashLabel = $('<span />').text(release.hash.substr(0, 7)).addClass('git-hash');
      const downloadLink = $('<a />').attr('href', url).text(release.version);
      const dartSdkVersion = $('<span />').text(
        release.dart_sdk_version ? release.dart_sdk_version.split(' ')[0] : '-',
      );
      const dartSdkArch = $('<span />').text(
        release.dart_sdk_arch ? release.dart_sdk_arch : 'x64',
      );
      const date = new Date(Date.parse(release.release_date));
      const provenance = getProvenanceLink(os, release, date, channel);
      $('<td />').append(downloadLink).appendTo(row);
      $('<td />').append(dartSdkArch).appendTo(row);
      $('<td />').append(hashLabel).appendTo(row);
      $('<td />').addClass('date').text(date.toLocaleDateString()).appendTo(row);
      $('<td />').append(dartSdkVersion).appendTo(row);
      $('<td />').append(provenance).appendTo(row);
    });
  }
}

function updateTableFailed(os) {
  const tab = $(`#tab-os-${os}`);
  tab.find('.loading').text('Failed to load releases. Refresh page to try again.');
}

let macOSArm64ArchiveFilename = '';

// Listen for the macOS arm64 download link to be clicked and update
// the example unzip command with correct arm64 filename
$('.download-latest-link-macos-arm64').click(function() {
  // Update inlined filenames in <code> element text nodes with arm64 filename:
  const fileNamePrefix = 'flutter_';
  const code = $(`code:contains("${fileNamePrefix}")`);
  const textNode = $(code).contents().filter(function() {
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
  const archString = !arch.length ? '': `-${arch}`;

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
  const textNode = $(code).contents().filter(function() {
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
      $('.apple-silicon').each(function(){
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
  const baseUrl = 'https://storage.googleapis.com/flutter_infra_release/releases/'
  if (os === 'windows' && date < new Date(Date.parse('4/3/2023'))) {
    // provenance not available before 4/3/2023 for Windows
    return $('<span />').text('-');
  } else if (date < new Date(Date.parse('12/15/2022'))) {
    // provenance not available before 12/15/2022 for macOS and Linux
    return $('<span />').text('-');
  }
  const extension = os === 'linux' ? 'tar.xz' : 'zip';
  return $('<a />').attr('href',
    `${baseUrl}${channel}/${os}/flutter_${os}_${release.version}-${channel}`+
    `.${extension}.intoto.jsonl`
  ).text(`${release.version} file`)
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
