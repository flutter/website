// Number of releases to show by default (rest will be behind a "show all" link).
var releasesToShow = 5;

// Fetches Flutter release JSON for the given OS and calls the callback once the data is available.
var fetchFlutterReleases = function (os, callback, errorCallback) {
  // OS: windows, macos, linux
  var url = "https://storage.googleapis.com/flutter_infra/releases/releases_" + os + ".json";
  $.ajax({
    type: "GET",
    url: url,
    dataType: "json",
    success: function (data) {
      callback(data, os);
    },
    error: function (xhr, textStatus, errorThrown) {
      errorCallback(os);
    }
  })
}

function convertReleaseFormat(releases, os) {
  // Convert releases into a format that's easier to work with:
  // Old
  // "1f3eb5034ff2372956620b2a9eb88683eee9495e": {
  // 	"dev": {
  // 		"release_date": "2018-02-27T00:26:37.058993Z",
  // 		"version": "v0.1.6",
  // 		"windows_archive": "dev/windows/flutter_windows_v0.1.6-dev.zip"
  // 	}
  // },
  // New:
  // {
  //   hash: 1f3eb5034ff2372956620b2a9eb88683eee9495e,
  //   channel: dev,
  // 	 release_date: Date("2018-02-27T00:26:37.058993Z"),
  // 	 version: "v0.1.6",
  //   archive: "dev/windows/flutter_windows_v0.1.6-dev.zip"
  // }
  return Object.keys(releases.releases).map(function (hash) {
    var release = releases.releases[hash];
    var channel = Object.keys(release)[0];
    return {
      hash: hash,
      channel: channel,
      release_date: new Date(Date.parse(release[channel].release_date)),
      version: release[channel].version,
      archive: release[channel][os + "_archive"]
    }
  })
}

function updateTable(releases, os) {
  // Convert the data for easier parsing and sort.
  var releaseData = convertReleaseFormat(releases, os).sort(function (r1, r2) {
    return r2.release_date.getTime() - r1.release_date.getTime();
  });

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
      $("<td />").append(downloadLink).appendTo(row);
      $("<td />").append(hashLabel).appendTo(row);
      $("<td />").addClass("date").text(release.release_date.toLocaleDateString()).appendTo(row);
    });
  }
}

function updateTableFailed(os) {
  var tab = $("#tab-os-" + os);
  tab.find(".loading").text("Failed to load releases");
}

// Send requests to render the tables.
$(function () {
  fetchFlutterReleases("windows", updateTable, updateTableFailed);
  fetchFlutterReleases("macos", updateTable, updateTableFailed);
  fetchFlutterReleases("linux", updateTable, updateTableFailed);
});

