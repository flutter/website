// Fetches Go link redirects from firebase.json
// Since we can't access it from the site directly, fetch it from GitHub main.
function fetchGoLinks(callback, errorCallback, goLinksElement) {
  const firebaseConfigUrl = 'https://raw.githubusercontent.com/flutter/website/main/firebase.json';

  fetch(firebaseConfigUrl)
      .then(response => {
        if (response.status === 200) {
          return response.json();
        } else {
          throw Error('Failed to load resources.');
        }
      })
      .then(firebaseConfig => updateList(firebaseConfig.hosting.redirects, goLinksElement))
      .catch(_ => {
        if (errorCallback) errorCallback(goLinksElement);
      });
}

function updateList(redirects, goLinksElement) {
  redirects.filter(
      redirect =>
          redirect.source &&
          redirect.source.startsWith('/go/') &&
          redirect.source !== '/go/template' &&
          redirect.destination.startsWith('https://docs.google.com/')
  ).forEach(
      redirect => {
        const anchorElement = document.createElement('a');
        anchorElement.href = redirect.destination;
        anchorElement.textContent = redirect.source;

        const listItemElement = document.createElement('li');
        listItemElement.appendChild(anchorElement);

        goLinksElement.appendChild(listItemElement);
      }
  );
}

function updateListFailed(goLinksElement) {
  const failedElement = document.createElement('li');
  failedElement.textContent = 'Failed to load resources. Refresh page to try again.';

  goLinksElement.appendChild(failedElement);
}

function setup() {
  const goLinksElement = document.getElementById('go-links');
  if (!goLinksElement) {
    return;
  }

  // Send request to get list, then render the list
  fetchGoLinks(updateList, updateListFailed, goLinksElement);
}

if (document.readyState !== "loading") {
  setup();
} else {
  document.addEventListener("DOMContentLoaded", setup);
}
