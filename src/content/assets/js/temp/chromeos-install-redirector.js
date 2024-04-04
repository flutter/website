const oldToNew = {
  'configuring-web-app-support': '/get-started/install/chromeos/web',

  'android-setup-without-android-studio': '/get-started/install/chromeos/android?tab=download#configure-android-development',
  'android-setup': '/get-started/install/chromeos/android?tab=download#configure-android-development',
  'configuring-android-app-support': '/get-started/install/chromeos/android?tab=download#configure-android-development',
  'set-up-your-android-device': '/get-started/install/chromeos/android#configure-your-target-android-device',
  'set-up-the-android-emulator': '/get-started/install/chromeos/android#configure-your-target-android-device',
  'agree-to-android-licenses': '/get-started/install/chromeos/android#agree-to-android-licenses',
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
      }).catch((_) => {
  });
}

const currentLocation = window.location.pathname;

if (currentLocation.includes('/get-started/install/chromeos') &&
    currentLocation.split('/')
        .filter(value => value.trim().length !== 0).length === 3) {
  handleRedirect();
}
