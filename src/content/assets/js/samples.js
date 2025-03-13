const _filters = {
    type: 'all',
    searchTerm: '',
};

/* Finds all the relevant HTML elements, and adds click handlers to them that
*  facilitate searching and filtering the samples index page.
*/
function setupSampleFilters() {
    /*
    * Section -- set up tables and rows
    *
    * Finds each table row with sample data and creates a "sampleInfo" Map
    * Each table row has a link to the resource, and a GA custom event is added to it here.
    * Finds each <table> so they can be conditionally hidden in [filterSamples()]
    * There's one table per resource type (i.e. codelab, recipes, etc)
    *
    */
    const tableSection = document.getElementById('all-samples-tables');
    const tables = tableSection?.querySelectorAll('.samples-table');
    const rows = tableSection?.querySelectorAll('.table-row');
    const sampleInfo = [];
    const tableInfo = [];
    rows.forEach(row => {
        const sampleName = row.id;
        if (!sampleName) return;
        sampleInfo.push({
            name: sampleName,
            type: row.dataset.type,
            tags: row.dataset.tags.split(', '),
        });

        const sourceButton = row.querySelector('.td-icon');
        if (!sourceButton) return;
        sourceButton.addEventListener('click', async () => {
            // TODO(ewindmill): Custom analytics event
        });
    });
    tables.forEach(table => {
        // removes 'table-' from the id
       tableInfo.push(table.id.slice(6));
    });

    /* Section - Filters */
    const filtersSection = document.getElementById('samples-filter-group');

    /* Section Filters - Set up search bar
    *   Finds the searchbar
    *   Adds an event handler to filter on input
    */
    const searchInput = filtersSection.querySelector('.search-wrapper input');
    searchInput.addEventListener('input', event => {
        _filters.searchTerm = searchInput.value.toLowerCase();
        filterSamples();
    });


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
                    const menuName = chip.dataset.menu.slice(5);
                    _filters[menuName] = 'all';
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
                    const menuName = chip.dataset.menu.slice(5);
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
        _resetFilters();
        filterSamples();
    });

    function filterSamples() {
        const samplesToShow = new Set();
        const tablesToShow = new Set();

        // if no filters are selected, show everything
        if (_filters.type === 'all' && _filters.searchTerm === "") {
            for (const sample of sampleInfo) {
                samplesToShow.add(sample.name);
            }
            for (const table of tableInfo) {
                tablesToShow.add(table);
            }
        } else {
            for (const sample of sampleInfo) {
                const matchesType = _filters.type.includes(sample.type) || _filters.type === 'all';

                const nameMatchesTerm =
                    (_filters.searchTerm !== '' && sample.name.toLowerCase().includes(_filters.searchTerm))
                    || _filters.searchTerm === '';

                // combine tags into one long String, which will be compared to the search term
                const tags = sample.tags.join(' ');
                const tagsMatchesTerm =
                    (_filters.searchTerm !== '' && tags.toLowerCase().includes(_filters.searchTerm))
                    || _filters.searchTerm === '';


                if (matchesType && (nameMatchesTerm || tagsMatchesTerm)) {
                    samplesToShow.add(sample.name);
                    for (const table of tableInfo) {
                        if (table === sample.type || _filters.type === 'all') {
                            tablesToShow.add(table);
                        }
                    }
                }
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


        tables.forEach(table => {
            const tableId = table.id.slice(6);
            if (tablesToShow.has(tableId)) {
                table.classList.remove('hidden');
            } else {
                table.classList.add('hidden');
            }
        })
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

function _resetFilters() {
    _filters.type = 'all';
    _filters.searchTerm = '';
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
