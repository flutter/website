// Fetches Go link redirects from firebase.json
// Since we can't access it from the site directly, fetch it from GitHub main.
const fetchGoLinks = function (callback, errorCallback) {
  // OS: windows, macos, linux
  const url = "https://raw.githubusercontent.com/flutter/website/main/firebase.json";
  $.ajax({
    type: "GET",
    url: url,
    dataType: "json",
    success: function (data) { callback(data); },
    error: function (xhr, textStatus, errorThrown) {
      if (errorCallback) errorCallback();
    }
  })
}

function updateList(links) {
  const go_links = $('#go-links');
  if (!go_links) {
    return;
  }

  links.hosting.redirects.filter(
      redirect =>
          redirect.source &&
          redirect.source.startsWith('/go/') &&
          redirect.source !== '/go/template'
  ).forEach(
      redirect => go_links.append(`<li><a href="${redirect.destination}">${redirect.source}</a></li>`)
  );
}

function updateListFailed() {
  const go_links = $('#go-links');
  if (!go_links) {
    return;
  }
  go_links.append(`<li>Failed to load resources. Refresh page to try again.</li>`);
}

// Send requests to render the tables.
$(function () {
  fetchGoLinks(updateList, updateListFailed);
});
