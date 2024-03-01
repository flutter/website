// Depends on main.js being loaded first.
// Focuses the card for the current OS on `/get-started/install/`.
document.addEventListener("DOMContentLoaded", function(_) {
  if (!getOS) return;

  const currentOS = getOS();
  if (!currentOS) return;

  const osButton = document.getElementById(`install-${currentOS}`);
  if (!osButton) return;

  osButton.focus();
  osButton.classList.add('card-highlight');
});
