const _filters = {
    type: 'all',
    searchTerm: '',
};

function setupSampleFilters() {
    /*
    * Section -- set up tables and rows
    *
    * Finds each table row with sample data and creates a "sampleInfo" Map
    *   Each table row has a link to the resource, and a GA custom event is added to it here.
    * Finds each <table> so they can be conditionally hidden in [filterSamples()]
    *   There's one table per resource type (i.e. codelab, recipes, etc)
    *
    */
    const tableSection = document.getElementById('all-samples-tables');
    const tables = tableSection?.querySelectorAll('.samples-table');
    const rows = tableSection?.querySelectorAll('.table-row');
    const sampleInfo = [];
    rows.forEach(row => {
        const sampleName = row.id;
        if (!sampleName) return;
        sampleInfo.push({
            name: sampleName,
            type: row.dataset.type,
            categories: row.dataset.categories.split(', '),
        });

        const sourceButton = row.querySelector('.td-icon');
        if (!sourceButton) return;
        sourceButton.addEventListener('click', async () => {
            console.log('clicked source button');
            // TODO(ewindmill): Custom analytics event
        });
    });

    /* Section - Filters */
    const filtersSection = document.getElementById('samples-filter-group');

    /* Section Filters - Set up search bar
    *   Finds the searchbar
    *   Adds an event handler to filter on input
    */
    const searchInput = filtersSection.querySelector('.search-wrapper input');
    searchInput.addEventListener('input', filterSamples);


    /* Section Filters - Set up select chips
    *   Finds each 'select chip'. For each, a click handler is added that handles showing and hiding the dropdown menu.
    *   Finds each option in the select chip's dropdown menu. For each option, it adds a click handler that toggles the
    *     option as selected or not selected. If the option is being unselected it changes the [_filters.type] to "all"
    *     and resets the chip UI.  Otherwise, it changes [_filters.type] to the selected option and updates the UI to
    *     show which option is selected.
    */
    const selectChips = filtersSection.querySelectorAll('button.select-chip');
    selectChips.forEach(chip => {
        chip.addEventListener('click', _ => {
            const menuToToggle = chip.dataset.menu;
            _closeMenusAndToggle(menuToToggle);
        });
        const options = chip.parentElement.querySelectorAll('.select-menu button');

        function unselectOptions() {
            options.forEach(option => {
                option.classList.remove('selected');
                option.ariaSelected = 'false';
            });
        }

        options.forEach(option => {
            option.addEventListener('click', () => {
                if (option.classList.contains('selected')) {
                    _filters[chip.dataset.menu] = 'all';
                    _resetChip(chip);
                } else {
                    // adds class 'selected' to the chip and option
                    // adds filter from option to the chip
                    unselectOptions();
                    option.classList.add('selected');
                    option.ariaSelected = 'true';
                    chip.classList.add('selected');
                    chip.querySelector('.label').textContent = option.querySelector('.label').textContent;
                    chip.dataset.filter = option.dataset.filter;
                    // i.e. "type-menu"
                    const menuName = chip.dataset.menu.split('-').slice(0, -1);
                    _filters[menuName] = option.dataset.filter;
                }

                filterSamples();
            });
        });
    });

    /* Section Filters - Clear filters button */
    filtersSection.querySelector('#reset-filters').addEventListener('click', () => {
        searchInput.value = '';
        selectChips.forEach(chip => _resetChip(chip));
        filterSamples();
    });

    /// TODO: handle hiding tables
    function filterSamples() {
        const samplesToShow = new Set();

        // if no filters are selected, show everything
        if (_filters.type === 'all' && _filters.searchTerm === "") {
            for (const sample of sampleInfo) {
                samplesToShow.add(sample.name);
            }
        }

        for (const sample of sampleInfo) {
            if (_filters.searchTerm !== "" &&
                (sample.name.includes(_filters.searchTerm)
                    || sample.categories.includes(_filters.searchTerm))) {
                samplesToShow.add(sample.name);
            }

            if (sample.type === _filters["type"]) {
                samplesToShow.add(sample.name);
            }
        }

        rows.forEach(row => {
            const sampleName = row.id;
            if (samplesToShow.has(sampleName)) {
                row.classList.remove('hidden');
            } else {
                row.classList.add('hidden');
            }
        });
    }

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

function _resetChip(chip) {
    chip.classList.remove('selected');
    if (chip.classList.contains('filter-chip')) {
        chip.ariaChecked = 'false';
    } else if (chip.classList.contains('select-chip')) {
        chip.parentElement.querySelectorAll('.select-menu button')
            .forEach(option => {
                option.classList.remove('selected');
                option.ariaSelected = 'false';
            });
        chip.ariaExpanded = 'false';
        chip.querySelector('.label').textContent = chip.dataset.title;
    }
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
