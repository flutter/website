const filters = {
    // These properties track the active filters and/or search term
    type: new Set(),
    tags: new Set(),
    difficulty: new Set(),
    searchTerm: '',
    // The keys correspond to a checkbox in the filter sidebar (created from
    //      'type' in src/_data/learning-resources-index/filters.yml)
    // The items inside the value array correspond to the 'type' property that
    //      can exist in the metadata (on items in the files in src/_data/learning-resources-index)
    resourceTypeMapping: {
        'tutorial': ['codelab', 'tutorial'],
        'sample code': ['quickstart', 'demo', 'sample', 'sample code'],
        'workshop': ['workshop', 'video'],
        'how to': ['recipe', 'how to']
    },

    // Checks for existing filters, but not search terms
    hasFilters: function () {
        return this.type.size > 0 ||
            this.tags.size > 0 ||
            this.difficulty.size > 0;
        },
    // Takes a Set, and returns a filtered Set
    filter: function (resources) {
        const resourcesToShow = new Set();
        let filteredResources = [];
        if (this.hasFilters()) {
            // TODO: START HERE TOMORROW this code is reached on change, but filters don't work
            for (const resource of resources) {
                const tags = resource.tags.join('').toLowerCase();
                const selectedFilterTags = Array.from(filters.tags);
                const matchesTags = selectedFilterTags.some(t => {tags.contains(t)});

                const type = resource.type.toLowerCase();
                const selectedTypes = Array.from(filters.type);
                const matchesTypes = selectedTypes.some(t => {return t === type});

                if (matchesTags || matchesTypes) {
                    filteredResources.push(resource);
                }
            }
        } else {
            filteredResources = resources;
        }

        for (const resource of filteredResources) {
            const tags = resource.tags.join('').toLowerCase();
            const type = resource.type.toLowerCase();
            const description = resource.description.toLowerCase();
            const name = resource.name.toLowerCase();

            if (name.includes(this.searchTerm) ||
                tags.toLowerCase().includes(this.searchTerm) ||
                type.includes(this.searchTerm) ||
                description.includes(this.searchTerm)
            ) {
                resourcesToShow.add(resource.name);
            }
        }

        return resourcesToShow;
    }
}

// The remaining functions deal with the DOM
function filterResources() {
    const resourcesToShow = filters.filter(resourcesInfo);
    resourceCards.forEach(card => {
        const resourceName = card.id;
        if (resourcesToShow.has(resourceName)) {
            card.classList.remove('hidden');
        } else {
            card.classList.add('hidden');
        }
    });
    const resourcesCount = document.getElementById('displayed-resource-card-count');
    resourcesCount.textContent = resourcesToShow.size.toString();
}


function _setupResourceFilters() {
    // index the resource metadata
    const resourceCards = document.getElementById('all-resources-grid')?.querySelectorAll('.card');
    if (!resourceCards) return;
    const resourcesInfo = _setupResourceInfo(resourceCards);

    // sets up the resource count element that says "Showing x / y" below the search bar.
    const allResourcesCount = document.getElementById('total-resource-card-count');
    allResourcesCount.textContent = (resourcesInfo.length - 1).toString();

    // set up search bar interaction
    const searchSection = document.getElementById('resource-search-group');
    const searchInput = searchSection.querySelector('.search-wrapper input');
    searchInput.addEventListener('input', event => {
        filters.searchTerm = searchInput.value.toLowerCase();
        filterResources(resourcesInfo);
    });

    // set up checkbox interaction handling
    const filterSection = document.getElementById('resource-filter-group');
    const allCheckboxes = filterSection.querySelectorAll('input');
    allCheckboxes.forEach(checkbox => {
        _setupFilterChange(checkbox, filterResources);
    });

    function filterResources() {
        console.log(filters.tags);
        const resourcesToShow = filters.filter(resourcesInfo);
        console.log(resourcesToShow);
        resourceCards.forEach(card => {
            const resourceName = card.id;
            if (resourcesToShow.has(resourceName)) {
                card.classList.remove('hidden');
            } else {
                card.classList.add('hidden');
            }
        });
        const resourcesCount = document.getElementById('displayed-resource-card-count');
        resourcesCount.textContent = resourcesToShow.size.toString();
    }

    filterResources();
}


