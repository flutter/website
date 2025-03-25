/* Finds all the relevant HTML elements, and adds click handlers to them that
*  facilitate searching and filtering the samples index page.
*/
function setupSampleFilters() {
    const sampleCards = document.getElementById('all-samples-grid')?.querySelectorAll('.card');
    if (!sampleCards) return
    const samplesInfo = [];

    sampleCards.forEach(card => {
        const sampleName = card.id;
        if (!sampleName) return;
        samplesInfo.push({
            name: sampleName,
            type: card.dataset.type,
            tags: card.dataset.tags.split(', '),
            description: card.dataset.description,
        });

        card.addEventListener('click', async () => {
            window.dataLayer?.push({
                'event': 'samples_index_click',
                'resource_type': card.dataset.type,
                'resource_title': sampleName,
            })
        });
    });

    const filtersSection = document.getElementById('samples-filter-group');
    const searchInput = filtersSection.querySelector('.search-wrapper input');

    function filterSamples() {
        const samplesToShow = new Set();
        const searchTerm = searchInput.value.toLowerCase();
        for (const sample of samplesInfo) {
            if (sample.name.toLowerCase().includes(searchTerm) ||
                sample.tags.join('').toLowerCase().includes(searchTerm) ||
                sample.type.toLowerCase().includes(searchTerm) ||
                sample.description.toLowerCase().includes(searchTerm)) {
                samplesToShow.add(sample.name);
            }

        }


        sampleCards.forEach(card => {
            const sampleName = card.id;
            if (samplesToShow.has(sampleName)) {
                card.classList.remove('hidden');
            } else {
                card.classList.add('hidden');
            }
        });
    }

    searchInput.addEventListener('input', filterSamples);
    document.addEventListener('click', (event) => {
        // If not clicking inside a menu wrapper, close all menus.
        if (!event.target.closest('.button-menu-wrapper')) {
            _closeMenusAndToggle();
        }
    });

    document.addEventListener('keydown', (event) => {
        // If pressing the `esc` key in the filter area, close any open menus.
        if (event.key === 'Escape' && event.target.closest('#filter-and-search')) {
            _closeMenusAndToggle();
        }
    });

    filterSamples();
}

function _closeMenusAndToggle(menuToToggle = '') {
    document.querySelectorAll('.select-chip').forEach(chip => {
        const menu = chip.parentElement.querySelector('.select-menu');
        if (menu.id === menuToToggle) {
            if (menu.classList.contains('show-menu')) {
                menu.classList.remove('show-menu');
                chip.ariaExpanded = 'false';
            } else {
                menu.classList.add('show-menu');
                chip.ariaExpanded = 'true';
            }
        } else {
            // Close all other menus.
            menu.classList.remove('show-menu');
            chip.ariaExpanded = 'false';
        }
    });
}

document.onreadystatechange = () => {
    switch (document.readyState) {
        case "interactive":
            setupSampleFilters();
            break;
        case "complete":
            setupSampleFilters();
            break;
    }
}
