// Number of releases to show by default (rest will be behind a "show all" link).
var releasesToShow = 5;

// Fetches Flutter release JSON for the given OS and calls the callback once the data is available.
var fetchFlutterReleases = function (os, callback, errorCallback) {
  // OS: windows, macos, linux
  var url = "https://storage.googleapis.com/flutter_infra_release/releases/releases_" + os + ".json";
  $.ajax({
    type: "GET",
    url: url,
    dataType: "json",
    success: function (data) {
      callback(data, os);
    },
    error: function (xhr, textStatus, errorThrown) {
      if (errorCallback)
        errorCallback(os);
    }
  })
}

function updateTable(releases, os) {
  var releaseData = releases.releases;

  for (var channel in releases.current_release) {
    var table = $("#downloads-" + os + "-" + channel);
    table.addClass("collapsed").find(".loading").remove();

    var releasesForChannel = releaseData.filter(function (release) {
      return release.channel == channel;
    });

    releasesForChannel.forEach(function (release, index) {
      // If this is the first row after the cut-off, insert the "Show more..." link.
      if (index === releasesToShow) {
        var showAll = $("<a />").text("Show all...").attr("href", "#").click(function (event) {
          $(this).closest("table").removeClass("collapsed");
          $(this).closest("tr").remove();
          event.preventDefault();
        });
        $("<tr>").append($("<td colspan=\"3\"></td></tr>").append(showAll)).appendTo(table);
      }

      var className = index >= releasesToShow ? "overflow" : "";
      var url = releases.base_url + "/" + release.archive;
      var row = $("<tr />").addClass(className).appendTo(table);
      var hashLabel = $("<span />").text(release.hash.substr(0, 7)).addClass("git-hash");
      var downloadLink = $("<a />").attr("href", url).text(release.version);
      var date = new Date(Date.parse(release.release_date));
      $("<td />").append(downloadLink).appendTo(row);
      $("<td />").append(hashLabel).appendTo(row);
      $("<td />").addClass("date").text(date.toLocaleDateString()).appendTo(row);
    });
  }
}

function updateTableFailed(os) {
  var tab = $("#tab-os-" + os);
  tab.find(".loading").text("Failed to load releases");
}

function updateDownloadLink(releases, os) {
  var channel = "beta";
  var releasesForChannel = releases.releases.filter(function (release) {
    return release.channel == channel;
  });
  if (!releasesForChannel.length)
    return;

  var release = releasesForChannel[0];
  var linkSegments = release.archive.split("/");
  var archiveFilename = linkSegments[linkSegments.length - 1]; // Just the filename part of url
  var downloadLink = $(".download-latest-link-" + os);
  downloadLink
    .text(archiveFilename)
    .attr("href", releases.base_url + "/" + release.archive);

  // We have may other placeholders on the page that want to show the download filename, so
  // update them.
  $(".download-latest-link-filename-" + os).text(archiveFilename);
}

function updateDownloadLinkFailed(os) {
  $(".download-latest-link-" + os).text("(failed)");
}

// Send requests to render the tables.
$(function () {
  if ($(".sdk-archives").length) {
    fetchFlutterReleases("windows", updateTable, updateTableFailed);
    fetchFlutterReleases("macos", updateTable, updateTableFailed);
    fetchFlutterReleases("linux", updateTable, updateTableFailed);
  }
  if ($(".download-latest-link-windows").length)
    fetchFlutterReleases("windows", updateDownloadLink, updateDownloadLinkFailed);
  if ($(".download-latest-link-macos").length)
    fetchFlutterReleases("macos", updateDownloadLink, updateDownloadLinkFailed);
  if ($(".download-latest-link-linux").length)
    fetchFlutterReleases("linux", updateDownloadLink, updateDownloadLinkFailed);
});

