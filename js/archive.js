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

function updateTable(releases, os) {
  // Convert the data for easier parsing and sort.
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

// Send requests to render the tables.
$(function () {
  if ($(".sdk-archives").length) {
    fetchFlutterReleases("windows", updateTable, updateTableFailed);
    fetchFlutterReleases("macos", updateTable, updateTableFailed);
    fetchFlutterReleases("linux", updateTable, updateTableFailed);
  }
});

