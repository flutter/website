$(document).ready(function() {

	function initSideNav() {
	  var sideBarToggle = document.getElementById('sidebar-toggle-button');
	  var sideDrawer = document.getElementById('mysidebar');
	  var background = document.getElementById('overlay-under-drawer');

	  function toggleBoth() {
	    if (sideDrawer) {
	      sideDrawer.classList.toggle('active');
	    }

	    if (background) {
	      background.classList.toggle('active');
	    }
	  }

	  if (background) {
	    background.addEventListener('click', function(e) {
	      toggleBoth();
	    });
	  }

	  if (sideBarToggle) {
	    sideBarToggle.addEventListener('click', function(e) {
	      toggleBoth();
	    });
	  }
	}

    initSideNav();
});