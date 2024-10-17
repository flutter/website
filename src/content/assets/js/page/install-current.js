// Depends on main.js being loaded first.
// Highlights the card for the current OS on `/get-started/install/`.
document.addEventListener("DOMContentLoaded", function(_) {
  if (!getOS) return;

  const currentOS = getOS();
  if (!currentOS) return;

  const osButton = document.getElementById(`install-${currentOS}`);
  if (!osButton) return;

  osButton.classList.add('card-highlight');

  const header = osButton.querySelector('.card-title');
  if (!header) return;
  const currentSubtitle = document.createElement('span');
  currentSubtitle.textContent = 'Current device';
  currentSubtitle.classList.add('card-subtitle');
  header.appendChild(currentSubtitle);
});
