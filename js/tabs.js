function setupTabs() {
    var tabs = $('.tabs__top-bar li');
    var tabContents = $('.tabs__content');

    function clearTabsCurrent() {
      tabs.removeClass('current');
      tabContents.removeClass('current');
    }
  
    tabs.click(function () {
      clearTabsCurrent();
  
      var tab_id = $(this).attr('data-tab');
  
      $(this).addClass('current');
      $("#" + tab_id).addClass('current');
    });
  
    // The following selects the correct default tab in /guides/get-started
    function selectOperatingSystemInTabs(osName) {
      clearTabsCurrent();
  
      $("li[data-tab='tab-sdk-install-" + osName + "']").addClass('current');
      $('#tab-sdk-install-' + osName).addClass('current');
    }
  
    if (window.navigator.userAgent.indexOf("Mac") != -1) {
      selectOperatingSystemInTabs('mac');
    } else if (window.navigator.userAgent.indexOf("Linux") != -1 &&
               window.navigator.userAgent.indexOf("Android") == -1) {
      // Doesn't auto-select the Linux tab when on Android.
      selectOperatingSystemInTabs('linux');
    }
}

$(document).ready(function () {
    setupTabs();
});