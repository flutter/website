/* eslint-disable require-jsdoc */
/* eslint-disable valid-jsdoc */
/**
 * Fetches Go link redirects from firebase.json
 * Since we can't access it from the site directly,
 * fetch it from GitHub main.
 */ 
function fetchGoLinks() {
  const firebaseConfigUrl = 'https://raw.githubusercontent.com/flutter/website/main/firebase.json';

  return fetch(firebaseConfigUrl)
      .then((response) => {
        if (!response.ok) {
          throw new Error('Failed to load resources.');
        }
        return response.json();
      })
      .then((firebaseConfig) => firebaseConfig.hosting.redirects)
      .catch((error) => {
        console.error('Error fetching Go links:', error);
        throw error; // Propagate the error to handle it at a higher level
      });
}

function createGoLinkElements(redirects) {
  const fragment = document.createDocumentFragment();

  redirects
      .filter(
          (redirect) =>
            redirect.source &&
        redirect.source.startsWith('/go/') &&
        redirect.source !== '/go/template' &&
        redirect.destination.startsWith('https://docs.google.com/'),
      )
      .forEach((redirect) => {
        const anchorElement = document.createElement('a');
        anchorElement.href = redirect.destination;
        anchorElement.textContent = redirect.source;

        const listItemElement = document.createElement('li');
        listItemElement.appendChild(anchorElement);

        fragment.appendChild(listItemElement);
      });

  return fragment;
}

function updateList(goLinksElement, redirects) {
  const goLinkElements = createGoLinkElements(redirects);
  goLinksElement.appendChild(goLinkElements);
}

function updateListFailed(goLinksElement) {
  const failedElement = document.createElement('li');
  failedElement.textContent =
      'Failed to load resources. Refresh page to try again.';
  goLinksElement.appendChild(failedElement);
}

function setup() {
  const goLinksElement = document.getElementById('go-links');
  if (!goLinksElement) {
    return;
  }

  fetchGoLinks()
      .then((redirects) => updateList(goLinksElement, redirects))
      .catch(() => updateListFailed(goLinksElement));
}

if (document.readyState !== 'loading') {
  setup();
} else {
  document.addEventListener('DOMContentLoaded', setup);
}
