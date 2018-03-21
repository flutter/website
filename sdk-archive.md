---
layout: page
title: Flutter SDK Archive

permalink: /sdk-archive/
---

The Beta channel contains the most stable Flutter builds. See [Flutter’s
channels](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
for details.

<div id="tab-set-os" class="sdk-archives">

	<ul class="tabs__top-bar">
		<li class="tab-link current" data-tab="tab-os-windows">Windows</li>
		<li class="tab-link" data-tab="tab-os-macos">Mac OS</li>
		<li class="tab-link" data-tab="tab-os-linux">Linux</li>
	</ul>

	<div id="tab-os-windows" class="tabs__content current">

		<h2>Beta channel, Windows</h2>
		<table id="downloads-windows-beta">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table><br />

		<h2>Dev channel, Windows</h2>
		<table id="downloads-windows-dev">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table>

	</div>

	<div id="tab-os-macos" class="tabs__content">
	
		<h2>Beta channel, Mac OS</h2>
		<table id="downloads-macos-beta">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table><br />

		<h2>Dev channel, Mac OS</h2>
		<table id="downloads-macos-dev">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table>

	</div>

	<div id="tab-os-linux" class="tabs__content">

		<h2>Beta channel, Linux</h2>
		<table id="downloads-linux-beta">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table><br />
		
		<h2>Dev channel, Linux</h2>
		<table id="downloads-linux-dev">
			<thead><tr><th>Version</th><th>Ref</th><th class="date">Release Date</th></tr></thead>
			<tr class="loading"><td colspan="3">Loading...</td></tr>
		</table>

	</div>

</div>

## Master channel

Installation bundles are not available for master. However, you can get the SDK
directly from our GitHub repo by 'git cloning' the master channel (as
specified by -b master), and then trigger a download of the SDK dependencies:

```terminal
git clone -b master https://github.com/flutter/flutter.git
./flutter/bin/flutter --version
```

For additional details on how our installation bundles are structured, see
[Installation bundles](https://github.com/flutter/flutter/wiki/Flutter-Installation-Bundles).
