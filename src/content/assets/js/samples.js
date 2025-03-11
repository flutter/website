function setupSampleFilters() {
    const rows = document
        .getElementById('all-samples-tables')
        ?.querySelectorAll('.table-row');
    if (!rows) return;

    const sampleInfo = [];
    rows.forEach(row => {
        const sampleName = row.id;
        if (!sampleName) return;
        sampleInfo.push({
            name: sampleName,
            isDart: row.dataset.isDart === 'true',
            isFlutter: row.dataset.isFlutter === 'true',
            isCodelab: row.dataset.isCodelab === 'true',
            isSample: row.dataset.isSample === 'true',
            isDemo: row.dataset.isDemo === 'true',
        });

        const sourceButton = row.querySelector('.icon-button');
        if (!sourceButton) return;

        sourceButton.addEventListener('click', async () => {
            // TODO(ewindmill): Custom analytics event
        });
    });

    const filterButtons = document.getElementById('samples-filters');
    if (!filterButtons) return;

    const filterChips = filterButtons.querySelectorAll('button.filter-chip');
    const chips = filterButtons.querySelectorAll('button.chip');

    filterChips.forEach(chip => {
        chip.addEventListener('click', () => {
            chip.classList.toggle('selected');
            const checked = chip.ariaChecked;
            chip.ariaChecked = checked === 'true' ? 'false' : 'true';
            filterSamples();
        });
    });

    function filterSamples() {
        const samplesToShow = new Set();
        const selectedChips = Array.from(chips).filter(chip => chip.classList.contains('selected'));
        const selectedProperties = selectedChips.map(chip => chip.dataset.filter);

        for (const sample of sampleInfo) {
            const sampleName = sample.name;
            // if at least one property in the sample is not true, don't show
            if (selectedProperties.any(property => sample[property] !== true)) continue;
            samplesToShow.add(sampleName);
        }
    }

    filterSamples();
}

document.onreadystatechange = () => {
    switch(document.readyState) {
        case "interactive":
            setupSampleFilters();
            break;
        case "complete":
            setupSampleFilters();
            break;
    }
}
