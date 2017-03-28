$( document ).ready(function() {
    // activate tooltips. although this is a bootstrap js function,
    // it must be activated this way in your theme.
    $('[data-toggle="tooltip"]').tooltip({
        placement : 'top'
    });
});

$(document).ready(function() {
    // Initialize navgoco with default options
    $("#mysidebar").navgoco({
        caretHtml: '',
        accordion: true,
        openClass: 'active', // open
        save: false, // leave false or nav highlighting doesn't work right
        cookie: {
            name: 'navgoco',
            expires: false,
            path: '/'
        },
        slide: {
            duration: 400,
            easing: 'swing'
        }
    });

    $("#collapseAll").click(function(e) {
        e.preventDefault();
        $("#mysidebar").navgoco('toggle', false);
    });

    $("#expandAll").click(function(e) {
        e.preventDefault();
        $("#mysidebar").navgoco('toggle', true);
    });

    $("#mysidebar li.active").parents('li').toggleClass("active");
    $("#mysidebar li.active").parents('ul').show();

    /**
     * AnchorJS
     */
    anchors.add('h2,h3,h4,h5');
});

