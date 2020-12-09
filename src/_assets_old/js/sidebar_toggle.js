$(document).ready(function() {

	function initSideNav() {
	  var sideBarToggle = document.getElementById('sidebar-toggle-button');
    var sideNavContainer = document.getElementById('side-nav-container');
	  var sideDrawer = document.getElementById('mysidebar');
	  var background = document.getElementById('overlay-under-drawer');

	  function toggleAll() {
	    if (sideDrawer) {
	      sideDrawer.classList.toggle('active');
	    }

	    if (sideNavContainer) {
	    	sideNavContainer.classList.toggle('active');
			}

	    if (background) {
	      background.classList.toggle('active');
	    }
	  }

	  if (background) {
	    background.addEventListener('click', function(e) {
	      toggleAll();
	    });
	  }

	  if (sideBarToggle) {
	    sideBarToggle.addEventListener('click', function(e) {
	      toggleAll();
	    });
	  }
	}

    initSideNav();
});
