const oldToNew = {
  'windows-setup': '/get-started/install/windows/desktop',

  'set-up-your-android-device': '/get-started/install/windows/mobile#configure-your-target-android-device',
  'set-up-the-android-emulator': '/get-started/install/windows/mobile#configure-your-target-android-device',
  'agree-to-android-licenses': '/get-started/install/windows/mobile#agree-to-android-licenses',
  'android-setup': '/get-started/install/windows/mobile#configure-android-development',
};

function handleRedirect() {
  const rawOldFragment = window.location.hash;

  // If no fragment was specified, don't do anything.
  if (!rawOldFragment) {
    return;
  }

  const oldFragmentWithHash = rawOldFragment.trim().toLowerCase();

  // If the fragment is empty, don't do anything.
  if (oldFragmentWithHash.length === 0) {
    return;
  }

  const oldFragment = oldFragmentWithHash.substring(1);

  // If the fragment did not exist, don't do anything.
  if (!(oldFragment in oldToNew)) {
    return;
  }

  const newDestination = oldToNew[oldFragment];

  // If the desired destination exists, go there.
  // Otherwise, don't go anywhere.
  fetch(newDestination)
      .then((response) => {
        if (response.status === 200) {
          window.location.replace(newDestination);
        }
      }).catch((_) => {});
}

const currentLocation = window.location.pathname;

// Only handle redirects in the parent directory, not any subdirectories.
if (currentLocation.includes('/get-started/install/windows') &&
    currentLocation.split('/')
        .filter(value => value.trim().length !== 0).length === 3) {
  handleRedirect();
}
