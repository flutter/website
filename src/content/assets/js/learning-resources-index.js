const filters = {
    // These properties track the active filters and/or search term
    type: new Set(),
    tags: new Set(),
    searchTerm: '',
    // The keys correspond to a checkbox in the filter sidebar (created from
    //      'type' in src/_data/learning-resources-index/filters.yml)
    // The items inside the value array correspond to the 'type' property that
    //      can exist in the metadata (on items in the files in src/_data/learning-resources-index)
    resourceTypeMapping: {
        'tutorial': ['codelab', 'tutorial'],
        'sample code': ['quickstart', 'demo', 'sample', 'sample code'],
        'workshop': ['workshop', 'video'],
        'recipe': ['recipe', 'how to', 'cookbook']
    },
    resourceTagMapping: {
        'ai': ['ai', 'gemini', 'llm'],
        'animation': ['animations', 'animate', 'animation'],
        'architecture': ['state-management', 'architecture', 'provider', 'bloc', 'stream'],
        'cupertino': ['cupertino', 'ios', 'macos'],
        'dart': ['dart', 'cli'],
        'design': ['design', 'widgets'],
        'desktop': ['windows', 'macos', 'linux'],
        'firebase': ['firebase', 'firestore', 'cloud'],
        'good for beginners': ['beginner', 'beginners'],
        'google apis': ['google', 'gemini', 'maps', 'firebase', 'cloud'],
        'ios': ['cupertino', 'ios'],
        'layout': ['layout', 'lists', 'scrolling', 'widgets'],
        'material': ['material', 'android'],
        'routing and navigation': ['routing', 'route', 'navigation', 'navigator'],
        'state management': ['state-management', 'architecture', 'provider', 'bloc', 'stream'],
        'testing': ['testing', 'tests', "test", 'perf', 'performance'],
        'web': ['web', 'wasm'],
        'widgets': ['widgets', 'layout'],
    },

    // Checks for existing filters, but not search terms
    hasFilters: function () {
        return this.type.size > 0 ||
            this.tags.size > 0;
    },
    // Takes a Set, and returns a filtered Set
    filter: function (resources) {
        const resourcesToShow = new Set();
        let filteredResources = [];
        if (this.hasFilters()) {
            for (const resource of resources) {
                const tags = resource.tags.join(' ').toLowerCase();
                const selectedFilterTags = Array.from(filters.tags);
                const matchesTags = selectedFilterTags.some(t => {
                    return tags.includes(t)
                });

                const type = resource.type.toLowerCase();
                const selectedTypes = Array.from(filters.type);
                const matchesTypes = selectedTypes.some(t => {
                    return t === type
                });

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
    },
    clear: function () {
        this.type.clear();
        this.tags.clear();
        this.searchTerm = '';
    }
}

function _setupResourceFilters() {
    // index the resource metadata
    const resourceGrid = document.getElementById('all-resources-grid');
    if (!resourceGrid) return;
    const resourceCards = resourceGrid.querySelectorAll('.card');
    const resourcesInfo = _setupResourceInfo(resourceCards);

    // sets up the resource count element that says "Showing x / y" below the search bar.
    const allResourcesCount = document.getElementById('total-resource-card-count');
    allResourcesCount.textContent = (resourcesInfo.length).toString();

    // set up search bar interaction
    const searchSection = document.getElementById('resource-search-group');
    const searchInput = searchSection.querySelector('.search-wrapper input');
    searchInput.addEventListener('input', _ => {
        filters.searchTerm = searchInput.value.toLowerCase();
        filterResources();
    });

    // set up checkbox interaction handling
    const filterSection = document.getElementById('resource-filter-group');
    const allCheckboxes = filterSection.querySelectorAll('input');
    allCheckboxes.forEach(checkbox => {
        _setupFilterChange(checkbox, filterResources);
    });

    // Clear filters button
    const clearFiltersButton = document.getElementById("clear-resource-index-filters");
    clearFiltersButton.addEventListener('click', _ => {
        filters.clear();
        searchInput.value = '';
        filterResources();
        allCheckboxes.forEach(box => {
            box.checked = false;
        })
    });

    function toggleClearFiltersButton() {
        clearFiltersButton.disabled = !(filters.hasFilters() || filters.searchTerm > 0);
    }

    function filterResources() {
        toggleClearFiltersButton();
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

    // Show the first few items to start.
    filterGroups.forEach(ul => {
        const allFiltersForGroup = ul.querySelectorAll('li');
        const initialAmountToShow = 4;
        for (let filterIndex = 0; filterIndex < initialAmountToShow && filterIndex < allFiltersForGroup.length; filterIndex += 1) {
            allFiltersForGroup[filterIndex].classList.remove('hidden');
        }
    });
}

function _setupResourceInfo(resourceCards) {
    const resourcesInfo = [];
    resourceCards.forEach(card => {
        const resourceName = card.id;
        if (!resourceName) return;
        const tags = card.dataset.tags.split(', ').map(t => t.toLowerCase());
        resourcesInfo.push({
            name: resourceName,
            type: card.dataset.type,
            tags: tags,
            description: card.dataset.description,
        });

        card.addEventListener('click', async (_) => {
            window.dataLayer?.push({
                'event': 'learning_resource_index_click',
                'learning_resource_type': card.dataset.type,
                'learning_resource_title': resourceName,
            });
        });
    });
    return resourcesInfo;
}

function _setupFilterChange(checkbox, filterResources) {
    const id = checkbox.id;
    const filter = id.split('-')[1].toLowerCase();
    // category refers to the filter types: tags, type
    const category = checkbox.dataset.category.toLowerCase();

    checkbox.addEventListener('change', _ => {
        if (checkbox.checked) {
            window.dataLayer?.push({
                'event': 'learning_resource_index_filter_selected',
                'learning_resource_filter_name': filter,
                'learning_resource_filter_type': category,
            });
            switch (category) {
                case 'tags':
                    const tagGroup = filters.resourceTagMapping[filter];
                    tagGroup.forEach(tag => filters[category].add(tag))
                    break;
                case 'type':
                    const typeGroup = filters.resourceTypeMapping[filter];
                    typeGroup.forEach(type => filters[category].add(type))
                    break;
            }
        } else {
            switch (category) {
                case 'tags':
                    const tagGroup = filters.resourceTagMapping[filter];
                    tagGroup.forEach(tag => filters[category].delete(tag))
                    break;
                case 'type':
                    const typeGroup = filters.resourceTypeMapping[filter];
                    typeGroup.forEach(type => filters[category].delete(type))
                    break;
            }
        }

        filterResources();
    });
}

// This button is only displayed on smaller screens
function _setupDropdownMenu() {
    const pageContent = document.getElementById('resource-index-content');
    if (!pageContent) return;

    const filtersButton = pageContent.querySelector('.show-filters-button');
    const filtersEl = pageContent.querySelector('.right-col');
    if (!filtersButton || !filtersEl) return;

    function _closeMenu() {
        filtersEl.classList.remove('show');
        filtersButton.ariaExpanded = 'false';
    }

    filtersButton.addEventListener('click', (_) => {
        if (filtersEl.classList.contains('show')) {
            _closeMenu();
        } else {
            filtersEl.classList.add('show');
            filtersButton.ariaExpanded = 'true';
        }
    });

    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            _closeMenu();
        }
    });

    // Close the dropdown if anywhere not in the filters menu is.
    const content = document.getElementById('all-resources-grid');
    content.addEventListener('click', (_) => {
        if (!filtersEl.classList.contains('show')) {
            return;
        }
        _closeMenu();
    });
}

function shuffleElements(container) {
    const elements = container.children;
    for (let i = elements.length; i >= 0; i--) {
        container.appendChild(elements[Math.random() * i | 0]);
    }
}

window.addEventListener('load', (_) => {
    const resourceGrid = document.getElementById('all-resources-grid');
    shuffleElements(resourceGrid);
})


document.onreadystatechange = () => {
    if (document.readyState === "interactive" ||
        document.readyState === "complete") {
        _setupResourceFilters();
        _setUpCollapsibleFilterLists();
        _setupDropdownMenu();
    }
}