function _setUpCollapsibleFilterLists() {
    const filterSidebar = document.getElementById('resource-filter-group');
    const filterGroups = filterSidebar.querySelectorAll('ul');
    const toggleButtons = filterSidebar.querySelectorAll('button');

    toggleButtons.forEach(button => {
        const id = button.id;
        const correspondingUlId = "#" + id.split('-').slice(0, 2).join('-');
        const ul = filterSidebar.querySelector(correspondingUlId);

        const liCount = Array.from(ul.querySelectorAll('li')).length;
        if (liCount <= 2) {
            button.classList.add('hidden');
            return;
        }

        button.addEventListener('click', _ => {
            const nodeList = ul.querySelectorAll('li');
            const liElements = Array.from(nodeList);
            const isCollapsed = ul.classList.contains('collapsed');
            const icon = button.querySelector('.material-symbols');
            const label = button.querySelector('.label');
            if (isCollapsed) {
                liElements.forEach(li => li.classList.remove('hidden'));
                label.textContent = 'Less';
                icon.textContent = 'expand_less';
                ul.classList.remove('collapsed');
            } else {
                liElements.slice(2).forEach(li => li.classList.add('hidden'));
                icon.textContent = 'expand_more';
                label.textContent = 'More';
                ul.classList.add('collapsed');
            }
        });
    });

    // Show the first two items to start
    filterGroups.forEach(ul => {
        const allFiltersForGroup = ul.querySelectorAll('li');
        if (allFiltersForGroup.length >= 1) allFiltersForGroup[0].classList.remove('hidden');
        if (allFiltersForGroup.length >= 2) allFiltersForGroup[1].classList.remove('hidden');
    });
}

function _setupResourceInfo(resourceCards) {
    const resourcesInfo = [];
    resourceCards.forEach(card => {
        const resourceName = card.id;
        if (!resourceName) return;
        let tags = card.dataset.tags.split(', ').map(t => t.toLowerCase());

        resourcesInfo.push({
            name: resourceName,
            type: card.dataset.type,
            tags: tags,
            description: card.dataset.description,
        });

        card.addEventListener('click', async (_) => {
            window.dataLayer?.push({
                'event': 'resources_index_click',
                'resource_type': card.dataset.type,
                'resource_title': resourceName,
            });
        });
    });
    return resourcesInfo;
}

// TODO
function _setupFilterChange(checkbox, onChange) {
    const id = checkbox.id;
    const filter = id.split('-')[1].toLowerCase();
    // category refers to the filter types: tags, type and difficulty
    const category = checkbox.dataset.category.toLowerCase();

    checkbox.addEventListener('change', _ => {
        if (checkbox.checked) {
            switch (category) {
                case 'tags':
                case 'difficulty':
                    filters[category].add(filter);
                    break;
                case 'type':
                    const typeGroup = filters.resourceTypeMapping[filter];
                    typeGroup.forEach(type => filters[category].add(type))
                    break;
            }
        } else {
            switch (category) {
                case 'tags':
                case 'difficulty':
                    filters[category].delete(filter);
                    break;
                case 'type':
                    const typeGroup = filters.resourceTypeMapping[filter];
                    typeGroup.forEach(type => filters[category].delete(type))
                    break;
            }
        }

        // TODO: not implemented in Google Analytics
        window.dataLayer?.push({
            'event': 'resources_index_filter',
            'filter_name': filter,
            'filter_type': category,
        });
        onChange();
    });
}

// This button is only displayed on smaller screens
function _setupDropdownMenu() {
    const searchGroup = document.getElementById('resource-search-group');
    if (!searchGroup) return;

    const dropdownButton = searchGroup.querySelector('.dropdown-button');
    const dropdownMenu = searchGroup.querySelector('.dropdown-content');
    if (!dropdownButton || !dropdownMenu) return;

    function _closeMenu() {
        dropdownMenu.classList.remove('show');
        dropdownButton.ariaExpanded = 'false';
    }

    dropdownButton.addEventListener('click', (_) => {
        if (dropdownMenu.classList.contains('show')) {
            _closeMenu();
        } else {
            console.log('open');
            dropdownMenu.classList.add('show');
            dropdownButton.ariaExpanded = 'true';
        }
    });

    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            _closeMenu();
        }
    });

    // Close the dropdown if anywhere not in the inline TOC is clicked.
    document.addEventListener('click', (event) => {
        if (event.target.closest('#resource-search-group')) {
            return;
        }
        _closeMenu();
    });
}

document.onreadystatechange = () => {
    switch (document.readyState) {
        case "interactive":
            _setUpCollapsibleFilterLists();
            _setupResourceFilters();
            _setupDropdownMenu();
            break;
        case "complete":
            _setUpCollapsibleFilterLists();
            _setupResourceFilters();
            _setupDropdownMenu();
            break;
    }
}
